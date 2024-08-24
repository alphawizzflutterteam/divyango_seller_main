import 'package:flutter/material.dart';

import '../services/btnPage.dart';
import '../services/colors.dart';
import '../widgets/appbar_widget.dart';
import 'PaymentType.dart';

class Subscription extends StatefulWidget {
  const Subscription({super.key});

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  int isSelect = 0;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;

    return Scaffold(
      // appBar: AppBar(
      //   leading: GestureDetector(
      //       onTap: () {
      //         Navigator.pop(context);
      //       },
      //       child: Icon(
      //         Icons.arrow_back_ios,
      //         color: Colors.white,
      //       )),
      //   backgroundColor: colors.secondary,
      //   title: Padding(
      //     padding: EdgeInsets.symmetric(horizontal: width * 0.13),
      //     child: Text(
      //       "Subscription",
      //       style: TextStyle(color: Colors.white),
      //     ),
      //   ),
      // ),
      appBar: appBarWithBackWidget(
          context: context, title: '                   Subscription', color: colors.whiteTemp1),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.040, vertical: height * 0.014),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.025),
            Center(
                child: Image.asset("assets/images/subscription.png",
                    height: height * 0.25)),
            SizedBox(height: height * 0.025),
            Text(
              "Subscription Plan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: height * 0.025),
            Container(
              height: height * 0.3,
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelect = 0;
                            });
                          },
                          child: Container(
                            height: height * 0.29,
                            width: width * 0.4,
                            decoration: BoxDecoration(
                              color: isSelect == 0
                                  ? Colors.grey[200]
                                  : Colors.white,
                              border: isSelect == 0
                                  ? Border.all(
                                      color: colors.secondary,
                                    )
                                  : Border.all(
                                      color: Colors.white,
                                    ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.04,
                                  vertical: height * 0.02),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(height: height * 0.0125),
                                      Text(
                                        "₹",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        "562",
                                        style: TextStyle(
                                            fontSize: 27,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "/annual",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.019,
                                  ),
                                  Text(
                                    "Yearly",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: colors.primary),
                                  ),
                                  SizedBox(
                                    height: height * 0.0,
                                  ),
                                  Text(
                                    "Lorem Ipsum is simply dummy text\nof the printing and typesetting\nindustry",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.070,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelect = 1;
                            });
                          },
                          child: Container(
                            height: height * 0.29,
                            width: width * 0.4,
                            decoration: BoxDecoration(
                              color: isSelect == 1
                                  ? Colors.grey[200]
                                  : Colors.white,
                              border: isSelect == 1
                                  ? Border.all(
                                      color: colors.secondary,
                                    )
                                  : Border.all(
                                      color: Colors.white,
                                    ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.04,
                                  vertical: height * 0.02),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(height: height * 0.0125),
                                      Text(
                                        "₹",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Text(
                                        "62",
                                        style: TextStyle(
                                            fontSize: 27,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "/monthly",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.019,
                                  ),
                                  Text(
                                    "Monthly",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: colors.primary),
                                  ),
                                  SizedBox(
                                    height: height * 0.0,
                                  ),
                                  Text(
                                    "Lorem Ipsum is simply dummy text\nof the printing and typesetting\nindustry",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: height * 0.130,
            ),
            // TextButton(
            //   onPressed: () {
            //     Navigator.pop(context);
            //      Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentType()));
            //   },
            //   child: Container(
            //     height: height * 0.05,
            //     width: width * 0.85,
            //     decoration: BoxDecoration(
            //       color: colors.primary,
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //     child: Center(
            //       child: Text(
            //         "Choose Plan",
            //         style: TextStyle(color: Colors.white),
            //       ),
            //     ),
            //   ),
            // ),
            FilledBtn(
              width: 330,
              title: "Choose Plan",
              onPress: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PaymentType()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
