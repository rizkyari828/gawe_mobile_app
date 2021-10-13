import 'package:gaweid2/utils/SessionManager.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var globalName = "".obs,
      globalEmail = "".obs,
      globalLevel = "".obs,
      idUser = "".obs,
      globalid_employee = "".obs;
  var status = false.obs;
  var mystatus = false.obs;

  SessionManager sessionManager = SessionManager();

  @override
  void onInit() async {
    super.onInit();
    getPreferences();
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
}