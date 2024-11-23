import 'package:divyango_user/screens/homepage/navigation_page.dart';
import 'package:flutter/material.dart';

import 'homepage/leads.dart';
import 'homepage/leadsdetails.dart';

class PaySuccessful extends StatefulWidget {
  const PaySuccessful({Key,key});

  @override
  State<PaySuccessful> createState() => _PaySuccessfulState();
}

class _PaySuccessfulState extends State<PaySuccessful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          Navigator.pop(context);
          //Navigator.pop(context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NavigationPage()));
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/paymentsucees.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: null /* add child content here */,
        ),
      ),
    );
  }
}
