import 'package:gaweid2/utils/models/versionModel.dart';
import 'package:gaweid2/utils/providers/utilsProvider.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class UtilsController extends GetxController {
  var tips = List<Data>.empty().obs;
  var isDataProcessing = false.obs;
  RxString currentBuild = "".obs;

  @override
  void onInit() async {
    super.onInit();
    initPackageInfo();
  }

  void initPackageInfo() {
    PackageInfo.fromPlatform().then((value) {
      currentBuild(value.buildNumber);
      getVersion(currentBuild.toString());
    });
  }

  void getVersion(build) {
    try {
      isDataProcessing(true);
      UtilsProvider().getVersion(build).then((value) {
        // print(value.data.buildNumber);
        isDataProcessing(false);
        tips.clear();
        tips.add(value.data);
        if(value.data.updateAvailable == 1){
          Get.defaultDialog(
            title: "Perbarui Aplikasi",
            middleText: "Yuk, perbarui aplikasi kamu untuk menikmati fitur terbaru",
            onCancel: () => {},
            textCancel: "Nanti",
            onConfirm: () => launch("https://play.google.com/store/apps/details?id=id.gawe.gaweid2&hl=en&gl=US"),
            textConfirm: "Perbarui",
            backgroundColor: Colors.white,
            titleStyle: TextStyle(color: Colors.black54),
            middleTextStyle: TextStyle(color: Colors.black54),
          );
        }
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