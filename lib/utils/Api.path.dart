import 'package:flutter/cupertino.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../services/colors.dart';

class ApiServicves {
  static const String baseUrl =
      "https://developmentalphawizz.com/divyango_new/api/";
  static const String imageUrl =
      "https://developmentalphawizz.com/divyango_new/uploads/";

  static const String usserSignUp = '${baseUrl}vendor_register';
  static const String changePassword = '${baseUrl}change_password';
  static const String sendOtp = '${baseUrl}v_send_otp';
  static const String vendorlOgin = '${baseUrl}vendor_login';
  static const String verifyOtp = '${baseUrl}v_verify_otp';
  static const String getpolicy = '${baseUrl}pages';
  static const String getProfile = '${baseUrl}vendor_data';
  static const String updateProfile = '${baseUrl}vendor_edit';
  static const String getCategory = '${baseUrl}get_all_cat';
  static const String transaction = '${baseUrl}get_transactions';
  static const String faqs = '${baseUrl}vendor_faq';
  static const String getAccessibility = '${baseUrl}get_all_accessibility';
  static const String venueList = '${baseUrl}get_venue_list';
  static const String deletVenue = '${baseUrl}delete_venue';
  static const String plans = '${baseUrl}get_plans';
  static const String myplan = '${baseUrl}my_plans';
  static const String planPurcahse = '${baseUrl}purchase_plan';
  static const String getReview = '${baseUrl}get_review_venue';
  static const String addVenues = '${baseUrl}add_venue';
  static const String editVenues = '${baseUrl}edit_venue';
}

String? user_id;
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
