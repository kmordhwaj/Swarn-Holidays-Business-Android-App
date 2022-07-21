import 'package:swarn_holidays_business_main/ecom/services/data_streams/data_stream.dart';
import 'package:swarn_holidays_business_main/ecom/services/database/user_database_helper.dart';

class OrderedProductsStream extends DataStream<List<String>> {
  @override
  void reload() {
    final orderedProductsFuture = UserDatabaseHelper().orderedProductsList;
    orderedProductsFuture.then((data) {
      addData(data);
    }).catchError((e) {
      addError(e);
    });
  }
}
