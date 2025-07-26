import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:global_defense_insight/core/AppConstant/appContant.dart';
import 'package:global_defense_insight/core/utils/theme/text_theme.dart';
import 'package:global_defense_insight/presentation/Screens/sign_In.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    return Padding(
      padding: EdgeInsets.only(top: Get.height / 25),
      child: Drawer(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        child: Wrap(
          runSpacing: 10,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Abu Bakar",
                  style: textTheme.bodyLarge,
                ),
                subtitle: Text(
                  "Version 1.0.1",
                  style: textTheme.bodyLarge,
                ),
                leading: CircleAvatar(
                  radius: 22,
                  backgroundColor: Appcolor.blue,
                  child: Text("A"),
                ),
              ),
            ),
            Divider(
              indent: 10,
              endIndent: 10,
              thickness: 1.5,
              color: Colors.grey,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    "Home",
                    style: textTheme.bodyLarge,
                  ),
                  leading: Icon(Icons.home)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    "Product",
                    style: textTheme.bodyLarge,
                  ),
                  leading: Icon(Icons.production_quantity_limits)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    "Order",
                    style: textTheme.bodyLarge,
                  ),
                  leading: Icon(Icons.shopping_bag)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    "Contact",
                    style: textTheme.bodyLarge,
                  ),
                  leading: Icon(Icons.contact_support)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: ListTile(
                  onTap: () {
                    final FirebaseAuth _auth = FirebaseAuth.instance;
                    _auth.signOut();
                    GoogleSignIn variable = GoogleSignIn();
                    variable.signOut();
                    Get.offAll(() => SignIn());
                  },
                  titleAlignment: ListTileTitleAlignment.center,
                  title: Text(
                    "Logout",
                    style: textTheme.bodyLarge,
                  ),
                  leading: Icon(Icons.logout)),
            ),
          ],
        ),
      ),
    );
  }
}
