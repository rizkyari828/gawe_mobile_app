import 'package:gaweid2/modules/media/models/MediaModel.dart';
import 'package:gaweid2/modules/media/providers/mediaProvider.dart';
import 'package:get/get.dart';
class MediaController extends GetxController with StateMixin<List<Media>>{
  List<Media> mediaData = [];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getData();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }


  void getData() {
    try {
      change(null, status: RxStatus.loading());
      MediaProvider().getNews().then((value) {
          mediaData.clear();
          mediaData.addAll(value.media);
          change(mediaData, status: RxStatus.success());
        }, onError: (err) {
        change(null, status: RxStatus.error(err.toString()));
      });
    } catch (exception) {
      change(
        null,
        status: RxStatus.error(exception.toString()),
      );
    }
  }

}