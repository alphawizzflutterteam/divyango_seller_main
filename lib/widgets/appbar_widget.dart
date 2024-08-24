import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/colors.dart';

AppBar appBarWidget() {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    //leading: Image(image: AssetImage("assets/images/logo.png")),
    actions: [
      const Icon(
        CupertinoIcons.bell,
        color: Colors.black,
      ),
      const SizedBox(
        width: 15,
      ),
    ],
  );
}

AppBar appBarWithBackWidget({required BuildContext context, required String title, required Color color}) {
  return AppBar(
    backgroundColor: colors.secondary,
    foregroundColor: colors.whiteFont,
    elevation: 0,
    //leading: Image(image: AssetImage("assets/images/logo.png")),
    leading: InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: const Padding(
        padding: EdgeInsets.only(left: 10),
        child: Icon(
          Icons.arrow_back_ios,
          size: 20,
        ),
      ),
    ),
    leadingWidth: 40,
    title: Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  );
}
