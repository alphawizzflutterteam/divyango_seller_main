import 'dart:convert';
import 'dart:io';
import 'package:divyango_user/screens/homepage/navigation_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/GetProfileModel.dart';
import '../services/btnPage.dart';
import '../services/colors.dart';
import '../utils/Api.path.dart';
import 'homepage/my_profile.dart';
import 'homepage/persistance_nav_bar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profile();
  }

  GetProfileModel? getProfileModel;

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
          emailController.text = getProfileModel!.data!.cpEmail ?? "";
          mobileController.text = getProfileModel!.data!.cpMobile ?? "";
          nameController.text = getProfileModel!.data!.cpName ?? "";
          projectNameController.text = getProfileModel!.data!.projectName ?? "";
          gstNameController.text = getProfileModel!.data!.gstName ?? "";
          gstNoCTr.text = getProfileModel!.data!.gstNo ?? "";
          // _image = getProfileModel!.data!.logo;
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

  bool isLoading = false;

  updateProfile() async {
    setState(() {
      isLoading = true;
    });
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    String? user_id = sharedPreferences.getString('user_id');
    String? proType = sharedPreferences.getString('proTypes');
    var request =
    http.MultipartRequest('POST', Uri.parse(ApiServicves.updateProfile));
    request.fields.addAll({
      'id': user_id.toString(),
      'name': nameController.text,
      'mobile': mobileController.text,
      'email': emailController.text,
      'gst': gstNoCTr.text,
      'gst_name': gstNameController.text,
      'pro_type': proType.toString(),
    });
    print("update profile ${request.fields}");
    request.files
        .add(await http.MultipartFile.fromPath('profile', _image!.path));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      var result = jsonDecode(finalResponse);
      if (result['status'] == true) {
        Fluttertoast.showToast(msg: '${result['message']}');
        Navigator.push(context,
            // MaterialPageRoute(builder: (context) => PersistanceNavBarWidget()));
            MaterialPageRoute(builder: (context) => NavigationPage()));
      } else {
        Fluttertoast.showToast(msg: '${result['message']}');
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  final projectNameController = TextEditingController();
  final gstNoCTr = TextEditingController();
  final gstNameController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final addressController = TextEditingController();

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
        Navigator.pop(context);
      });
    }
  }

  String? _validateEmail(value) {
    if (value!.isEmpty) {
      return "Please enter an email";
    }
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return "Please enter a valid email";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.whiteTemp,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colors.secondary,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              // // project name field
              // Container(
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       border: Border.all(color: Colors.grey)),
              //   child: TextFormField(
              //     readOnly: true,
              //     controller: projectNameController,
              //     style: const TextStyle(fontSize: 18, color: Colors.black),
              //     decoration: const InputDecoration(
              //         contentPadding:
              //             EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //         labelText: 'Project Name',
              //         labelStyle: TextStyle(color: colors.darkgrey),
              //         border: InputBorder.none),
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),

              // // gst no field
              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     border: Border.all(color: Colors.grey),
              //   ),
              //   child: TextFormField(
              //     readOnly: true,
              //     controller: gstNoCTr,
              //     keyboardType: TextInputType.text,
              //     style: const TextStyle(fontSize: 18, color: Colors.black),
              //     maxLength: 15,
              //     decoration: const InputDecoration(
              //         counterText: "",
              //         contentPadding:
              //             EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //         labelText: 'GST Number',
              //         labelStyle: TextStyle(color: colors.darkgrey),
              //         border: InputBorder.none),
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),

              // // gst name field
              // Container(
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       border: Border.all(color: Colors.grey)),
              //   child: TextFormField(
              //     readOnly: true,
              //     controller: gstNameController,
              //     style: const TextStyle(fontSize: 18, color: Colors.black),
              //     decoration: const InputDecoration(
              //         contentPadding:
              //             EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //         labelText: 'GST Name',
              //         labelStyle: TextStyle(color: colors.darkgrey),
              //         border: InputBorder.none),
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),

              // name field
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
              // Container(
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       border: Border.all(color: Colors.grey)),
              //   child: TextFormField(
              //     controller: nameController,
              //     style: const TextStyle(fontSize: 18, color: Colors.black),
              //     decoration: const InputDecoration(
              //         contentPadding:
              //             EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //         labelText: 'Name',
              //         labelStyle: TextStyle(color: colors.darkgrey),
              //         border: InputBorder.none),
              //   ),
              // ),
              const SizedBox(
                height: 13,
              ),
              // Container(
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       border: Border.all(color: Colors.grey)),
              //   child: TextFormField(
              //     controller: emailController,
              //     style: const TextStyle(fontSize: 18, color: Colors.black),
              //     decoration: const InputDecoration(
              //         contentPadding:
              //             EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //         labelText: 'Email',
              //         labelStyle: TextStyle(color: colors.darkgrey),
              //         border: InputBorder.none),
              //   ),
              // ),

              // mobile filed
              TextFormField(
                controller: mobileController,
                keyboardType: TextInputType.phone,
               // maxLength: 40,
                decoration: InputDecoration(
                  filled: true,
                  isDense: true,
                  fillColor: colors.txtField,

                  hintText: 'Personal Mobile Number',
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
                style: TextStyle(
                  color: colors.darkgrey,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Mobile Number';
                  }
                  return null;
                },
                //maxLength: 10,
              ),
              const SizedBox(
                height: 13,
              ),

              // Container(
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       border: Border.all(color: Colors.grey)),
              //   child: TextFormField(
              //     controller: mobileController,
              //     keyboardType: TextInputType.number,
              //     style: const TextStyle(fontSize: 18, color: Colors.black),
              //     maxLength: 10,
              //     decoration: const InputDecoration(
              //         counterText: "",
              //         contentPadding:
              //             EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //         labelText: 'Mobile',
              //         labelStyle: TextStyle(color: colors.darkgrey),
              //         border: InputBorder.none),
              //   ),
              // ),

              // email field
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  isDense: true,
                  fillColor: colors.txtField,
                  hintText: 'Email',
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
                style: TextStyle(
                  color: colors.darkgrey,
                ),
                validator: _validateEmail,
              ),
              const SizedBox(
                height: 13,
              ),

              // Age Field
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  isDense: true,
                  fillColor: colors.txtField,
                  hintText: 'Business Name',
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
                style: TextStyle(
                  color: colors.darkgrey,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your Age';
                  } else if (value!.length > 2) {
                    return 'Please enter valid Age';
                  }
                  return null;
                },
              ),

              const SizedBox(
                  height: 13
              ),

              // UDID Field
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  isDense: true,
                  fillColor: colors.txtField,
                  hintText: 'Business contact details',
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
                style: TextStyle(
                  color: colors.darkgrey,
                ),
              ),

              const SizedBox(
                height: 13,
              ),

              // Gender Field
              TextFormField(
                keyboardType: TextInputType.text,
                maxLines: 4,
                decoration: InputDecoration(
                  filled: true,
                  isDense: true,
                  fillColor: colors.txtField,
                  hintText: 'Address',
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
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return 'Please enter your Disability Type';
                //   } else if (value!.length > 2) {
                //     return 'Please enter valid Disability Type';
                //   }
                //   return null;
                // },
              ),

              // const SizedBox(
              //   height: 20,
              // ),

              // Disability Field
              // TextFormField(
              //   keyboardType: TextInputType.text,
              //   decoration: InputDecoration(
              //     filled: true,
              //     isDense: true,
              //     fillColor: colors.txtField,
              //     hintText: 'Disability Type',
              //     hintStyle: TextStyle(color: colors.fieldTxt),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8.0),
              //       borderSide: BorderSide.none,
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8.0),
              //       borderSide: BorderSide.none,
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8.0),
              //       borderSide: BorderSide.none,
              //     ),
              //   ),
              //   style: const TextStyle(
              //     color: colors.darkgrey,
              //   ),
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return 'Please enter your Disability Type';
              //     } else if (value!.length > 2) {
              //       return 'Please enter valid Disability Type';
              //     }
              //     return null;
              //   },
              // ),


              // // image section
              // InkWell(
              //   onTap: () {
              //     showDialog(
              //       context: context,
              //       builder: (BuildContext context) {
              //         return AlertDialog(
              //           title: const Text('Select Image'),
              //           content: Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               InkWell(
              //                 child: Container(
              //                   //  padding: EdgeInsets.all(16),
              //                   height: 30,
              //                   width: 80,
              //                   decoration: BoxDecoration(
              //                       borderRadius: BorderRadius.circular(10),
              //                       color: colors.primary),
              //                   child: const Center(
              //                       child: Text(
              //                     "Gallery",
              //                     style: TextStyle(color: colors.whiteTemp),
              //                   )),
              //                 ),
              //                 onTap: () {
              //                   // Navigator.of(context).pop(); // Close the AlertDialog
              //                   getImageFromGallery();
              //                   Navigator.pop(context);
              //                 },
              //               ),
              //               InkWell(
              //                 child: Container(
              //                   height: 30,
              //                   width: 80,
              //                   decoration: BoxDecoration(
              //                       borderRadius: BorderRadius.circular(10),
              //                       color: colors.primary),
              //                   child: const Center(
              //                       child: Text(
              //                     "Camera",
              //                     style: TextStyle(color: colors.whiteTemp),
              //                   )),
              //                 ),
              //                 onTap: () {
              //                   //  Navigator.of(context).pop(); // Close the AlertDialog
              //                   getImageFromCamera();
              //                 },
              //               ),
              //             ],
              //           ),
              //         );
              //       },
              //     );
              //   },
              //   child: Container(
              //     height: 150,
              //     width: 250,
              //     margin: EdgeInsets.only(
              //         right: MediaQuery.of(context).size.width * 0.6),
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10),
              //         border: Border.all(color: Colors.grey)),
              //     child: _image == null
              //         ? SizedBox(
              //             height: 170,
              //             child: Image.network(getProfileModel!.data!.logo!,
              //                 fit: BoxFit.fill),
              //           )
              //         : Column(
              //             children: [
              //               SizedBox(
              //                 height: 0,
              //               ),
              //               Container(
              //                   height: 127,
              //                   width: 250,
              //                   // margin: EdgeInsets.only(
              //                   //     right: MediaQuery.of(context).size.width * 0.6),
              //                   // decoration: BoxDecoration(
              //                   //     borderRadius: BorderRadius.circular(10),
              //                   //     border: Border.all(color: Colors.grey)),
              //                   child: Image.file(_image!, fit: BoxFit.fill)),
              //               SizedBox(
              //                 height: 20,
              //               ),
              //             ],
              //           ),
              //   ),
              // ),

              SizedBox(
                height: 110,
              ),
              // InkWell(
              //   onTap: () {
              //     updateProfile();
              //   },
              //   child: Container(
              //     height: 50,
              //     decoration: BoxDecoration(
              //         color: colors.primary,
              //         borderRadius: BorderRadius.circular(10)),
              //     child: const Center(
              //         child: Text('Save',
              //             style: TextStyle(
              //                 color: colors.whiteTemp1,
              //                 fontWeight: FontWeight.bold,
              //                 fontSize: 16))),
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              FilledBtn(
                width: 330,
                title: "Save",
                onPress: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MyProfile()));
                },
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
