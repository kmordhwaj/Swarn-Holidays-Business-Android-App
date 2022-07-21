import 'package:swarn_holidays_business_main/ecom/services/data_streams/data_stream.dart';
import 'package:swarn_holidays_business_main/ecom/services/database/user_database_helper.dart';

class RentProductsStream extends DataStream<List<String>> {
  @override
  void reload() {
    final rentProductsFuture = UserDatabaseHelper().usersOwnedProductsList;
    rentProductsFuture.then((rentProducts) {
      addData(rentProducts!.cast<String>());
    }).catchError((e) {
      addError(e);
    });
  }
}
