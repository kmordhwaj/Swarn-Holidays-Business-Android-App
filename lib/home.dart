// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swarn_holidays_business_main/dealnotification.dart';
import 'package:swarn_holidays_business_main/user_data.dart';
import 'package:swarn_holidays_business_main/BottomNavigationScreen.dart';
import 'abc/addpage.dart';
import 'message.dart';

class Home extends StatefulWidget {
  static const String id = 'home';

  const Home({
    Key? key,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  final PageController homePageController = PageController();
  String? currentUserId;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    currentUserId = Provider.of<UserData>(context, listen: false).currentUserId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: homePageController,
            children: const [AddPage(), MessageScreen(), DealNotification()],
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (page) {
              setState(() {
                pageIndex = page;
              });
            },
          ),
          BottomNavigationScreen(currentUserId: currentUserId)
        ],
      ),
    );
  }
}
