import 'package:divyango_user/screens/homepage/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../services/colors.dart';
import 'leads.dart';

class PersistanceNavBarWidget extends StatefulWidget {
  const PersistanceNavBarWidget({Key,key});

  @override
  State<PersistanceNavBarWidget> createState() =>
      _PersistanceNavBarWidgetState();
}

class _PersistanceNavBarWidgetState extends State<PersistanceNavBarWidget> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      // HomePageWidget(),
      const LeadsWidget(),
      const ProfileWidget(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "assets/images/home.png",
        ),
        title: ("Home"),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        activeColorSecondary: Colors.black,
        activeColorPrimary: colors.primary,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      // PersistentBottomNavBarItem(
      //   icon: Image.asset(
      //     "assets/images/leads.png",
      //   ),
      //   title: ("Leads"),
      //   textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      //   activeColorSecondary: Colors.black,
      //   activeColorPrimary: colors.primary,
      //   inactiveColorPrimary: CupertinoColors.systemGrey,
      // ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "assets/images/Profile.png",
        ),
        title: ("Profile"),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        activeColorSecondary: Colors.black,
        activeColorPrimary: colors.primary,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineToSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        // hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        // popAllScreensOnTapOfSelectedTab: true,
        // popActionScreens: PopActionScreensType.all,
        // itemAnimationProperties: const ItemAnimationProperties(
        //   duration: Duration(milliseconds: 200),
        //   curve: Curves.ease,
        // ),
        // screenTransitionAnimation: const ScreenTransitionAnimation(
        //   animateTabTransition: true,
        //   curve: Curves.ease,
        //   duration: Duration(milliseconds: 200),
        // ),
        navBarStyle: NavBarStyle.style1,
      ),
    );
  }
}
