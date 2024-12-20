import 'dart:convert';

import 'package:divyango_user/screens/auth/otp_page.dart';
import 'package:divyango_user/services/colors.dart';
import 'package:divyango_user/utils/Api.path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../homepage/navigation_page.dart';
import 'MySingUp.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key, key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? otp;
  String? mobile;
  bool isLoading = false;
  String? _selectedPro = 'Facebook';
  String? _loginType = 'phone';

  final _formKey = GlobalKey<FormState>();
  int selectedIndex = 99;
  bool selected = false;
  bool _obscureText = true;
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.whiteTemp,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            _loginImg(),
            _loginForm(),
          ],
        ),
      ),
    );
  }

  _loginImg() {
    return Container(
      margin: const EdgeInsets.only(top: 70),
      width: MediaQuery.of(context).size.width,
      child: SvgPicture.asset(
        'assets/images/signin.svg',
        fit: BoxFit.contain,
      ),
    );
  }

  _loginForm() {
    return Padding(
      padding: const EdgeInsets.only(top: 360),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2 + 30,
        decoration: const BoxDecoration(
          color: colors.secondary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // welcome txt
                    const Text(
                      "Sign In",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: colors.whiteFont),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Welcome, Please Enter Your Details",
                      style: TextStyle(fontSize: 16, color: colors.whiteFont),
                    ),

                    const SizedBox(height: 8),

                    // radio buttons
                    Row(
                      children: [
                        Radio<String>(
                          value: 'phone',
                          groupValue: _loginType,
                          fillColor:
                              MaterialStateProperty.all(colors.whiteFont),
                          onChanged: (String? value) {
                            setState(() {
                              _loginType = value;
                            });
                          },
                        ),
                        const Text(
                          "Phone",
                          style:
                              TextStyle(fontSize: 14, color: colors.whiteFont),
                        ),
                        Radio<String>(
                          value: 'email',
                          groupValue: _loginType,
                          fillColor:
                              MaterialStateProperty.all(colors.whiteFont),
                          onChanged: (String? value) {
                            setState(() {
                              _loginType = value;
                            });
                          },
                        ),
                        const Text(
                          "Email",
                          style:
                              TextStyle(fontSize: 14, color: colors.whiteFont),
                        )
                      ],
                    ),

                    const SizedBox(height: 4),

                    _loginType == 'phone'
                        // mobile txt field
                        ? TextFormField(
                            controller: mobileController,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            decoration: InputDecoration(
                              counterText: "",
                              filled: true,
                              isDense: true,
                              fillColor: colors.whiteTemp,
                              hintText: 'Mobile Number',
                              hintStyle:
                                  const TextStyle(color: colors.fieldTxt),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: const TextStyle(
                              color: colors.blackTemp,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a mobile number';
                              } else if (value.length < 10 ||
                                  value.length > 10) {
                                return 'Please enter valid mobile number';
                              }
                              return null;
                            },
                          )
                        : Column(
                            children: [
                              // Email Field
                              TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  filled: true,
                                  isDense: true,
                                  fillColor: colors.whiteTemp,
                                  hintText: 'Email',
                                  hintStyle:
                                      const TextStyle(color: colors.fieldTxt),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                style: const TextStyle(
                                  color: colors.blackTemp,
                                ),
                                validator: _validateEmail,
                              ),

                              const SizedBox(height: 10),

                              // Password Field
                              TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                controller: passController,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  filled: true,
                                  isDense: true,
                                  fillColor: colors.whiteTemp,
                                  hintText: 'Password',
                                  hintStyle:
                                      const TextStyle(color: colors.fieldTxt),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  ),
                                ),
                                style: const TextStyle(
                                  color: colors.blackTemp,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a password';
                                  } else if (value!.length < 8) {
                                    return 'Password is too short';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),

                    const SizedBox(height: 10),

                    // login button
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          _loginType == 'phone' ? login() : loginEmail();
                        }
                      },
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                            color: colors.primary,
                            borderRadius: BorderRadius.circular(10)),
                        child: isLoading
                            ? loadingWidget()
                            : Center(
                                child: Text(
                                  _loginType == 'phone' ? 'Send OTP' : 'Login',
                                  style: const TextStyle(
                                    color: colors.whiteTemp1,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                      ),
                    ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Checkbox(
                    //       checkColor: colors.secondary,
                    //       fillColor: MaterialStateProperty.all(colors.primary),
                    //       value: selected,
                    //       onChanged: (value) {
                    //         setState(() {
                    //           selected = value!;
                    //         });
                    //       },
                    //     ),
                    //     // Column(
                    //     //   children: [
                    //     //     const Text(
                    //     //       'By continuing you agree to our',
                    //     //       style: TextStyle(
                    //     //           fontSize: 14, color: colors.whiteFont),
                    //     //     ),
                    //     //     RichText(
                    //     //       text: TextSpan(
                    //     //         children: [
                    //     //           TextSpan(
                    //     //             text: 'Terms of Service',
                    //     //             style: const TextStyle(
                    //     //               color: colors.primary,
                    //     //               fontSize: 14,
                    //     //               fontWeight: FontWeight.bold,
                    //     //               decoration: TextDecoration.underline,
                    //     //             ),
                    //     //             recognizer: TapGestureRecognizer()
                    //     //               ..onTap = () {
                    //     //                 Navigator.push(
                    //     //                   context,
                    //     //                   MaterialPageRoute(
                    //     //                       builder: (context) =>
                    //     //                           const TermsAndCondition()),
                    //     //                 );
                    //     //               },
                    //     //           ),
                    //     //           const TextSpan(
                    //     //             text: ' And ',
                    //     //             style: TextStyle(
                    //     //               color: colors.whiteFont,
                    //     //             ),
                    //     //           ),
                    //     //           TextSpan(
                    //     //             text: 'Privacy Policy',
                    //     //             style: const TextStyle(
                    //     //               color: colors.primary,
                    //     //               fontSize: 14,
                    //     //               fontWeight: FontWeight.bold,
                    //     //               decoration: TextDecoration.underline,
                    //     //             ),
                    //     //             recognizer: TapGestureRecognizer()
                    //     //               ..onTap = () {
                    //     //                 Navigator.push(
                    //     //                     context,
                    //     //                     MaterialPageRoute(
                    //     //                         builder: (context) =>
                    //     //                             const PrivacyPolicy()));
                    //     //               },
                    //     //           ),
                    //     //         ],
                    //     //       ),
                    //     //     ),
                    //     //   ],
                    //     // ),
                    //   ],
                    // ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(fontSize: 14, color: colors.whiteFont),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUp(),
                            ),
                          );
                        },
                        child: const Text(
                          "SignUp",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: colors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validateEmail(value) {
    if (value!.isEmpty) {
      return "Please enter an email";
    }
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return "Please enter a valid email";
    }
  }

  login() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.sendOtp));
    request.fields.addAll({'mobile': mobileController.text});
    print('login para ${request.fields}');
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      if (finalResult['response_code'] == '1') {
        print("working=========");
        otp = finalResult["otp"];
        setState(() {});
        print("otp is $otp $proType");
        Fluttertoast.showToast(msg: '${finalResult['message']}');
        mobile = mobileController.text.toString();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Verification(
              OTP: otp.toString(),
              MOBILE: mobile.toString(),
            ),
          ),
        );
        setState(() {
          isLoading = false;
        });
        mobileController.clear();
      } else {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "${finalResult['message']}");
      }
    } else {
      setState(() {
        isLoading = false;
      });

      print(response.reasonPhrase);
    }
  }

  loginEmail() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.vendorlOgin));
    request.fields.addAll(
        {'email': emailController.text, 'password': passController.text});
    print('login para ${request.fields}');
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      if (finalResult['response_code'] == '1') {
        print("working=========");
        user_id = finalResult['user_id'];
        user_mobile = finalResult['mobile'];
        print("user id in verify otp $user_id $user_mobile");
        await prefs.setString('user_id', finalResult['user_id'].toString());
        await prefs.setString('mobile', user_mobile.toString());
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: '${finalResult['message']}');
        Navigator.push(
            context,
            MaterialPageRoute(
                // builder: (context) => const PersistanceNavBarWidget()));
                builder: (context) => const NavigationPage()));
        mobileController.clear();
      } else {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "${finalResult['message']}");
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print(response.reasonPhrase);
    }
  }
}
