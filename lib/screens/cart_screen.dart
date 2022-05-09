import 'package:amazonclone/model/product_model.dart';
import 'package:amazonclone/model/user_details.dart';
import 'package:amazonclone/resources/firestore_methods.dart';
import 'package:amazonclone/utils/colors.dart';
import 'package:amazonclone/utils/constants.dart';
import 'package:amazonclone/utils/utils.dart';
import 'package:amazonclone/widgets/cart_item_widget.dart';
import 'package:amazonclone/widgets/custom_main_button.dart';
import 'package:amazonclone/widgets/search_bar_widget.dart';
import 'package:amazonclone/widgets/user_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection("cart")
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snap) {
                        if (snap.connectionState == ConnectionState.waiting) {
                          return CustomMainButton(
                            child: Text(
                              "Loading",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            color: yellowColor,
                            isLoading: true,
                            onPressed: () {},
                          );
                        } else {
                          return CustomMainButton(
                            child: Text(
                              "Proceed to buy ${snap.data!.docs.length} items",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            color: yellowColor,
                            isLoading: false,
                            onPressed: () async {
                              await FirestoreMethods().buyAllItemsInCart(
                                  userDetailsModel:
                                      Provider.of<UserDetailsProvider>(context,
                                              listen: false)
                                          .userDetailsModel);
                              Utils().showSnackBar(
                                  context: context, content: "Done");
                            },
                          );
                        }
                      },
                    )),
                Expanded(
                  child: StreamBuilder(
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return Container();
                      } else {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            ProductModel productModel =
                                ProductModel.getModelFromJson(
                                    json: snap.data!.docs[index].data());
                            return CartItemWidget(productModel: productModel);
                          },
                          itemCount: snap.data!.docs.length,
                        );
                      }
                    },
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("cart")
                        .snapshots(),
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
