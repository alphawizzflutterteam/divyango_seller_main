import 'dart:convert';

import 'package:divyango_user/screens/venue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../Model/ReviewModel.dart';
import '../../Model/VenueListModel.dart';
import '../../services/colors.dart';
import '../../utils/Api.path.dart';
import '../../widgets/appbar_widget.dart';

class LeadsScreen extends StatefulWidget {
  final VenueData? model;
  LeadsScreen({Key? key, this.model}) : super(key: key);

  @override
  State<LeadsScreen> createState() => _LeadsScreenState();
}

class _LeadsScreenState extends State<LeadsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    review();
  }

  int isSelect = 1;
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

  final List<String> ratingType = ["Accessible", "Partially Accessible", "Not Accessible"];

  ReviewModel? reviewModel;

  review() async {
    var headers = {
      'Cookie': 'ci_session=a03793758217097f6ee63976aee7e8508c715b65'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiServicves.getReview));
    request.fields.addAll({'venue_id': widget.model!.id.toString()});
    request.headers.addAll(headers);
    print(request.fields);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = ReviewModel.fromJson(json.decode(result));
      setState(() {
        reviewModel = finalResult;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  convertDate(String? date){
    String apiResponseDate = date.toString();

    // Parse the string to a DateTime object
    DateTime parsedDate = DateTime.parse(apiResponseDate);

    // Format the DateTime to only display the date
    String _formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);

    return _formattedDate;

    // print(_formattedDate); // Output: 2024-11-22
  }

  @override
  Widget build(BuildContext context) {
    // Split the accessibility names into a list and remove duplicates
    final List<String> accessibilityList = widget.model!.accessibilityNames!
        .split(',')
        .map((e) => e.trim())
        .toSet()
        .toList(); // Convert to Set to remove duplicates, then back to List

    return Scaffold(
      backgroundColor: colors.whiteTemp,
      appBar: appBarWithBackWidget(
          context: context,
          title: '                     Venue Detail',
          color: colors.whiteTemp1),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
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
                        image: DecorationImage(
                            image: NetworkImage(
                                '${ApiServicves.imageUrl}${widget.model?.image}'),
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
                      Text(
                        '${widget.model?.name}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 20,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Container(
                            width: 200,
                            child: Text(
                              '${widget.model?.address}',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 13),
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
                            size: 20,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            '${widget.model?.mobile}',
                            style: const TextStyle(color: Colors.grey),
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
                  const Text(
                    'Business hours',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Start & End Time',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '${widget.model?.startTime} - ${widget.model?.endTime}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'Accessibility',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 12,
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text.rich(
                          TextSpan(
                            children: accessibilityList.map((name) {
                              return TextSpan(
                                text: name,
                                style: const TextStyle(
                                  color: colors.secondary, // Change to your desired color
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [
                                  // Add a comma after each name, except the last one
                                  if (accessibilityList.last != name)
                                    TextSpan(
                                      text: ', ',
                                      style: const TextStyle(
                                        color: colors.secondary, // Change to your desired comma color
                                      ),
                                    ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),


                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: accessibilityList.map((name) {
                  //     return Padding(
                  //       padding:
                  //           const EdgeInsets.all(4), // Space between containers
                  //       child: Container(
                  //         // height: 35,
                  //         // width: 180,
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(5),
                  //         ),
                  //         child: Padding(
                  //           padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  //           child: Text(
                  //             name,
                  //             style: const TextStyle(
                  //               color: colors.secondary,
                  //               fontSize: 16,
                  //               fontWeight: FontWeight.w600,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   }).toList(),
                  // ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Review and Rating",
                        style:
                            TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      reviewModel?.totalCount == null ||
                              reviewModel?.totalCount == ""
                          ? const Center(
                              child: Text(
                              "(0)",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ))
                          : Row(
                              children: [
                                // SizedBox(width: 8),
                                Text(
                                  " (${reviewModel?.totalCount})",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600, fontSize: 16),
                                ),
                              ],
                            ),
                    ],
                  ),
                ],
              ),
            ),

            ///rating bars
            reviewModel?.accessiblePercentage != null
            ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: List.generate(3, (index) {
                  String type = ratingType[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: SizedBox(
                      // width: 300,
                      child: Row(
                        children: [
                          Expanded(
                            flex:1,
                            child: Text('${type}',
                                style: TextStyle(fontSize: 16)),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            flex: 2,
                            child: LinearProgressIndicator(
                              // value: [0.8, 0.4, 0.1][index],
                              value: [reviewModel?.accessiblePercentage, reviewModel?.partiallyAccessiblePercentage, reviewModel?.notAccessiblePercentage][index]! / 100,
                              backgroundColor: Colors.grey[300],
                              color: index == 0
                                  ? Colors.green
                                  : (index == 1
                                  ? Colors.orange
                                  : Colors.red),
                            ),
                          ),
                          SizedBox(width: 8),
                          // Text('${(100 * (1 - 0.2 * index)).toInt()}'),
                          Text(
                              index == 0
                                  ? '${reviewModel?.accessiblePercentage}%'
                                  : index == 1
                                    ? '${reviewModel?.partiallyAccessiblePercentage}%'
                                    : '${reviewModel?.notAccessiblePercentage}%'
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            )
            : SizedBox(),
            SizedBox(height: 12,),

            reviewModel?.data.isEmpty == true ||
                    reviewModel?.data.length == null ||
                    reviewModel?.data.length == ""
                ? const Center(
                    child: Text("No Review Here",
                        style: TextStyle(fontWeight: FontWeight.w600)))
                : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: reviewModel?.data.length ?? 0,
                  itemBuilder: (context, index) {
                    String reviewDate = convertDate(reviewModel?.data[index].createdAt.toString());
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
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
                                        borderRadius:
                                            BorderRadius.circular(4)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: Image.network(
                                        'https://developmentalphawizz.com/divyango_new/uploads/profile_pics/${reviewModel?.data[index].profilePic}',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${reviewModel?.data[index].username}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/accessible.png',
                                            height: 20,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            "${reviewModel?.data[index].revText}",
                                            style: const TextStyle(
                                                color: colors.secondary),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                "${reviewDate}"
                                    .replaceAll(".000", ""),
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600),
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
                )
          ],
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Image.asset("assets/images/delete.png", height: 50),
          content: const Text(
            "    Are you sure you want to\n                    delete?",
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceEvenly, // Ensure buttons are evenly spaced
              children: [
                Container(
                  padding: EdgeInsets.zero,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero, // Remove internal padding
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
                        child: Text("Cancel",
                            style: TextStyle(color: Colors.black)),
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
                      padding: EdgeInsets.zero, // Remove internal padding
                    ),
                    child: Container(
                      height: 43,
                      width: 99,
                      decoration: BoxDecoration(
                        color:
                            colors.primary, // Replace with your primary color
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Center(
                        child: Text("Delete",
                            style: TextStyle(color: Colors.white)),
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
