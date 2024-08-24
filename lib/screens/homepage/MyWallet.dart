import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/TransactionModel.dart';
import '../../services/colors.dart';
import '../../utils/Api.path.dart';

class Mywallet extends StatefulWidget {
  // final String walletAmount;
  const Mywallet({Key? key, required}) : super(key: key);

  @override
  State<Mywallet> createState() => _MywalletState();
}

class _MywalletState extends State<Mywallet> {
  @override
  void initState() {
    super.initState();
    walletTransactions();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  String? vendorId;

  // getData() async {
  //   final SharedPreferences preferences = await SharedPreferences.getInstance();
  //   vendorId = preferences.getString('vendor_id');
  //   return walletTransactions();
  // }

  Razorpay? _razorpay;
  int? pricerazorpayy;
  void openCheckout(amount) async {
    double res = double.parse(amount.toString());
    pricerazorpayy = int.parse(res.toStringAsFixed(0)) * 100;
    // Navigator.of(context).pop();
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': "$pricerazorpayy",
      'name': 'DigitalBuzz',
      'image': 'assets/images/Group 165.png',
      'description': 'Hojayega',
    };
    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  TextEditingController addMoneyCtr = TextEditingController();
  String? wallet_balance_added;

  var arrPrice = [10000, 20000, 40000, 60000, 80000, 100000];
  int addMoney = 0;

  addWallet() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? user_id = sharedPreferences.getString('user_id');
    // var headers = {
    //   'Cookie': 'ci_session=b5700f932d8b03efe164db4d2f6eccb8c428fdfa'
    // };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.addWallet));
    request.fields.addAll({
      'project_id': user_id.toString(),
      'amount': addMoneyCtr.text,
    });
    print("add wallet amount ${request.fields}");
    // request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonresponse = json.decode(finalResponse);
      // if (jsonresponse["status"] == true) {
      //   print("workinggg}");
      // } else {
      //   Fluttertoast.showToast(msg: jsonresponse["message"]);
      // }
    } else {
      print(response.reasonPhrase);
    }
  }

  TransactionModel? transactionModel;
  walletTransactions() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? user_id = sharedPreferences.getString('user_id');
    // var headers = {
    //   'Cookie': 'ci_session=e3825b4be6db7ecb421f2db35bd0a2ab2c91e923'
    // };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.getTransaction));
    request.fields.addAll({
      'project_id': user_id.toString(),
    });
    print("get wallet ${request.fields}");
    // request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("ksdkjdsss");
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse =
          TransactionModel.fromJson(json.decode(finalResponse));
      setState(() {
        print(
            "===============${transactionModel?.data?.first.createdAt}===========");
        transactionModel = jsonResponse;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(msg: "Payment successfully");
    addWallet();
    Navigator.pop(context);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment cancelled by user");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.whiteTemp,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colors.whiteTemp1,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child:
              const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        ),
        title: const Text(
          'Wallet',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(top: 20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       Container(
            //         height: 100,
            //         width: MediaQuery.of(context).size.width / 1.5,
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(10),
            //             border: Border.all(color: Colors.black)),
            //         // decoration: BoxDecoration(
            //         //     image: const DecorationImage(
            //         //       image: AssetImage("assets/images/homeblue.png"),
            //         //       fit: BoxFit.cover,
            //         //     ),
            //         //     borderRadius: BorderRadius.circular(20)
            //         // ),
            //         child: Padding(
            //           padding: const EdgeInsets.only(top: 25),
            //           child: Column(
            //             children: const [
            //               Text(
            //                 "Wallet Balance ",
            //                 style: TextStyle(
            //                     fontWeight: FontWeight.w600,
            //                     color: colors.blackTemp,
            //                     fontSize: 19),
            //               ),
            //               SizedBox(
            //                 height: 10,
            //               ),
            //               // wallet_balance_added == null ? Text("₹ 500",
            //               //     style: TextStyle(
            //               //         fontWeight: FontWeight.w600,
            //               //         color: colors.whiteTemp,
            //               //         fontSize: 23)):
            //               Text(
            //                 "₹ ${500}",
            //                 style: TextStyle(
            //                     fontWeight: FontWeight.w600,
            //                     color: colors.blackTemp,
            //                     fontSize: 23),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height / 3.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: colors.whiteTemp,
                      border: Border.all(color: colors.blackTemp, width: 1)),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 15, left: 30, right: 30),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: addMoneyCtr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Fill This Field';
                            }
                            return null;
                          },
                          // keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: "Add Money",
                            hintStyle: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            isDense: true,
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade200)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade200),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Container(
                          height: 30,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            // Set the direction to horizontal
                            itemCount: arrPrice.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: InkWell(
                                  onTap: () {
                                    //  print("11");
                                    addMoney = addMoney + arrPrice[index];
                                    setState(() {
                                      addMoneyCtr.text = addMoney.toString();
                                    });
                                  },
                                  child: Container(
                                    width: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: colors.whiteTemp1),
                                    child: Center(
                                      child: Text(
                                        arrPrice[index].toString(),
                                        style:
                                            TextStyle(color: colors.blackTemp),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          final form = _formkey.currentState!;
                          if (form.validate() && addMoneyCtr.text != '0') {
                            form.save();
                            double amount =
                                double.parse(addMoneyCtr.text.toString());
                            openCheckout((amount));
                          }
                        },
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width / 1.3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: colors.whiteTemp1),
                          child: const Center(
                            child: Text(
                              "Add Money",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: colors.blackTemp,
                                  fontSize: 19),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: const [
                  Text(
                    "Wallet Transaction",
                    style: TextStyle(
                        fontSize: 15,
                        color: colors.blackTemp,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            transactionModel?.status == false
                ? const Center(
                    child: Text(
                      "No Transaction Found",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.black),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: transactionModel?.data?.length ?? 0,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return listItem(index);
                    },
                  ),
          ],
        ),
      ),
    );
  }

  listItem(int index) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: colors.whiteTemp,
            border: Border.all(color: colors.primary, width: 2),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
              decoration: const BoxDecoration(
                  color: colors.primary,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(13),
                      topRight: Radius.circular(13))),
              child: Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Date Created",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '${transactionModel?.data?[index].createdAt}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Amount Added"),
                  // Image.asset('assets/images/transactions.png', height: 50, width: 50,),
                  // SizedBox(width: 15,),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width / 1.6,
                  //   child: Text(
                  //     "${transactionModel?.data?[index].userType}",
                  //     maxLines: 2,
                  //     overflow: TextOverflow.ellipsis,
                  //     style: const TextStyle(
                  //         color: colors.black54,
                  //         fontWeight: FontWeight.normal,
                  //         fontSize: 14),
                  //   ),
                  // ),
                  Text(
                    "₹ ${transactionModel?.data?[index].amount}",
                    style: const TextStyle(
                        color: colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                transactionModel?.data?[index].status == 0
                    ? Container(
                        margin: const EdgeInsets.only(right: 8, bottom: 8),
                        padding: const EdgeInsets.only(
                            top: 4, bottom: 4, left: 8, right: 8),
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                        ),
                        child: const Text(
                          "Pending",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : SizedBox(),
                transactionModel?.data?[index].status == 1
                    ? Container(
                        margin: const EdgeInsets.only(right: 8, bottom: 8),
                        padding: const EdgeInsets.only(
                            top: 4, bottom: 4, left: 8, right: 8),
                        decoration: const BoxDecoration(
                          color: colors.secondary,
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                        ),
                        child: const Text(
                          "Approved",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : SizedBox(),
                transactionModel?.data?[index].status == 2
                    ? Container(
                        margin: const EdgeInsets.only(right: 8, bottom: 8),
                        padding: const EdgeInsets.only(
                            top: 4, bottom: 4, left: 8, right: 8),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                        ),
                        child: const Text(
                          "Reject",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : SizedBox(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
