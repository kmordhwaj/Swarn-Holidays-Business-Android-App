import 'package:swarn_holidays_business_main/ecom/services/data_streams/data_stream.dart';
import 'package:swarn_holidays_business_main/ecom/services/database/user_database_helper.dart';

class FollowingPostStream extends DataStream<List<String>?> {
  @override
  void reload() {
    final followingpostList = UserDatabaseHelper().followingsPost1;
    followingpostList.then((list) {
      addData(list);
    }).catchError((e) {
      addError(e);
    });
  }
}
