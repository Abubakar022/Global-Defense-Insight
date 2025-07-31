import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:global_defense_insight/controller/reset_Password.dart';
import 'package:global_defense_insight/core/AppConstant/appContant.dart';
import 'package:global_defense_insight/core/utils/Helper/Gspace.dart';
import 'package:global_defense_insight/core/utils/theme/text_theme.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _SignInState();
}

class _SignInState extends State<ResetPassword> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    forgetPasswordController ForgetPasswordController =
        Get.put(forgetPasswordController());
    TextEditingController userEmail = TextEditingController();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme =
        isDark ? GTextTheme.darkTextTheme : GTextTheme.lightTextTheme;

    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                !isKeyboardVisible
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Iconsax.ship,
                                size: 25,
                              ),
                              Gspace.spaceHorizontal(7),
                              Text(
                                "Global Defense Insight",
                                style: textTheme.headlineSmall!
                                    .copyWith(fontSize: 18),
                              )
                            ],
                          ),
                          Text(
                            "Reset Password",
                            style: textTheme.headlineLarge,
                          ),
                          Text(
                            "A fresh start is just one step away",
                            style: textTheme.headlineSmall,
                          ),
                          Gspace.spaceVertical(20),
                          Text(
                            "Email",
                            style:
                                textTheme.headlineLarge!.copyWith(fontSize: 17),
                          ),
                          Gspace.spaceVertical(10),
                          TextField(
                            controller: userEmail,
                            decoration: InputDecoration(
                                labelText: "Enter Your Email ...",
                                prefixIcon: Icon(Icons.email_rounded)),
                          ),
                          Gspace.spaceVertical(20),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () {
                                  String email = userEmail.text.trim();

                                  RegExp emailRegex =
                                      RegExp(r"^[a-zA-Z0-9._%+-]+@gmail\.com$");

                                  if (email.isEmpty ||
                                      !emailRegex.hasMatch(email)) {
                                    Get.snackbar(
                                      "Invalid Email",
                                      "Please enter a valid Gmail address (e.g. example@gmail.com)",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Appcolor.blue,
                                      colorText: Color(0xFFf3f6f8),
                                    );
                                  } else {
                                    String email = userEmail.text.trim();
                                    ForgetPasswordController
                                        .forgetPasswordControllerFun(email);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Appcolor.blue,
                                  foregroundColor: Colors.white,
                                ),
                                child: Text(
                                  "Send Link",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Iconsax.ship,
                                size: 25,
                              ),
                              Gspace.spaceHorizontal(7),
                              Text(
                                "Global Defense Insight",
                                style: textTheme.headlineSmall!
                                    .copyWith(fontSize: 18),
                              )
                            ],
                          ),
                          Gspace.spaceVertical(20),
                          Text(
                            "Please enter your registered email address below.\nAfter pressing the \"Forgot Password\" button, you will receive a password reset link in your email.\nFollow the instructions in the email to securely reset your password.",
                            style: textTheme.bodyLarge,
                          ),
                          Gspace.spaceVertical(20),
                          Text(
                            "Email",
                            style:
                                textTheme.headlineLarge!.copyWith(fontSize: 17),
                          ),
                          Gspace.spaceVertical(10),
                          TextField(
                            controller: userEmail,
                            decoration: InputDecoration(
                                labelText: "Enter Your Email ...",
                                prefixIcon: Icon(Icons.email_rounded)),
                          ),
                          Gspace.spaceVertical(20),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () {
                                  String email = userEmail.text.trim();

                                  RegExp emailRegex =
                                      RegExp(r"^[a-zA-Z0-9._%+-]+@gmail\.com$");

                                  if (email.isEmpty ||
                                      !emailRegex.hasMatch(email)) {
                                    Get.snackbar(
                                      "Invalid Email",
                                      "Please enter a valid Gmail address (e.g. example@gmail.com)",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Appcolor.blue,
                                      colorText: Color(0xFFf3f6f8),
                                    );
                                  } else {
                                    String email = userEmail.text.trim();
                                    ForgetPasswordController
                                        .forgetPasswordControllerFun(email);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Appcolor.blue,
                                  foregroundColor: Colors.white,
                                ),
                                child: Text(
                                  "Send Link",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
      );
    });
  }
}
