import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:profile_app/Screens/login_page.dart';
import 'package:profile_app/Screens/profile_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    //our user would be notified
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  Future<void> _initialScreen(User? user) async {
    if (user == null) {
      print("Login Page");
      Get.offAll(() => LoginPage());
    } else {
      try {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (snapshot.exists) {
          final userData = snapshot.data() as Map<String, dynamic>;
          Get.offAll(() => ProfileScreen(userData: userData));
        } else {
          // User data not found in Firestore
          // You can handle this case according to your requirements
        }
      } catch (e) {
        // Error occurred while fetching user data
        // You can show an error message to the user using your preferred UI framework
        Get.snackbar(
          "Error",
          "Failed to fetch user data",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Error",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          messageText: Text(
            e.toString(),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        );
      }
    }
  }

  Future<void> register(
    String name,
    String email,
    String password,
    String phoneNumber,
    File? imageFile,
    String about,
  ) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      String userId = userCredential.user!.uid;
      String imageUrl = '';

      if (imageFile != null) {
        final String fileName = '${userId}_profile.jpg';
        firebase_storage.Reference storageRef =
            firebase_storage.FirebaseStorage.instance.ref().child(fileName);
        firebase_storage.UploadTask uploadTask = storageRef.putFile(imageFile);
        firebase_storage.TaskSnapshot taskSnapshot =
            await uploadTask.whenComplete(() {});
        imageUrl = await taskSnapshot.ref.getDownloadURL();
      }

      final CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');

      await usersCollection.doc(userId).set({
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'imageUrl': imageUrl,
        'about': about,
      });

      // Account creation and user data saving successful
      // Navigate to the profile screen
      Get.offAll(() => ProfileScreen(userData: {
            'name': name,
            'email': email,
            'phoneNumber': phoneNumber,
            'imageUrl': imageUrl,
            'about': about,
          }));
    } catch (e) {
      // Registration failed
      // You can show an error message to the user using your preferred UI framework
      Get.snackbar(
        "Registration Failed",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar("About Login", "Login message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Login failed",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          messageText: Text(
            e.toString(),
            style: TextStyle(
              color: Colors.white,
            ),
          ));
    }
  }

  Future<void> logout() async {
    await auth.signOut();
  }
}
