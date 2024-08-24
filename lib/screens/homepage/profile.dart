import 'dart:convert';
import 'package:divyango_user/screens/homepage/change_password.dart';
import 'package:divyango_user/screens/homepage/my_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Model/GetProfileModel.dart';
import '../../services/colors.dart';
import '../../utils/Api.path.dart';
import '../Edit Profile.dart';
import '../Faq.dart';
import '../PrivacyPolicy.dart';
import '../TermsAndCondition.dart';
import '../auth/mobile_login.dart';
import '../notification.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    super.initState();
    profile();
  }

  GetProfileModel? getProfileModel;
  bool isLoading = false;
  String? profileImage;

  profile() async {
    setState(() {
      isLoading = true;
    });
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? user_id = sharedPreferences.getString('user_id');
    String? proType = sharedPreferences.getString('proTypes');
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse(ApiServicves.getProfile));
      request.fields.addAll(
          {'user_id': user_id.toString(), 'pro_type': proType.toString()});
      print("profile para ${request.fields}");
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var finalResponse = await response.stream.bytesToString();
        var result = jsonDecode(finalResponse);
        if (result['status'] == true) {
          getProfileModel = GetProfileModel.fromJson(result);
          user_email = getProfileModel!.data!.cpEmail;
          user_mobile = getProfileModel!.data!.cpMobile;
          user_name = getProfileModel!.data!.cpName;
          business_name = getProfileModel!.data!.projectName;
          profileImage = getProfileModel!.data!.logo;
          project_Code = result["project_code"];
          is_Active = result["is_active"];
          await sharedPreferences.setString(
              'projectCode', result["project_code"].toString());
          await sharedPreferences.setString(
              'isActive', result["is_active"].toString());
          print(
              "profile data $user_name 2 $user_mobile 3 $user_email 4 $project_Code 5 $is_Active");
          isLoading = false;
          setState(() {});
        }
      } else {
        print(response.reasonPhrase);
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.whiteTemp,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colors.secondary,
        leading: SizedBox(),
        leadingWidth: 0,
        title: Row(
          children: [
            SvgPicture.asset('assets/images/mingcute_location-fill.svg'),
            const SizedBox(width: 4),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ward 35...",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  "Ratna Lok Colony, Indore",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationScreen()));
              },
              child: SvgPicture.asset('assets/images/Notification.svg')),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // profile card
          _profileCard(),

          const SizedBox(height: 10),

          // InkWell(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => const PaymentSelectionWidget()),
          //     );
          //   },
          //       child: Padding(
          //         padding: const EdgeInsets.only(left: 16, top: 10, right: 16),
          //         child: Container(
          //           width: double.infinity,
          //           height: 40,
          //           decoration: BoxDecoration(
          //             color: colors.grey,
          //             borderRadius: BorderRadius.circular(5),
          //           ),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceAround,
          //             children: [
          //               Text(
          //                 'Admin requested for payment',
          //                 style: TextStyle(fontWeight: FontWeight.bold),
          //               ),
          //               Icon(Icons.arrow_forward_ios)
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          // SizedBox(height: 20,),
          // const Padding(
          //   padding: EdgeInsets.only(left: 16, right: 16, top: 20),
          //   child: Text(
          //     'Details',
          //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          //   ),
          // ),


          // // business detail
          // InkWell(
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => BusinessDetails()));
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: const [
          //         Text(
          //           'Business Details',
          //           style: TextStyle(color: colors.darkgrey, fontSize: 14),
          //         ),
          //         Icon(Icons.arrow_forward_ios)
          //       ],
          //     ),
          //   ),
          // ),
          // Divider(color: colors.greyTemp),
          // // my wallet
          // InkWell(
          //   onTap: () {
          //     Navigator.push(
          //         context, MaterialPageRoute(builder: (context) => Mywallet()));
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: const [
          //         Text(
          //           'My Wallet',
          //           style: TextStyle(color: colors.darkgrey, fontSize: 14),
          //         ),
          //         Icon(Icons.arrow_forward_ios)
          //       ],
          //     ),
          //   ),
          // ),
          // Divider(color: colors.greyTemp),
          // // transaction
          // InkWell(
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => TransactionScreen()));
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: const [
          //         Text(
          //           'Transaction',
          //           style: TextStyle(color: colors.darkgrey, fontSize: 14),
          //         ),
          //         Icon(Icons.arrow_forward_ios)
          //       ],
          //     ),
          //   ),
          // ),
          // Divider(color: colors.greyTemp),

          // privacy policy
          settingCard(
            svgImg: SvgPicture.asset('assets/images/Privacy policy.svg'),
            title: 'Privacy Policy',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PrivacyPolicy()));
            },
          ),

          // terms conditions
          settingCard(
            svgImg: SvgPicture.asset('assets/images/terms_condition.svg'),
            title: 'Terms and Conditions',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TermsAndCondition()));
            },
          ),

          // faqs
          settingCard(
            svgImg: SvgPicture.asset('assets/images/FAQs.svg'),
            title: 'FAQs',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FaqScreen()),
              );
            },
          ),

          // change password
          settingCard(
            svgImg: SvgPicture.asset('assets/images/Change Password.svg'),
            title: 'Change Password',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChangePassword()),
              );
            },
          ),

          // logout
          InkWell(
            onTap: () {
              bottomSheet();
            },
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/images/Logout.svg'),
                  SizedBox(width: 8),
                  Text(
                    'Logout',
                    style: TextStyle(color: colors.red, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _profileCard() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: colors.primary10,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 72,
                        width: 72,
                        decoration: BoxDecoration(
                          // border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                          //color: Colors.blue,
                          image: DecorationImage(
                              image: NetworkImage(profileImage.toString()),
                              fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          business_name == null || business_name == ""
                              ? const Text(
                                  "User Name",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : Container(
                                  width: 160,
                                  child: Text(
                                    user_name.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/Call-1.png',
                                height: 16,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              user_mobile == null || user_mobile == ""
                                  ? const Text("+91")
                                  : Text(
                                      user_mobile.toString(),
                                    ),
                            ],
                          ),
                          // const SizedBox(
                          //   height: 5,
                          // ),
                          // Row(
                          //   children: [
                          //     Image.asset(
                          //       'assets/images/Message.png',
                          //     ),
                          //     const SizedBox(
                          //       width: 4,
                          //     ),
                          //     user_email == null || user_email == ""
                          //         ? Text("Business@gmail.com")
                          //         : Text(
                          //             user_email.toString(),
                          //           ),
                          //   ],
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MyProfile()));
        },
      ),
    );
  }

  bottomSheet() {
    // Show the bottom sheet when the button is pressed
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Image.asset('assets/images/logoutImage.png'),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Logout',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text(
                'Are you sure ,that you want to logout?',
                style: TextStyle(color: colors.darkgrey),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: colors.blackTemp)),
                      child: const Center(child: Text('Cancel')),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      removeSession();
                      PersistentNavBarNavigator.pushNewScreen(
                        context, screen: const LoginPage(),
                        withNavBar: false, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                      // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      //     LoginPage()), (Route<dynamic> route) => false);
                      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                    },
                    child: Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        color: colors.primary,
                        borderRadius: BorderRadius.circular(10),
                        // border: Border.all(color: colors.blackTemp)
                      ),
                      child: const Center(
                          child: Text(
                        'Logout',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: colors.whiteTemp1),
                      )),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> removeSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("user_id");
    prefs.remove("cp_mobile");
  }
}

class settingCard extends StatelessWidget {
  Widget svgImg;
  String title;
  void Function() onTap;

  settingCard(
      {super.key,
      required this.svgImg,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      svgImg,
                      SizedBox(width: 8),
                      Text(
                        title,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                ],
              ),
            ),
            const Divider(color: colors.greyTemp),
          ],
        ),
      ),
    );
  }
}
