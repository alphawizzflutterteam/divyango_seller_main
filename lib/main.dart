import 'package:divyango_user/screens/auth/splashScreen.dart';
import 'package:divyango_user/utils/NoInternet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_no_internet_widget/flutter_no_internet_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return InternetWidget(
      offline: const FullScreenWidget(
        child: NoInternetScreen(),
      ),
      online: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DivyanGo Seller',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          fontFamily: 'OpenSans',
          textTheme: const TextTheme(
            // bodyLarge: TextStyle(fontFamily: 'Satoshi'),
            // bodyMedium: TextStyle(fontFamily: 'Satoshi'),
            // bodySmall: TextStyle(fontFamily: 'Satoshi'),
            // displayLarge: TextStyle(fontFamily: 'Satoshi'),
            // displayMedium: TextStyle(fontFamily: 'Satoshi'),
            // displaySmall: TextStyle(fontFamily: 'Satoshi'),
            bodyLarge: TextStyle(fontFamily: 'OpenSans'),
            bodyMedium: TextStyle(fontFamily: 'OpenSans'),
            bodySmall: TextStyle(fontFamily: 'OpenSans'),
            displayLarge: TextStyle(fontFamily: 'OpenSans'),
            displayMedium: TextStyle(fontFamily: 'OpenSans'),
            displaySmall: TextStyle(fontFamily: 'OpenSans'),
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}