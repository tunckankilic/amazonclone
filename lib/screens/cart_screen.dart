import 'package:amazonclone/model/product_model.dart';
import 'package:amazonclone/model/user_details.dart';
import 'package:amazonclone/utils/colors.dart';
import 'package:amazonclone/utils/constants.dart';
import 'package:amazonclone/widgets/cart_item_widget.dart';
import 'package:amazonclone/widgets/custom_main_button.dart';
import 'package:amazonclone/widgets/search_bar_widget.dart';
import 'package:amazonclone/widgets/user_details.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(
        hasBackButton: false,
        isReadOnly: true,
      ),
      body: Center(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: kAppBarHeight / 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomMainButton(
                    child: Text(
                      "Proceed to buy (n) items",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    color: yellowColor,
                    isLoading: false,
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return CartItemWidget(
                        productModel: ProductModel(
                          url: categoryLogos[0],
                          sellerName: "Ayşe",
                          sellerUid: "asşdkjasşdkşals",
                          cost: 9999,
                          discount: 0,
                          noOfRating: 1,
                          rating: 8,
                          uid: "asdasdasdasda",
                          productName: "Item",
                        ),
                      );
                    },
                    itemCount: 5,
                  ),
                )
              ],
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
