import 'dart:typed_data';

import 'package:amazonclone/model/product_model.dart';
import 'package:amazonclone/model/user_details.dart';
import 'package:amazonclone/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
    required Uint8List image,
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
      String uid = Utils().getUid();
      String url =
          await uploadImageToDatabase(image: image, uid: Utils().getUid());
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
      ProductModel(
        url: url,
        productName: productName,
        cost: rawCost,
        discount: discont,
        uid: uid,
        sellerName: sellerName,
        sellerUid: sellerUid,
        rating: 5,
        noOfRating: 0,
      );
      firebaseFirestore.collection("products").doc(uid).set(product.getJson());
      output = "success";
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
}
