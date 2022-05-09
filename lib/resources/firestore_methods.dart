import 'dart:typed_data';

import 'package:amazonclone/model/order_model.dart';
import 'package:amazonclone/model/product_model.dart';
import 'package:amazonclone/model/review_model.dart';
import 'package:amazonclone/model/user_details.dart';
import 'package:amazonclone/utils/utils.dart';
import 'package:amazonclone/widgets/simple_product_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirestoreMethods {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future uploadNameAndAddress({required UserDetailsModel users}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .set(users.getJson());
  }

  Future getNameAndAddress() async {
    DocumentSnapshot snap = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get();
    UserDetailsModel userDetailsModel =
        UserDetailsModel.getModelFromJson((snap.data()) as dynamic);
    return userDetailsModel;
  }

  Future<String> uploadProductToDatabase({
    required Uint8List? image,
    required String productName,
    required String cost,
    required int discont,
    required String sellerName,
    required String sellerUid,
  }) async {
    productName.trim();
    cost.trim();
    String output = "Something went wrong";
    if (image != null && productName != "" && cost != "") {
      try {
        String uid = Utils().getUid();
        String url = await uploadImageToDatabase(image: image, uid: uid);
        double rawCost = double.parse(cost);
        rawCost = rawCost - (rawCost * (discont / 100));
        ProductModel product = ProductModel(
          url: url,
          productName: productName,
          cost: double.parse(cost),
          discount: discont,
          uid: uid,
          sellerName: sellerName,
          sellerUid: sellerUid,
          rating: 5,
          noOfRating: 0,
        );
        await firebaseFirestore
            .collection("products")
            .doc(uid)
            .set(product.getJson());
        output = "success";
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = "Please make sure all the fields";
    }

    return output;
  }

  Future<String> uploadImageToDatabase(
      {required Uint8List image, required String uid}) async {
    Reference storageRef =
        FirebaseStorage.instance.ref().child("products").child(uid);
    UploadTask uploadImg = storageRef.putData(image);
    TaskSnapshot task = await uploadImg;
    return task.ref.getDownloadURL();
  }

  Future<List<Widget>> getProductsFromDiscount(int discount) async {
    List<Widget> children = [];
    QuerySnapshot<Map<String, dynamic>> snap = await firebaseFirestore
        .collection("products")
        .where("discount", isEqualTo: discount)
        .get();
    for (int i = 0; i < snap.docs.length; i++) {
      DocumentSnapshot docSnap = snap.docs[i];
      ProductModel model =
          ProductModel.getModelFromJson(json: (docSnap.data()) as dynamic);
      children.add(
        SimpleProductWidget(productModel: model),
      );
    }
    return children;
  }

  Future uploadReviewToDatabase({
    required ReviewModel model,
    required String productUid,
  }) async {
    firebaseFirestore
        .collection("products")
        .doc(productUid)
        .collection("reviews")
        .add(model.getJson());
  }

  Future addProductToCard({required ProductModel productModel}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .doc(productModel.uid)
        .set(productModel.getJson());
  }

  Future deleteProductFromCart({required String uid}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .doc(uid)
        .delete();
  }

  Future buyAllItemsInCart({required UserDetailsModel userDetailsModel}) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .get();

    for (int i = 0; i < snapshot.docs.length; i++) {
      ProductModel productModel = ProductModel.getModelFromJson(
        json: snapshot.docs[i].data(),
      );
      addProductToOrders(productModel: productModel,userDetailsModel: userDetailsModel);
      await deleteProductFromCart(uid: productModel.uid);
    }
  }

  Future addProductToOrders(
      {required ProductModel productModel,
      required UserDetailsModel userDetailsModel}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("orders")
        .add(
          productModel.getJson(),
        );
    await sendOrderRequest(
        productModel: productModel, userDetailsModel: userDetailsModel);
  }

  Future sendOrderRequest(
      {required ProductModel productModel,
      required UserDetailsModel userDetailsModel}) async {
    OrderRequestModel orderRequestModel = OrderRequestModel(
        orderName: productModel.productName,
        buyersAddress: userDetailsModel.address);
    await firebaseFirestore
        .collection("users")
        .doc(productModel.sellerUid)
        .collection("orderRequests")
        .add(orderRequestModel.getJson());
  }
}
