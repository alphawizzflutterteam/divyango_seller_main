import 'dart:convert';

import 'package:divyango_user/Model/GetProfileModel.dart';
import 'package:divyango_user/screens/Edit%20Profile.dart';
import 'package:divyango_user/services/btnPage.dart';
import 'package:divyango_user/services/colors.dart';
import 'package:divyango_user/utils/Api.path.dart';
import 'package:divyango_user/widgets/appbar_widget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

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
      appBar: appBarWithBackWidget(
          context: context, title: "Profile", color: colors.primary),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FilledBtn(
            title: 'Edit Profile',
            onPress: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditProfile()),
            )),
      ),
      body:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 28),
          Column(
            children: [
              Center(
                child: Stack(
                  children:[

                    Container(
                    // margin: EdgeInsets.all(28),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.blue,
                      image: DecorationImage(
                          image: NetworkImage(profileImage.toString()),
                          fit: BoxFit.cover),
                    ),
                  ),
                    Padding(
                      padding: const EdgeInsets.only(top: 90.0,left: 40),
                      child: Image.asset("assets/images/editicon.png",height: 20,),
                    ),
                ],),
              ),
              SizedBox(height: 16),
              Text(
                user_name.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "+91 ${user_mobile.toString()}",
                style: TextStyle(fontSize: 14, color: colors.darkgrey),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              height: 46,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[200]
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                      Text("Business Name",style: TextStyle(fontSize: 14,color: Colors.grey,fontWeight: FontWeight.w500),),
                      Text("Business Name",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w500)
                      )],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              height: 47,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[200]
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Email",style: TextStyle(fontSize: 14,color: Colors.grey,fontWeight: FontWeight.w500),),
                    Text("robert.s@gmail.com",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w500)
                    )],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              height: 47,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[200]
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Business Type",style: TextStyle(fontSize: 14,color: Colors.grey,fontWeight: FontWeight.w500),),
                    Text("robert.s@gmail.com",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w500)
                    )],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              height: 47,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[200]
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Business Contact",style: TextStyle(fontSize: 14,color: Colors.grey,fontWeight: FontWeight.w500),),
                    Text("9876543210",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w500)
                    )],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[200]
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Address",style: TextStyle(fontSize: 14,color: Colors.grey,fontWeight: FontWeight.w500),),
                    Text("4517 Washington Ave. Manchester,\nKentucky 39495",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w500)
                    )],
                ),
              ),
            ),
          ),

          // Container(
          //   margin: EdgeInsets.all(16),
          //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          //   width: double.infinity,
          //   height: 134,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(16),
          //     color: Colors.grey.shade300,
          //   ),
          //   child: Row(
          //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Expanded(
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             // Column(
          //             //   crossAxisAlignment: CrossAxisAlignment.start,
          //             //   children: [
          //             //     Text(
          //             //       "Age",
          //             //       style: TextStyle(fontSize: 12, color: colors.darkgrey),
          //             //     ),
          //             //     Text(
          //             //       "45",
          //             //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          //             //     ),
          //             //   ],
          //             // ),
          //             // Column(
          //             //   crossAxisAlignment: CrossAxisAlignment.start,
          //             //   children: [
          //             //     Text(
          //             //       "Gender",
          //             //       style: TextStyle(fontSize: 12, color: colors.darkgrey),
          //             //     ),
          //             //     Text(
          //             //       "Male",
          //             //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          //             //     ),
          //             //   ],
          //             // ),
          //           ],
          //         ),
          //       ),
          //       // Expanded(
          //       //   child: Row(
          //       //     children: [
          //       //       Column(
          //       //         crossAxisAlignment: CrossAxisAlignment.start,
          //       //         children: [
          //       //           Text(
          //       //             "UDID",
          //       //             style: TextStyle(fontSize: 12, color: colors.darkgrey),
          //       //           ),
          //       //           Text(
          //       //             "56789",
          //       //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          //       //           ),
          //       //         ],
          //       //       ),
          //       //     ],
          //       //   ),
          //       // ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
