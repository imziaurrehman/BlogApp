import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './../customs.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';

class CreateUser with ChangeNotifier {
  // void currentuserId(String uid) {
  //   User? currentuid = _firebaseAuth.currentUser;
  //   uid = currentuid.uid;
  // }

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("user");
  File? get imggetter => getimage;
  User? _user = FirebaseAuth.instance.currentUser;
  // UserCredential get userCred =>
  // String path = Path.basename(getimage!.path);
  Future<User?> registeration(
      {required String? email,
      required String? password,
      String? username}) async {
    try {
      final user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email!.trim(), password: password!.trim());
      collectionReference.doc(user.user!.uid).set({
        "userId": user.user!.uid,
        "email": email,
        "displayusername": username,
      });
      return user.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    notifyListeners();
  }

  Future login({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
    } catch (e) {
      print(" $e");
    }

    notifyListeners();
  }

  // User? get currentUser => FirebaseAuth.instance.currentUser;
}







     // if (userdata!.uid.isEmpty && userdata.uid == null) {
      //   return;
      // } else {
      //   email = userdata.email;
      //   userdata.displayName = username;
      //   userdata.updateDisplayName(username);
      // }
      // UserUpdateInfo

      // print(userdata.toString());
      // await _firebaseAuth.currentUser.update
