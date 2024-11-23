import 'dart:convert';

import 'package:divyango_user/services/btnPage.dart';
import 'package:divyango_user/services/colors.dart';
import 'package:divyango_user/utils/Api.path.dart';
import 'package:divyango_user/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key, key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool? isLoading;

  changePass() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? user_id = sharedPreferences.getString('user_id');
    setState(() {
      isLoading = true;
    });
    var headers = {
      'Cookie': 'ci_session=8f5f4c48878524fcaf4acee4273ec526eb31df64'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.changePassword));
    request.fields.addAll({
      'user_id': user_id.toString(),
      'password': oldPswCtr.text,
      'npassword': newPswCtr.text,
      'cpassword': confirmPswCtr.text,
    });
    print("chanege password para ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = json.decode(result);
      if (finalResult['response_code'] == '1') {
        Fluttertoast.showToast(msg: '${finalResult['message']}');
        isLoading = false;
        Navigator.pop(context);
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  TextEditingController oldPswCtr = TextEditingController();
  TextEditingController newPswCtr = TextEditingController();
  TextEditingController confirmPswCtr = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWithBackWidget(
            context: context, title: "Change Password", color: colors.primary),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Old Password Field
                TextFormField(
                  controller: oldPswCtr,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    filled: true,
                    isDense: true,
                    fillColor: colors.txtField,
                    hintText: 'Old Password',
                    hintStyle: const TextStyle(color: colors.fieldTxt),
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
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  style: TextStyle(
                    color: colors.darkgrey,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    } else if (value.length < 8) {
                      return 'Password is too short';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),
                // New Password Field
                TextFormField(
                  controller: newPswCtr,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    filled: true,
                    isDense: true,
                    fillColor: colors.txtField,
                    hintText: 'New Password',
                    hintStyle: const TextStyle(color: colors.fieldTxt),
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
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  style: const TextStyle(
                    color: colors.darkgrey,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    } else if (value.length < 8) {
                      return 'Password is too short';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),
                // Confirm Password Field
                TextFormField(
                  controller: confirmPswCtr,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    filled: true,
                    isDense: true,
                    fillColor: colors.txtField,
                    hintText: 'Confirm Password',
                    hintStyle: const TextStyle(color: colors.fieldTxt),
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
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  style: const TextStyle(
                    color: colors.darkgrey,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    } else if (value.length < 8) {
                      return 'Password is too short';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FilledBtn(
            title: 'Change Password',
            onPress: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  isLoading = true;
                });
                changePass();
              }
            },
          ),
        ));
  }
}
