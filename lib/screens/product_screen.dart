import 'package:amazonclone/model/review_model.dart';
import 'package:amazonclone/model/user_details.dart';
import 'package:amazonclone/utils/colors.dart';
import 'package:amazonclone/utils/constants.dart';
import 'package:amazonclone/utils/utils.dart';
import 'package:amazonclone/widgets/cost_widget.dart';
import 'package:amazonclone/widgets/custom_main_button.dart';
import 'package:amazonclone/widgets/custom_simple_rounded_button.dart';
import 'package:amazonclone/widgets/rating_star_widget.dart';
import 'package:amazonclone/widgets/review_dialog.dart';
import 'package:amazonclone/widgets/review_widget.dart';
import 'package:amazonclone/widgets/search_bar_widget.dart';
import 'package:amazonclone/widgets/user_details.dart';
import 'package:flutter/material.dart';

import 'package:amazonclone/model/product_model.dart';

class ProductScreen extends StatefulWidget {
  final ProductModel productModel;
  ProductScreen({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Widget Space = SizedBox(
    height: 15,
  );
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return SafeArea(
      child: Scaffold(
        appBar: SearchBarWidget(
          hasBackButton: true,
          isReadOnly: true,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: kAppBarHeight / 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      widget.productModel.sellerName,
                                      style: TextStyle(
                                        color: activeCyanColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Text(widget.productModel.productName),
                                ],
                              ),
                              RatingStarWidget(
                                rating: widget.productModel.rating,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(15),
                          constraints:
                              BoxConstraints(maxHeight: screenSize.height / 3),
                          child: Image.network(
                            widget.productModel.url,
                          ),
                        ),
                        Space,
                        CostWidget(
                          color: Colors.black,
                          cost: widget.productModel.cost,
                        ),
                        Space,
                        CustomMainButton(
                          child: Text(
                            "Buy Now",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          color: Colors.orange[900]!,
                          isLoading: false,
                          onPressed: () {},
                        ),
                        Space,
                        CustomMainButton(
                          child: Text(
                            "Add to Cart Now",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          color: yellowColor,
                          isLoading: false,
                          onPressed: () {},
                        ),
                        Space,
                        CustomSimpleRoundedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => ReviewDialog());
                          },
                          text: "Drop a review for this product",
                        ),
                        Space,
                      ],
                    ),
                    SizedBox(
                      height: screenSize.height,
                      child: ListView.builder(itemBuilder: (context, index) {
                        return ReviewWidget(
                          reviewModel: ReviewModel(
                            senderName: "Tunç Kankılıç",
                            description: "Very good product",
                            rating: 5,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
            UserDetailsBar(
              offset: 0,
            ),
          ],
        ),
      ),
    );
  }
}
