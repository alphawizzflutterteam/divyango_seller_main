import 'package:flutter/material.dart';
import '../services/colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
          ),
          title: Text(
            'Notification',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          child: ListView.builder(
            itemCount: 15,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'You have New Lead',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '02 Mar 2023',
                          style: TextStyle(
                            fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: colors.darkgrey),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text('Lorem lpsum is simply dummy text'),
                  ),
                  Divider(
                    color: colors.darkgrey,
                  )
                ],
              );
            },
          ),
        ));
  }
}
