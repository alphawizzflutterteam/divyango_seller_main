import 'dart:convert';

import 'package:divyango_user/screens/PrivacyPolicy.dart';
import 'package:divyango_user/screens/TermsAndCondition.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../services/colors.dart';
import '../../utils/Api.path.dart';
import 'mobile_login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key, key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isSelect = false;
  String? selectedBusiness;
  final List<String> selectedBusinessOptions = ["Chai ki Dukan", "showroom"];
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _checkbox = false;
  bool _showError = false; // Track if form errors should be shown
  bool _checkboxError = false; // Track if checkbox error should be shown

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a mobile number';
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Please enter a valid 10-digit mobile number';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final addressController = TextEditingController();
  final passwordCtr = TextEditingController();
  final confirmPswCtr = TextEditingController();
  final businessNameCtr = TextEditingController();
  final businessContactCtr = TextEditingController();
  final typeOfBusinessCtr = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    businessType();
  }

  String? droopUplocation;
  String? droopLat;
  String? droopLong;

  register() async {
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.usserSignUp));
    request.fields.addAll({
      'uname': nameController.text,
      'mobile': mobileController.text,
      'email': emailController.text,
      'address': addressController.text,
      'password': passwordController.text,
      'confirm_password': confirmPasswordController.text,
      'bussiness_name': businessNameCtr.text,
      'type_of_bussiness': selectedCategory.toString(),
      'bussiness_contact': businessContactCtr.text,
      'lat': droopLat.toString(),
      'lang': droopLong.toString(),
    });
    print("registration para ${request.fields}");
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finaResult = jsonDecode(result);
      if (finaResult['response_code'] == '1') {
        setState(() {});
        Fluttertoast.showToast(msg: '${finaResult['message']}');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
        nameController.clear();
        mobileController.clear();
        emailController.clear();
        addressController.clear();
      } else {
        Fluttertoast.showToast(msg: "${finaResult['message']}");
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  bool isLoading = true;
  List<String> categories = [];
  String? selectedCategory;

  Future<void> businessType() async {
    print("Starting API call...");
    final String apiUrl =
        "https://developmentalphawizz.com/divyango_new/api/types_of_bussiness";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        print("Response Status Code: ${response.statusCode}");
        final data = json.decode(response.body);

        // Debugging: Print the entire response data
        print("Response Data: $data");

        if (data['status'] == "success") {
          List<dynamic> businessList = data['data'];
          setState(() {
            categories = businessList
                .map((item) => item['bussiness_name'] as String)
                .toList();
            selectedCategory = categories.isNotEmpty
                ? categories[0]
                : null; // Default to first item
            isLoading = false;
          });
        } else {
          print("API returned a non-success status.");
          setState(() {
            isLoading = false;
          });
        }
      } else {
        print("Failed to fetch data. Status code: ${response.statusCode}");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error during API call: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.04),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenHeight * 0.16),
                        child: const Text(
                          "Sign up",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  "Sign Up",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
                const Text(
                  "Enter the details below field",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Row(
                  children: [
                    Text(
                      "Personal info",
                      style: TextStyle(
                          fontSize: 16,
                          color: isSelect ? colors.secondary : colors.primary),
                    ),
                    SizedBox(
                      width: screenHeight * 0.10,
                    ),
                    Text(
                      "Business info",
                      style: TextStyle(
                          fontSize: 16,
                          color: isSelect ? colors.primary : Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        height: 20,
                        color: isSelect ? colors.secondary : colors.primary,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        height: 20,
                        color: isSelect ? colors.primary : Colors.grey.shade50,
                      ),
                    ),
                  ],
                ),
                isSelect
                    ? Column(
                        children: [
                          Textbattonn(
                            controller: businessNameCtr,
                            hint: "Business name",
                            validator: (value) {
                              if (_showError) {
                                return value!.isEmpty
                                    ? 'Please enter a business name'
                                    : null;
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : categories.isNotEmpty
                                  ? Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border:
                                              Border.all(color: Colors.black12),
                                          color: Colors.grey[200]),
                                      child: Column(
                                        children: [
                                          // const Text(
                                          //   "Select a Business Type:",
                                          //   style: TextStyle(
                                          //       fontSize: 18,
                                          //       fontWeight: FontWeight.bold),
                                          // ),
                                          SizedBox(height: 16),
                                          DropdownButton<String>(
                                            underline: SizedBox.shrink(),
                                            value: selectedCategory,
                                            isExpanded: true,
                                            items: categories
                                                .map((String category) =>
                                                    DropdownMenuItem<String>(
                                                      value: category,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(category),
                                                      ),
                                                    ))
                                                .toList(), // Correct mapping
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedCategory = newValue;
                                              });
                                              print(
                                                  "Selected Business Type: $selectedCategory");
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  : const Center(
                                      child: Text('No Business available.'),
                                    ),
                          SizedBox(
                            height: 5,
                          ),
                          Textbattonn(
                            isPhoneNumber: true,
                            controller: businessContactCtr,
                            hint: "Business contact Details",
                            validator: (value) {
                              if (_showError) {
                                return value!.isEmpty
                                    ? 'Please enter business contact details'
                                    : null;
                              }
                              return null;
                            },
                          ),
                          AddressBatton(
                            controller: addressController,
                            hint: "Address",
                            validator: (value) {
                              if (_showError) {
                                return value!.isEmpty
                                    ? 'Please enter an address'
                                    : null;
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: screenHeight * 0.11,
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Textbattonn(
                            controller: nameController,
                            hint: "Name",
                            validator: (value) {
                              if (_showError) {
                                return value!.isEmpty
                                    ? 'Please enter your name'
                                    : null;
                              }
                              return null;
                            },
                          ),
                          Textbattonn(
                            isPhoneNumber: true,
                            controller: mobileController,
                            keytype: const TextInputType.numberWithOptions(),
                            hint: "Personal Mobile Number",
                            validator: validateMobileNumber,
                          ),
                          Textbattonn(
                            controller: emailController,
                            hint: "Email",
                            validator: validateEmail,
                          ),
                          Textbattonn(
                            hint: "Create Password",
                            isPassword: true,
                            isPasswordVisible: isPasswordVisible,
                            controller: passwordController,
                            validator: validatePassword,
                            togglePasswordVisibility: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                          Textbattonn(
                            hint: "Confirm Password",
                            isPassword: true,
                            isPasswordVisible: isConfirmPasswordVisible,
                            controller: confirmPasswordController,
                            validator: validateConfirmPassword,
                            togglePasswordVisibility: () {
                              setState(() {
                                isConfirmPasswordVisible =
                                    !isConfirmPasswordVisible;
                              });
                            },
                          ),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          Row(
                            children: [
                              Container(
                                height: screenHeight * 0.02,
                                child: Checkbox(
                                  value: _checkbox,
                                  activeColor: colors.primary,
                                  onChanged: (value) {
                                    setState(() {
                                      _checkbox = value!;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              const Text("By Continuing you agree to our"),
                            ],
                          ),
                          if (_checkboxError)
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                "You must agree to the terms to continue.",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          Container(
                            height: screenHeight * 0.05,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const TermsAndCondition(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Terms of Service",
                                    style: TextStyle(color: colors.secondary),
                                  ),
                                ),
                                const Text(" and "),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const PrivacyPolicy(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Privacy Policy",
                                    style: TextStyle(color: colors.secondary),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                SizedBox(
                  height: screenHeight * 0.09,
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _showError = true;
                      _checkboxError = !_checkbox;
                      if (_formKey.currentState!.validate() && _checkbox) {
                        // If form is valid and checkbox is checked, toggle isSelect and navigate if necessary
                        if (isSelect) {
                          register();
                        }
                        isSelect = !isSelect;
                      }
                    });
                  },
                  child: Container(
                    height: screenHeight * 0.06,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        isSelect ? "Sign Up" : "Next",
                        style: const TextStyle(color: Colors.white),
                      ),
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

class BusinessDropdown extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> options;
  final ValueChanged<String?> onChanged;

  BusinessDropdown({
    required this.hint,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        border: InputBorder.none,
        fillColor: Colors.grey[200],
        hintText: hint,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      value: value,
      items: options.map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}

class Textbattonn extends StatefulWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  Textbattonn({
    Key,
    key,
    required this.hint,
    this.iconn,
    this.isPassword = false,
    this.isPasswordVisible,
    this.togglePasswordVisibility,
    this.controller,
    this.validator,
    this.keytype,
    this.isPhoneNumber = false,
  });
  final keytype;
  final String hint;
  final Widget? iconn;
  final bool isPassword;
  final bool? isPasswordVisible;
  final VoidCallback? togglePasswordVisibility;
  final bool isPhoneNumber;

  @override
  State<Textbattonn> createState() => _TextbattonnState();
}

class _TextbattonnState extends State<Textbattonn> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        keyboardType: widget.keytype,
        controller: widget.controller,
        validator: widget.validator,
        maxLength: widget.isPhoneNumber ? 10 : null,
        obscureText: widget.isPassword && !(widget.isPasswordVisible ?? false),
        decoration: InputDecoration(
          counterText: "",
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          border: InputBorder.none,
          fillColor: Colors.grey[200],
          hintText: widget.hint,
          prefixIcon: widget.iconn,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    widget.isPasswordVisible ?? false
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: widget.togglePasswordVisibility,
                )
              : null,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

class AddressBatton extends StatefulWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  AddressBatton({
    Key,
    key,
    required this.hint,
    this.iconn,
    this.isPassword = false,
    this.isPasswordVisible,
    this.togglePasswordVisibility,
    this.controller,
    this.validator,
    this.keytype,
    this.onChanged,
  });
  final keytype;
  final String hint;
  final Widget? iconn;
  final bool isPassword;
  final bool? isPasswordVisible;
  final ValueChanged<String>? onChanged;
  final VoidCallback? togglePasswordVisibility;

  @override
  State<AddressBatton> createState() => _AddressBattonState();
}

class _AddressBattonState extends State<AddressBatton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        onChanged: widget.onChanged,
        maxLines: 4,
        keyboardType: widget.keytype,
        controller: widget.controller,
        validator: widget.validator,
        obscureText: widget.isPassword && !(widget.isPasswordVisible ?? false),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          border: InputBorder.none,
          fillColor: Colors.grey[200],
          hintText: widget.hint,
          prefixIcon: widget.iconn,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    widget.isPasswordVisible ?? false
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: widget.togglePasswordVisibility,
                )
              : null,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
