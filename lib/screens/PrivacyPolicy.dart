import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;

import '../Model/Privacypolicy.dart';
import '../services/colors.dart';
import '../utils/Api.path.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  late Future myFuture;
  @override
  void initState() {
    myFuture = getPrivacyPolicy(); // TODO: implement initState
    super.initState();
  }

  Privacypolicy? privacyPolicy;
  Future<void> getPrivacyPolicy() async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse(ApiServicves.getpolicy));
      request.fields.addAll({'slug': 'privacy_policy'});
      http.StreamedResponse response = await request.send();
      var json = jsonDecode(await response.stream.bytesToString());
      if (response.statusCode == 200) {
        privacyPolicy = Privacypolicy.fromJson(json);
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
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child:
              const Icon(Icons.arrow_back_ios, size: 20, color: Colors.white),
        ),
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: myFuture,
            builder: (context, snap) {
              return snap.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(
                      backgroundColor: colors.primary,
                    ))
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      decoration: const BoxDecoration(
                        // const BorderRadius.all(Radius.Radius),
                        border: Border(
                          top: BorderSide(
                            //  BorderRadius.all(Radius.Radius),
                            color: colors.primary,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 1,
                            color: Colors.grey,
                            width: MediaQuery.of(context).size.width,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Html(data: privacyPolicy?.setting?.data.toString()),
                          Html(
                              data: privacyPolicy?.setting?.description
                                  .toString()),
                        ],
                      ),
                    );
            }),
      ),
    );
  }
}
