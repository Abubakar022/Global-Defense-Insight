import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:global_defense_insight/controller/get_User_Data.dart';
import 'package:global_defense_insight/controller/google_SignIn.dart';
import 'package:global_defense_insight/controller/signIn_With_Email.dart';
import 'package:global_defense_insight/core/AppConstant/appContant.dart';
import 'package:global_defense_insight/core/utils/Helper/Gspace.dart';
import 'package:global_defense_insight/core/utils/theme/text_theme.dart';
import 'package:global_defense_insight/presentation/Screens/home-Screen.dart';
import 'package:global_defense_insight/presentation/Screens/password.dart';
import 'package:global_defense_insight/presentation/Screens/sign_Up.dart';
import 'package:iconsax/iconsax.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GoogleSignInController _googleSignInController =
      Get.put(GoogleSignInController());

  SignInController signInController = Get.put(SignInController());
  GetUserDataController getUserDataController =
      Get.put(GetUserDataController());
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textTheme =
        isDark ? GTextTheme.darkTextTheme : GTextTheme.lightTextTheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Iconsax.ship, size: 25),
                              Gspace.spaceHorizontal(7),
                              Text(
                                "Global Defense Insight",
                                style: textTheme.headlineSmall!
                                    .copyWith(fontSize: 18),
                              )
                            ],
                          ),
                          Gspace.spaceVertical(10),
                          Text("Welcome Back!", style: textTheme.headlineLarge),
                          Text("Sign In to continue your journey",
                              style: textTheme.headlineSmall),
                          Gspace.spaceVertical(10),
                          Text("Email",
                              style: textTheme.headlineLarge!
                                  .copyWith(fontSize: 17)),
                          Gspace.spaceVertical(10),
                          TextField(
                            controller: userEmail,
                            decoration: InputDecoration(
                              labelText: "Enter Your Email ...",
                              prefixIcon: Icon(Icons.email_rounded),
                            ),
                          ),
                          Gspace.spaceVertical(10),
                          Text("Password",
                              style: textTheme.headlineLarge!
                                  .copyWith(fontSize: 17)),
                          Gspace.spaceVertical(10),
                          Obx(() => TextField(
                                controller: userPassword,
                                obscureText:
                                    !signInController.isPasswordVisible.value,
                                decoration: InputDecoration(
                                  labelText: "Enter Your Password ...",
                                  prefixIcon: Icon(Icons.password_rounded),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      signInController.isPasswordVisible
                                          .toggle();
                                    },
                                    child: Icon(
                                      signInController.isPasswordVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                ),
                              )),
                          Gspace.spaceVertical(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(ResetPassword());
                                },
                                child: Text("Forgot Password?",
                                    style: textTheme.headlineLarge!
                                        .copyWith(fontSize: 17)),
                              ),
                            ],
                          ),
                          Gspace.spaceVertical(20),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () async {
                                String email = userEmail.text.trim();
                                String password = userPassword.text.trim();

                                if (email.isEmpty || password.isEmpty) {
                                  Get.snackbar(
                                    "Missing Information",
                                    "Make sure to enter all required information accurately",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Appcolor.blue,
                                    colorText: Color(0xFFf3f6f8),
                                  );
                                  return;
                                }

                                UserCredential? userCredential =
                                    await signInController.SignInWithEmailFun(
                                        email, password);

                                if (userCredential == null ||
                                    userCredential.user == null) {
                                  // Sign-in failed, already handled in controller
                                  return;
                                }

                                var userData =
                                    await getUserDataController.getUserData(
                                  userCredential.user!.uid,
                                );

                                if (userCredential.user!.emailVerified) {
                                  if (userData[0]['isAdmin'] == true) {
                                    // You can navigate to admin screen if needed
                                  } else {
                                    Get.snackbar(
                                      "Login Successfully",
                                      "",
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Appcolor.blue,
                                      colorText: Color(0xFFf3f6f8),
                                    );
                                    Get.offAll(() => HomeScreen());
                                  }
                                } else {
                                  Get.snackbar(
                                    "Email Verification Required",
                                    "Please check your inbox and verify your email to proceed",
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Appcolor.blue,
                                    colorText: Color(0xFFf3f6f8),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Appcolor.blue,
                                foregroundColor: Colors.white,
                              ),
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Gspace.spaceVertical(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.grey,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Text("or", style: textTheme.headlineSmall),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Gspace.spaceVertical(25),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).secondaryHeaderColor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _googleSignInController.GoogleSignInFun();
                                    },
                                    child: Text("Sign In with Google",
                                        style: textTheme.headlineLarge!
                                            .copyWith(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700)),
                                  ),
                                  Gspace.spaceHorizontal(8),
                                  Image.asset(
                                    "assets/images/google.png",
                                    width: 25,
                                    height: 25,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gspace.spaceVertical(30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don’t have an account?",
                              style: textTheme.headlineSmall),
                          GestureDetector(
                            onTap: () {
                              Get.to(SignOut());
                            },
                            child: Text(" Sign Up",
                                style: textTheme.headlineLarge!
                                    .copyWith(fontSize: 17)),
                          )
                        ],
                      ),
                      Gspace.spaceVertical(10),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
