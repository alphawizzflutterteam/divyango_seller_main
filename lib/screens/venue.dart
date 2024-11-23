import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/VenueListModel.dart';
import '../services/colors.dart';
import '../utils/Api.path.dart';
import '../widgets/appbar_widget.dart';
import 'addVenue.dart';
import 'homepage/leadsdetails.dart';

class VenuePage extends StatefulWidget {
  // final String appBarTitle;
  //final TextEditingController _controller = TextEditingController();
  VenuePage({
    Key,
    key,
  });

  @override
  State<VenuePage> createState() => _VenuePageState();
}

class _VenuePageState extends State<VenuePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vendueList();
  }

  bool? isLoading = true;

  VenueListModel? venueListModel;

  vendueList() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? user_id = sharedPreferences.getString('user_id');
    setState(() {
      isLoading = true;
    });
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse(ApiServicves.venueList));
      request.fields.addAll({'v_id': user_id.toString()});
      print("profile para ${request.fields}");
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var finalResponse = await response.stream.bytesToString();
        final finalResult = VenueListModel.fromJson(json.decode(finalResponse));
        print("responseeee $finalResponse");
        setState(() {
          venueListModel = finalResult;
        });
        vendueList();
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception(e);
    }
  }

  deleteVenue(String? vId) async {
    var headers = {
      'Cookie': 'ci_session=ea00be8a918fc3c993e689c4af306acd9ca3f314'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.deletVenue));
    request.fields.addAll({'venue_id': vId.toString()});
    print("venue delet ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  deleteDialog(context, String? vId) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirm Delete"),
            content: const Text("Are you sure you wan't to delete this venue"),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: colors.primary),
                child: const Text("YES"),
                onPressed: () async {
                  deleteVenue(vId);
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: colors.primary),
                child: const Text("NO"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  bool isFrom = true;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Image.asset("assets/images/add.png"),
        backgroundColor: colors.primary,
        onPressed: () {
          // String appBarTitle = _controller.text;
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditVenueDetail(
                  appBarTitle: "Add Venue", bottomTitle: "Edit Venue"),
            ),
          );
        },
      ),
      appBar: appBarWithBackWidget(
          context: context,
          title: '                        Venue',
          color: colors.whiteTemp1),
      body: RefreshIndicator(
        onRefresh: () async {
          vendueList();
        },
        child: Column(
          children: [
            venueListModel?.data?.isEmpty == true ||
                    venueListModel?.data?.length == null
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 300),
                      child: Text(
                        "No Data Available",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.separated(
                      itemCount: venueListModel?.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 14),
                              width: width,
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LeadsScreen(),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 92,
                                            width: 92,
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image(
                                                image: NetworkImage(
                                                  '${ApiServicves.imageUrl}${venueListModel?.data?[index].image}',
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${venueListModel?.data?[index].name}',
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .location_on_outlined,
                                                          color: Colors.grey,
                                                          size: 20,
                                                        ),
                                                        SizedBox(
                                                          width: 200,
                                                          child: Text(
                                                            '${venueListModel?.data?[index].address}',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .grey),
                                                            maxLines: 2,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          CupertinoIcons.phone,
                                                          color: Colors.grey,
                                                          size: 16,
                                                        ),
                                                        Text(
                                                          '${venueListModel?.data?[index].mobile}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditVenueDetail(
                                                appBarTitle: "Edit Venue",
                                                model: venueListModel
                                                    ?.data?[index],
                                                bottomTitle: "Edit Venue",
                                                isFrom: true,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: colors.primary),
                                          child: const Center(
                                            child: Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          deleteDialog(
                                              context,
                                              venueListModel?.data?[index].id
                                                  .toString());
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: colors.primary),
                                          child: const Center(
                                            child: Icon(
                                              Icons.delete_forever,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const Divider(),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
