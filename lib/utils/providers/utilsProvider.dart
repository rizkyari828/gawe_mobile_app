import 'package:gaweid2/utils/models/versionModel.dart';
import 'package:get/get.dart';

class UtilsProvider extends GetConnect {
  String url = 'https://gawe.id/api_apps/apps/';

  UtilsProvider() {
    httpClient.baseUrl = url;
    httpClient.defaultContentType = 'application/json';
  }

  Future<VersionModel> getVersion(build) async {
    try {
      final response = await get('check_version/?build='+build);
      if (response.status.hasError) {
        return Future.error(response.statusText);
      } else {
        print(response.bodyString);
        return versionModelFromJson(response.bodyString);
      }
    } catch (exception){
      return Future.error(exception.toString());
    }
  }
}