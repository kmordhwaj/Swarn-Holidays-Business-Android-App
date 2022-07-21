import 'package:flutter/material.dart';

class HomeHeaderUp extends StatefulWidget {
  const HomeHeaderUp({
    Key? key,
  }) : super(key: key);

  @override
  _HomeHeaderUpState createState() => _HomeHeaderUpState();
}

class _HomeHeaderUpState extends State<HomeHeaderUp> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /*    GestureDetector(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: CircleAvatar(
            radius: 14,
          ),
        ),
        
        */
        /*   IconButton(
          icon: const Icon(Icons.person_add_alt_1_rounded),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => FriendSuggestion()));
          },
        ), */
        /*   IconButton(
            icon: Icon(Icons.favorite_border_outlined),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ActivityFeed()));
            }), */
        const Center(
          child: Text('swarn_holidays_business_main',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 22)),
        ),
        IconButton(
            icon: const Icon(Icons.offline_bolt_outlined), onPressed: () {}),
        IconButton(
            icon: const Icon(Icons.celebration_outlined), onPressed: () {}),
        IconButton(
            icon: const Icon(Icons.store),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            })
      ],
    );
  }
}
