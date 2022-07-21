import 'package:cached_network_image/cached_network_image.dart';
import 'package:swarn_holidays_business_main/ecom/components/top_rounded_container.dart';
import 'package:swarn_holidays_business_main/abc/Product.dart';
import 'package:swarn_holidays_business_main/ecom/screens/product_details/components/product_description.dart';
import 'package:swarn_holidays_business_main/ecom/screens/product_details/provider_models/ProductActions.dart';
import 'package:swarn_holidays_business_main/ecom/services/authentification/authentification_service.dart';
import 'package:swarn_holidays_business_main/ecom/services/database/user_database_helper.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:swarn_holidays_business_main/user_data.dart';
//import 'package:swarn_holidays_business_main/screens/general/ProfileScreen.dart';

import '../../../../size_config.dart';
import '../../../utils.dart';

class ProductActionsSection extends StatefulWidget {
  final Product? product;
  final String? currentUserId;

  const ProductActionsSection(
      {Key? key, required this.product, required this.currentUserId})
      : super(key: key);

  @override
  _ProductActionsSectionState createState() => _ProductActionsSectionState();
}

class _ProductActionsSectionState extends State<ProductActionsSection> {
  String? currentUserId;
  String? rentOwnerId;
  String? rentOwnerDp;

  @override
  void initState() {
    super.initState();
    currentUserId = Provider.of<UserData>(context, listen: false).currentUserId;
  }

  @override
  Widget build(BuildContext context) {
    final column = Column(
      children: [
        Stack(
          children: [
            TopRoundedContainer(
              child: ProductDescription(product: widget.product),
            ),
            /*  Row(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: buildFavouriteButton(),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: buildProfileButton(),
                ),
              ],
            ), */
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 120.0),
                child: Row(
                  children: [buildFavouriteButton(), buildProfileButton()],
                ),
              ),
            ),
          ],
        ),
      ],
    );
    UserDatabaseHelper()
        .isProductFavourite(uid: currentUserId, productId: widget.product!.id)
        .then(
      (value) {
        final productActions =
            Provider.of<ProductActions>(context, listen: false);
        productActions.productFavStatus = value;
      },
    ).catchError(
      (e) {
        Logger().w("$e");
      },
    );
    return column;
  }

  Widget buildProfileButton() {
    return Consumer<ProductActions>(builder: (context, productDetails, child) {
      return Container(
        padding: EdgeInsets.all(getProportionateScreenWidth(8)),
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 4),
        ),
        child: FutureBuilder(
            future: UserDatabaseHelper().idForRentOwner(widget.product!.id),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                final rentOwner = snapshot.data;
                bool isOwner = currentUserId == rentOwner;
                return isOwner ? iAmRentOwner() : someOneIsRentOwner(rentOwner);
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                final error = snapshot.error;
                Logger().w(error.toString());
              }
              return noOneIsRentOwner();
            }),
      );
    });
  }

  Widget iAmRentOwner() {
    return GestureDetector(
        onTap: () async {
          final verify = await showConfirmationDialog(context,
              "Are you sure that you dont wanna continue as RENT OWNER of this product?",
              positiveResponse: "Yes, I don't want to be owner",
              negativeResponse: "No");
          if (verify) {
            bool success = false;
            final future = UserDatabaseHelper()
                .removeRentOwner(
              uid: currentUserId,
              productId: widget.product!.id,
            )
                .then((status) {
              success = status;
            }).catchError((e) {
              Logger().e(e.toString());
              success = false;
            });
            await showDialog(
              context: context,
              builder: (context) {
                return FutureProgressDialog(
                  future,
                  message: const Text("Removing from Owned Product"),
                );
              },
            );
            if (success) {
              //    productDetails.switchProductOwnedStatus();
            }
          }
          return;
        },
        child: FutureBuilder(
            future: UserDatabaseHelper().displayPictureForCurrentUser,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                final profImageUrl = snapshot.data;
                return CircleAvatar(
                  radius: 20,
                  backgroundImage: CachedNetworkImageProvider(profImageUrl),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                final error = snapshot.error;
                Logger().w(error.toString());
              }
              return CircleAvatar(
                backgroundColor: Colors.blueGrey,
                radius: 20,
                child: Center(
                    child: Icon(
                  Icons.person,
                  color: Colors.green.shade300,
                )),
              );
            }));
  }

  Widget someOneIsRentOwner(rentOwner) {
    return GestureDetector(
        onTap: () async {
          /*     Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProfileScreen1(
                    profileId: rentOwner,
                    //   currentUserId: currentUserId,
                  ))); */
        },
        child: FutureBuilder(
            future: UserDatabaseHelper().displayPictureForUser(rentOwner),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                final profImageUrl = snapshot.data;
                return CircleAvatar(
                    radius: 20,
                    backgroundImage: CachedNetworkImageProvider(profImageUrl));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                final error = snapshot.error;
                Logger().w(error.toString());
              }
              return CircleAvatar(
                backgroundColor: Colors.blueGrey,
                radius: 20,
                child: Center(
                    child: Icon(
                  Icons.person,
                  color: Colors.green.shade300,
                )),
              );
            }));
  }

  Widget noOneIsRentOwner() {
    return GestureDetector(
        onTap: () async {
          final verify = await showConfirmationDialog(
              context, "Do you want to be a RENT OWNER of this product?",
              positiveResponse: "Yes, I want to be owner",
              negativeResponse: "No");
          if (verify) {
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
                      message: const Text("Resending verification email"),
                    );
                  },
                );
              }
              return;
            }
            bool success = false;
            final future = UserDatabaseHelper()
                .addRentOwner(
              uid: currentUserId,
              productId: widget.product!.id,
            )
                .then((status) {
              success = status;
            }).catchError((e) {
              Logger().e(e.toString());
              success = false;
            });
            await showDialog(
              context: context,
              builder: (context) {
                return FutureProgressDialog(
                  future,
                  message: const Text("Adding to Owned Product List"),
                );
              },
            );
            if (success) {
              //    productDetails.switchProductOwnedStatus();
            }
          }
          return;
        },
        child: CircleAvatar(
          backgroundColor: Colors.blueGrey,
          radius: 20,
          child: Center(
              child: Icon(
            Icons.person_add_alt_1_rounded,
            color: Colors.pink.shade300,
          )),
        ));
  }

  Widget buildFavouriteButton() {
    return Consumer<ProductActions>(
      builder: (context, productDetails, child) {
        return InkWell(
          onTap: () async {
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
                      message: const Text("Resending verification email"),
                    );
                  },
                );
              }
              return;
            }
            bool success = false;
            final future = UserDatabaseHelper()
                .switchProductFavouriteStatus(
                    productId: widget.product!.id,
                    uid: currentUserId,
                    newState: !productDetails.productFavStatus)
                .then((status) {
              success = status;
            }).catchError((e) {
              Logger().e(e.toString());
              success = false;
            });
            await showDialog(
              context: context,
              builder: (context) {
                return FutureProgressDialog(
                  future,
                  message: Text(
                    productDetails.productFavStatus
                        ? "Removing from Favourites"
                        : "Adding to Favourites",
                  ),
                );
              },
            );
            if (success) {
              productDetails.switchProductFavStatus();
            }
          },
          child: Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(8)),
            decoration: BoxDecoration(
              color: productDetails.productFavStatus
                  ? const Color(0xFFFFE6E6)
                  : const Color(0xFFF5F6F9),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
            ),
            child: Padding(
              padding: EdgeInsets.all(getProportionateScreenWidth(8)),
              child: Icon(
                Icons.favorite,
                color: productDetails.productFavStatus
                    ? const Color(0xFFFF4848)
                    : const Color(0xFFD8DEE4),
              ),
            ),
          ),
        );
      },
    );
  }
}
