import 'dart:typed_data';

import 'package:amazonclone/model/product_model.dart';
import 'package:amazonclone/model/user_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      try {
        output = "success";
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = "Please make sure all the fields";
    }

    return output;
  }
}
