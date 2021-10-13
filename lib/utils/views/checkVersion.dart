// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:gaweid2/utils/controllers/utilsController.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';


class CheckVersion extends StatelessWidget {
  final utilsC = Get.put(UtilsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (utilsC.isDataProcessing.value == true) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
         return utilsC.tips.first.updateAvailable.toString() == "1" ?
         Text("yok update"): Text("gausah update");
        }
      }),
    );
  }
}
