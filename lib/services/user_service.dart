import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paypie_project/models/user_model.dart';
import 'package:paypie_project/screens/sign_up_screen.dart';

class UserService with ChangeNotifier {
  /// upload user data
  void createUserProfile(
      {required XFile image,
      required String name,
      required String email,
      required String bio,
      required String gender,
      required DateTime dob}) async {
    final userUid = FirebaseAuth.instance.currentUser!.uid;

    try {
      final storageRef =
          FirebaseStorage.instance.ref().child('profile_pics/$userUid');
      await storageRef.putFile(File(image.path));
      final imageUrl = await storageRef.getDownloadURL();
      UserModel userModel;
      userModel = UserModel(
          uid: userUid,
          name: name,
          email: email,
          bio: bio,
          gender: gender,
          dob: dob,
          imageUrl: imageUrl);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userUid)
          .set(userModel.toMap());
      print("success");
    } catch (e) {
      print(e);
    }
  }

  //fetch data...
  Future<UserModel?> fetchUserProfile(String userUid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection("users")
          .doc(userUid)
          .get();

      if (userDoc.exists) {
        // If the document exists, convert the data to a UserModel object
        return UserModel.fromMap(userDoc.data()!);
      } else {
        // If the document doesn't exist
        print("User not found");
        return null;
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  //update the data
  void updateUserProfile(
      {required XFile image,
      required String name,
      required String email,
      required String bio,
      required String gender,
      required DateTime dob}) async {
    final userUid = FirebaseAuth.instance.currentUser!.uid;

    try {
      final storageRef =
          FirebaseStorage.instance.ref().child('profile_pics/$userUid');
      await storageRef.putFile(File(image.path));
      final imageUrl = await storageRef.getDownloadURL();
      UserModel userModel;
      userModel = UserModel(
          uid: userUid,
          name: name,
          email: email,
          bio: bio,
          gender: gender,
          dob: dob,
          imageUrl: imageUrl);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userUid)
          .update(userModel.toMap());
      print("success");
    } catch (e) {
      print(e);
    }
  }

  void signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate to the login or home page after successful logout
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignUpPage1()));
    } catch (e) {
      print("Error signing out: $e");
      // Handle error (you may want to show an error message to the user)
    }
  }

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    super.notifyListeners();
  }
}
