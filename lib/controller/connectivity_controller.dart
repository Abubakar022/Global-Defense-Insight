import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ConnectivityController extends GetxController {
  final RxBool isConnected = true.obs;
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  @override
  void onInit() {
    super.onInit();
    _initConnectivity();
    _subscription = Connectivity().onConnectivityChanged.listen((results) {
      _updateStatus(results);
    });
  }

  Future<void> _initConnectivity() async {
    try {
      List<ConnectivityResult> result = await Connectivity().checkConnectivity();
      _updateStatus(result);
    } catch (e) {
      print("⚠️ Error checking connectivity: $e");
    }
  }

  void _updateStatus(List<ConnectivityResult> results) {
    final hasConnection = results.any((r) => r != ConnectivityResult.none);

    if (!hasConnection && isConnected.value) {
      // Only show when going offline
      Get.snackbar(
        'No Internet Connection',
        'Please check your network.',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: const Duration(days: 1),
        snackPosition: SnackPosition.BOTTOM,
        mainButton: TextButton(
          onPressed: () => Get.closeAllSnackbars(),
          child: const Text('Dismiss', style: TextStyle(color: Colors.white)),
        ),
      );
    } else if (hasConnection && !isConnected.value) {
      // Back online
      Get.closeAllSnackbars();
    }

    isConnected.value = hasConnection;
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}
