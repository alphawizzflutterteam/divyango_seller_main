import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../services/btnPage.dart';
import '../../services/colors.dart';

class RegistrationSuccessWidget extends StatefulWidget {
  const RegistrationSuccessWidget({super.key});

  @override
  State<RegistrationSuccessWidget> createState() =>
      _RegistrationSuccessWidgetState();
}

class _RegistrationSuccessWidgetState extends State<RegistrationSuccessWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.bgColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.1),
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: Colors.grey, blurRadius: 1)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Great !",
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: colors.secondary),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "your account Created Successfully",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Center(
                        child: Image(
                            image: AssetImage('assets/images/IMG_7281.PNG')),
                      )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.13),
              child: FilledBtn(
                title: 'CONTINUE',
                onPress: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
