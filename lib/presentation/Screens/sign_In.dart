// import 'package:flutter/material.dart';
// import 'package:global_defense_insight/core/AppConstant/appContant.dart';
// import 'package:global_defense_insight/core/utils/Helper/Gspace.dart';
// import 'package:global_defense_insight/core/utils/theme/text_theme.dart';
// import 'package:iconsax/iconsax.dart';

// class SignIn extends StatefulWidget {
//   const SignIn({super.key});

//   @override
//   State<SignIn> createState() => _SignInState();
// }

// class _SignInState extends State<SignIn> {
//   bool _obscureText = true;
//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final textTheme =
//         isDark ? GTextTheme.darkTextTheme : GTextTheme.lightTextTheme;
//     return Scaffold(
//       backgroundColor: Theme.of(context).primaryColor,
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).primaryColor,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(
//                         Iconsax.ship,
//                         size: 25,
//                       ),
//                       Gspace.spaceHorizontal(7),
//                       Text(
//                         "Global Defense Insight",
//                         style: textTheme.headlineSmall!.copyWith(fontSize: 18),
//                       )
//                     ],
//                   ),
//                   Text(
//                     "Welcome Back!",
//                     style: textTheme.headlineLarge,
//                   ),
//                   Text(
//                     "Sign In to continue your journey",
//                     style: textTheme.headlineSmall,
//                   ),
//                   Gspace.spaceVertical(10),
//                   Text(
//                     "Email",
//                     style: textTheme.headlineLarge!.copyWith(fontSize: 17),
//                   ),
//                   Gspace.spaceVertical(10),
//                   TextField(
//                     decoration: InputDecoration(
//                         labelText: "Enter Your Email ...",
//                         prefixIcon: Icon(Icons.email_rounded)),
//                   ),
//                   Gspace.spaceVertical(10),
//                   Text(
//                     "Password",
//                     style: textTheme.headlineLarge!.copyWith(fontSize: 17),
//                   ),
//                   Gspace.spaceVertical(10),
//                   TextField(
//                     decoration: InputDecoration(
//                         labelText: "Enter Your Password ...",
//                         prefixIcon: Icon(Icons.password_rounded),
//                         suffixIcon: IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 _obscureText = !_obscureText;
//                               });
//                             },
//                             icon: Icon(_obscureText
//                                 ? Icons.visibility_off_rounded
//                                 : Icons.visibility_rounded))),
//                   ),
//                   Gspace.spaceVertical(10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text(
//                         "Forgotten Password?",
//                         textAlign: TextAlign.center,
//                         style: textTheme.headlineLarge!.copyWith(fontSize: 17),
//                       ),
//                     ],
//                   ),
//                   Gspace.spaceVertical(10),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                         onPressed: () {},
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Appcolor.blue,
//                           foregroundColor: Colors.white,
//                         ),
//                         child: Text(
//                           "Sign In",
//                           style: TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.bold),
//                         )),
//                   ),
//                   Gspace.spaceVertical(10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         child: Divider(
//                           thickness: 3,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           "or",
//                           style: textTheme.headlineSmall,
//                         ),
//                       ),
//                       Expanded(
//                         child: Divider(
//                           thickness: 1,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Gspace.spaceVertical(25),
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                         onPressed: () {},
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor:
//                               Theme.of(context).secondaryHeaderColor,
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text("Sign In with Google",
//                                 style: textTheme.headlineLarge!.copyWith(
//                                     fontSize: 20, fontWeight: FontWeight.w700)),
//                             Gspace.spaceHorizontal(8),
//                             Image.asset(
//                               "assets/images/google.png",
//                               width: 25,
//                               height: 25,
//                             )
//                           ],
//                         )),
//                   ),
//                 ],
//               ),
//               Gspace.spaceVertical(40),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,

//                 children: [
//                   Text(
//                     "Don’t have an account?",
//                     style: textTheme.headlineSmall,
//                   ),
//                   Text(
//                     " Sign Up",
//                     style: textTheme.headlineLarge!.copyWith(fontSize: 17),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:global_defense_insight/core/AppConstant/appContant.dart';
import 'package:global_defense_insight/core/utils/Helper/Gspace.dart';
import 'package:global_defense_insight/core/utils/theme/text_theme.dart';
import 'package:iconsax/iconsax.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
                          Text("Welcome Back!",
                              style: textTheme.headlineLarge),
                          Text("Sign In to continue your journey",
                              style: textTheme.headlineSmall),
                          Gspace.spaceVertical(10),
                          Text("Email",
                              style: textTheme.headlineLarge!
                                  .copyWith(fontSize: 17)),
                          Gspace.spaceVertical(10),
                          TextField(
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
                          TextField(
                            obscureText: _obscureText,
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
                                    : Icons.visibility_rounded),
                              ),
                            ),
                          ),
                          Gspace.spaceVertical(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Forgotten Password?",
                                  style: textTheme.headlineLarge!
                                      .copyWith(fontSize: 17)),
                            ],
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
                              child: Text("Sign In",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
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
                                child: Text("or",
                                    style: textTheme.headlineSmall),
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
                                backgroundColor: Theme.of(context)
                                    .secondaryHeaderColor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Sign In with Google",
                                      style: textTheme.headlineLarge!.copyWith(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700)),
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
                          Text(" Sign Up",
                              style: textTheme.headlineLarge!
                                  .copyWith(fontSize: 17)),
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
