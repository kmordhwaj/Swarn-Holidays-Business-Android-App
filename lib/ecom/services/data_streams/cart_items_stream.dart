import 'package:swarn_holidays_business_main/ecom/services/data_streams/data_stream.dart';
import 'package:swarn_holidays_business_main/ecom/services/database/user_database_helper.dart';

class CartItemsStream extends DataStream<List<String>> {
  @override
  void reload() {
    final allProductsFuture = UserDatabaseHelper().allCartItemsList;
    allProductsFuture.then((favProducts) {
      addData(favProducts);
    }).catchError((e) {
      addError(e);
    });
  }
}
