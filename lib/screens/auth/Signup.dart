import 'dart:convert';
import 'dart:io';
import 'package:divyango_user/screens/auth/mobile_login.dart';
import 'package:divyango_user/utils/Api.path.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../Model/GetCityModel.dart';
import '../../services/colors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCity();
  }

  final projectNameController = TextEditingController();
  final gstNoCTr = TextEditingController();
  final gstNameController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final addressController = TextEditingController();

  List<String> dropDownList = ['Project1', 'Project2', 'Project3'];
  List<String> cityList = ['City1', 'City2', 'City3'];
  String selectedProjectType = '';
  String selectedCity = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _validateEmail(value) {
    if (value!.isEmpty) {
      return "Please enter an email";
    }
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return "Please enter a valid email";
    }
  }

  String? _selectedPro = 'Facebook';

  List<CityData> cityLists = [];
  CityData? cityValue;
  String? cityId;
  bool _obscureText = true;
  bool _obscureText2 = true;

  getCity() async {
    var request = http.MultipartRequest('GET', Uri.parse(ApiServicves.cities));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responseData);
      if (mounted) {
        setState(() {
          cityLists = GetCity.fromJson(userData).data;
        });
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  register() async {
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.usserSignUp));
    request.fields.addAll({
      'project_name': projectNameController.text,
      'name': nameController.text,
      'mobile': mobileController.text,
      'email': emailController.text,
      'address': addressController.text,
      'gst_no': gstNoCTr.text,
      'gst_name': gstNameController.text,
      'city': cityId.toString(),
      'pro_type': '$_selectedPro',
      // 'profile': _image!.path
    });
    print("registration para ${request.fields}");
    if (_image == null || _image == "") {
    } else {
      request.files
          .add(await http.MultipartFile.fromPath('profile', _image!.path));
    }
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finaResult = jsonDecode(result);
      if (finaResult['status'] == true) {
        setState(() {});
        Fluttertoast.showToast(msg: '${finaResult['message']}');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
        projectNameController.clear();
        nameController.clear();
        mobileController.clear();
        emailController.clear();
        addressController.clear();
        gstNoCTr.clear();
      } else {
        Fluttertoast.showToast(msg: "${finaResult['message']}");
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.whiteTemp,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Sign Up",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context, false);
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            )),
      ),
      // return Scaffold(
      //   backgroundColor: colors.whiteTemp,
      //   appBar:
      //   appBarWithBackWidget(
      //       context: context, title: 'Sign Up', color: colors.transparent),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   decoration: const BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage("assets/images/Sign up.png"),
            //       fit: BoxFit.fill,
            //     ),
            //   ),
            //   child: Container(
            //     padding: EdgeInsets.symmetric(horizontal: 20),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Container(
            //             padding: EdgeInsets.only(
            //                 right: MediaQuery.of(context).size.width * 0.3,
            //                 top: 10),
            //             child: const Image(
            //                 image: AssetImage('assets/images/applogo.png'))),
            //         const Padding(
            //           padding: EdgeInsets.only(top: 10),
            //           child: Text(
            //             "Create Your Project",
            //             style: TextStyle(
            //                 fontSize: 28, fontWeight: FontWeight.bold),
            //           ),
            //         ),
            //         const Text(
            //           "Enter your phone number to proceed",
            //           style: TextStyle(fontSize: 16, color: colors.darkgrey),
            //         ),
            //         const SizedBox(
            //           height: 10,
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 28,
                        color: colors.blackTemp,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Container(
                  //   padding: const EdgeInsets.all(3),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     border: Border.all(color: colors.darkgrey),
                  //   ),
                  //   child: DropdownButton(
                  //     isExpanded: true,
                  //     value: cityValue,
                  //     hint: const Padding(
                  //       padding: EdgeInsets.only(left: 10),
                  //       child: Text('Select City'),
                  //     ),
                  //     // Down Arrow Icon
                  //     icon: const Icon(Icons.keyboard_arrow_down),
                  //     // Array list of items
                  //     items: cityLists.map((items) {
                  //       return DropdownMenuItem(
                  //         value: items,
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(left: 10),
                  //           child: Text(items.city.toString()),
                  //         ),
                  //       );
                  //     }).toList(),
                  //     onChanged: (CityData? value) {
                  //       setState(() {
                  //         cityValue = value!;
                  //         cityId = cityValue!.id.toString();
                  //         print("name herererb $cityValue $cityId");
                  //       });
                  //     },
                  //     underline: Container(),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Container(
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10),
                        //       border: Border.all(color: Colors.grey)),
                        //   child: TextFormField(
                        //     controller: projectNameController,
                        //     style: const TextStyle(
                        //         fontSize: 18, color: colors.darkgrey),
                        //     validator: (value) {
                        //       if (value!.isEmpty) {
                        //         return 'Please enter a Company name';
                        //       }
                        //       return null;
                        //     },
                        //     decoration: const InputDecoration(
                        //         contentPadding: EdgeInsets.symmetric(
                        //             horizontal: 20, vertical: 10),
                        //         labelText: 'Company Name',
                        //         labelStyle: TextStyle(color: colors.darkgrey),
                        //         border: InputBorder.none),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10),
                        //       border: Border.all(color: Colors.grey)),
                        //   child: TextFormField(
                        //     controller: gstNoCTr,
                        //     keyboardType: TextInputType.text,
                        //     style: const TextStyle(
                        //         fontSize: 18, color: colors.darkgrey),
                        //     // validator: (value) {
                        //     //   if (value!.isEmpty) {
                        //     //     return 'Please enter gst number';
                        //     //   }
                        //     //   return null;
                        //     // },
                        //     maxLength: 15,
                        //     decoration: const InputDecoration(
                        //         counterText: "",
                        //         contentPadding: EdgeInsets.symmetric(
                        //             horizontal: 20, vertical: 10),
                        //         labelText: 'GST Number',
                        //         labelStyle: TextStyle(color: colors.darkgrey),
                        //         border: InputBorder.none),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10),
                        //       border: Border.all(color: Colors.grey)),
                        //   child: TextFormField(
                        //     controller: gstNameController,
                        //     style: const TextStyle(
                        //         fontSize: 18, color: Colors.black),
                        //     // validator: (value) {
                        //     //   if (value!.isEmpty) {
                        //     //     return 'Please enter a Gst Name';
                        //     //   }
                        //     //   return null;
                        //     // },
                        //     decoration: const InputDecoration(
                        //         contentPadding: EdgeInsets.symmetric(
                        //             horizontal: 20, vertical: 10),
                        //         labelText: 'GST Name',
                        //         labelStyle: TextStyle(color: colors.darkgrey),
                        //         border: InputBorder.none),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),

                        // Name Field
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

                        const SizedBox(
                          height: 20,
                        ),

                        // Mobile Number
                        TextFormField(
                          controller: mobileController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            filled: true,
                            isDense: true,
                            fillColor: colors.txtField,
                            hintText: 'Mobile Number',
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
                          maxLength: 10,
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        // Email Field
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
                          height: 20,
                        ),

                        // Age Field
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            isDense: true,
                            fillColor: colors.txtField,
                            hintText: 'Age',
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
                              return 'Please enter your Age';
                            } else if (value!.length > 2) {
                              return 'Please enter valid Age';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        // UDID Field
                        TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            isDense: true,
                            fillColor: colors.txtField,
                            hintText: 'UDID (optional)  ',
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
                          height: 20,
                        ),

                        // Create Password Field
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            filled: true,
                            isDense: true,
                            fillColor: colors.txtField,
                            hintText: 'Create Password',
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
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                          style: TextStyle(
                            color: colors.darkgrey,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a password';
                            }
                            else if (value!.length < 8) {
                              return 'Password is too short';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        // Confirm Password Field
                        TextFormField(
                          keyboardType: TextInputType.number,
                          obscureText: _obscureText2,
                          decoration: InputDecoration(
                            filled: true,
                            isDense: true,
                            fillColor: colors.txtField,
                            hintText: 'Confirm Password',
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
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText2 ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText2 = !_obscureText2;
                                });
                              },
                            ),
                          ),
                          style: TextStyle(
                            color: colors.darkgrey,
                          ),
                        ),

                        // Container(
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(10),
                        //       border: Border.all(color: Colors.grey)),
                        //   child: TextFormField(
                        //     minLines: 1,
                        //     maxLines: 5,
                        //     controller: addressController,
                        //     style: const TextStyle(
                        //         fontSize: 18, color: Colors.black),
                        //     validator: (value) {
                        //       if (value!.isEmpty) {
                        //         return 'Please enter a Address';
                        //       }
                        //       return null;
                        //     },
                        //     decoration: const InputDecoration(
                        //         contentPadding: EdgeInsets.symmetric(
                        //             horizontal: 20, vertical: 10),
                        //         labelText: 'Address',
                        //         labelStyle: TextStyle(color: colors.darkgrey),
                        //         border: InputBorder.none),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Row(
                  //   children: [
                  //     Radio<String>(
                  //       value: 'Facebook',
                  //       groupValue: _selectedPro,
                  //       onChanged: (String? value) {
                  //         setState(() {
                  //           _selectedPro = value;
                  //         });
                  //       },
                  //     ),
                  //     const Text("FaceBook"),
                  //     Radio<String>(
                  //       value: 'Facebooks',
                  //       groupValue: _selectedPro,
                  //       onChanged: (String? value) {
                  //         setState(() {
                  //           _selectedPro = value;
                  //         });
                  //       },
                  //     ),
                  //     const Text("Google")
                  //   ],
                  // ),
                  const SizedBox(height: 10),
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
                                    // Navigator.of(context).pop(); // Close the AlertDialog
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
                                    )),
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
                    child: Container(
                      height: 128,
                      width: deviceWidth,
                      // margin: EdgeInsets.only(
                      //     right: MediaQuery.of(context).size.width * 0.6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: colors.primary),
                      ),
                      child: _image != null
                          ? Container(
                              height: 170,
                              child: Image.file(_image!, fit: BoxFit.fill))
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.image, color: colors.primary,),
                                Text('Upload Adharcard', style: TextStyle(color: colors.primary),),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: Column()
                //
                //   ListView(
                //     children: [
                //
                //     ],
                //   ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        child: Container(
          height: 100,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  print("imasaj ${_image == null}");
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    if (cityValue == null) {
                      Fluttertoast.showToast(msg: "Please Select City");
                      print("===============$_image===========");
                      return;
                    }
                    // else if (_image == null) {
                    //   print("aaaaaa $_image===========");
                    //   Fluttertoast.showToast(msg: "Please Select Image");
                    //   return;
                    // }
                    else {
                      register();
                    }
                  }
                  // register();
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(10)),
                  child: isLoading
                      ? loadingWidget()
                      : const Center(
                          child: Text('Sign Up',
                              style: TextStyle(
                                  color: colors.whiteTemp1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16))),
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(fontSize: 14, color: colors.blackTemp),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "SignIn",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold, color: colors.primary),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isLoading = false;

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
}
