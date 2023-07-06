import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profile_app/Auth/auth_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var aboutController = TextEditingController();
  var signupImages = ["google-logo.png", "twitter-logo.png", "fb-logo.png"];
  XFile? _imageFile;

  bool _isImagePickerActive = false;

  Future<void> _selectImage() async {
    if (_isImagePickerActive) {
      return; // Return early if image picker is already active
    }

    _isImagePickerActive = true;

    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _imageFile = XFile(pickedFile.path);
      }
    } catch (e) {
      // Handle any errors that occur during the image selection process
      print(e.toString());
    } finally {
      _isImagePickerActive = false;
      setState(() {});
    }
  }

  Future<void> _clearCache() async {
    await DefaultCacheManager().emptyCache();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: w,
              height: h * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('images/signup.png'),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            if (_imageFile != null) ...[
              Image.file(
                File(_imageFile!.path),
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
            ],
            ElevatedButton(
              onPressed: _selectImage,
              child: Text('Choose Profile Image'),
            ),
            Container(
              width: w,
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 7,
                          offset: Offset(1, 1),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: "Enter Your Name",
                        prefixIcon: Icon(Icons.person),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 7,
                          offset: Offset(1, 1),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Enter Your Email",
                        prefixIcon: Icon(
                          Icons.email,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 7,
                          offset: Offset(1, 1),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        hintText: "Enter Your Phone",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 7,
                          offset: Offset(1, 1),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.password),
                        hintText: "Enter Your Password",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 7,
                          offset: Offset(1, 1),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: aboutController,
                      keyboardType: TextInputType.multiline,
                      minLines: 3,
                      maxLines: 7,
                      decoration: InputDecoration(
                        hintText: "Enter Your Bio",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      // Enables the TextField to occupy available vertical space
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.back(),
                      text: "Have an account already?",
                      style: GoogleFonts.montserrat(
                          color: Colors.grey[500], fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String name = nameController.text.trim();
                String email = emailController.text.trim();
                String password = passwordController.text.trim();
                String phoneNumber = phoneController.text.trim();
                String about = aboutController.text.trim();
                File? imageFile =
                    _imageFile != null ? File(_imageFile!.path) : null;

                await AuthController.instance.register(
                  name,
                  email,
                  password,
                  phoneNumber,
                  imageFile,
                  about,
                );
              },
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: const [Color(0xFF6c58bc), Color(0xFF3b2fb7)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  constraints:
                      const BoxConstraints(maxWidth: 200, minHeight: 50),
                  alignment: Alignment.center,
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.all(0.0),
              ),
            ),
            SizedBox(height: w * 0.1),
            RichText(
              text: TextSpan(
                text: "Sign up using one of the following methods",
                style: TextStyle(color: Colors.grey[500], fontSize: 16),
              ),
            ),
            Wrap(
              children: List<Widget>.generate(3, (index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          AssetImage("images/${signupImages[index]}"),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
