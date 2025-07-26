import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:global_defense_insight/core/AppConstant/appContant.dart';
import 'package:global_defense_insight/presentation/Screens/sign_In.dart';

class forgetPasswordController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> forgetPasswordControllerFun(String UserEmail) async {
    try {
      EasyLoading.show(status: "Please wait...");
      await _auth.sendPasswordResetEmail(email: UserEmail);
      EasyLoading.dismiss();

      Get.snackbar(
        "Email Sent",
        "A password reset link has been sent to $UserEmail",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Appcolor.blue,
        colorText: const Color(0xFFf3f6f8),
      );

      Get.off(() => const SignIn());
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();

      String errorMessage;

      switch (e.code) {
        case 'invalid-email':
          errorMessage = "The email address is not valid.";
          break;
        case 'user-not-found':
          errorMessage = "No user found with this email address.";
          break;
        case 'missing-email':
          errorMessage = "Please enter an email address.";
          break;
        default:
          errorMessage = "Something went wrong. Please try again.";
      }

      Get.snackbar(
        "Error",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Appcolor.blue,
        colorText: const Color(0xFFf3f6f8),
      );
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar(
        "Unexpected Error",
        "Something went wrong. Please try again later.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Appcolor.blue,
        colorText: const Color(0xFFf3f6f8),
      );
    }
  }
}
