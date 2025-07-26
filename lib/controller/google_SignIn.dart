import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:global_defense_insight/controller/device_Token.dart';
import 'package:global_defense_insight/core/AppConstant/appContant.dart';
import 'package:global_defense_insight/model/user_Model.dart';
import 'package:global_defense_insight/presentation/Screens/home-Screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInController extends GetxController {
  final _googleSignIn = GoogleSignIn();

  final FirebaseAuth auth = FirebaseAuth.instance;
  String _getGoogleErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'account-exists-with-different-credential':
        return 'An account already exists with a different sign-in method.';
      case 'invalid-credential':
        return 'Invalid or expired credentials. Please try again.';
      case 'user-disabled':
        return 'Your account has been disabled. Contact support.';
      case 'user-not-found':
        return 'No user found for this Google account.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'network-request-failed':
        return 'Network error. Check your internet connection.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }

  Future<void> GoogleSignInFun() async {
    DeviceTokenController deviceTokenController =
        Get.put(DeviceTokenController());

    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        EasyLoading.show(status: "Please Wait...");
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          final UserModel userModel = UserModel(
            uId: user.uid,
            username: user.displayName ?? '',
            email: user.email ?? '',
            phone: user.phoneNumber ?? '',
            userImg: user.photoURL ?? '',
            userDeviceToken: deviceTokenController.deviceToken.toString(),
            country: '',
            userAddress: '',
            street: '',
            isAdmin: false,
            isActive: true,
            createdOn: DateTime.now(),
          );

          await FirebaseFirestore.instance
              .collection('user')
              .doc(user.uid)
              .set(userModel.toMap());

          EasyLoading.dismiss();
          Get.offAll(() => HomeScreen());
        }
      }
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      final message = _getGoogleErrorMessage(e.code);
      Get.snackbar(
        "Google Sign-In Error",
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Appcolor.blue, // ✅ Custom app color
        colorText: const Color(0xFFf3f6f8),
      );
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar(
        "Unexpected Error",
        "Something went wrong during Google Sign-In. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Appcolor.blue, // ✅ Consistent color
        colorText: const Color(0xFFf3f6f8),
      );
      print("Google Sign-In Error: $e");
    }
  }
}
