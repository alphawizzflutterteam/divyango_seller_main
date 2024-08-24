import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/colors.dart';
import '../widgets/appbar_widget.dart';
import 'addVenue.dart';
import 'homepage/leadsdetails.dart';

class VenuePage extends StatefulWidget {
  // final String appBarTitle;
  //final TextEditingController _controller = TextEditingController();
   VenuePage({super.key,});

  @override
  State<VenuePage> createState() => _VenuePageState();
}

class _VenuePageState extends State<VenuePage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Image.asset("assets/images/add.png"),
        backgroundColor: colors.primary,
        onPressed: () {
         // String appBarTitle = _controller.text;
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>EditVenueDetail(appBarTitle:"Add Venue")));
        },
      ),
      appBar: appBarWithBackWidget(
          context: context, title: '                        Venue', color: colors.whiteTemp1),
      body: Column(
        children: [
          Expanded(
              child: ListView.separated(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return listTileWidget(context);
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
    );
  }

  Widget listTileWidget(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          margin: const EdgeInsets.symmetric(horizontal: 14),
          width: width,
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
                          'https://static.toiimg.com/thumb/msid-107830245,imgsize-242397,width-400,resizemode-4/107830245.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                Text(' 8535453210',
                                    style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
