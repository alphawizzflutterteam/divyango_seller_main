import 'package:flutter/material.dart';

import '../../services/colors.dart';

class BusinessDetails extends StatefulWidget {
  const BusinessDetails({Key? key}) : super(key: key);

  @override
  State<BusinessDetails> createState() => _BusinessDetailsState();
}

class _BusinessDetailsState extends State<BusinessDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.whiteTemp,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colors.whiteTemp1,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child:
              const Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        ),
        title: const Text(
          'Business Detail',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          //color: Colors.blue,
                          image: DecorationImage(
                              image: AssetImage('assets/images/demo.png'),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Business Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Image.asset('assets/images/Call-1.png'),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              '8976543234',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/Message.png',
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              'Business@gmail.com',
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          //  SizedBox(height: 5,),
          //  SizedBox(height: 5,),
          Divider(
            color: colors.greyTemp,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(color: colors.darkgrey),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Client Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'GST Name',
                      style: TextStyle(color: colors.darkgrey),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Demo GST Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Project Code',
                      style: TextStyle(color: colors.darkgrey),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'P-116',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'City',
                      style: TextStyle(color: colors.darkgrey),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Indore',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Address', style: TextStyle(color: colors.darkgrey)),
                SizedBox(
                  height: 4,
                ),
                Text('2972 Westheimer Rd. Santa Ana, lllinois 85486',
                    style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
