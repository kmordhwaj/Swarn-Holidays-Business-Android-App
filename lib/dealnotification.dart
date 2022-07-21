import 'package:flutter/material.dart';
import 'package:swarn_holidays_business_main/ecom/services/authentification/authentification_service.dart';
import 'package:swarn_holidays_business_main/ecom/utils.dart';

class DealNotification extends StatefulWidget {
  const DealNotification({Key? key}) : super(key: key);

  @override
  State<DealNotification> createState() => _DealNotificationState();
}

class _DealNotificationState extends State<DealNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Deals Notification'),
        actions: [
          IconButton(
              onPressed: () async {
                final confirmation =
                    await showConfirmationDialog(context, "Confirm Sign out ?");
                if (confirmation) AuthentificationService().signOut();
              },
              icon: const Icon(Icons.logout_rounded))
        ],
      ),
      body: const Center(
        child: Text('deals notification'),
      ),
    );
  }
}
