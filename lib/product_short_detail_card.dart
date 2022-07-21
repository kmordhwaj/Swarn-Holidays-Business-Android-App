// ignore_for_file: unnecessary_string_escapes

import 'package:swarn_holidays_business_main/abc/Product.dart';
import 'package:swarn_holidays_business_main/abc/product_database_helper.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'constants.dart';
import 'size_config.dart';

class ProductShortDetailCard extends StatelessWidget {
  final String? productId;
  final VoidCallback onPressed;
  const ProductShortDetailCard({
    Key? key,
    required this.productId,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: FutureBuilder<Product?>(
        future: ProductDatabaseHelper().getProductWithID(productId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final product = snapshot.data!;
            return Row(
              children: [
                SizedBox(
                  width: getProportionateScreenWidth(88),
                  child: AspectRatio(
                    aspectRatio: 0.88,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: product.images!.isNotEmpty
                          ? Image.network(
                              product.images![0]!,
                              fit: BoxFit.contain,
                            )
                          : const Text("No Image"),
                    ),
                  ),
                ),
                SizedBox(width: getProportionateScreenWidth(20)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title!,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: kTextColor,
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(height: 10),
                      Text.rich(
                        TextSpan(
                            text: "\₹${product.discountPrice}    ",
                            style: const TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                            children: [
                              TextSpan(
                                text: "\₹${product.originalPrice}",
                                style: const TextStyle(
                                  color: kTextColor,
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 11,
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            final errorMessage = snapshot.error.toString();
            Logger().e(errorMessage);
          }
          return const Center(
            child: Icon(
              Icons.error,
              color: kTextColor,
              size: 60,
            ),
          );
        },
      ),
    );
  }
}
