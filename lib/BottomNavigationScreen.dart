// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:swarn_holidays_business_main/dealnotification.dart';
import 'package:swarn_holidays_business_main/message.dart';
import 'abc/addpage.dart';

class BottomNavigationScreen extends StatefulWidget {
  final String? currentUserId;
  const BottomNavigationScreen({Key? key, required this.currentUserId})
      : super(key: key);

  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);

    List<Widget> _buildScreens() {
      return const [AddPage(), MessageScreen(), DealNotification()];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
            icon: const Icon(CupertinoIcons.home),
            title: ("Home"),
            textStyle: const TextStyle(
                color: Colors.purple, fontWeight: FontWeight.bold),
            activeColorPrimary: CupertinoColors.systemRed,
            inactiveColorPrimary: Colors.purple,
            activeColorSecondary: CupertinoColors.systemBlue),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.message_rounded),
          title: ("Queries"),
          textStyle: const TextStyle(
              color: Colors.purple, fontWeight: FontWeight.bold),
          activeColorPrimary: CupertinoColors.systemRed,
          inactiveColorPrimary: Colors.purple,
          activeColorSecondary: CupertinoColors.systemBlue,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(
            Icons.notifications,
          ),
          title: ("Deals"),
          textStyle: const TextStyle(
              color: Colors.purple, fontWeight: FontWeight.bold),
          activeColorPrimary: CupertinoColors.systemRed,
          inactiveColorPrimary: Colors.purple,
          activeColorSecondary: CupertinoColors.systemBlue,
        ),
      ];
    }

    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.black,
        //  Colors.pink.shade100, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: const NavBarDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          colorBehindNavBar: Colors.transparent,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style10, // Choose the nav bar style with this property.
      ),
    );
  }
}
