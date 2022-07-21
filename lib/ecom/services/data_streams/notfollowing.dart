import 'package:swarn_holidays_business_main/ecom/services/data_streams/data_stream.dart';
import 'package:swarn_holidays_business_main/ecom/services/database/user_database_helper.dart';

class NotFollowingStream extends DataStream<List<String>?> {
  @override
  void reload() {
    final addressesList = UserDatabaseHelper().usersNotFollowing;
    addressesList.then((list) {
      addData(list);
    }).catchError((e) {
      addError(e);
    });
  }
}
