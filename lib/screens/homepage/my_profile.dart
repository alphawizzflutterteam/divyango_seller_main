import 'dart:convert';
import 'dart:io';

import 'package:divyango_user/Model/GetProfileModel.dart';
import 'package:divyango_user/services/btnPage.dart';
import 'package:divyango_user/services/colors.dart';
import 'package:divyango_user/utils/Api.path.dart';
import 'package:divyango_user/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'navigation_page.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key, key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  void initState() {
    // TODO: implement initState
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
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse(ApiServicves.getProfile));
      request.fields.addAll({'vid': user_id.toString()});
      print("profile para ${request.fields}");
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var finalResponse = await response.stream.bytesToString();
        var result = jsonDecode(finalResponse);
        if (result['response_code'] == '1') {
          getProfileModel = GetProfileModel.fromJson(result);
          nameController.text = getProfileModel?.user?.uname ?? "";
          emailController.text = getProfileModel?.user?.email ?? "";
          mobileController.text = getProfileModel?.user?.mobile ?? "";
          user_email = getProfileModel?.user?.email;
          user_mobile = getProfileModel?.user?.mobile;
          user_name = getProfileModel?.user?.uname;
          // profileImage = getProfileModel?.user?.profileImage;
          print("profile data $user_name 2 $user_mobile 3 $user_email");
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

  updateProfile() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? user_id = sharedPreferences.getString('user_id');
    var headers = {
      'Cookie': 'ci_session=099e663bfd122a3caab80a368fa16ee0920fca06'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.updateProfile));
    request.fields.addAll({
      'id': user_id.toString(),
      'uname': nameController.text,
      'mobile': mobileController.text,
      'email': emailController.text,
      'address': '',
      'bussiness_name': '',
      'type_of_bussiness': '',
      'bussiness_contact': ''
    });
    print("=========update pfoile${request.fields}");

    _image != null
        ? request.files.add(await http.MultipartFile.fromPath(
            'profile_image', _image!.path.toString() ?? ""))
        : true;
    print("profile image upladed ${request.files}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("working@@");
      var finalResponse = await response.stream.bytesToString();
      print("rerrrrrrrrrrrr $finalResponse");
      var result = json.decode(finalResponse);
      if (result['response_code'] == "1") {
        print("$result===========");
        Fluttertoast.showToast(msg: '${result['message']}');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NavigationPage(),
          ),
        );
        profile();
      } else {
        Fluttertoast.showToast(msg: '${result['message']}');
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();

  File? _image;

  final picker = ImagePicker();

  Future getImageFromGallery() async {
    XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxHeight: 400,
        maxWidth: 400);
    print("image $_image");
    if (image != null) {
      _image = File(image.path);
      print("image is ${_image!.path}");
      setState(() {
        // Navigator.pop(context);
      });
    }
  }

  Future getImageFromCamera() async {
    XFile? image = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxHeight: 400,
        maxWidth: 400);
    if (image != null) {
      _image = File(image.path);
      setState(() {
        // Navigator.pop(context);
      });
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
          title: 'Update Profile',
          onPress: () => updateProfile(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 28),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Select Image'),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                child: Container(
                                  //  padding: EdgeInsets.all(16),
                                  height: 30,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: colors.primary),
                                  child: const Center(
                                      child: Text(
                                    "Gallery",
                                    style: TextStyle(color: colors.whiteTemp),
                                  )),
                                ),
                                onTap: () {
                                  getImageFromGallery();
                                  Navigator.pop(context);
                                },
                              ),
                              InkWell(
                                child: Container(
                                  height: 30,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: colors.primary),
                                  child: const Center(
                                    child: Text(
                                      "Camera",
                                      style: TextStyle(color: colors.whiteTemp),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  //  Navigator.of(context).pop(); // Close the AlertDialog
                                  getImageFromCamera();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Center(
                    child: Stack(
                      children: [
                        _image != null
                            ? Container(
                                height: 130,
                                width: 130,
                                decoration: BoxDecoration(
                                  // border: Border.all(color: Colors.bl  ack),
                                  borderRadius: BorderRadius.circular(8),
                                  //color: Colors.blue,
                                  image: DecorationImage(
                                      image: FileImage(_image!),
                                      fit: BoxFit.cover),
                                ),
                              )
                            : Container(
                                // margin: EdgeInsets.all(28),
                                height: 130,
                                width: 130,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.grey,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "${getProfileModel?.user?.profileImage}"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.only(top: 115.0, left: 50),
                          child: Image.asset(
                            "assets/images/editicon.png",
                            height: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
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
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        fillColor: colors.txtField,
                        hintText: 'Name',
                        hintStyle: TextStyle(color: colors.fieldTxt),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(
                        color: colors.darkgrey,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a Name';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        fillColor: colors.txtField,
                        hintText: 'Email',
                        hintStyle: const TextStyle(color: colors.fieldTxt),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(
                        color: colors.darkgrey,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a Name';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: mobileController,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        counterText: "",
                        filled: true,
                        isDense: true,
                        fillColor: colors.txtField,
                        hintText: 'Mobile',
                        hintStyle: const TextStyle(color: colors.fieldTxt),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: TextStyle(
                        color: colors.darkgrey,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a Name';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
