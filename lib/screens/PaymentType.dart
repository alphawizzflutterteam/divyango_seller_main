import 'package:flutter/material.dart';
import '../services/btnPage.dart';
import '../services/colors.dart';
import '../widgets/appbar_widget.dart';
import 'Payment.dart';
import 'Payment1.dart';

class PaymentType extends StatefulWidget {
  const PaymentType({super.key});

  @override
  State<PaymentType> createState() => _PaymentTypeState();
}

class _PaymentTypeState extends State<PaymentType> {
  String select = "Visa";

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;

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
      //     padding: EdgeInsets.symmetric(horizontal: width * 0.13),
      //     child: Text("Payment Type"),
      //   ),
      // ),
      appBar: appBarWithBackWidget(
          context: context, title: '                  Payment Type', color: colors.whiteTemp1),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: height * 0.015, horizontal: width * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select payment method",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: height * 0.025),
            buildPaymentOption(
              context,
              imagePath: "assets/images/visa.png",
              label: "Visa",
              value: "Visa",
              imageHeight: height * 0.037,
              paddingWidth: width * 0.01,
            ),
            SizedBox(height: height * 0.022),
            buildPaymentOption(
              context,
              imagePath: "assets/images/phonepay.png",
              label: "Phone Pay",
              value: "Phone Pay",
              imageHeight: height * 0.05,
              paddingWidth: width * 0.01,
            ),
            SizedBox(height: height * 0.037),
            buildPaymentOption(
              context,
              imagePath: "assets/images/upi.png",
              label: "UPI Payment",
              value: "UPI Payment",
              imageHeight: height * 0.037,
              paddingWidth: width * 0.01,
            ),
            SizedBox(height: height * 0.037),
            buildPaymentOption(
              context,
              imagePath: "assets/images/googlepay.png",
              label: "Google Pay",
              value: "Google Pay",
              imageHeight: height * 0.05,
              paddingWidth: width * 0.01,
            ),
            Spacer(),
            // TextButton(
            //   onPressed: () {
            //     //Navigator.pop(context);
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => Payment()),
            //     );
            //   },
            //   child: Container(
            //     height: height * 0.05,
            //     width: width * 0.9,
            //     decoration: BoxDecoration(
            //       color: colors.primary,
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //     child: Center(
            //       child: Text(
            //         "Continue",
            //         style: TextStyle(color: Colors.white),
            //       ),
            //     ),
            //   ),
            // ),
            FilledBtn(
              width: 330,
              title: "Continue",
              onPress: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Payment()));
              },
            ),
            //SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }

  Widget buildPaymentOption(
      BuildContext context, {
        required String imagePath,
        required String label,
        required String value,
        required double imageHeight,
        required double paddingWidth,
      }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          SizedBox(width: paddingWidth),
          Image.asset(imagePath, height: imageHeight),
          SizedBox(width: paddingWidth * 2),
          Text(label),
          Spacer(),
          Radio(
            value: value,
            groupValue: select,
            activeColor: colors.primary,
            onChanged: (String? newValue) {
              setState(() {
                select = newValue!;
              });
            },
          ),
        ],
      ),
    );
  }
}
