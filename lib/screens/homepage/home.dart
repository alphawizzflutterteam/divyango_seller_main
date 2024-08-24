// import 'dart:convert';
//
// import 'package:digitalbuzz/services/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../Model/CampaignModel.dart';
// import '../../utils/Api.path.dart';
// import '../notification.dart';
//
// class HomePageWidget extends StatefulWidget {
//   const HomePageWidget({super.key});
//
//   @override
//   State<HomePageWidget> createState() => _HomePageWidgetState();
// }
//
// String selectedDate = '';
//
// class _HomePageWidgetState extends State<HomePageWidget> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     convertDateTimeDispla();
//     getCampagin();
//   }
//
//   var dateFormate;
//   String? formattedDate;
//   String? timeData;
//
//   convertDateTimeDispla() {
//     var now = DateTime.now();
//     var yesterday = now.subtract(Duration(days: 1));
//     var formatter = DateFormat('yyyy-MM-dd');
//     formattedDate = formatter.format(yesterday);
//     print(
//         "date before $formattedDate"); // This will print the date of one day before today
//   }
//
//   CompaignModel? compaignData;
//   getCampagin() async {
//     final SharedPreferences sharedPreferences =
//         await SharedPreferences.getInstance();
//     String? user_id = sharedPreferences.getString('user_id');
//     try {
//       Map data = {
//         'project_id': user_id.toString(),
//         'from_date': date1 == null || date1 == "" ? formattedDate : date1,
//         'to_date': date2 == null || date2 == "" ? formattedDate : date2,
//       };
//       http.Response response = await http.post(
//         Uri.parse(ApiServicves.campagin),
//         body: {
//           'project_id': user_id.toString(),
//           'from_date': date1 == null || date1 == "" ? formattedDate : date1,
//           'to_date': date2 == null || date2 == "" ? formattedDate : date2,
//         },
//       );
//       print("companion parameter$data");
//       print("user id ind home page${response.body}");
//       var json = jsonDecode(response.body);
//       if (response.statusCode == 200) {
//         setState(() {
//           compaignData = CompaignModel.fromJson(json);
//         });
//       } else {
//         print(response.reasonPhrase);
//       }
//     } catch (e, stackTrace) {
//       print(stackTrace);
//       throw Exception(e);
//     }
//   }
//
//   DateTime? _startDate;
//   DateTime? _endDate;
//   String? _selectedStatus;
//
//   final List<String> _status = [
//     'Today',
//     'Yesterday',
//     'Last 7 Days',
//     'Last 14 Days',
//     'This month',
//     'Last 30 Days',
//     'Last Month',
//     'Last 90 days',
//     'Maximum',
//     'Custom Date',
//     'This Week',
//     'This Week'
//   ];
//
//   void _pickDateRange() async {
//     DatePicker.showDatePicker(
//       context,
//       showTitleActions: true,
//       onChanged: (date) {},
//       onConfirm: (date) {
//         setState(() {
//           _startDate = date;
//         });
//         DatePicker.showDatePicker(
//           context,
//           showTitleActions: true,
//           onChanged: (date) {},
//           onConfirm: (date) {
//             setState(() {
//               _endDate = date;
//             });
//           },
//           currentTime: DateTime.now(),
//         );
//       },
//       currentTime: DateTime.now(),
//     );
//   }
//
//   String? date1;
//   String? date2;
//   bool showDate = true;
//   DateTime initialDate = DateTime.now();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: colors.whiteTemp1,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: Image.asset(
//           'assets/images/applogo.png',
//           scale: 4,
//         ),
//         actions: [
//           InkWell(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const NotificationScreen()),
//               );
//             },
//             child: Image.asset('assets/images/Notification.png'),
//           ),
//           const SizedBox(
//             width: 5,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             flex: 2,
//             child: Column(
//               children: [
//                 SizedBox(height: 10),
//                 // Padding(
//                 //   padding: const EdgeInsets.symmetric(horizontal: 10),
//                 //   child: DropdownButtonFormField<String>(
//                 //     value: _selectedStatus,
//                 //     icon: const Icon(
//                 //       Icons.keyboard_arrow_down_sharp,
//                 //       color: colors.primary,
//                 //     ),
//                 //     onChanged: (String? newValue) {
//                 //       setState(() {
//                 //         _selectedStatus = newValue;
//                 //         if (newValue == 'Custom Date') {
//                 //           _pickDateRange();
//                 //         }
//                 //       });
//                 //     },
//                 //     items: _status.map((String orderitem) {
//                 //       return DropdownMenuItem(
//                 //         value: orderitem,
//                 //         child: Text(
//                 //           orderitem.toString(),
//                 //           style:
//                 //           const TextStyle(color: colors.secondary),
//                 //         ),
//                 //       );
//                 //     }).toList(),
//                 //     decoration: const InputDecoration(
//                 //         contentPadding: EdgeInsets.all(10),
//                 //         border: OutlineInputBorder(
//                 //           borderRadius: BorderRadius.all(Radius.circular(10)),
//                 //         ),
//                 //         hintText: 'Select Status',
//                 //         hintStyle: TextStyle(color: colors.primary),
//                 //         filled: true,
//                 //         fillColor: Colors.white),
//                 //   ),
//                 //
//                 // ),
//                 // if (_selectedStatus == 'Custom Date' && _startDate != null && _endDate != null)
//                 //   Padding(
//                 //     padding: const EdgeInsets.all(8.0),
//                 //     child: Text(
//                 //       'Start End Date: ${DateFormat('yyyy-MM-dd').format(_startDate!)} - ${DateFormat('yyyy-MM-dd').format(_endDate!)}',
//                 //     ),
//                 //   ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   height: 40,
//                   width: MediaQuery.of(context).size.width,
//                   child: Row(
//                     children: [
//                       const Text(
//                         'Date:',
//                         style: TextStyle(
//                             color: Color(0xFF112c48),
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         date1 ?? "$formattedDate",
//                         style: const TextStyle(
//                             color: Color(0xFF112c48),
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16),
//                       ),
//                       Text(
//                         date2 != null ? " to $date2 " : " to $formattedDate",
//                         style: const TextStyle(
//                             color: Color(0xFF112c48),
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16),
//                       ),
//                       // Expanded(
//                       //   child: Container(
//                       //     height: 40,
//                       //     decoration: BoxDecoration(
//                       //         borderRadius: BorderRadius.circular(5),
//                       //         border: Border.all(
//                       //             color: Colors.grey.shade400, width: 0.9)),
//                       //     child: Center(
//                       //       child: Text(
//                       //         selectedDate == ''
//                       //             ? '$formattedDate'
//                       //             : selectedDate,
//                       //         style: TextStyle(
//                       //             color: selectedDate != ''
//                       //                 ? Colors.black
//                       //                 : Colors.black54),
//                       //       ),
//                       //     ),
//                       //   ),
//                       // ),
//                       const SizedBox(
//                         width: 25,
//                       ),
//                       showDate
//                           ? Container(
//                               decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.black),
//                                   borderRadius: BorderRadius.circular(10)),
//                               child: IconButton(
//                                 onPressed: () async {
//                                   DateTime? selectedDate1 =
//                                       await showDatePicker(
//                                           context: context,
//                                           initialDate: DateTime.now(),
//                                           firstDate: DateTime(1950),
//                                           lastDate: DateTime.now());
//                                   if (selectedDate1 != null) {
//                                     setState(() {
//                                       initialDate = selectedDate1;
//                                       date1 =
//                                           "${selectedDate1.year}-0${selectedDate1.month}-${selectedDate1.day}";
//                                       showDate = false;
//                                     });
//                                   }
//                                   await getCampagin();
//                                 },
//                                 icon: const Icon(
//                                   Icons.calendar_month_outlined,
//                                   color: Color(0xFF112c48),
//                                 ),
//                               ),
//                             )
//                           : Container(
//                               decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.black),
//                                   borderRadius: BorderRadius.circular(10)),
//                               child: IconButton(
//                                 onPressed: () async {
//                                   DateTime? selectedDate = await showDatePicker(
//                                       context: context,
//                                       initialDate: DateTime.now(),
//                                       firstDate: DateTime(1950),
//                                       lastDate: DateTime.now());
//                                   if (selectedDate != null) {
//                                     setState(() {
//                                       date2 =
//                                           "${selectedDate.year}-0${selectedDate.month}-${selectedDate.day}";
//                                       showDate = true;
//                                     });
//                                   }
//                                   await getCampagin();
//                                 },
//                                 icon: const Icon(
//                                   Icons.calendar_month_outlined,
//                                   color: colors.primary,
//                                 ),
//                               ),
//                             ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             child: headerTextWidget(
//                               title: 'Balance',
//                               subTitle:
//                                   (compaignData?.campaignData?.totalBudget! ==
//                                           null)
//                                       ? '₹ 0.0'
//                                       : '₹ ${compaignData!.balance.toString()}',
//                             ),
//                           ),
//                           // Expanded(
//                           //   child: headerTextWidget(
//                           //     title: 'Result',
//                           //     subTitle: (compaignData?.allCampaignData?.result?.isEmpty ?? true)
//                           //         ? '0.0'
//                           //         : compaignData!.allCampaignData!.result!,
//                           //   ),
//                           // ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       Container(
//                         height: 170,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 20, vertical: 20),
//                         color: Colors.white,
//                         child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: headerTextWidget(
//                                     title: 'Total Leads',
//                                     subTitle: (compaignData?.campaignData?.leads
//                                                 ?.isEmpty ??
//                                             true)
//                                         ? '0.0'
//                                         : compaignData!.campaignData!.leads!
//                                             .replaceAll(".00", ""),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: headerTextWidget(
//                                     title: 'CPL SC',
//                                     subTitle: (compaignData
//                                                 ?.campaignData?.avgCpl ==
//                                             null)
//                                         ? '₹ 0.0'
//                                         : '₹ ${double.parse(compaignData!.campaignData!.avgCpl.toString()).toStringAsFixed(2)}',
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 30,
//                             ),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: headerTextWidget(
//                                     title: 'Amount Spend',
//                                     subTitle: (compaignData
//                                                 ?.campaignData?.dailySpent ==
//                                             null)
//                                         ? '₹ 0.0'
//                                         : '₹ ${double.parse(compaignData!.campaignData!.dailySpent.toString()).toStringAsFixed(2)}',
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: headerTextWidget(
//                                     title: 'Ads Budget',
//                                     subTitle: (compaignData
//                                                 ?.campaignData?.totalBudget ==
//                                             null)
//                                         ? '₹ 0.0'
//                                         : '₹ ${double.parse(compaignData!.campaignData!.totalBudget.toString()).toStringAsFixed(2)}',
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Container(
//               color: Colors.white,
//               child: Column(
//                 children: [
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   compaignData?.status == false
//                       ? const Center(
//                           child: Text(
//                             "No Campaign Found",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black),
//                           ),
//                         )
//                       : Expanded(
//                           child: ListView.separated(
//                             padding: const EdgeInsets.only(bottom: 30),
//                             physics: const BouncingScrollPhysics(),
//                             itemCount:
//                                 compaignData?.campaignData?.campaigns.length ??
//                                     0,
//                             itemBuilder: (context, index) {
//                               return listTileContainer(index);
//                             },
//                             separatorBuilder: (context, index) {
//                               return const SizedBox(
//                                 height: 20,
//                               );
//                             },
//                           ),
//                         ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(2015, 8),
//         lastDate: DateTime(2101));
//     if (picked != null && picked != DateTime.now()) {
//       setState(() {
//         selectedDate = DateFormat('yyyy-MM-dd').format(picked);
//       });
//     }
//     getCampagin();
//   }
//
//   Widget listTileContainer(int index) {
//     print("===============${compaignData?.status}===========");
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       width: MediaQuery.of(context).size.width,
//       // height: MediaQuery.of(context).size.height * 0.35,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.grey.shade400, width: 0.5),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(
//             height: 15,
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Text(
//               '${compaignData?.campaignData?.campaigns[index].campaignName}',
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Row(
//               children: [
//                 // Expanded(
//                 //   child: subHeaderTextWidget(
//                 //       title: 'Date', subTitle: '${compaignData?.campaignData[index].date}'),
//                 // ),
//                 Expanded(
//                   child: subHeaderTextWidget(
//                       title: 'Budget',
//                       subTitle:
//                           '₹ ${double.parse(compaignData!.campaignData!.campaigns[index].sumBudgetSc.toString()).toStringAsFixed(2)}'),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           // Container(
//           //   padding: EdgeInsets.symmetric(horizontal: 20),
//           //   child: Row(
//           //     children: [
//           //       Expanded(
//           //         child: subHeaderTextWidget(
//           //             title: 'Amount Spent', subTitle: '₹${compaignData?.campaignData[index].amountSpent}'),
//           //       ),
//           //       Expanded(
//           //         child: subHeaderTextWidget(
//           //             title: 'Ad Set Budget', subTitle: '₹${compaignData?.campaignData[index].adSetBudget}'),
//           //       ),
//           //     ],
//           //   ),
//           // ),
//           // const SizedBox(
//           //   height: 20,
//           // ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: subHeaderTextWidget(
//                       title: 'CPL SC',
//                       subTitle:
//                           '₹ ${double.parse(compaignData!.campaignData!.campaigns[index].sumCplSc.toString()).toStringAsFixed(2)}'),
//                 ),
//                 Expanded(
//                   child: subHeaderTextWidget(
//                       title: 'Spent SC',
//                       subTitle:
//                           '₹ ${double.parse(compaignData!.campaignData!.campaigns[index].sumSpentSc.toString()).toStringAsFixed(2)}'),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             height: 40,
//             color: Colors.grey.shade100,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Result',
//                   style: TextStyle(fontSize: 14, color: Colors.grey),
//                 ),
//                 Text(
//                   '${compaignData?.campaignData?.campaigns[index].sumResults}',
//                   style: const TextStyle(
//                       fontSize: 14, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget headerTextWidget({required String title, required String subTitle}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(fontSize: 14, color: Colors.grey),
//         ),
//         Text(
//           subTitle,
//           style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         )
//       ],
//     );
//   }
//
//   Widget subHeaderTextWidget(
//       {required String title, required String subTitle}) {
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(fontSize: 12, color: Colors.grey),
//           ),
//           Text(
//             subTitle,
//             style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
// }
