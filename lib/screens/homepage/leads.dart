import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import '../../services/colors.dart';
import '../Subscription.dart';
import '../notification.dart';
import '../venue.dart';
import 'FilterSheet.dart';
import 'leadsdetails.dart';

class LeadsWidget extends StatefulWidget {
  const LeadsWidget({super.key});

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
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.whiteTemp,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: colors.secondary,
        title: Padding(
          padding: const EdgeInsets.only(left: 105.0),
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
                        builder: (context) => const NotificationScreen()));
              },
              child: SvgPicture.asset('assets/images/Notification.svg')),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Container(
        // padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            subscriptionBox(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
              child: Text(
                "Venue",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
                child: ListView.separated(
              itemCount: 10,
              itemBuilder: (context, index) {
                return listTileWidget();
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
            ))
          ],
        ),
      ),
    );
  }

  subscriptionBox() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 12, top: 13),
      child: Row(children: [
        InkWell(
          onTap: () {
            //Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context)=>VenuePage()));
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 13),
                  child: Image.asset("assets/images/icon1.png"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            "10",
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Venue",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Subscription()));
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 13),
                  child: Image.asset("assets/images/icon2.png"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 17.0),
                          child: Text(
                            "Active",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Subscription",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
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

  Widget listTileWidget() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          margin: const EdgeInsets.symmetric(horizontal: 14),
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height * 0.35,
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10),
          //     border: Border.all(color: Colors.grey.shade400, width: 0.5)),

          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LeadsScreen()),
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
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: const Image(
                      image: NetworkImage(
                          'https://static.toiimg.com/thumb/msid-107830245,imgsize-242397,width-400,resizemode-4/107830245.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
                Expanded(
                    flex: 2,
                    child: Container(
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // Align children to the start and end of the row
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Destiny Cafe',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  // SizedBox(
                                  //   width: 3,
                                  // ),
                                  Text('2972 Westheimer Rd. San...',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey)),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.phone,
                                    color: Colors.grey,
                                    size: 16,
                                  ),
                                  // SizedBox(
                                  //   width: 3,
                                  // ),
                                  Text(' 8535453210',
                                      style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              )
                            ],
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(right: 5),
                          //   child: Container(
                          //     width: 100,
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(5),
                          //       border: Border.all(
                          //         color: Colors.black,
                          //         width: 1,
                          //       ),
                          //     ),
                          //     child: const Center(
                          //       child: Text(
                          //         'Not Connected',
                          //         style:
                          //             TextStyle(fontSize: 12, color: Colors.black),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
