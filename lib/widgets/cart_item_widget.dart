import 'package:amazonclone/resources/firestore_methods.dart';
import 'package:amazonclone/screens/product_screen.dart';
import 'package:flutter/material.dart';

import 'package:amazonclone/model/product_model.dart';
import 'package:amazonclone/utils/colors.dart';
import 'package:amazonclone/utils/utils.dart';
import 'package:amazonclone/widgets/custom_simple_rounded_button.dart';
import 'package:amazonclone/widgets/custom_square_button.dart';
import 'package:amazonclone/widgets/product_info.dart';

class CartItemWidget extends StatelessWidget {
  final ProductModel productModel;
  CartItemWidget({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Container(
      padding: EdgeInsets.all(25),
      height: screenSize.height / 2,
      width: screenSize.width,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          ProductScreen(productModel: productModel)),
                );
              },
              child: Row(
                children: [
                  SizedBox(
                    width: screenSize.width / 3,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Center(
                        child: Image.network(
                          productModel.url,
                        ),
                      ),
                    ),
                  ),
                  ProductInfo(
                      productName: productModel.productName,
                      cost: productModel.cost,
                      sellerName: productModel.sellerName),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                CustomSquareButton(
                  child: Icon(Icons.remove),
                  onPressed: () {},
                  color: backgroundColor,
                  dimension: 40,
                ),
                CustomSquareButton(
                  child: Text(
                    "0",
                    style: TextStyle(color: activeCyanColor),
                  ),
                  onPressed: () {},
                  color: Colors.white,
                  dimension: 40,
                ),
                CustomSquareButton(
                  child: Icon(Icons.add),
                  onPressed: () async {
                    await FirestoreMethods().addProductToCard(
                        productModel: ProductModel(
                      url: productModel.url,
                      productName: productModel.productName,
                      cost: productModel.cost,
                      discount: productModel.discount,
                      uid: Utils().getUid(),
                      sellerName: productModel.sellerName,
                      sellerUid: productModel.sellerUid,
                      rating: productModel.rating,
                      noOfRating: productModel.noOfRating,
                    ));
                  },
                  color: backgroundColor,
                  dimension: 40,
                ),
              ],
            ),
            flex: 1,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Column(
                children: [
                  Row(
                    children: [
                      CustomSimpleRoundedButton(
                        onPressed: () async {
                          FirestoreMethods()
                              .deleteProductFromCart(uid: productModel.uid);
                        },
                        text: "Delete",
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      CustomSimpleRoundedButton(
                        onPressed: () {},
                        text: "Save for later",
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "See More",
                        style: TextStyle(
                          color: activeCyanColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}
