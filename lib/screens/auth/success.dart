import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

import '../../services/colors.dart';

class SuccussScreen extends StatefulWidget {
  const SuccussScreen({Key,key});

  @override
  State<SuccussScreen> createState() => _SuccussScreenState();
}

class _SuccussScreenState extends State<SuccussScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image:
                    AssetImage("assets/images/Successfully Create Project.png"),
                fit: BoxFit.fill)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.10,
              child: SvgPicture.asset(
                'assets/images/Tick Square.svg',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const SizedBox(
              height: 5,
            ),
            const Center(
              child: Text(
                "Payment Successful",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: colors.blackTemp),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Center(
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colors.black12),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  show() {
    Future.delayed(const Duration(seconds: 5), () {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) =>HomePageWidget()),
      // );
    });
  }
}
