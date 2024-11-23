import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/VenueListModel.dart';
import '../../services/colors.dart';
import '../../utils/Api.path.dart';
import '../Subscription.dart';
import '../notification.dart';
import '../venue.dart';
import 'leadsdetails.dart';

class LeadsWidget extends StatefulWidget {
  const LeadsWidget({Key, key});

  @override
  State<LeadsWidget> createState() => _LeadsWidgetState();
}

class _LeadsWidgetState extends State<LeadsWidget> {
  List<String> list = [
    'All',
    'Cafes',
    'Restaurants',
    'Libraries',
    'Toilets',
    'Cinemas'
  ];

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
      }
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception(e);
    }
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    return WillPopScope(
      child: Scaffold(
        backgroundColor: colors.whiteTemp,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: colors.secondary,
          title: const Padding(
            padding: EdgeInsets.only(left: 105.0),
            child: Text(
              "Dashboard",
              style: TextStyle(color: Colors.white),
            ),
          ),
          // Row(
          //   children: [
          //     SvgPicture.asset('assets/images/mingcute_location-fill.svg'),
          //     SizedBox(width: 4),
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           "Ward 35...",
          //           style: TextStyle(color: Colors.white, fontSize: 16),
          //         ),
          //         Text(
          //           "Ratna Lok Colony, Indore",
          //           style: TextStyle(color: Colors.white, fontSize: 12),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
          actions: [
            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationScreen(),
                    ),
                  );
                },
                child: SvgPicture.asset('assets/images/Notification.svg')),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            vendueList();
          },
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                subscriptionBox(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                  child: Text(
                    "Venue",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
                venueListModel?.data?.isEmpty == true ||
                        venueListModel?.data?.length == null ||
                        venueListModel?.data?.length == ""
                    ? const Center(
                        child: Text(
                          "No Data Available",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      )
                    : Expanded(
                        child: ListView.separated(
                          itemCount: venueListModel?.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 14),
                                  width: width,
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => LeadsScreen(
                                                  model: venueListModel
                                                      ?.data?[index]),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 92,
                                                width: 92,
                                                padding:
                                                    const EdgeInsets.all(5),
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
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '${venueListModel?.data?[index].name}',
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                              Icons
                                                                  .location_on_outlined,
                                                              color:
                                                                  Colors.grey,
                                                              size: 20,
                                                            ),
                                                            Container(
                                                              width: 200,
                                                              child: Text(
                                                                '${venueListModel?.data?[index].address}',
                                                                style: const TextStyle(
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
                                                              CupertinoIcons
                                                                  .phone,
                                                              color:
                                                                  Colors.grey,
                                                              size: 16,
                                                            ),
                                                            Text(
                                                              '${venueListModel?.data?[index].mobile}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
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
                      )
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Confirm Exit"),
                content: const Text("Are you sure you want to exit?"),
                actions: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: colors.primary),
                    child: const Text("YES"),
                    onPressed: () {
                      SystemNavigator.pop();
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
        return true;
      },
    );
  }

  subscriptionBox() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 12, top: 13),
      child: Row(children: [
        InkWell(
          onTap: () {
            //Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => VenuePage()));
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.19,
            width: MediaQuery.of(context).size.width / 2.3,
            decoration: BoxDecoration(
                color: colors.darkmbar, borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 13),
                  child: Image.asset("assets/images/icon1.png"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: venueListModel?.totalCount == null ||
                                  venueListModel?.totalCount == ""
                              ? const Text(
                                  "0",
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600),
                                )
                              : Text(
                                  "${venueListModel?.totalCount.toString()}",
                                  style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600),
                                ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Venue",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.arrow_forward_ios),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Subscription(),
              ),
            );
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.19,
            width: MediaQuery.of(context).size.width / 2.3,
            decoration: BoxDecoration(
                color: colors.light, borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 13),
                  child: Image.asset("assets/images/icon2.png"),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 17.0),
                          child: Text(
                            "Active",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Subscription",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.arrow_forward_ios),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
