import 'package:flutter/material.dart';

var milestoneCount;
List milestoneList = [1, 2, 3, 4];

Color getColor(double item) {
  if (item < milestoneCount) {
    return colors.primary;
  } else if (item > milestoneCount && item == item++) {
    return Colors.teal;
  }
  return Colors.red;
}

extension colors on ColorScheme {
  static MaterialColor primary_app = const MaterialColor(
    0xffFBB10C,
    const <int, Color>{
      50: primary,
      100: primary,
      200: primary,
      300: primary,
      400: primary,
      500: primary,
      600: primary,
      700: primary,
      800: primary,
      900: primary,
      1000: primary,
    },
  );

  static const Color primary = Color(0xffFBB10C); //0xffF8CE13
  static const Color primary10 = Color(0x20fbb10c); //0xffF8CE13
  static const Color secondary = Color(0xff4E821C); //0xff0194FE
  static const Color whiteFont = Color(0xffFFFFFF);
  static const Color blackTemp = Color(0xff000000);
  static const Color txtField = Color(0xffF3F3F3);
  static const Color fieldTxt = Color(0xFFB8B8B8);
  static const Color whiteTemp1 = Color(0xffFDF7DE);
  static const Color grey = Color(0xffD7E0FF);
  static const Color greyTemp = Color(0xffD9D9D9);
  static const Color darkgrey = Color(0xff848383);
  static const Color appbarColor = Color(0xFFE9E9E9);
  static const Color bgColor = Color(0xffF2F3FF);
  static const Color lightRed = Color(0xffFFEFCC);
  static const Color darkRed = Color(0xffB8163D);
  static const Color lightGreen = Color(0xffB8FFD0);
  static const Color darkGreen = Color(0xff2B6F1B);
  static const Color darkmbar = Color(0xffDDE7FF);
  static const Color light = Color(0xffFFEFCC);
  static const Color lightgreen = Color(0xff4E821C);

  // bool get apcolor  =>
  //      this.apcolor == number > 0 && number < 100;
  // this.brightness == Brightness.light ? primary : primary;
  Color get btnColor =>
      this.brightness == Brightness.dark ? whiteTemp : primary;

  Color get lightWhite =>
      this.brightness == Brightness.dark ? darkColor : const Color(0xffefefef);

  Color get fontColor =>
      this.brightness == Brightness.dark ? whiteTemp : const Color(0xff222222);

  Color get gray =>
      this.brightness == Brightness.dark ? darkColor3 : Color(0xfff0f0f0);

  Color get simmerBase =>
      this.brightness == Brightness.dark ? darkColor2 : Color(0xffFEE9E9E9);

  Color get simmerHigh =>
      this.brightness == Brightness.dark ? darkColor : Color(0xffFEE9E9E9);

  static Color darkIcon = Color(0xff9B9B9B);

  static const Color grad1Color = Color(0xffB7281D);
  static const Color grad2Color = Color(0xffB7281D);
  static const Color lightWhite2 = Color(0xffEEF2F3);

  static const Color transparent = Color(0xFFFBFBFB);
  static const Color darkBlue = Color(0xffB7281D);
  static const Color lightBlue = Color(0xFFADD8E6);
  static const Color purpleColor = Color(0xFF3E4095);
  static const Color darkYellow = Color(0xFFF58634);
  static const Color darkRed1= Color(0xFFED2F59);
  static const Color lightgray = Color(0xFFFBFBFB);

  static const Color yellow = Color(0xfffdb403);

  static const Color yellow2 = Color(0xffcea70e);

  //Color(0xfff1dd90);

  static const Color red = Colors.red;

  Color get lightBlack =>
      this.brightness == Brightness.dark ? whiteTemp : const Color(0xff52575C);

  Color get lightBlack2 =>
      this.brightness == Brightness.dark ? white70 : const Color(0xff999999);

  static const Color darkColor = Color(0xff17242B);
  static const Color darkColor2 = Color(0xff29414E);
  static const Color darkColor3 = Color(0xff22343C);

  Color get white =>
      this.brightness == Brightness.dark ? darkColor2 : const Color(0xffFFFFFF);
  static const Color whiteTemp = Color(0xffFFFFFF);

  Color get black =>
      this.brightness == Brightness.dark ? whiteTemp : const Color(0xff000000);

  static const Color white10 = Colors.white10;
  static const Color white30 = Colors.white30;
  static const Color white70 = Colors.white70;
  static const Color whiteScaffold = Color(0xffEFEFEF);

  static const Color black54 = Colors.black54;
  static const Color black12 = Colors.black12;
  static const Color disableColor = Color(0xffEEF2F9);

  static const Color blackTemp1 = Color(0xff000000);

  Color get black26 =>
      this.brightness == Brightness.dark ? white30 : Colors.black26;
  static const Color cardColor = Color(0xffFFFFFF);

  Color get back1 => this.brightness == Brightness.dark
      ? Color(0xff1E3039)
      : Color(0x66a2d8fe);

  Color get back2 => this.brightness == Brightness.dark
      ? Color(0xff09202C)
      : Color(0x66bdb1ff);

  Color get back3 => this.brightness == Brightness.dark
      ? Color(0xff10101E)
      : Color(0x66EFAFBF);

  Color get back4 => this.brightness == Brightness.dark
      ? Color(0xff171515)
      : Color(0x66F9DED7);

  Color get back5 => this.brightness == Brightness.dark
      ? Color(0xff0F1412)
      : Color(0x66C6F8E5);
}
double? deviceHeight;
double? deviceWidth;
