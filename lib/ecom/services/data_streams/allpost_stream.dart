/*import 'package:swarn_holidays_business_main/ecom/services/data_streams/data_stream.dart';
import 'package:swarn_holidays_business_main/ecom/services/database/user_database_helper.dart';

class AllPostStream extends DataStream<List<String>> {
  @override
  void reload() {
    final allpostList = UserDatabaseHelper().trendingPost1;
    allpostList.then((list) {
      addData(list);
    }).catchError((e) {
      addError(e);
    });
  }
}
*/