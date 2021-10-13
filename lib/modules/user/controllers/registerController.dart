import 'package:gaweid2/modules/user/providers/usersProvider.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class RegisterController extends GetxController {
  var referrals = List<dynamic>.empty().obs;
  var isDataProcessing = false.obs;

  @override
  void onInit() async {
    super.onInit();
    getReferral();
  }

  void getReferral() {
    try {
      isDataProcessing(true);
      UsersProvider().getReferral().then((value) {
        // print(value.data.buildNumber);
        isDataProcessing(false);
        referrals.clear();
        referrals.addAll(value);
      }, onError: (err) {
        print(err);
        isDataProcessing(false);
        showSnackBar("Error", err.toString(), Colors.red);
      });
    } catch (exception) {
      isDataProcessing(false);
      showSnackBar("Exception", exception.toString(), Colors.red);
    }
  }

  showSnackBar(String title, String message, Color backgroundColor) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: backgroundColor,
        colorText: Colors.white);
  }
}