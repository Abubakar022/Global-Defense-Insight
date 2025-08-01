import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:global_defense_insight/api/api_Call.dart';
import 'package:global_defense_insight/core/AppConstant/MyHttpOverrides.dart';
import 'package:global_defense_insight/core/utils/theme/Theme.dart';
import 'package:global_defense_insight/firebase_options.dart';
import 'package:global_defense_insight/presentation/Screens/discover_Screen.dart';
import 'package:global_defense_insight/presentation/Screens/home-Screen.dart';
import 'package:global_defense_insight/presentation/Screens/news_detail_screen.dart';
import 'package:global_defense_insight/presentation/Screens/onboarding.dart';
import 'package:global_defense_insight/presentation/Screens/all_News.dart';
import 'package:global_defense_insight/presentation/Screens/password.dart';
import 'package:global_defense_insight/presentation/Screens/sign_In.dart';
import 'package:global_defense_insight/presentation/Screens/sign_Up.dart';
import 'package:global_defense_insight/presentation/Screens/splash-screen.dart';
import 'package:get/get.dart';

Future<void> main() async {
  Get.put(PostController());
  HttpOverrides.global = MyHttpOverrides();
   WidgetsFlutterBinding.ensureInitialized();
  // await GetStorage.init();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
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
      themeMode: ThemeMode.system,
      theme: GAppTheme.lightTheme,
      darkTheme: GAppTheme.darkTheme,
      home: HomeScreen(),
      builder: EasyLoading.init(),
    );
  }
}
