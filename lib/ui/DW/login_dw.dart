import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/constant/constant.dart';
import 'package:gaweid2/modules/user/models/ModelLogin.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';

import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/ui/DW/register_dw.dart';

import 'package:gaweid2/modules/user/view/menu/UserDashboard.dart';
import 'package:gaweid2/modules/user/view/register/Register_user.dart';
import 'package:gaweid2/modules/user/view/register/LupaPassword.dart';

import 'package:gaweid2/utils/SessionManager.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Login_Dw extends StatefulWidget {
  @override
  _LoginDWState createState() => _LoginDWState();
}

enum LoginStatus { not_login, Login }

class _LoginDWState extends State<Login_Dw> {
  bool _isHidePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  final loading = false;
  var InSignIn = false;

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
        // loading;
        //Dialogs.showLoadingDialog(context, _formKey); //invoking login

        setState(() {
          InSignIn = true;
        });
        login();
      }
    }
    ;
  }

  String tokenplayerId2;
  void playerid(String email) async{
    // var status = await OneSignal.shared.getPermissionSubscriptionState();

    // var tokenplayerId = status.subscriptionStatus.userId;
    // setState(() {
    //   tokenplayerId2 = tokenplayerId;

    // });

//    await OneSignal.shared.postNotification(OSCreateNotification(
//        playerIds: [tokenplayerId],
//        content: "Selamat Pagi Pandu",
//        heading: "Terimakasih Telah Login di Gawe.id",
////        buttons: [
////          OSActionButton(text: "test1", id: "id1"),
////          OSActionButton(text: "test2", id: "id2")
////        ]
//    ));

    // await OneSignal.shared.postNotification(OSCreateNotification.silentNotification(
    //     playerIds: [tokenplayerId],
    //     additionalData: {
    //       'test' : 'value',
    //     }
    // ));

    // ModelRegister data = await network.player_id(email, tokenplayerId);
    // print("tokenplayer${tokenplayerId}");
    // Toast.show(tokenplayerId, context, duration: 3, gravity: Toast.TOP);
  }

  void login() async {
    // loading ;
    ModelLogin data = await network.login(
        etEmail.text.toString(), etPassword.text.toString());
    //print(data.status);
//    print(data.level);
//    print(data.user.name);

    if (data.status == 200) {
      //print(data.user.firstName);

//        if(int.parse(data.profil_power) <= 60){
//
//          Navigator.of(context).pushReplacement(new MaterialPageRoute(
//              builder: (BuildContext context) => datadiri1()));
//
//
//        }else{

      setState(() {
        status = true;
        _loginStatus = LoginStatus.Login;
        globalLevel = "1";
        sessionManager.savePreference(status, data.firstName, data.userId,
            data.idEmployee, data.email, data.picture, data.password,data.profile_power, data.latitude, data.longitude);
      });
//          Navigator.of(context).pushReplacement(new MaterialPageRoute(
//              builder: (BuildContext context) => UserDashboard()));
      // Navigator.of(context).pushReplacementNamed(HOMEPAGE);

      playerid(data.email);

      Navigator.of(context)
          .pushNamedAndRemoveUntil(HOMEPAGE, (route) => false);


      //print("tes${_loginStatus}");

//        }



    } else if (data.status == 404) {
      Navigator.of(_formKey.currentContext, rootNavigator: true).pop();
      Toast.show("Email/Sandi Salah", context,
          duration: 3, gravity: Toast.BOTTOM);
    } else if (data.status == 405) {
      Navigator.of(_formKey.currentContext, rootNavigator: true).pop();

      Toast.show("Akun Anda Belum Aktif", context,
          duration: 3, gravity: Toast.BOTTOM);
    } else {
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
      backgroundColor: Color(0xFF039ec7),
      body: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FlatButton(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(new MaterialPageRoute(
                      builder: (BuildContext context) => UserDashboard()));
                },
              ),
            ],
          ),
          Column(
            // mainAxisAlignment: MainAxisAlignment.botto,
            children: <Widget>[

              Image.asset(
                'images/slider/bckg2.png',
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),

              //SizedBox(height: 220,),
              Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 16),
                          TextFormField(

                            style: TextStyle(fontSize: 16.0, color: Colors.black),
                            keyboardType: TextInputType.emailAddress,
                            controller: etEmail,
                            decoration: InputDecoration(
                              contentPadding:
                              const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              // labelText: "Email",
                              hintText: "Email",
                            ),
                            validator: emailValidator,
                            // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                            onSaved: (value) {
                              email = value;
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            style: TextStyle(fontSize: 16.0, color: Colors.black),
                            obscureText: _isHidePassword,
                            autofocus: false,
                            keyboardType: TextInputType.text,
                            //  keyboardType: TextInputType.visiblePassword,
                            controller: etPassword,
                            decoration: InputDecoration(
                              contentPadding:
                              const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  _togglePasswordVisibility();
                                },
                                child: Icon(
                                  _isHidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: _isHidePassword ? Colors.grey : Colors.blue,
                                ),
                              ),
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              //labelText: "Password",
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
                            child: InSignIn
                                ? SpinKitFadingCircle(
                              color: Colors.redAccent,
                            )
                                : RaisedButton(
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
                          Container(
                            child: FlatButton(
                              onPressed: () {
                                Navigator.of(context).push(new MaterialPageRoute(
                                    builder: (BuildContext context) => Register_DW()));
                              },
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "Belum Punya Akun Daily Worker ?  Registrasi Sekarang",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (BuildContext context) => LupaPassword()));
                            },
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Lupa Password",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16,),
                                Text('V.1.0'),
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
        ],
      ),
    );
  }
}

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please Wait....",
                          style: TextStyle(color: Colors.blueAccent),
                        )
                      ]),
                    )
                  ]));
        });
  }
}
