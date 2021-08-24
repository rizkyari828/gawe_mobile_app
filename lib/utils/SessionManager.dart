import 'package:shared_preferences/shared_preferences.dart';

abstract class RuleUtils {
  void savePreference(
      bool status,
      String name,
      String iduser,
      String id_employee,
      String email,
      String picture,
      String password,
      String profil_power,
      double latitude,
      double longitude);
  void refreshToken(String token);
  void session_register(bool status_register, email, no_hp, name);
  Future getPreference();
  Future getsession_register();
}

class SessionManager implements RuleUtils {
  String fullname,
      email,
      picture,
      iduser,
      password,
      level,
      token,
      id_employee,
      no_hp,
      name,
      profile_power;
  bool status, status_register;
  int iduser_register;
  double longitude, latitude;

  @override
  void savePreference(
      bool status,
      String name,
      String iduser,
      String id_employee,
      String email,
      String picture,
      String password,
      String profile_power,
      double latitude,
      double longitude) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("status", status);
    sharedPreferences.setString("name", name);
    sharedPreferences.setString("id_user", iduser);
    sharedPreferences.setString("id_employee", id_employee);
    sharedPreferences.setString("email", email);
    sharedPreferences.setString("picture", picture);
    sharedPreferences.setString("password", password);
    sharedPreferences.setString("profile_power", profile_power);
    sharedPreferences.setDouble("latitude", latitude);
    sharedPreferences.setDouble("longitude", longitude);
    sharedPreferences.commit();
  }

  @override
  Future getPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    status = sharedPreferences.getBool("status");
    fullname = sharedPreferences.get("name");
    iduser = sharedPreferences.get("iduser");
    id_employee = sharedPreferences.get("id_employee");
    email = sharedPreferences.get("email");
    picture = sharedPreferences.get("picture");
    password = sharedPreferences.get("password");
    profile_power = sharedPreferences.get("profile_power");
    latitude = sharedPreferences.get("latitude");
    longitude = sharedPreferences.get("longitude");
    sharedPreferences.commit();
    return fullname;
  }

  @override
  void refreshToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", token);
    sharedPreferences.commit();
  }

  @override
  void session_register(bool status_register, email, no_hp, name) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("status_register", status_register);

    sharedPreferences.setString("email", email);
    sharedPreferences.setString("no_hp", no_hp);
    sharedPreferences.setString("email", email);
    sharedPreferences.setString("name", name);
    sharedPreferences.commit();
  }

  @override
  Future getsession_register() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    status_register = sharedPreferences.getBool("status_register");
    email = sharedPreferences.get("email");
    no_hp = sharedPreferences.get("no_hp");
    name = sharedPreferences.get("name");
    sharedPreferences.commit();
    return name;
  }
}
