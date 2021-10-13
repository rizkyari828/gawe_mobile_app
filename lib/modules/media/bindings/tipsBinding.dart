import 'package:gaweid2/modules/media/controllers/tipsController.dart';
import 'package:get/get.dart';

class TipsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(TipsController());
  }
}