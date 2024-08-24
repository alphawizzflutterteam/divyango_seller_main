import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import '../../services/colors.dart';
import '../notification.dart';
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
        elevation: 0,
        backgroundColor: colors.secondary,
        title: const Row(
          children: [
            Icon(
              Icons.location_on_rounded,
              color: Colors.white,
              size: 26,
            ),
            SizedBox(width: 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ward 35...",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  "Ratna Lok Colony, Indore",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
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
            width: 16,
          )
        ],
      ),
      body: Container(
        // padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              color: colors.secondary,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search Places',
                  hintStyle: const TextStyle(color: Colors.grey),
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: const Icon(Icons.search),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1)),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "So Nearby Places",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8)),
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: selectedIndex == index
                                    ? colors.primary
                                    : Colors.white,
                                border:
                                    Border.all(color: Colors.grey.shade400)),
                            child: Text(
                              list[index],
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          width: 10,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
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

  Widget listTileWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height * 0.35,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade400, width: 0.5)),

      child: Row(
        children: [
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(5),
            child: const Image(
              image: NetworkImage(
                  'https://static.toiimg.com/thumb/msid-107830245,imgsize-242397,width-400,resizemode-4/107830245.jpg'),
              fit: BoxFit.fill,
            ),
          )),
          Expanded(
              flex: 2,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LeadsScreen()),
                  );
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // Align children to the start and end of the row
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Demo List 1',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.call,
                                color: Colors.grey,
                                size: 12,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text('8169906673',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.calendar,
                                color: Colors.grey,
                                size: 12,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text('12 Feb 2024',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Not Connected',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Container(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text('Demo List 1',
                //           style: TextStyle(
                //               fontSize: 14, fontWeight: FontWeight.bold)),
                //       SizedBox(
                //         height: 5,
                //       ),
                //       Row(
                //         children: [
                //           Icon(
                //             Icons.call,
                //             color: Colors.grey,
                //             size: 12,
                //           ),
                //           SizedBox(
                //             width: 3,
                //           ),
                //           Text('8169906673',
                //               style: TextStyle(fontSize: 12, color: Colors.grey)),
                //         ],
                //       ),
                //       SizedBox(
                //         height: 5,
                //       ),
                //       Row(
                //         children: [
                //           Icon(
                //             CupertinoIcons.calendar,
                //             color: Colors.grey,
                //             size: 12,
                //           ),
                //           SizedBox(
                //             width: 3,
                //           ),
                //           Text('12 Fev 2024',
                //               style: TextStyle(fontSize: 12, color: Colors.grey)),
                //         ],
                //       ),
                //       SizedBox(
                //         height: 5,
                //       )
                //     ],
                //   ),
                // ),
              ))
        ],
      ),
    );
  }
}
