import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Model/FaqModel.dart';
import '../services/colors.dart';
import '../utils/Api.path.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  ScrollController controller = new ScrollController();
  bool flag = true;
  bool expand = true;
  int selectedIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(_scrollListener);
  }

  _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      if (this.mounted) {
        if (mounted)
          setState(() {
            // isLoadingmore = true;
            getFaq();
          });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);
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
          'FAQS',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white  ),
        ),
      ),
      body: SingleChildScrollView(
        child: FaqModel == null || FaqModel == ""
            ? const Center(
                child: CircularProgressIndicator(
                  color: colors.primary,
                ),
              )
            : FutureBuilder(
                future: getFaq(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  FaqModel faqsList = snapshot.data;
                  if (snapshot.hasData) {
                    return ListView.builder(
                      controller: controller,
                      itemCount: faqsList.data?.length,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Card(
                            elevation: 1,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(4),
                              onTap: () {
                                if (mounted) {
                                  setState(() {
                                    selectedIndex = index;
                                    flag = !flag;
                                  });
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            faqsList.data![index].title ?? "",
                                            style: const TextStyle(
                                                color: Colors.black),
                                          )),
                                      selectedIndex != index || flag
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: Text(
                                                          faqsList.data![index]
                                                                  .description ??
                                                              "",
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ))),
                                                // Icon(Icons.keyboard_arrow_down)
                                              ],
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8.0),
                                                      child: Text(
                                                        faqsList.data![index]
                                                                .description ??
                                                            "",
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                  //Icon(Icons.keyboard_arrow_up)
                                                ]),
                                    ]),
                              ),
                            ));
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Icon(Icons.error_outline);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
      ),
    );
  }

  Future getFaq() async {
    var request = http.Request('GET', Uri.parse('${ApiServicves.faqs}'));

    http.StreamedResponse response = await request.send();
    print(request);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      print(str);
      return FaqModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  }
}
