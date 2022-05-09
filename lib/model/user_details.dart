import 'package:amazonclone/resources/firestore_methods.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserDetailsModel {
  final String name;
  final String address;
  UserDetailsModel({required this.address, required this.name});
  Map<String, dynamic> getJson() => {
        "name": name,
        "address": address,
      };

  factory UserDetailsModel.getModelFromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
      address: json["address"],
      name: json["name"],
    );
  }
}

class UserDetailsProvider with ChangeNotifier {
  UserDetailsModel userDetailsModel;
  UserDetailsProvider()
      : userDetailsModel =
            UserDetailsModel(address: "loading", name: "loading");
  Future getDate() async {
    userDetailsModel = await FirestoreMethods().getNameAndAddress();
    notifyListeners();
  }
}
