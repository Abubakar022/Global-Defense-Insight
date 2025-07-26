import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:global_defense_insight/core/AppConstant/appContant.dart';
import 'package:global_defense_insight/model/user_Model.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Password Visibility
  var isPasswordVisible = false.obs;
String _getSignupErrorMessage(String code) {
  switch (code) {
    case 'email-already-in-use':
      return 'This email is already in use. Try logging in instead.';
    case 'invalid-email':
      return 'Please enter a valid email address.';
    case 'operation-not-allowed':
      return 'Email/password sign-up is currently disabled.';
    case 'weak-password':
      return 'Password is too weak. Use at least 6 characters.';
    case 'network-request-failed':
      return 'No internet connection. Please try again.';
    case 'too-many-requests':
      return 'Too many attempts. Please wait and try again later.';
    default:
      return 'An unknown error occurred. Please try again.';
  }
}

  Future<UserCredential?> SignUpWithEmailFun(
    String UserEmail,
    String UserName,
    String UserPhone,
    String UserPassword,
    String UserDeviceToken,
  ) async {
    try {
      EasyLoading.show(status: "Please Wait...");

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: UserEmail,
        password: UserPassword,
      );

      // Send email verification
      await userCredential.user!.sendEmailVerification();

      UserModel userModel = UserModel(
        uId: userCredential.user!.uid,
        username: UserName,
        email: UserEmail,
        phone: UserPhone,
        userImg: '',
        userDeviceToken: UserDeviceToken,
        country: '',
        userAddress: '',
        street: '',
        isAdmin: false,
        isActive: true,
        createdOn: DateTime.now(),
      );

      // Save user data in Firestore
      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(userModel.toMap());

      EasyLoading.dismiss();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      final message = _getSignupErrorMessage(e.code);
      Get.snackbar(
        "Sign-Up Failed",
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Appcolor.blue,
        colorText: const Color(0xFFf3f6f8),
      );
      return null;
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar(
        "Unexpected Error",
        "Something went wrong. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Appcolor.blue,
        colorText: const Color(0xFFf3f6f8),
      );
      return null;
    }
  }
}
