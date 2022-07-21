import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swarn_holidays_business_main/abc/allpage.dart';
import 'package:swarn_holidays_business_main/abc/favouritepage.dart';
import 'package:swarn_holidays_business_main/abc/searchscreen.dart';
import 'package:swarn_holidays_business_main/abc/settings.dart';
import 'package:swarn_holidays_business_main/user_data.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  int index = 0;
  final selectedColor = Colors.blue;
  final unSelectedColor = Colors.grey;
  final labelstyle = const TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
  bool isExtended = false;
  String pageOrientation = "a";
  String? currentUserId;

  @override
  void initState() {
    super.initState();
    currentUserId = Provider.of<UserData>(context, listen: false).currentUserId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          title: SizedBox(
              width: 110,
              height: 55,
              child: Image.asset(
                'assets/images/logob.png',
                fit: BoxFit.fill,
              )),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SearchScreenS()));
                },
                icon: const Icon(Icons.search))
          ],
        ),
        body: screen());
  }

  Widget screen() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 7),
          toggleButton(),
          const SizedBox(height: 10),
          mainBody(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  setPageOrientation(String pageOrientation) {
    setState(() {
      this.pageOrientation = pageOrientation;
    });
  }

  Container toggleButton() {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width * 0.99,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.transparent),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              setPageOrientation("a");
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.33,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: pageOrientation == 'a'
                      ? Colors.pink
                      : Colors.transparent),
              child: Center(
                  child: Icon(
                Icons.home,
                color: Colors.white,
                size: pageOrientation == 'a' ? 30 : 25,
              )),
            ),
          ),
          InkWell(
            onTap: () {
              setPageOrientation("b");
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.33,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: pageOrientation == 'b'
                      ? Colors.pink
                      : Colors.transparent),
              child: Center(
                  child: Icon(
                pageOrientation == 'b'
                    ? Icons.favorite_outline_rounded
                    : Icons.favorite_border_rounded,
                color: Colors.white,
                size: pageOrientation == 'b' ? 30 : 25,
              )),
            ),
          ),
          InkWell(
            onTap: () {
              setPageOrientation("c");
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.33,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: pageOrientation == 'c'
                      ? Colors.pink
                      : Colors.transparent),
              child: Center(
                  child: Icon(
                Icons.settings,
                color: Colors.white,
                size: pageOrientation == 'c' ? 30 : 25,
              )),
            ),
          ),
        ],
      ),
    );
  }

  mainBody() {
    if (pageOrientation == 'a') {
      return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ChatListContainer(
          currentUserId: currentUserId,
        ),
      );
    } else if (pageOrientation == 'b') {
      return const FavouritePage();
    } else if (pageOrientation == 'c') {
      return const SettingsPage();
    }
  }
}
