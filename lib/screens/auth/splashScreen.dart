import 'package:divyango_user/screens/homepage/navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/colors.dart';
import '../homepage/persistance_nav_bar.dart';
import 'mobile_login.dart';
String? finalOtp;

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getValidation();
    // TODO: implement initState
    super.initState();
  }


  Future getValidation() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? user_id = sharedPreferences.getString('user_id');
    print("user id in splash screen $user_id");
    finalOtp = user_id;
    _navigateToHome();
  }

  _navigateToHome() {
    Future.delayed(const Duration(seconds:2),() {
      if (finalOtp == null || finalOtp ==  '') {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
      } else {
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  PersistanceNavBarWidget()));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>  NavigationPage()));
      }
    },
    );
  }


  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/Splash.png"),
          fit: BoxFit.fill,
        ),
      ),
      // child: const Image(image: AssetImage('assets/images/logo.svg')),
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: SvgPicture.asset('assets/images/logo.svg'),
      ),
    );
  }
}
