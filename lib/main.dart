import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:global_defense_insight/api/background_service.dart';
import 'package:global_defense_insight/controller/connectivity_controller.dart';
import 'package:global_defense_insight/core/AppConstant/MyHttpOverrides.dart';
import 'package:global_defense_insight/core/utils/theme/Theme.dart';
import 'package:global_defense_insight/firebase_options.dart';
import 'package:global_defense_insight/presentation/Screens/home-Screen.dart';
import 'package:global_defense_insight/presentation/Screens/news_detail_screen.dart';
import 'package:global_defense_insight/model/post_Model.dart';
import 'dart:convert';
import 'dart:io';
import 'package:workmanager/workmanager.dart';
import 'package:global_defense_insight/api/api_Call.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('🔔 Background message received: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.instance.subscribeToTopic('all');

  Get.put(PostController());
  Get.put(ConnectivityController());

  // Init WorkManager
  Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  Workmanager().registerPeriodicTask(
    "1",
    fetchNewPostsTask,
    frequency: const Duration(minutes: 15),
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _setupFirebaseMessaging();
  }

  void _setupFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Request permission
    await messaging.requestPermission();

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("🔵 Foreground notification: ${message.notification?.title}");
      // Optional: Show local notification if you want
    });

    // Background/tap notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationClick(message);
    });

    // Cold start
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _handleNotificationClick(message);
      }
    });
  }

  void _handleNotificationClick(RemoteMessage message) {
    if (message.data.containsKey('postId')) {
      final postId = int.tryParse(message.data['postId'].toString());
      if (postId != null) {
        final postController = Get.find<PostController>();
        final post = postController.postList.firstWhere(
          (p) => p.id == postId,
          orElse: () => PostModel(
              id: postId,
              title: "Post",
              content: "Details not available",
              categories: []),
        );
        navigatorKey.currentState?.push(MaterialPageRoute(
          builder: (_) => NewsDetailScreen(post: post),
        ));
      }
    }
  }

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


// import 'dart:io';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:global_defense_insight/api/api_Call.dart';
// import 'package:global_defense_insight/core/AppConstant/MyHttpOverrides.dart';
// import 'package:global_defense_insight/core/utils/theme/Theme.dart';
// import 'package:global_defense_insight/firebase_options.dart';
// import 'package:global_defense_insight/presentation/Drawer-Screen/ContactUs.dart';
// import 'package:global_defense_insight/presentation/Drawer-Screen/SubmissionGuidelines.dart';
// import 'package:global_defense_insight/presentation/Drawer-Screen/about_Us.dart';
// import 'package:global_defense_insight/presentation/Screens/discover_Screen.dart';
// import 'package:global_defense_insight/presentation/Screens/home-Screen.dart';
// import 'package:global_defense_insight/presentation/Screens/news_detail_screen.dart';
// import 'package:global_defense_insight/presentation/Screens/onboarding.dart';
// import 'package:global_defense_insight/presentation/Screens/all_News.dart';
// import 'package:global_defense_insight/presentation/Screens/password.dart';
// import 'package:global_defense_insight/presentation/Screens/sign_In.dart';
// import 'package:global_defense_insight/presentation/Screens/sign_Up.dart';
// import 'package:global_defense_insight/presentation/Screens/splash-screen.dart';
// import 'package:get/get.dart';

// Future<void> main() async {
//   Get.put(PostController());
//   HttpOverrides.global = MyHttpOverrides();
//    WidgetsFlutterBinding.ensureInitialized();
//   // await GetStorage.init();
  
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform
//   );
//   await SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown, // Optional: allows upside down
//   ]);
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       themeMode: ThemeMode.system,
//       theme: GAppTheme.lightTheme,
//       darkTheme: GAppTheme.darkTheme,
//       home: HomeScreen(),
//       builder: EasyLoading.init(),
//     );
//   }
// }
