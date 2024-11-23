import 'dart:convert';

import 'package:divyango_user/screens/homepage/navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:otp_text_field/otp_text_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/btnPage.dart';
import '../../services/colors.dart';
import '../../utils/Api.path.dart';

class Verification extends StatefulWidget {
  final String? OTP;
  final String? MOBILE;

  Verification({Key, key, this.OTP, this.MOBILE});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  @override
  intitState() {
    super.initState();
    print("mobilelleel ${widget.MOBILE} ${widget.OTP}");
    otp = widget.OTP.toString();
  }

  TextEditingController otpController = TextEditingController();

  String? otp;

  verifyOtp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.verifyOtp));
    request.fields
        .addAll({'mobile': widget.MOBILE.toString(), 'otp': otp.toString()});
    print("verify otp ${request.fields}");
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = jsonDecode(result);
      if (finalresult['response_code'] == '1') {
        user_id = finalresult['user_id'];
        user_mobile = finalresult['mobile'];
        print("user id in verify otp $user_id $user_mobile");
        await prefs.setString('user_id', finalresult['user_id'].toString());
        await prefs.setString('mobile', user_mobile.toString());
        Fluttertoast.showToast(msg: '${finalresult['message']}');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NavigationPage(),
          ),
        );
      } else {
        Fluttertoast.showToast(msg: '${finalresult['message']}');
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.sendOtp));
    request.fields.addAll({'mobile': widget.MOBILE.toString()});
    print('login para ${request.fields}');
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      if (finalResult['response_code'] == '1') {
        print("working=========");
        otp = finalResult["otp"];
        // otp = widget.OTP.toString();
        setState(() {});
        print("otp is $otp $proType");
        Fluttertoast.showToast(msg: '${finalResult['message']}');
      } else {
        Fluttertoast.showToast(msg: "${finalResult['message']}");
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  final _formKey = GlobalKey<FormState>();

  OtpFieldController pinController = OtpFieldController();

  void validateOtp(String pin) {
    if (pin.isEmpty) {
      debugPrint("OTP is empty");
    } else if (pin.length < 4) {
      debugPrint("OTP is less than 4 digits");
    } else if (pin != "1234") {
      // Replace "1234" with your desired OTP for validation
      debugPrint("Invalid OTP");
    } else {
      debugPrint("OTP validated successfully!");
    }
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    print("=======sssssssssssss========${widget.MOBILE}===========");
    return Scaffold(
      backgroundColor: colors.whiteTemp,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "OTP Verification",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context, false);
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            )),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          child: SingleChildScrollView(
            child: Stack(
              // physics: BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 300),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2 + 10,
                    decoration: const BoxDecoration(
                      color: colors.secondary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "OTP Verification ",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: colors.whiteFont),
                          ),
                        ),
                        // const SizedBox(
                        //   height: 8,
                        // ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Please enter the 4-digit code send to you at            \n+91 ${widget.MOBILE}",
                            style: const TextStyle(
                                fontSize: 14, color: colors.whiteFont),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "${widget.OTP}",
                            style: const TextStyle(
                                fontSize: 18, color: colors.whiteFont),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: OTPTextField(
                        //     keyboardType: TextInputType.number,
                        //     spaceBetween: 20,
                        //     contentPadding:
                        //         EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        //     length: 4,
                        //     width: MediaQuery.of(context).size.width - 40,
                        //     fieldWidth: 60,
                        //     style: TextStyle(fontSize: 18),
                        //     textFieldAlignment: MainAxisAlignment.spaceAround,
                        //     fieldStyle: FieldStyle.box,
                        //     outlineBorderRadius: 10,
                        //     controller: pinController,
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: PinCodeTextField(
                            // backgroundColor: Colors.white,
                            appContext: context,
                            length: 4,
                            keyboardType: TextInputType.number,
                            controller: otpController,
                            validator: (value) {
                              if (value!.length < 4) {
                                return "otp length must be 4";
                              } else {
                                return null;
                              }
                            },
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 60,
                              activeFillColor: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: FilledBtn(
                            width: MediaQuery.of(context).size.width,
                            title: 'Verify',
                            onPress: () {
                              otp = otpController.text;
                              print("===============$otp===========");
                              if (_formKey.currentState!.validate()) {
                                verifyOtp();
                                // Fluttertoast.showToast(msg: "Wrong Otp");
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextButton(
                          onPressed: () {
                            login();
                          },
                          child: const Text(
                            "Resend OTP",
                            style: TextStyle(color: colors.primary),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0, top: 16),
                  child: Container(
                    child: SvgPicture.asset(
                      'assets/images/otp-verification.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
