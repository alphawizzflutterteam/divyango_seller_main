import 'package:flutter/cupertino.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../services/colors.dart';

class ApiServicves {
  static const String baseUrl = "https://dberp.digitalbuzzindia.com/api/";
  static const String imageUrl = "https://dberp.digitalbuzzindia.com/";

  static const String usserSignUp = '${baseUrl}create_project';
  static const String cities = '${baseUrl}get_cities';
  static const String sendOtp = '${baseUrl}send_otp';
  static const String verifyOtp = '${baseUrl}verify_otp';
  static const String getpolicy = '${baseUrl}get_policies';
  static const String getProfile = '${baseUrl}get_profile';
  static const String updateProfile = '${baseUrl}update_profile';
  static const String campagin = '${baseUrl}get_campaign';
  static const String transaction = '${baseUrl}get_transactions';
  static const String faqs = '${baseUrl}get_faqs';
  static const String getTransaction = '${baseUrl}get_wallet';
  static const String addWallet = '${baseUrl}add_wallet';
}

int? user_id;
String? user_mobile,
    proType,
    user_email,
    user_name,
    business_name,
    project_Code,
    is_Active;

Widget loadingWidget() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        "Loading  ",
        style: TextStyle(
          fontSize: 18,
          color: colors.whiteTemp,
        ),
      ),
      Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: colors.whiteTemp,
          size: 30,
        ),
      ),
    ],
  );
}
