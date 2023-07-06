import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile_app/Auth/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  final Map<String, dynamic> userData;

  ProfileScreen({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extract user data from the userData map
    final String name = userData['name'] ?? 'N/A';
    final String email = userData['email'] ?? 'N/A';
    final String phoneNumber = userData['phoneNumber'] ?? 'N/A';
    final String imageUrl = userData['imageUrl'] ?? '';
    final String bio = userData['about'] ?? 'N/A';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6c58bc),
        title: Center(
          child: Text(
            "Profile",
            style: GoogleFonts.montserrat(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 70,
              backgroundImage:
                  NetworkImage(imageUrl), // Use NetworkImage for online images
              //backgroundImage: AssetImage('images/profileimage.jpg'), // For local images
            ),
            const SizedBox(height: 20),
            itemProfile("Name", name, Icons.person_2_outlined),
            SizedBox(height: 10),
            itemProfile("Email", email, Icons.email_outlined),
            SizedBox(height: 10),
            itemProfile("Phone", phoneNumber, Icons.phone),
            SizedBox(height: 10),
            itemProfile("Bio", bio, Icons.history_edu_outlined),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                AuthController.instance.logout();
              },
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFF71520), Color(0xFF3b2fb7)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  constraints: BoxConstraints(maxWidth: 200, minHeight: 50),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout),
                      SizedBox(width: 5),
                      Text(
                        "Log out",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.all(0.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            color: Color(0xFF6c58bc).withOpacity(.2),
            spreadRadius: 5,
            blurRadius: 10,
          )
        ],
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
        ),
      ),
    );
  }
}
