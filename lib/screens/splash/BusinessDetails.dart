import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/GetProfileModel.dart';
import '../../services/btnPage.dart';
import '../../services/colors.dart';
import '../../utils/Api.path.dart';

class BusinessDetails extends StatefulWidget {
  const BusinessDetails({Key? key}) : super(key: key);

  @override
  State<BusinessDetails> createState() => _BusinessDetailsState();
}

class _BusinessDetailsState extends State<BusinessDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profile();
    businessType();
  }

  TextEditingController nameCtr = TextEditingController();
  TextEditingController addressCtr = TextEditingController();
  TextEditingController contactCtr = TextEditingController();
  TextEditingController businessTypeCtr = TextEditingController();

  bool isLoading = false;
  GetProfileModel? getProfileModel;

  List<String> categories = [];
  String? selectedCategory;

  Future<void> businessType() async {
    print("Starting API call...");
    final String apiUrl =
        "https://developmentalphawizz.com/divyango_new/api/types_of_bussiness";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        print("Response Status Code: ${response.statusCode}");
        final data = json.decode(response.body);

        // Debugging: Print the entire response data
        print("Response Data: $data");

        if (data['status'] == "success") {
          List<dynamic> businessList = data['data'];
          setState(() {
            categories = businessList
                .map((item) => item['bussiness_name'] as String)
                .toList();
            selectedCategory = categories.isNotEmpty
                ? categories[0]
                : null; // Default to first item
            isLoading = false;
          });

          // categories.forEach((element) {
          //   print(
          //       "categororr ${getProfileModel?.user?.typeOfBussiness}  dddddd ${element['bussiness_name']}");
          //   if (getProfileModel?.user?.typeOfBussiness.toString() == element['id'].toString()) {
          //     selectedCategory = element['id'];
          //   }
          // });
        } else {
          print("API returned a non-success status.");
          setState(() {
            isLoading = false;
          });
        }
      } else {
        print("Failed to fetch data. Status code: ${response.statusCode}");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error during API call: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

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
          nameCtr.text = getProfileModel?.user?.bussinessName ?? "";
          businessTypeCtr.text = getProfileModel?.user?.typeOfBussiness ?? "";
          addressCtr.text = getProfileModel?.user?.address ?? "";
          contactCtr.text = getProfileModel?.user?.bussinessContact ?? "";
          isLoading = false;
          print("asddadadsadasdsadadas ${nameCtr.text}");
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
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://developmentalphawizz.com/divyango_new/api/vendor_edit'));
    request.fields.addAll({
      'id': user_id.toString(),
      'uname': '${getProfileModel?.user?.uname}',
      'mobile': '${getProfileModel?.user?.mobile}',
      'email': '${getProfileModel?.user?.email}',
      'address': addressCtr.text,
      'bussiness_name': nameCtr.text,
      'type_of_bussiness': selectedCategory.toString(),
      'bussiness_contact': contactCtr.text
    });
    print("edit business details ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("working@@");
      var finalResponse = await response.stream.bytesToString();
      var result = json.decode(finalResponse);
      if (result['response_code'] == "1") {
        print("$result===========");
        Fluttertoast.showToast(msg: '${result['message']}');
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: '${result['message']}');
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FilledBtn(
          title: 'Update',
          onPress: () => updateProfile(),
        ),
      ),
      backgroundColor: colors.whiteTemp,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colors.secondary,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child:
              const Icon(Icons.arrow_back_ios, size: 20, color: Colors.white),
        ),
        title: const Text(
          'BusinessDetails',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 10, top: 20),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: nameCtr,
                      decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        fillColor: colors.txtField,
                        hintText: 'BusinessName',
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
                          return 'Please enter a BusinessName';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
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
                      controller: addressCtr,
                      decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        fillColor: colors.txtField,
                        hintText: 'Address',
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
                          return 'Please enter a Address';
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
                      controller: contactCtr,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        counterText: "",
                        filled: true,
                        isDense: true,
                        fillColor: colors.txtField,
                        hintText: 'ContachNumbar',
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
                          return 'Please enter a ContachNumbar';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : categories.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black12),
                              color: Colors.grey[200]),
                          child: Column(
                            children: [
                              // const Text(
                              //   "Select a Business Type:",
                              //   style: TextStyle(
                              //       fontSize: 18,
                              //       fontWeight: FontWeight.bold),
                              // ),
                              SizedBox(height: 16),
                              DropdownButton<String>(
                                underline: SizedBox.shrink(),
                                value: selectedCategory,
                                isExpanded: true,
                                items: categories
                                    .map((String category) =>
                                        DropdownMenuItem<String>(
                                          value: category,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(category),
                                          ),
                                        ))
                                    .toList(), // Correct mapping
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedCategory = newValue;
                                  });
                                  print(
                                      "Selected Business Type: $selectedCategory");
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    : const Center(
                        child: Text('No Business available.'),
                      ),
          ],
        ),
      ),
    );
  }
}
