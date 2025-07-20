import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_defense_insight/core/utils/theme/Theme.dart';
import 'package:global_defense_insight/presentation/Screens/home-Screen.dart';
import 'package:global_defense_insight/presentation/Screens/onboarding.dart';
import 'package:global_defense_insight/presentation/Screens/password.dart';
import 'package:global_defense_insight/presentation/Screens/sign_In.dart';
import 'package:global_defense_insight/presentation/Screens/sign_Out.dart';
import 'package:global_defense_insight/presentation/Screens/splash-screen.dart';
import 'package:get/get.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown, // Optional: allows upside down
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      theme: GAppTheme.lightTheme,
      darkTheme: GAppTheme.darkTheme,
      home: ResetPassword(),
    );
  }
}
