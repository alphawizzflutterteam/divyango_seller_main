import 'package:flutter/material.dart';
import '../../services/colors.dart';
import '../homepage/leads.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isSelect = false;
  String? selectedBusiness;
  final List<String> selectedBusinessOptions = ["Chai ki dukan", "showroom"];
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _checkbox = true;
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
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenHeight * 0.16),
                        child: Text(
                          "Sign up",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Sign Up",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
                Text(
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
                          BusinessDropdown(
                            hint: "Type of business",
                            value: selectedBusiness,
                            options: selectedBusinessOptions,
                            onChanged: (newValue) {
                              setState(() {
                                selectedBusiness = newValue;
                              });
                            },
                          ),
                          Textbattonn(
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
                            keytype: TextInputType.numberWithOptions(),
                            hint: "Personal Mobile Number",
                            validator: validateMobileNumber,
                          ),
                          Textbattonn(
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
                              Text("By Continuing you agree to our"),
                            ],
                          ),
                          if (_checkboxError)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
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
                                  onPressed: () {},
                                  child: Text(
                                    "Terms of Service",
                                    style: TextStyle(color: colors.secondary),
                                  ),
                                ),
                                Text(" and "),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LeadsWidget(),
                            ),
                          );
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
                        style: TextStyle(color: Colors.white),
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
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        border: InputBorder.none,
        fillColor: Colors.grey[200],
        hintText: hint,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
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
    super.key,
    required this.hint,
    this.iconn,
    this.isPassword = false,
    this.isPasswordVisible,
    this.togglePasswordVisibility,
    this.controller,
    this.validator,
    this.keytype,
  });
  final keytype;
  final String hint;
  final Widget? iconn;
  final bool isPassword;
  final bool? isPasswordVisible;
  final VoidCallback? togglePasswordVisibility;

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
        obscureText: widget.isPassword && !(widget.isPasswordVisible ?? false),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
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
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
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
    super.key,
    required this.hint,
    this.iconn,
    this.isPassword = false,
    this.isPasswordVisible,
    this.togglePasswordVisibility,
    this.controller,
    this.validator,
    this.keytype,
  });
  final keytype;
  final String hint;
  final Widget? iconn;
  final bool isPassword;
  final bool? isPasswordVisible;
  final VoidCallback? togglePasswordVisibility;

  @override
  State<AddressBatton> createState() => _AddressBattonState();
}

class _AddressBattonState extends State<AddressBatton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        maxLines: 4,
        keyboardType: widget.keytype,
        controller: widget.controller,
        validator: widget.validator,
        obscureText: widget.isPassword && !(widget.isPasswordVisible ?? false),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
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
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
