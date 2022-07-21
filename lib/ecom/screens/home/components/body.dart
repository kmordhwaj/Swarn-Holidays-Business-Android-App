/*
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:swarn_holidays_business_main/abc/Product.dart';
import 'package:swarn_holidays_business_main/ecom/screens/cart/cart_screen.dart';
import 'package:swarn_holidays_business_main/ecom/screens/category_products/category_products_screen.dart';
import 'package:swarn_holidays_business_main/ecom/screens/home/components/home_header_down2.dart';
import 'package:swarn_holidays_business_main/ecom/screens/home/components/home_header_up.dart';
import 'package:swarn_holidays_business_main/ecom/screens/product_details/product_details_screen.dart';
import 'package:swarn_holidays_business_main/ecom/screens/search_result2/search_result_screen2.dart';
import 'package:swarn_holidays_business_main/ecom/services/authentification/authentification_service.dart';
import 'package:swarn_holidays_business_main/ecom/services/data_streams/all_products_stream.dart';
import 'package:swarn_holidays_business_main/ecom/services/data_streams/favourite_products_stream.dart';
import 'package:swarn_holidays_business_main/abc/product_database_helper.dart';
import 'package:swarn_holidays_business_main/size_config.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:logger/logger.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../utils.dart';
import 'product_type_box.dart';
import 'products_section.dart';

const String ICON_KEY = "icon";
const String TITLE_KEY = "title";
const String PRODUCT_TYPE_KEY = "product_type";

class Body extends StatefulWidget {
  final String? currentUserId;
  const Body({
    Key? key,
    this.currentUserId,
  }) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int activeIndex = 0;

  final productCategories = <Map>[
    <String, dynamic>{
      ICON_KEY: "assets/icons/Electronics.svg",
      TITLE_KEY: "Electronics",
      PRODUCT_TYPE_KEY: ProductType.Electronics,
    },
    <String, dynamic>{
      ICON_KEY: "assets/icons/Books.svg",
      TITLE_KEY: "Books",
      PRODUCT_TYPE_KEY: ProductType.Books,
    },
    <String, dynamic>{
      ICON_KEY: "assets/icons/Fashion.svg",
      TITLE_KEY: "Fashion",
      PRODUCT_TYPE_KEY: ProductType.Fashion,
    },
    <String, dynamic>{
      ICON_KEY: "assets/icons/Groceries.svg",
      TITLE_KEY: "Groceries",
      PRODUCT_TYPE_KEY: ProductType.Groceries,
    },
    <String, dynamic>{
      ICON_KEY: "assets/icons/Art.svg",
      TITLE_KEY: "Art",
      PRODUCT_TYPE_KEY: ProductType.Art,
    },
    <String, dynamic>{
      ICON_KEY: "assets/icons/Others.svg",
      TITLE_KEY: "Others",
      PRODUCT_TYPE_KEY: ProductType.Others,
    },
  ];

  final FavouriteProductsStream favouriteProductsStream =
      FavouriteProductsStream();
  final AllProductsStream allProductsStream = AllProductsStream();

  final urlImages = [
    'https://firebasestorage.googleapis.com/v0/b/swarn_holidays_business_main-32fe3.appspot.com/o/Banner%2F1.jpg?alt=media&token=ca6f064f-e0de-42bc-ae90-3c0c84acc03d',
    'https://firebasestorage.googleapis.com/v0/b/swarn_holidays_business_main-32fe3.appspot.com/o/Banner%2F2.jpg?alt=media&token=9f3b246c-5912-4b3b-8021-68be3cd9a7c0',
    'https://firebasestorage.googleapis.com/v0/b/swarn_holidays_business_main-32fe3.appspot.com/o/Banner%2F3.jpg?alt=media&token=9c97aae6-d4bd-4133-a494-08b68298c57a',
    'https://firebasestorage.googleapis.com/v0/b/swarn_holidays_business_main-32fe3.appspot.com/o/Banner%2F4.jpg?alt=media&token=960c5e49-b223-497b-a6a2-b927f6655a75',
    'https://firebasestorage.googleapis.com/v0/b/swarn_holidays_business_main-32fe3.appspot.com/o/Banner%2F5.jpg?alt=media&token=ad8f2eb1-4313-4efc-80d5-56225593422a',
    'https://firebasestorage.googleapis.com/v0/b/swarn_holidays_business_main-32fe3.appspot.com/o/Banner%2F6.jpg?alt=media&token=7b40b94c-7180-4d76-87a6-9a0cb8884c5a',
    'https://firebasestorage.googleapis.com/v0/b/swarn_holidays_business_main-32fe3.appspot.com/o/Banner%2F7.jpg?alt=media&token=ad192946-b666-4315-869a-135f979f30fa',
    'https://firebasestorage.googleapis.com/v0/b/swarn_holidays_business_main-32fe3.appspot.com/o/Banner%2F8.jpg?alt=media&token=f926ec09-aa74-4e49-b6bb-d03b3adc18e1'
  ];

  @override
  void initState() {
    super.initState();
    favouriteProductsStream.init();
    allProductsStream.init();
  }

  @override
  void dispose() {
    favouriteProductsStream.dispose();
    allProductsStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: refreshPage,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: getProportionateScreenHeight(15)),
              HomeHeaderUp(),
              SizedBox(height: 5),
              HomeHeaderDown2(
                onSearchSubmitted: (value) async {
                  final String? query = value.toString();
                  if (query!.length <= 0) return;
                  List<String?>? searchedProductsId;
                  try {
                    searchedProductsId = await ProductDatabaseHelper()
                        .searchInProducts(query.toLowerCase());

                    if (searchedProductsId != null) {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchResultScreen2(
                            searchQuery: query,
                            searchResultProductsId: searchedProductsId,
                            searchIn: "All Products",
                          ),
                        ),
                      );
                      await refreshPage();
                    } else {
                      throw "Couldn't perform search due to some unknown reason";
                    }
                  } catch (e) {
                    final String? error = e.toString();
                    Logger().e(error);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("$error"),
                      ),
                    );
                  }
                },
                onCartButtonPressed: () async {
                  bool allowed = AuthentificationService().currentUserVerified;
                  if (!allowed) {
                    final reverify = await showConfirmationDialog(context,
                        "You haven't verified your email address. This action is only allowed for verified users.",
                        positiveResponse: "Resend verification email",
                        negativeResponse: "Go back");
                    if (reverify) {
                      final future = AuthentificationService()
                          .sendVerificationEmailToCurrentUser();
                      await showDialog(
                        context: context,
                        builder: (context) {
                          return FutureProgressDialog(
                            future,
                            message: Text("Resending verification email"),
                          );
                        },
                      );
                    }
                    return;
                  }
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ),
                  );
                  await refreshPage();
                },
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              SizedBox(
                height: SizeConfig.screenHeight * 0.1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    children: [
                      ...List.generate(
                        productCategories.length,
                        (index) {
                          return ProductTypeBox(
                            icon: productCategories[index][ICON_KEY],
                            title: productCategories[index][TITLE_KEY],
                            onPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryProductsScreen(
                                    productType: productCategories[index]
                                        [PRODUCT_TYPE_KEY],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              _autoSlider(),
              SizedBox(
                height: SizeConfig.screenHeight * 0.5,
                child: ProductsSection(
                  sectionTitle: "Products You Like",
                  productsStreamController: favouriteProductsStream,
                  emptyListMessage: "Add Product to Favourites",
                  onProductCardTapped: onProductCardTapped,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              SizedBox(
                height: SizeConfig.screenHeight * 0.8,
                child: ProductsSection(
                  sectionTitle: "Explore All Products",
                  productsStreamController: allProductsStream,
                  emptyListMessage: "Looks like all Stores are closed",
                  onProductCardTapped: onProductCardTapped,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(80)),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> refreshPage() {
    favouriteProductsStream.reload();
    allProductsStream.reload();
    return Future<void>.value();
  }

  void onProductCardTapped(String? productId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(
            productId: productId, currentUserId: widget.currentUserId),
      ),
    ).then((_) async {
      await refreshPage();
    });
  }

  _autoSlider() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider.builder(
            options: CarouselOptions(
                autoPlay: true,
                height: 280,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 1500),
                viewportFraction: 0.8,
                autoPlayInterval: const Duration(seconds: 3),
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                onPageChanged: (index, reason) => setState(() {
                      activeIndex = index;
                    })),
            itemCount: urlImages.length,
            itemBuilder: (context, index, realIndex) {
              final urlImage = urlImages[index];
              return buildImage(urlImage, index);
            },
          ),
          SizedBox(height: 10),
          buildIndicator()
        ],
      ),
    );
  }

  Widget buildImage(String urlImage, int index) => Container(
      margin: EdgeInsets.symmetric(horizontal: 6),
      color: Colors.grey,
      width: double.infinity,
      child: CachedNetworkImage(
        imageUrl: urlImage,
        fit: BoxFit.cover,
      ));

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: urlImages.length,
      effect: WormEffect(
          dotColor: Colors.blue.shade100,
          dotHeight: 12,
          dotWidth: 16,
          activeDotColor: Colors.pink.shade400),
    );
  }
}
*/