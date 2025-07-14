import 'package:flutter/material.dart';
import 'package:global_defense_insight/core/utils/theme/Theme.dart';
import 'package:global_defense_insight/presentation/Screens/splash-screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: GAppTheme.lightTheme,
      darkTheme: GAppTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}
