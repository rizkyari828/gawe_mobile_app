import 'package:gaweid2/modules/media/models/MediaModel.dart';
import 'package:gaweid2/modules/media/providers/mediaProvider.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class TipsController extends GetxController {
  SessionManager sessionManager = SessionManager();
  var tips = List<Media>.empty().obs;
  var isDataProcessing = false.obs;
  var globalName = "".obs,
      globalEmail = "".obs,
      globalLevel = "".obs,
      idUser = "".obs,
      globalid_employee = "".obs;
  var status = false.obs;
  var mystatus = false.obs;



  @override
  void onInit() async {
    super.onInit();
    // Fetch Data
    getPreferences();
    getTips();
  }

  void getPreferences() {
    sessionManager.getPreference().then((value) {
        mystatus(sessionManager.status);
        globalName(sessionManager.fullname);
        globalEmail(sessionManager.email);
        idUser(sessionManager.iduser);
        globalid_employee(sessionManager.id_employee);
    });
  }

  void getTips() {
    try {
      // print(idUser);
      // isMoreDataAvailable(false);
      isDataProcessing(true);
      MediaProvider().getTips(sessionManager.iduser).then((value) {
        isDataProcessing(false);
        tips.clear();
        tips.addAll(value.media);
      }, onError: (err) {
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