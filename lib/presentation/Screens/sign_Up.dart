import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:global_defense_insight/controller/device_Token.dart';
import 'package:global_defense_insight/controller/signUp_with_Mail.dart';
import 'package:global_defense_insight/core/AppConstant/appContant.dart';
import 'package:global_defense_insight/core/utils/Helper/Gspace.dart';
import 'package:global_defense_insight/core/utils/theme/text_theme.dart';
import 'package:global_defense_insight/presentation/Screens/sign_In.dart';
import 'package:iconsax/iconsax.dart';

class SignOut extends StatefulWidget {
  const SignOut({super.key});

  @override
  State<SignOut> createState() => _SignInState();
}

class _SignInState extends State<SignOut> {
  var isPasswordVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    SignUpController signUpController = Get.put(SignUpController());
    DeviceTokenController deviceTokenController =
        Get.put(DeviceTokenController());
    TextEditingController UserName = TextEditingController();
    TextEditingController UserEmail = TextEditingController();
    TextEditingController UserPhone = TextEditingController();

    TextEditingController UserPassword = TextEditingController();

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme =
        isDark ? GTextTheme.darkTextTheme : GTextTheme.lightTextTheme;
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
              Column(
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
                        style: textTheme.headlineSmall!.copyWith(fontSize: 18),
                      )
                    ],
                  ),
                  Text(
                    "Create an Account",
                    style: textTheme.headlineLarge,
                  ),
                  Text(
                    "Get started with something exceptional",
                    style: textTheme.headlineSmall,
                  ),
                  Gspace.spaceVertical(20),
                  Text(
                    "Email",
                    style: textTheme.headlineLarge!.copyWith(fontSize: 17),
                  ),
                  Gspace.spaceVertical(10),
                  TextField(
                    controller: UserEmail,
                    decoration: InputDecoration(
                        labelText: "Enter Your Email ...",
                        prefixIcon: Icon(Icons.email_rounded)),
                  ),
                  Gspace.spaceVertical(10),
                  Text(
                    "Username",
                    style: textTheme.headlineLarge!.copyWith(fontSize: 17),
                  ),
                  Gspace.spaceVertical(10),
                  TextField(
                    controller: UserName,
                    decoration: InputDecoration(
                        labelText: "Enter Your Username ...",
                        prefixIcon: Icon(Icons.person_2_rounded)),
                  ),
                  Gspace.spaceVertical(10),
                  Text(
                    "phone",
                    style: textTheme.headlineLarge!.copyWith(fontSize: 17),
                  ),
                  Gspace.spaceVertical(10),
                  TextField(
                    controller: UserPhone,
                    decoration: InputDecoration(
                        labelText: "Enter Your phone Number ...",
                        prefixIcon: Icon(Icons.phone_android_rounded)),
                  ),
                  Gspace.spaceVertical(10),
                  Text(
                    "Password",
                    style: textTheme.headlineLarge!.copyWith(fontSize: 17),
                  ),
                  Gspace.spaceVertical(10),
                  Obx(() => TextField(
                        controller: UserPassword,
                        obscureText: !signUpController.isPasswordVisible.value,
                        decoration: InputDecoration(
                          labelText: "Enter Your Password ...",
                          prefixIcon: Icon(Icons.password_rounded),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              signUpController.isPasswordVisible.toggle();
                            },
                            child: Icon(signUpController.isPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                      )),
                  Gspace.spaceVertical(20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () async {
                          String name = UserName.text.trim();
                          String email = UserEmail.text.trim();
                          String phone = UserPhone.text.trim();
                          String password = UserPassword.text.trim();
                          String token =
                              deviceTokenController.deviceToken.toString();

                          // Common passwords list (can be expanded)
                          List<String> commonPasswords = [
                            '123456',
                            'password',
                            '123456789',
                            'qwerty',
                            'abc123'
                          ];

                          // Email regex pattern
                          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

                          if (name.isEmpty ||
                              email.isEmpty ||
                              phone.isEmpty ||
                              password.isEmpty) {
                            Get.snackbar("All fields are required", "",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Appcolor.blue,
                                colorText: Color(0xFFf3f6f8));
                          } else if (name.length > 20) {
                            Get.snackbar(
                                "Username must be less than 20 characters", "",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Appcolor.blue,
                                colorText: Color(0xFFf3f6f8));
                          } else if (!emailRegex.hasMatch(email)) {
                            Get.snackbar("Invalid email format", "",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Appcolor.blue,
                                colorText: Color(0xFFf3f6f8));
                          } else if (phone.length != 11 ||
                              !phone.startsWith('03')) {
                            Get.snackbar(
                                "Invalid phone number. Must be 11 digits & start with '03'",
                                "",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Appcolor.blue,
                                colorText: Color(0xFFf3f6f8));
                          } else if (password.length < 6) {
                            Get.snackbar(
                                "Password must be at least 6 characters", "",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Appcolor.blue,
                                colorText: Color(0xFFf3f6f8));
                          } else if (commonPasswords
                              .contains(password.toLowerCase())) {
                            Get.snackbar(
                                "Password too common. Try a stronger one", "",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Appcolor.blue,
                                colorText: Color(0xFFf3f6f8));
                          } else {
                            UserCredential? userCredential =
                                await signUpController.SignUpWithEmailFun(
                                    email, name, phone, password, token);
                            if (userCredential != null) {
                              Get.snackbar("Verification Email Sent",
                                  "Check your inbox to verify.",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Appcolor.blue,
                                  colorText: Color(0xFFf3f6f8));
                              Get.offAll(() => SignIn());
                            }
                            FirebaseAuth.instance.signOut();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Appcolor.blue,
                          foregroundColor: Colors.white,
                        ),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                  ),
                  Gspace.spaceVertical(25),
                ],
              ),
              Gspace.spaceVertical(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: textTheme.headlineSmall,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(SignIn());
                    },
                    child: Text(
                      " Sign In",
                      style: textTheme.headlineLarge!.copyWith(fontSize: 17),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
