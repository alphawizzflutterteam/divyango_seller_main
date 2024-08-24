import 'package:divyango_user/screens/homepage/leads.dart';
import 'package:divyango_user/screens/homepage/profile.dart';
import 'package:divyango_user/screens/notification.dart';
import 'package:divyango_user/services/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;

  List<Widget> _buildScreens() {
    return [const LeadsWidget(), const ProfileWidget()];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _appBar(),

      body: _buildScreens()[_selectedIndex],

      // floatingActionButton:  CustomBottomNavBar(
      //     selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),

      floatingActionButton: MediaQuery.of(context).viewInsets.bottom != 0.0 ? null : CustomBottomNavBar(
          selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // _appBar() {
  //   return AppBar(
  //     leading: SizedBox(),
  //     leadingWidth: 0,
  //     elevation: 0,
  //     backgroundColor: colors.secondary,
  //     title: Row(
  //       children: [
  //         SvgPicture.asset('assets/images/mingcute_location-fill.svg'),
  //         const SizedBox(width: 4),
  //         const Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               "Ward 35...",
  //               style: TextStyle(color: Colors.white, fontSize: 16),
  //             ),
  //             Text(
  //               "Ratna Lok Colony, Indore",
  //               style: TextStyle(color: Colors.white, fontSize: 12),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //     actions: [
  //       InkWell(
  //           onTap: () {
  //             Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                     builder: (context) => const NotificationScreen()));
  //           },
  //           child: SvgPicture.asset('assets/images/Notification.svg')),
  //       const SizedBox(
  //         width: 16,
  //       )
  //     ],
  //   );
  // }
}

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 250,
      width: MediaQuery.of(context).size.width / 2 + 80,
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(36),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 0, // Spread radius
            blurRadius: 20, // Blur radius
            offset: Offset(0, 4), // Offset in x and y directions
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () => onItemTapped(0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color:
                  selectedIndex == 0 ? colors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/images/Home.svg',
                      color: selectedIndex == 0 ? Colors.white : Colors.black,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Home',
                      style: TextStyle(
                        color: selectedIndex == 0 ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => onItemTapped(1),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color:
                  selectedIndex == 1 ? colors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/images/profile.svg',
                      color: selectedIndex == 1 ? Colors.white : Colors.black,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Profile',
                      style: TextStyle(
                        color: selectedIndex == 1 ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
