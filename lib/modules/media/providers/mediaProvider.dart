import 'package:gaweid2/modules/media/models/MediaModel.dart';
import 'package:get/get.dart';

class MediaProvider extends GetConnect {
  String url = 'https://gawe.id/api_apps/apps/';

  MediaProvider() {
    httpClient.baseUrl = url;
    httpClient.defaultContentType = 'application/json';
  }

  Future<MediaModel> getNews() async {
    try {
      final response = await get("news_new");
      if (response.status.hasError) {
        return Future.error(response.statusText);
      } else {
        return mediaModelFromJson(response.bodyString);
      }
    } catch (exception){
        return Future.error(exception.toString());
    }
  }

  Future<MediaModel> getTips(id) async {
    print(id);
    try {
      final response = await get("tips_new");
      if (response.status.hasError) {
        return Future.error(response.statusText);
      } else {
        return mediaModelFromJson(response.bodyString);
      }
    } catch (exception){
      return Future.error(exception.toString());
    }
  }
}