import 'package:flutter/cupertino.dart';
import 'package:swarn_holidays_business_main/models.dart';

class UserData extends ChangeNotifier {
  String? currentUserId;

  // String profileImageUrl;

  bool cameFromRegisterScreen = false;

  UserModal currentUser = UserModal();
}
