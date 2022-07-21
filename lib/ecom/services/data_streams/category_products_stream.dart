import 'package:swarn_holidays_business_main/abc/Product.dart';
import 'package:swarn_holidays_business_main/ecom/services/data_streams/data_stream.dart';
import 'package:swarn_holidays_business_main/abc/product_database_helper.dart';

class CategoryProductsStream extends DataStream<List<String>> {
  final ProductType? category;

  CategoryProductsStream(this.category);
  @override
  void reload() {
    final allProductsFuture =
        ProductDatabaseHelper().getCategoryProductsList(category);
    allProductsFuture.then((favProducts) {
      addData(favProducts);
    }).catchError((e) {
      addError(e);
    });
  }
}
