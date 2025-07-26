import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:global_defense_insight/core/AppConstant/appContant.dart';

class SignInController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Password Visibility
  var isPasswordVisible = false.obs;

  String getFriendlyFirebaseError(String errorCode) {
    if (errorCode == 'invalid-email') {
      return 'Please enter a valid email address.';
    } else if (errorCode == 'user-disabled') {
      return 'This account has been disabled. Please contact support.';
    } else if (errorCode == 'user-not-found') {
      return 'No account found with this email address.';
    } else if (errorCode == 'wrong-password') {
      return 'The password you entered is incorrect.';
    } else if (errorCode == 'email-already-in-use') {
      return 'This email is already registered. Please sign in.';
    } else if (errorCode == 'operation-not-allowed') {
      return 'This sign-in method is not enabled. Contact support.';
    } else if (errorCode == 'weak-password') {
      return 'Password is too weak. Use at least 6 characters.';
    } else if (errorCode == 'too-many-requests') {
      return 'Too many attempts. Please wait and try again later.';
    } else if (errorCode == 'network-request-failed') {
      return 'Network error. Please check your internet connection.';
    } else if (errorCode == 'missing-email') {
      return 'Email field is required.';
    } else if (errorCode == 'missing-password') {
      return 'Password field is required.';
    } else if (errorCode == 'invalid-login-credentials') {
      return 'Invalid login credentials. Please try again.';
    } else if (errorCode == 'internal-error') {
      return 'Something went wrong on our end. Please try again later.';
    } else if (errorCode == 'invalid-login-credentials' ||
        errorCode == 'invalid-credential' ||
        errorCode == 'user-mismatch') {
      return 'Your login credentials are incorrect or expired. Please try again.';
    } else {
      return 'Something went wrong. Please try again.';
    }
  }

  Future<UserCredential?> SignInWithEmailFun(
    String UserEmail,
    String UserPassword,
  ) async {
    try {
      EasyLoading.show(status: "Please Wait...");
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: UserEmail,
        password: UserPassword,
      );
      EasyLoading.dismiss();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      String friendlyMessage = getFriendlyFirebaseError(e.code);
      Get.snackbar(
        "Sign-In Error",
        friendlyMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Appcolor.blue,
        colorText: Color(0xFFf3f6f8),
      );
      return null;
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar(
        "Unexpected Error",
        "Something went wrong. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Appcolor.blue,
        colorText: Color(0xFFf3f6f8),
      );
      return null;
    }
  }
}
