import 'package:divyango_user/screens/paymentSuccessful.dart';
import 'package:flutter/material.dart';

import '../services/btnPage.dart';
import '../services/colors.dart';
import '../widgets/appbar_widget.dart';

class Payment extends StatefulWidget {
  const Payment({Key, key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final _formKey = GlobalKey<FormState>();
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   leading: GestureDetector(
        //     onTap: () {
        //       Navigator.pop(context);
        //     },
        //     child: Icon(
        //       Icons.arrow_back_ios,
        //       color: Colors.white,
        //     ),
        //   ),
        //   backgroundColor: colors.secondary,
        //   title: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 65.0),
        //     child: Text("Payment"),
        //   ),
        // ),
        appBar: appBarWithBackWidget(
            context: context,
            title: '                      Payment',
            color: colors.whiteTemp1),
        body: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Textbattonn(
                      hint: "Enter your name",
                      validator: validateName,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Textbattonn(
                      iconn: Icon(Icons.payment),
                      hint: "Card Number",
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Textbattonn(
                      hint: "Expiry Date",
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Textbattonn(
                      hint: "CVV",
                    ),
                    SizedBox(
                      height: 345,
                    ),
                    // TextButton(
                    //   onPressed: () {
                    //     Navigator.pop(context);
                    //     //Navigator.pop(context);
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(builder: (context) => PaySuccessful()),
                    //     );
                    //   },
                    //   child: Container(
                    //     height: 40,
                    //     width: 343,
                    //     decoration: BoxDecoration(
                    //       color: colors.primary,
                    //       borderRadius: BorderRadius.circular(8),
                    //     ),
                    //     child: Center(
                    //       child: Text(
                    //         "Pay Now",
                    //         style: TextStyle(color: Colors.white),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    FilledBtn(
                        width: 330,
                        title: "Pay Now",
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PaySuccessful()));
                          }
                        }
                        // {
                        //
                        //  // Navigator.pop(context);
                        //   Navigator.push(context,
                        //       MaterialPageRoute(builder: (context) => PaySuccessful()));
                        // },
                        ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class Textbattonn extends StatefulWidget {
  Textbattonn({Key, key, required this.hint, this.iconn, this.validator});
  var hint, iconn, validator;

  @override
  State<Textbattonn> createState() => _TextbattonnState();
}

class _TextbattonnState extends State<Textbattonn> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        border: InputBorder.none,
        fillColor: Colors.grey[200],
        hintText: widget.hint,
        prefixIcon: widget.iconn,
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
    );
  }
}
