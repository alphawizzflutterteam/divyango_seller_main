import 'dart:ffi';
import 'package:divyango_user/screens/homepage/FilterSheet.dart';
import 'package:divyango_user/screens/venue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../services/colors.dart';
import '../../widgets/appbar_widget.dart';
import '../addVenue.dart';

class LeadsScreen extends StatefulWidget {
  const LeadsScreen({Key? key}) : super(key: key);

  @override
  State<LeadsScreen> createState() => _LeadsScreenState();
}

class _LeadsScreenState extends State<LeadsScreen> {
  int isSelect = 1;
  List<String> _filters = [
    'Not Connected',
    'UNDER FOLLOWUP',
    'IN PROGRESS',
    'CLIENT CLOSED',
    'NOT ANSWERED'
  ];
  List<String> _selectedFilters = [];

  void _selectFilter(String filter) {
    setState(() {
      if (_selectedFilters.contains(filter)) {
        _selectedFilters.remove(filter);
      } else {
        _selectedFilters.add(filter);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.whiteTemp,
      bottomNavigationBar: InkWell(
        onTap: () {
          // Handle onTap event here
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    isSelect = 0;
                  });
                  _showAlertDialog(context);
                },
                child: Container(
                  height: 50,
                  width: 155,
                  decoration: BoxDecoration(
                    color: isSelect == 0 ? colors.primary : Colors.white,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                      child: Text(
                    "Delete",
                    style: TextStyle(
                      color: isSelect == 1 ? Colors.black : Colors.white,
                    ),
                  )),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isSelect = 1;
                  });
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditVenueDetail(
                                appBarTitle: "Edit Venue Detail",
                              )));
                },
                child: Container(
                  height: 50,
                  width: 155,
                  decoration: BoxDecoration(
                    color: isSelect == 1 ? colors.primary : Colors.white,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                      child: Text(
                    "Edit",
                    style: TextStyle(
                      color: isSelect == 1 ? Colors.white : Colors.black,
                    ),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
      appBar: appBarWithBackWidget(
          context: context, title: 'Venue Detail', color: colors.whiteTemp1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  width: 110,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: const DecorationImage(
                          image: AssetImage('assets/images/demo.png'),
                          fit: BoxFit.cover)),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Destiny Cafe',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 20,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text(
                          '2972 Westheimer Rd. San...',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.phone,
                          size: 20,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text(
                          '8435457271',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Business hours',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 12),
                Text(
                  'Start & End Time',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  '09:00 AM - 11:00',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Accessibility',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Container(
                        height: 28,
                        width: 180,
                        decoration: BoxDecoration(
                            color: colors.lightGreen,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            'Wheelchair accessibility',
                            style: TextStyle(
                                color: colors.secondary,
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 28,
                        width: 110,
                        decoration: BoxDecoration(
                            color: colors.lightGreen,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            'Hearing loops',
                            style: TextStyle(
                                color: colors.secondary,
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    height: 28,
                    width: 160,
                    decoration: BoxDecoration(
                        color: colors.lightGreen,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        'Accessible restrooms',
                        style: TextStyle(
                            color: colors.secondary,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Review and Rating",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    Row(
                      children: [
                        SizedBox(width: 8),
                        Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text(
                            "(620)",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(4)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.asset(
                                    'assets/images/user.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Jane Cooper",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/accessible.png',
                                        height: 20,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "Accessible",
                                        style:
                                            TextStyle(color: colors.secondary),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            "25/6/2024",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: colors.greyTemp,
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Image.asset("assets/images/delete.png", height: 50),
          content: Text(
            "    Are you sure you want to\n                    delete?",
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,  // Ensure buttons are evenly spaced
              children: [
                Container(
                  padding: EdgeInsets.zero,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,  // Remove internal padding
                    ),
                    child: Container(
                      height: 43,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Center(
                        child: Text("Cancel", style: TextStyle(color: Colors.black)),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.zero,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,  // Remove internal padding
                    ),
                    child: Container(
                      height: 43,
                      width: 99,
                      decoration: BoxDecoration(
                        color: colors.primary,  // Replace with your primary color
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Center(
                        child: Text("Delete", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VenuePage()),
                      );
                      // Add delete logic here
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

}
