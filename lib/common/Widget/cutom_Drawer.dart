import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:global_defense_insight/core/AppConstant/appContant.dart';
import 'package:global_defense_insight/core/utils/theme/text_theme.dart';
import 'package:global_defense_insight/presentation/Drawer-Screen/AdvertiseWithUs.dart';
import 'package:global_defense_insight/presentation/Drawer-Screen/ContactUs.dart';
import 'package:global_defense_insight/presentation/Drawer-Screen/SubmissionGuidelines.dart';
import 'package:global_defense_insight/presentation/Drawer-Screen/about_Us.dart';
import 'package:global_defense_insight/presentation/Screens/sign_In.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconsax/iconsax.dart';

class DrawerWideget extends StatefulWidget {
  const DrawerWideget({super.key});

  @override
  State<DrawerWideget> createState() => _DrawerWidegetState();
}

class _DrawerWidegetState extends State<DrawerWideget> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme =
        isDark ? GTextTheme.darkTextTheme : GTextTheme.lightTextTheme;
// 🔁 Get current user from FirebaseAuth
final user = FirebaseAuth.instance.currentUser;
final displayName = user?.displayName ?? "Guest";
final initial = displayName.isNotEmpty ? displayName[0].toUpperCase() : "U";

    return Padding(
      padding: EdgeInsets.only(top: Get.height / 25),
      child: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            // 👤 User Info
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Hello,",
                  style: textTheme.headlineLarge!.copyWith(fontSize: 18),
                ),
                subtitle: Text(
                  displayName,
                  style: textTheme.bodyLarge,
                ),
                leading: CircleAvatar(
                  radius: 22,
                  backgroundColor: Appcolor.blue,
                  child: Text(
                    initial,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),

            Divider(
              indent: 10,
              endIndent: 10,
              thickness: 1.5,
              color: Colors.grey,
            ),

            // Menu Items
            ListTile(
              onTap: () {
                Get.to(AboutUs());
              },
              titleAlignment: ListTileTitleAlignment.center,
              title: Text("About Us", style: textTheme.bodyLarge),
              leading: Icon(Iconsax.people,
                  color: isDark ? Colors.white : Colors.black),
            ),

            ListTile(
              onTap: () {
                Get.to(AdvertiseWithUs());
              },
              titleAlignment: ListTileTitleAlignment.center,
              title: Text("Advertise With Us", style: textTheme.bodyLarge),
              leading: Icon(Icons.campaign,
                  color: isDark ? Colors.white : Colors.black),
            ),
            ListTile(
              onTap: () {
                Get.to(SubmissionGuidelines());
              },
              titleAlignment: ListTileTitleAlignment.center,
              title: Text("Submission Guidelines", style: textTheme.bodyLarge),
              leading: Icon(Icons.article,
                  color: isDark ? Colors.white : Colors.black),
            ),
            ListTile(
              onTap: () {
                Get.to(ContactUs());
              },
              titleAlignment: ListTileTitleAlignment.center,
              title: Text("Contact Us", style: textTheme.bodyLarge),
              leading: Icon(Icons.contact_support_outlined,
                  color: isDark ? Colors.white : Colors.black),
            ),
            Spacer(), // Push logout to bottom

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  await GoogleSignIn().signOut();
                  Get.offAll(() => SignIn());
                },
                icon: Icon(Icons.logout, color: Colors.white),
                label: Text(
                  "Sign Out",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
