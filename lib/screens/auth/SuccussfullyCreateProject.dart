import 'package:divyango_user/screens/homepage/navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../services/colors.dart';
import '../homepage/persistance_nav_bar.dart';

class SuccessfullyCreate extends StatefulWidget {
  const SuccessfullyCreate({super.key});

  @override
  State<SuccessfullyCreate> createState() => _SuccessfullyCreateState();
}

class _SuccessfullyCreateState extends State<SuccessfullyCreate> {
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
            Container(
              height: MediaQuery.of(context).size.height * 0.10,
              child: Image.asset(
                'assets/images/SuccessfullyCreate.png',
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
                "Successfully Create Project",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: colors.blackTemp),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Center(
              child: Text(
                "You have successfully create project shorty we will connect will you",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
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
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            // builder: (context) => const PersistanceNavBarWidget()),
            builder: (context) => const NavigationPage()),
      );
    });
  }
}
