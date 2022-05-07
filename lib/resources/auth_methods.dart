import 'package:amazonclone/model/user_details.dart';
import 'package:amazonclone/resources/firestore_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirestoreMethods firestoreMethods = FirestoreMethods();
  Future<String> signUpUser({
    required String name,
    required String address,
    required String email,
    required String password,
  }) async {
    name.trim();
    address.trim();
    email.trim();
    password.trim();
    String output = "Something Went Wrong";
    if (name != "" && address != "" && email != "" && password != "") {
      try {
        await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        output = "success";
        UserDetailsModel userDetailsModel =
            UserDetailsModel(address: address, name: name);
        await firestoreMethods.uploadNameAndAddress(users: userDetailsModel);
      } on FirebaseAuthException catch (e) {
        output = e.toString();
      }
    } else {
      output = "Please fill up all fields";
    }
    return output;
  }

  Future<String> SignInUser({
    required String email,
    required String password,
  }) async {
    email.trim();
    password.trim();
    String output = "Something Went Wrong";
    if (email != "" && password != "") {
      try {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.toString();
      }
    } else {
      output = "Please fill up all fields";
    }
    return output;
  }
}
