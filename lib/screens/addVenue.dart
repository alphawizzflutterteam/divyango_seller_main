import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/Accessiblity.dart';
import '../Model/VenueListModel.dart';
import '../services/MapScreen.dart';
import '../services/btnPage.dart';
import '../services/colors.dart';
import '../utils/Api.path.dart';
import '../widgets/appbar_widget.dart';

class EditVenueDetail extends StatefulWidget {
  final String appBarTitle, bottomTitle;
  VenueData? model;
  bool? isFrom = true;
  EditVenueDetail(
      {Key,
      key,
      required this.appBarTitle,
      this.model,
      required this.bottomTitle,
      this.isFrom});

  @override
  State<EditVenueDetail> createState() => _EditVenueDetailState();
}

String? startTime, endTime;

class _EditVenueDetailState extends State<EditVenueDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    venueCtr.text = widget.model?.name ?? "";
    contactCtr.text = widget.model?.mobile ?? "";
    emailCtr.text = widget.model?.email ?? "";
    addresCtr.text = widget.model?.address ?? "";
    startTimeCtr.text = widget.model?.startTime ?? "";
    endTimeCtr.text = widget.model?.endTime ?? "";
    // _image = File(widget.model?.image.toString() ?? "");
    // print("mage is $_image sdasdd ${widget.model?.image.toString() ?? ""}");
    fetchCategories();
    getAccessibility();
  }

  List categories = [];
  String? selectedCategory;

  Future<void> fetchCategories() async {
    final String apiUrl =
        "https://developmentalphawizz.com/divyango_new/api/get_all_cat";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == 1 && data['categories'] != null) {
          setState(() {
            categories = data['categories'];
            isLodaing = false;
            categories.forEach((element) {
              print(
                  "categororr ${widget.model?.category}  dddddd ${element['c_name']}");
              if (widget.model?.category.toString() ==
                  element['id'].toString()) {
                selectedCategory = element['id'];
              }
            });
          });
        } else {
          setState(() {
            isLodaing = false;
          });
        }
      } else {
        setState(() {
          isLodaing = false;
        });
      }
    } catch (e) {
      setState(() {
        isLodaing = false;
      });
    }
  }

  AccessibilityModel? accessibilityModel;
  List<Map<String, dynamic>> dataList = [];

  getAccessibility() async {
    var headers = {
      'Cookie': 'ci_session=442950844f912cd0157527552772c07639e6b9de'
    };
    var request =
        http.Request('POST', Uri.parse(ApiServicves.getAccessibility));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("asddddddddd");
      var result = await response.stream.bytesToString();
      print("asddddddddd@@@@@@@");
      var finalResult = json.decode(result);
      if (finalResult['status'] == 1) {
        print("asddddddddd!!!!!!!!");
        // accessibilityModel = AccessibilityModel.fromJson(finalResult);
        setState(() {
          dataList = List<Map<String, dynamic>>.from(
            finalResult["accessibility"].map((item) => {
                  "id": item["id"],
                  "name": item["name"],
                  "isChecked": false, // Default unchecked
                }),
          );
          print("ddadadda $dataList");
          isLodaing = false;
        });
      }
    } else {
      isLodaing = false;
      print(response.reasonPhrase);
    }
  }

  TextEditingController venueCtr = TextEditingController();
  TextEditingController contactCtr = TextEditingController();
  TextEditingController addresCtr = TextEditingController();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController startTimeCtr = TextEditingController();
  TextEditingController endTimeCtr = TextEditingController();

  bool isLodaing = true;

  addVenue() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? user_id = sharedPreferences.getString('user_id');
    setState(() {
      isLodaing = true;
    });
    var headers = {
      'Cookie': 'ci_session=8f5f4c48878524fcaf4acee4273ec526eb31df64'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.addVenues));
    request.fields.addAll({
      'seller_id': user_id.toString(),
      'name': venueCtr.text,
      'mobile': contactCtr.text,
      'email': emailCtr.text,
      'accesblity': selectedItems.join(','),
      'category': selectedCategory.toString(),
      'address': addresCtr.text,
      'start_time': startTimeCtr.text,
      'end_time': endTimeCtr.text,
      'lat': droopLat.toString(),
      "lang": droopLong.toString()
    });
    print("add venue para ${request.fields}");
    request.headers.addAll(headers);
    request.files.add(
        await http.MultipartFile.fromPath('image', _image!.path.toString()));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = json.decode(result);
      if (finalResult['response_code'] == '1') {
        Fluttertoast.showToast(msg: '${finalResult['message']}');
        isLodaing = false;
        Navigator.pop(context);
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  aeditVenue() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? user_id = sharedPreferences.getString('user_id');
    setState(() {
      isLodaing = true;
    });
    var headers = {
      'Cookie': 'ci_session=8f5f4c48878524fcaf4acee4273ec526eb31df64'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.editVenues));
    request.fields.addAll({
      'seller_id': user_id.toString(),
      'name': venueCtr.text,
      'mobile': contactCtr.text,
      'email': emailCtr.text,
      'accesblity': selectedItems.join(','),
      'category': selectedCategory.toString(),
      'address': addresCtr.text,
      'start_time': startTimeCtr.text,
      'end_time': endTimeCtr.text,
      'venue_id': widget.model!.id.toString(),
      'lat': droopLat.toString(),
      "lang": droopLong.toString()
    });
    print("edit venue para ${request.fields}");
    request.headers.addAll(headers);
    request.files.add(
        await http.MultipartFile.fromPath('image', _image!.path.toString()));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = json.decode(result);
      if (finalResult['response_code'] == '1') {
        Fluttertoast.showToast(msg: '${finalResult['message']}');
        isLodaing = false;
        Navigator.pop(context);
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  final _formKey = GlobalKey<FormState>();
  String? selectedAccessibility;

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }

  String? validateStartHours(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }

  String? validateEndHours(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }

  String? validateContactNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a contact number';
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Please enter a valid 10-digit contact number';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an address';
    }
    return null;
  }

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

  List<String> selectedItems = [];

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        startTimeCtr.text = pickedTime.format(context);
        print("sdaadasd $startTime endtime $endTime");
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        endTimeCtr.text = pickedTime.format(context);
        print("sdaadasd $startTime endtime $endTime");
      });
    }
  }

  String? _validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address cannot be empty';
    }
    return null;
  }

  String? droopUplocation;
  String? droopLat;
  String? droopLong;
  String? venueImg;

  @override
  Widget build(BuildContext context) {
    print("dsadadsadadad ${widget.bottomTitle}");
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      // appBar: AppBar(
      //   leading: GestureDetector(
      //     onTap: () {
      //       Navigator.pop(context);
      //     },
      //     child: Icon(
      //       Icons.arrow_back_ios,
      //       color: Colors.white,
      //     ),
      //   ),
      //   backgroundColor: colors.secondary,
      //   title: Text(
      //     "Edit Venue",
      //     style: TextStyle(color: Colors.white),
      //   ),
      // ),
      appBar: appBarWithBackWidget(
          context: context,
          title: widget.appBarTitle.toString(),
          color: colors.whiteTemp1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.02),
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
                                    ),
                                  ),
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
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  //  Navigator.of(context).pop(); // Close the AlertDialog
                                  getImageFromCamera();
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 160,
                    width: deviceWidth,
                    // margin: EdgeInsets.only(
                    //     right: MediaQuery.of(context).size.width * 0.6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: colors.primary),
                    ),
                    child: _image != null
                        ? Container(
                            height: 180,
                            child: Image.file(_image!, fit: BoxFit.fill))
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image,
                                color: colors.primary,
                              ),
                              Text(
                                'Upload Image',
                                style: TextStyle(color: colors.primary),
                              ),
                            ],
                          ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Textbattonn(
                  controller: venueCtr,
                  hint: "Venue name",
                  validator: validateName,
                ),
                SizedBox(height: screenHeight * 0.02),
                Textbattonn(
                  controller: contactCtr,
                  keytype: const TextInputType.numberWithOptions(),
                  hint: "Contact number",
                  validator: validateContactNumber,
                ),
                SizedBox(height: screenHeight * 0.02),
                Textbattonn(
                  controller: emailCtr,
                  hint: "Email",
                  validator: validateEmail,
                ),
                SizedBox(height: screenHeight * 0.02),

                // SizedBox(height: screenHeight * 0.01),

                TextFormField(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MapScreen(
                                  mapKey:
                                      'AIzaSyAyO9RG1HfX7Qiz-dB6NaSUagjLzg26hTU',
                                ))).then((value) {
                      if (value != null) {
                        setState(() {
                          droopUplocation = value[2];
                          droopLat = value[0].toString();
                          droopLong = value[1].toString();
                          addresCtr.text = droopUplocation.toString();
                        });
                      }
                    });
                  },
                  controller: addresCtr,
                  maxLines: 4,
                  validator: _validateAddress,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    border: InputBorder.none,
                    fillColor: Colors.grey[200],
                    hintText: 'Address',
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                isLodaing
                    ? const Center(
                        child:
                            CircularProgressIndicator()) // Show a loader while fetching data
                    : dataList.isEmpty
                        ? const Center(
                            child: Text("No data available"),
                          ) // Show message if data is empty
                        : Container(
                            height: 60,
                            width: 380,
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxHeight: 50),
                              child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: dataList.length,
                                itemBuilder: (context, index) => SizedBox(
                                  width: 170, // Adjust width as needed
                                  child: CheckboxListTile(
                                    value: dataList[index]["isChecked"],
                                    onChanged: (value) {
                                      setState(() {
                                        dataList[index]["isChecked"] = value!;
                                        String currentItem =
                                            dataList[index]['id'];

                                        if (value) {
                                          // Add to selectedItems if checked
                                          if (!selectedItems
                                              .contains(currentItem)) {
                                            selectedItems.add(currentItem);
                                          }
                                        } else {
                                          // Remove from selectedItems if unchecked
                                          selectedItems.remove(currentItem);
                                        }
                                      });
                                    },
                                    title: Text(
                                      dataList[index][
                                          "name"], // Show the name from the API
                                      style: const TextStyle(
                                          color: Colors.black87, fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: isLodaing
                      ? const Center(child: CircularProgressIndicator())
                      : categories.isNotEmpty
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white54,
                                border: Border.all(
                                    color: Colors.grey), // Add border color
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5), // Add padding
                              width: MediaQuery.of(context).size.width,
                              child: DropdownButtonHideUnderline(
                                // Remove underline
                                child: DropdownButton<String>(
                                  value: selectedCategory,
                                  hint: const Text('Select a Category'),
                                  isExpanded:
                                      true, // Ensure it fits the container
                                  items: categories.map((category) {
                                    return DropdownMenuItem<String>(
                                      value: category['id'],
                                      child: Text(category['c_name']),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCategory = value;
                                    });
                                    print("asdad $selectedCategory");
                                  },
                                  dropdownColor:
                                      Colors.white, // Dropdown background color
                                  icon: const Icon(Icons.arrow_drop_down,
                                      color:
                                          Colors.grey), // Dropdown arrow style
                                ),
                              ),
                            )
                          : const Center(
                              child: Text('No categories available.'),
                            ),
                ),
                SizedBox(height: screenHeight * 0.015),
                const Text(
                  "Business hours",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: screenHeight * 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                        controller: startTimeCtr,
                        validator: validateStartHours,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 0),
                          border: InputBorder.none,
                          fillColor: Colors.grey[200],
                          hintText: "StartTime",
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        readOnly: true,
                        onTap: () {
                          _selectStartTime(context);
                        },
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                        controller: endTimeCtr,
                        validator: validateEndHours,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 0),
                          border: InputBorder.none,
                          fillColor: Colors.grey[200],
                          hintText: "EndTime",
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        readOnly: true,
                        onTap: () {
                          _selectEndTime(context);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                widget.isFrom == true
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 9.0),
                        child: FilledBtn(
                          width: screenWidth * 0.9,
                          title: "Edit Venue",
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              aeditVenue();
                            }
                          },
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 9.0),
                        child: isLodaing == false
                            ? FilledBtn(
                                width: screenWidth * 0.9,
                                title: "Add Venue",
                                onPress: () {
                                  if (_formKey.currentState!.validate()) {
                                    addVenue();
                                  }
                                },
                              )
                            : const Center(child: CircularProgressIndicator())),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Textbattonn extends StatefulWidget {
  Textbattonn(
      {Key,
      key,
      required this.hint,
      this.validator,
      this.keytype,
      required this.controller});
  var hint, keytype;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  @override
  State<Textbattonn> createState() => _TextbattonnState();
}

class _TextbattonnState extends State<Textbattonn> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keytype,
      validator: widget.validator,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        border: InputBorder.none,
        fillColor: Colors.grey[200],
        hintText: widget.hint,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class Adressbatton extends StatefulWidget {
  Adressbatton(
      {Key, key, required this.hint, this.validator, required this.controller});
  var hint;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  @override
  State<Adressbatton> createState() => _AdressbattonState();
}

class _AdressbattonState extends State<Adressbatton> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      maxLines: 4,
      validator: widget.validator,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        border: InputBorder.none,
        fillColor: Colors.grey[200],
        hintText: widget.hint,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class AccessibilityDropdown extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> options;
  final ValueChanged<String?> onChanged;

  AccessibilityDropdown({
    required this.hint,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        border: InputBorder.none,
        fillColor: Colors.grey[200],
        hintText: hint,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      value: value,
      items: options.map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
