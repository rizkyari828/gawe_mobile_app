import 'package:flutter/material.dart';
import 'package:gaweid2/modules/user/models/ModelLogin.dart';
import 'package:gaweid2/modules/user/models/ModelUser.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/user/view/menu/UserDashboard.dart';
import 'package:gaweid2/modules/user/view/register/LupaPassword.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:gaweid2/utils/Validation.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

enum LoginStatus { not_login, Login }

class _LoginState extends State<Login> {
  bool _isHidePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  TextEditingController etEmail = TextEditingController();
  TextEditingController etPassword = TextEditingController();

  BaseEndPoint network = NetworkProvider();
  final _formKey = GlobalKey<FormState>();

  String name, email, password1, confrim_password;
  var globalName = "", globalEmail = "", globalLevel = "";
  LoginStatus _loginStatus = LoginStatus.not_login;
  var status = false;
//  var value;
  var mystatus;

  SessionManager sessionManager = SessionManager();

  String emailValidator(String value) {
    //Toast.show(value, context, duration: 3, gravity: Toast.BOTTOM);
    if (value.length == 0) {
      Toast.show("Email Tidak Boleh Kosong", context,
          duration: 3, gravity: Toast.BOTTOM);
      return "Email is Required";
    } else if (!value.contains('@')) {


      return "Email is Invalid";
    } else {
      return null;
    }
  }

  String nameValidator(String value) {
    if (value.length < 4) {
      return "name must be length 4";
    } else {
      return null;
    }
  }

  void checkEmailAndPassowrd() async {
    if (_formKey.currentState.validate()) {
      //JIKA TRUE
      _formKey.currentState.save(); //MAKA FUNGSI SAVE() DIJALANKAN

      if (etEmail.text.isEmpty || etPassword.text.isEmpty) {
        Toast.show("Email/Password Tidak Boleh Kosong", context,
            duration: 3, gravity: Toast.BOTTOM);
      } else {
        // Toast.show("Login", context, duration: 3, gravity: Toast.BOTTOM);
        //login();
        ModelLogin data = await network.login(
            etEmail.text.toString(), etPassword.text.toString());


        print("data{$data}");
        login();

//        if (data.status == 200) {
//
//          if(data.message == "Login_Success"){
//            //print(data.user.firstName);
//            setState(() {
//              status = true;
//              _loginStatus = LoginStatus.Login;
//              globalLevel = "1";
//              sessionManager.savePreference(
//                  status,
//                  data.user.firstName,
//                  data.userId,
//                  data.id_employee,
//                  data.user.email,
//                  data.user.picture,
//                  data.user.password);
//            });
//            Navigator.of(context).pushReplacement(new MaterialPageRoute(
//                builder: (BuildContext context) => UserDashboard()));
//          }else{
//            Toast.show("Sandi Salah", context, duration: 10, gravity: Toast.BOTTOM);
//          }
//
//
//          print("tes${_loginStatus}");
//        } else {
//          Toast.show("Sandi Salah", context, duration: 10, gravity: Toast.BOTTOM);
//        }
      }
    };

  }

  void login() async {
    ModelLogin data = await network.login(
        etEmail.text.toString(), etPassword.text.toString());
    //print(data.status);
//    print(data.level);
//    print(data.user.name);

    if (data.status == 200) {
      //print(data.user.firstName);
      setState(() {
        status = true;
        _loginStatus = LoginStatus.Login;
        globalLevel = "1";
        sessionManager.savePreference(
            status,
            data.firstName,
            data.userId,
            data.idEmployee,
            data.email,
            data.picture,
            data.password,
        data.profile_power,
        data.latitude,
        data.longitude);
      });
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) => UserDashboard()));
      print("tes${_loginStatus}");
    } else if (data.status == 404) {
      Toast.show("Email/Sandi Salah", context, duration: 3, gravity: Toast.BOTTOM);
    }else if (data.status == 405) {
      Toast.show("Akun Anda Belum Aktif", context, duration: 3, gravity: Toast.BOTTOM);
    }


    else {
      print("gagal");
      Toast.show("Gagal", context, duration: 3, gravity: Toast.BOTTOM);
    }
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setBool("status", false);
      preferences.clear();
      preferences.commit();
      _loginStatus = LoginStatus.not_login;
    });
  }

  void getPreferences() async {
    await sessionManager.getPreference().then((value) {
      setState(() {
        mystatus = sessionManager.status;
        globalName = sessionManager.fullname;
        globalEmail = sessionManager.email;
        globalLevel = sessionManager.level;
        _loginStatus =
        mystatus == true ? LoginStatus.Login : LoginStatus.not_login;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPreferences();
    //signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FlatButton(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(new MaterialPageRoute(
                      builder: (BuildContext context) => UserDashboard()));
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32),
            child: Center(
                child: Text(
                  "Login Your Account",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black, blurRadius: 4),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 16),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: etEmail,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Email",
                          hintText: "Email tes",
                        ),
                        validator: emailValidator,
                        // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                        onSaved: (value) {
                          email = value;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        obscureText: _isHidePassword,
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        //  keyboardType: TextInputType.visiblePassword,
                        controller: etPassword,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              _togglePasswordVisibility();
                            },
                            child: Icon(
                              _isHidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: _isHidePassword
                                  ? Colors.grey
                                  : Colors.blue,
                            ),
                          ),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Password",
                          hintText: "Password ..",
                        ),
                        validator: nameValidator,
                        onSaved: (value) {
                          password1 = value;
                        },
                      ),
                      SizedBox(height: 16),
                      SizedBox(height: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onPressed: () {
                            checkEmailAndPassowrd();

                          },
                          color: Colors.green,
                          child: Text("Login",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {

                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Already have an account ?",
                              style: TextStyle(color: Colors.black),
                            ),
                            Text("Sign", style: TextStyle(color: Colors.indigo))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
