import 'package:amazonclone/model/order_model.dart';
import 'package:amazonclone/model/product_model.dart';
import 'package:amazonclone/model/user_details.dart';
import 'package:amazonclone/screens/sell_screen.dart';
import 'package:amazonclone/utils/utils.dart';
import 'package:amazonclone/widgets/account_screen_app_bar.dart';
import 'package:amazonclone/widgets/custom_main_button.dart';
import 'package:amazonclone/widgets/products_showcase_list_view.dart';
import 'package:amazonclone/widgets/simple_product_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/introduction_widget.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    UserDetailsModel userDetailsModel =
        Provider.of<UserDetailsProvider>(context).userDetailsModel;
    Size screenSize = Utils().getScreenSize();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(0.56), child: AccountScreenAppBar()),
        body: SingleChildScrollView(
          child: SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: Column(
              children: [
                IntroductionWidget(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomMainButton(
                    child: Text(
                      "Sign Out",
                      style: TextStyle(color: Colors.black),
                    ),
                    color: Colors.orange,
                    isLoading: false,
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomMainButton(
                    child: Text(
                      "Sell",
                      style: TextStyle(color: Colors.black),
                    ),
                    color: Colors.yellow,
                    isLoading: false,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SellScreen()));
                    },
                  ),
                ),
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("orders")
                        .get(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return Container();
                      } else {
                        List<Widget> children = [];
                        for (int i = 0; i < snap.data!.docs.length; i++) {
                          ProductModel productModel =
                              ProductModel.getModelFromJson(
                                  json: snap.data!.docs[i].data());
                          children.add(
                              SimpleProductWidget(productModel: productModel));
                        }
                        return ProductsShowcaseListView(
                            title: "Your Orders", children: children);
                      }
                    }),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Order Requests",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      } else {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            OrderRequestModel orderRequestModel =
                                OrderRequestModel.getModelFromJson(
                                    json: snapshot.data!.docs[index].data());
                            return ListTile(
                              title: Text(
                                "Order: ${orderRequestModel.orderName}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                  "Address: ${orderRequestModel.buyersAddress}"),
                              trailing: IconButton(
                                onPressed: () async {
                                  FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .collection("orderRequests")
                                      .doc(
                                        snapshot.data!.docs[index].id,
                                      )
                                      .delete();
                                },
                                icon: Icon(Icons.check),
                              ),
                            );
                          },
                          itemCount: snapshot.data!.docs.length,
                        );
                      }
                    },
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("orderRequests")
                        .snapshots(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
