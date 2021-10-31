import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/constant/constant.dart';
import 'package:gaweid2/modules/user/models/ModelLogin.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/modules/user/view/register/aktfikanAkun.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/user/view/menu/UserDashboard.dart';
import 'package:gaweid2/modules/user/view/register/Register_user.dart';
import 'package:gaweid2/modules/user/view/register/LupaPassword.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

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

  final loading = false;
  var InSignIn = false;

  TextEditingController etEmail = TextEditingController();
  TextEditingController etPassword = TextEditingController();

  BaseEndPoint network = NetworkProvider();
  final _formKey = GlobalKey<FormState>();

  String name, email, password1, confrim_password;
  var globalName = "",
      globalEmail = "",
      globalLevel = "",
      globalid_employee = "";
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
      return "Password must be length 4";
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

        setState(() {
          InSignIn = true;
        });

//        ModelLogin data = await network.login(
//            etEmail.text.toString(), etPassword.text.toString());
//        print("data{$data}");
        // loading;


        //Dialogs.showLoadingDialog(context, _formKey); //invoking login
        login();

        //playerid(etEmail.text.toString());
        // _handleSendNotification();
      }
    }
  }

  // void _handleSendNotification() async {
  //   var status = await OneSignal.shared.getPermissionSubscriptionState();

  //   var playerId = status.subscriptionStatus.userId;

  //   var imgUrlString =
  //       "http://cdn1-www.dogtime.com/assets/uploads/gallery/30-impossibly-cute-puppies/impossibly-cute-puppy-2.jpg";

  //   var notification = OSCreateNotification(
  //       playerIds: [playerId],
  //       content: "this is a test from OneSignal's Flutter SDK",
  //       heading: "Test Notification",
  //       iosAttachments: {"id1": imgUrlString},
  //       bigPicture: imgUrlString,
  //       buttons: [
  //         OSActionButton(text: "test1", id: "id1"),
  //         OSActionButton(text: "test2", id: "id2")
  //       ]);

  //   var response = await OneSignal.shared.postNotification(notification);
  //   Toast.show("${response}", context, duration: 3, gravity: Toast.TOP);

  //   this.setState(() {
  //     Toast.show("${response}", context, duration: 3, gravity: Toast.TOP);
  //   });
  // }


  String tokenplayerId2;
  String playerID = "";
  void playeridSubmit(String email, String playerId) async {
    print("Data ${playerID}");
    final response =
    await http.post(NetworkConfig().baseUrl + "apps/save_playerId", body: {
      'email': email,
      'player_id':playerId
    });

    final jsondata = jsonDecode(response.body);
    ModelRegister listData = ModelRegister.fromJson(jsondata);

    // print("registrasi${jsondata}");

    //Toast.show("weas", context, duration: 3, gravity: Toast.TOP);
    // var status = await OneSignal.shared.getPermissionSubscriptionState();
    //Toast.show("status${status}", context, duration: 3, gravity: Toast.TOP);

    // var tokenplayerId = status.subscriptionStatus.userId;


    // setState(() {
    //   tokenplayerId2 = tokenplayerId;
    // });

    // await OneSignal.shared
    //     .postNotification(OSCreateNotification.silentNotification(playerIds: [
    //   tokenplayerId
    // ], additionalData: {
    //   'test': 'value',
    // }));

    // print("tokenplayer${tokenplayerId}");
  }

  void login() async {
    // loading ;

    ModelLogin data = await network.login(
        etEmail.text.toString(), etPassword.text.toString());
    // print(data.latitude);
//    print(data.level);
//    print(data.user.name);

    if (data.status == 200) {
//      Toast.show(data.profile_power, context,
//          duration: 3, gravity: Toast.BOTTOM);
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


      playeridSubmit(data.email, playerID);
     // Toast.show(tokenplayerId2, context, duration: 3, gravity: Toast.TOP);
      Navigator.of(context).pushNamedAndRemoveUntil(HOMEPAGE, (route) => false);
    } else if (data.status == 404) {
      // Navigator.of(_formKey.currentContext, rootNavigator: true).pop();
      setState(() {
        InSignIn = false;
      });

      Toast.show("Email/Password salah", context, duration: 3, gravity: Toast.TOP);
    } else if (data.status == 405) {
      Navigator.of(_formKey.currentContext, rootNavigator: true).pop();

      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) =>
              aktifkanAkun(email: etEmail.text.toString())));
    } else {
      print("gagal");
      Toast.show("Gagal", context, duration: 3, gravity: Toast.TOP);
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
        globalid_employee = sessionManager.id_employee;
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
    // OneSignal.shared.getDeviceState().then((deviceState) {
    //   setState(() {
    //     playerID = deviceState.userId;
    //   });
    //   print("DeviceState: ${deviceState.userId}");
    // });
    //signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFF039ec7),
      body: ListView(
        children: [
          Stack(
            // mainAxisAlignment: MainAxisAlignment.botto,
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
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => UserDashboard()));
                    },
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.height,
                height: 280,
                decoration: new BoxDecoration(
                    color: mainColor
                ),
              ),
              // Image.asset(
              //   "images/slider/bckg_akun.png",
              //   height: MediaQuery.of(context).size.height / 4,
              //   width: MediaQuery.of(context).size.width,
              //   fit: BoxFit.cover,
              // ),
              //SizedBox(height: 220,),
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Container(
                  height: 100,
                  child: Center(
                    child: Image.asset(
                      'images/logo_polos.png',
                      height: MediaQuery.of(context).size.height / 7,
                      width: MediaQuery.of(context).size.width/2.5,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 200.0,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 16),
                          Text(' Hallo, \n Selamat datang kembali', style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w300,
                          ),),
                          SizedBox(height: 16),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: TextFormField(
                              style:
                                  TextStyle(fontSize: 16.0, color: Colors.black),
                              keyboardType: TextInputType.emailAddress,
                              controller: etEmail,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: mainColor),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
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
                          ),
                          SizedBox(height: 10),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: TextFormField(
                              style:
                                  TextStyle(fontSize: 16.0, color: Colors.black),
                              obscureText: _isHidePassword,
                              autofocus: false,
                              keyboardType: TextInputType.text,
                              //  keyboardType: TextInputType.visiblePassword,
                              controller: etPassword,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: mainColor),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                filled: true,
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
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                //labelText: "Password",
                                hintText: "Password",
                              ),
                              validator: nameValidator,
                              onSaved: (value) {
                                password1 = value;
                              },
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).push(new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LupaPassword()));
                            },
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Lupa password",
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400,),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: InSignIn
                                ? Container(child: Center(child: CircularProgressIndicator()))
                                : MaterialButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    onPressed: () {
                                      checkEmailAndPassowrd();
                                    },
                                    color: mainColor,
                                    child: Text("Login",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Text(
                              "Belum punya akun ?",
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400,),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Register()));
                              },
                              color: mainColor,
                              child: Text("Daftar",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  // borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
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
