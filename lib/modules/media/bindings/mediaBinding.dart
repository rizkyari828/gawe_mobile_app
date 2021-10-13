import 'package:gaweid2/modules/media/controllers/mediaController.dart';
import 'package:get/get.dart';

class MediaBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MediaController());
  }
}