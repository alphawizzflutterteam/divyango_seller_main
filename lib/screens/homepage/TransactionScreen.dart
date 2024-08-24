import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Model/GetTransactionModel.dart';
import '../../services/colors.dart';
import '../../utils/Api.path.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTransaction();
  }

  GetTransactionModel? transactionData;

  getTransaction() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? user_id = sharedPreferences.getString('user_id');
    // try {
    http.Response response = await http.post(
      Uri.parse(ApiServicves.transaction),
      body: {'project_id': user_id.toString()},
    );
    print("user id in home page${response.body}");
    var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        transactionData = GetTransactionModel.fromJson(json);
      });
    } else {
      print(response.reasonPhrase);
    }
    // } catch (e, stackTrace) {
    //   print(stackTrace);
    //   throw Exception(e);
    // }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
      Fluttertoast.showToast(msg: "Invoice Downloaded");
    } else {
      throw 'Could not launch $url';
    }
  }

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
          'Transaction',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: transactionData?.status == false
            ? const Text(
                "Transaction Not Found",
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
              )
            : Container(
                height: double.infinity,
                child: ListView.builder(
                  itemCount: transactionData?.data.length ?? 0,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${transactionData?.data[index].invNo}',
                                style: const TextStyle(color: colors.darkgrey),
                              ),
                              Container(
                                height: 25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: colors.secondary
                                    // index % 2==0 ?  colors.lightGreen : colors.lightRed
                                    ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 8, top: 2),
                                  child: Text(
                                    '${transactionData?.data[index].paymentType}',
                                    style: const TextStyle(color: Colors.white),
                                    // style: TextStyle(color: index % 2==0 ? colors.darkGreen : colors.darkRed),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '₹${transactionData?.data[index].amount}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  '${transactionData?.data[index].createdAt}'
                                      .replaceAll(".000", ""),
                                  style:
                                      const TextStyle(color: colors.darkgrey),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  print(
                                      "invoice url ${transactionData?.data[index].paymentInvoice}");
                                  if (transactionData
                                              ?.data[index].paymentInvoice ==
                                          null ||
                                      transactionData
                                              ?.data[index].paymentInvoice ==
                                          "") {
                                    Fluttertoast.showToast(
                                        msg: "Invoice Not Available");
                                  } else {
                                    _launchURL(
                                        "${transactionData?.data[index].paymentInvoice}");
                                  }
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: const Color(0xffFDF7DE)),
                                  child: const Icon(
                                    Icons.download,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),

                        ///   SizedBox(height: 10,)
                      ],
                    );
                  },
                ),
              ),
      ),
    );
  }
}
