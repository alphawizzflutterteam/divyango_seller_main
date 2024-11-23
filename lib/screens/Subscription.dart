import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/PlanModel.dart';
import '../services/btnPage.dart';
import '../services/colors.dart';
import '../utils/Api.path.dart';
import '../widgets/appbar_widget.dart';

class Subscription extends StatefulWidget {
  const Subscription({Key, key});

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  int isSelect = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    plansList();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Razorpay? _razorpay;
  int? pricerazorpayy;
  void openCheckout(price) async {
    double res = double.parse(price.toString());
    pricerazorpayy = int.parse(res.toStringAsFixed(0)) * 100;
    // Navigator.of(context).pop();
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': "$pricerazorpayy",
      'name': 'Divyango',
      'image': 'assets/images/Group 165.png',
      'description': 'Divyango',
    };
    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  String? planId, amount;
  purchasePlan(txnId) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? user_id = sharedPreferences.getString('user_id');
    var headers = {
      'Cookie': 'ci_session=39bcfe9928de3afaecdfa832ed9b029e25237b51'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.planPurcahse));
    request.fields.addAll({
      'plan_id': planId.toString(),
      'user_id': user_id.toString(),
      'transaction_id': txnId.toString()
    });
    print("sdddddadasd ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = json.decode(result);
      if (finalResult['response_code'] == "1") {
        Fluttertoast.showToast(msg: "${finalResult['msg']}");
      } else {
        Fluttertoast.showToast(msg: "${finalResult['msg']}");
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(msg: "Payment successfully");
    purchasePlan("${response.paymentId}");
    Navigator.pop(context);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment cancelled by user");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  bool? isLoading = true;

  PlanModel? planModel;

  plansList() async {
    setState(() {
      isLoading = true;
    });
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse(ApiServicves.plans));
      print("profile para ${request.fields}");
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var finalResponse = await response.stream.bytesToString();
        final finalResult = PlanModel.fromJson(json.decode(finalResponse));
        print("responseeee $finalResponse");
        setState(() {
          planModel = finalResult;
        });
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception(e);
    }
  }

  int? selectedPlanIndex = 0;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;

    return Scaffold(
      // appBar: AppBar(
      //   leading: GestureDetector(
      //       onTap: () {
      //         Navigator.pop(context);
      //       },
      //       child: Icon(
      //         Icons.arrow_back_ios,
      //         color: Colors.white,
      //       )),
      //   backgroundColor: colors.secondary,
      //   title: Padding(
      //     padding: EdgeInsets.symmetric(horizontal: width * 0.13),
      //     child: Text(
      //       "Subscription",
      //       style: TextStyle(color: Colors.white),
      //     ),
      //   ),
      // ),
      appBar: appBarWithBackWidget(
          context: context,
          title: '                   Subscription',
          color: colors.whiteTemp1),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.040, vertical: height * 0.014),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.025),
            Center(
                child: Image.asset("assets/images/subscription.png",
                    height: height * 0.25)),
            SizedBox(height: height * 0.025),
            const Text(
              "Subscription Plan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: height * 0.025),
            Container(
              height: height * 0.3,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: planModel?.data.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedPlanIndex = index;
                              });
                              planId = planModel?.data[index].id.toString();
                              amount = planModel?.data[index].price.toString();
                            },
                            child: Container(
                              height: height * 0.29,
                              width: width * 0.4,
                              decoration: BoxDecoration(
                                color: selectedPlanIndex == index
                                    ? Colors.grey[200]
                                    : Colors.white,
                                border: Border.all(
                                  color: selectedPlanIndex == index
                                      ? Colors.green
                                      : Colors.black12,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.04,
                                    vertical: height * 0.02),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(height: height * 0.0125),
                                        const Text(
                                          "₹",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          "${planModel?.data[index].price}",
                                          style: const TextStyle(
                                              fontSize: 27,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          "/${planModel?.data[index].planType}",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * 0.019,
                                    ),
                                    Text(
                                      "${planModel?.data[index].title}",
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: colors.primary),
                                    ),
                                    SizedBox(
                                      height: height * 0.0,
                                    ),
                                    Text(
                                      "${planModel?.data[index].description}",
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: height * 0.130,
            ),
            FilledBtn(
              width: 330,
              title: "Buy Plan",
              onPress: () {
                openCheckout(amount);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const PaymentType(),
                //     ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
