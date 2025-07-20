import 'package:flutter/material.dart';
import 'package:global_defense_insight/core/AppConstant/appContant.dart';
import 'package:global_defense_insight/core/utils/Helper/Gspace.dart';
import 'package:global_defense_insight/core/utils/theme/text_theme.dart';
import 'package:iconsax/iconsax.dart';

class SignOut extends StatefulWidget {
  const SignOut({super.key});

  @override
  State<SignOut> createState() => _SignInState();
}

class _SignInState extends State<SignOut> {
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
                  TextField(
                    decoration: InputDecoration(
                        labelText: "Enter Your Password ...",
                        prefixIcon: Icon(Icons.password_rounded),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            icon: Icon(_obscureText
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded))),
                  ),
                  Gspace.spaceVertical(20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {},
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
                  Text(
                    " Sign In",
                    style: textTheme.headlineLarge!.copyWith(fontSize: 17),
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
