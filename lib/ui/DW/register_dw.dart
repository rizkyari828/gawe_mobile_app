import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/constant/constant.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';

import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/ui/DW/datadiri1_dw.dart';
import 'package:gaweid2/ui/DW/datadiri2_dw.dart';
import 'package:gaweid2/modules/user/view/Login.dart';
import 'package:gaweid2/modules/user/view/menu/UserDashboard.dart';
import 'package:gaweid2/modules/user/view/register/datadiri/datadiri1.dart';
import 'package:gaweid2/modules/user/view/register/datadiri/datadiri2.dart';
import 'package:gaweid2/modules/user/view/register/datadiri/datadiri3.dart';
import 'package:gaweid2/modules/user/view/register/datadiri/datadiri4.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class Register_DW extends StatefulWidget {
  @override
  _Register_DWState createState() => _Register_DWState();
}

enum LoginStatus { not_login, Login }

class _Register_DWState extends State<Register_DW> {
  bool _isHidePassword = true;

  List dataSumber = [];
  String valsumber;
  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  var InSignIn = false;
  TextEditingController etEmail = TextEditingController();
  TextEditingController etName = TextEditingController();
  TextEditingController etPassword = TextEditingController();
  TextEditingController etReferal = TextEditingController();
  TextEditingController etNo_hp = TextEditingController();

  BaseEndPoint network = NetworkProvider();
  final _formKey = GlobalKey<FormState>();

  String name, referal, hp, email, password1, confrim_password;
  var globalName = "", globalEmail = "", globalLevel = "";
  LoginStatus _loginStatus = LoginStatus.not_login;
  var status = false;
  var status_register = false;
//  var value;
  var mystatus;
  bool monVal = false;

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

  void checkEmailAndPassowrd() {
    if (_formKey.currentState.validate()) {
      //JIKA TRUE
      _formKey.currentState.save(); //MAKA FUNGSI SAVE() DIJALANKAN

//       if(valsumber==null){
//         Toast.show("Email/Password Tidak Boleh Kosong", context,
//          duration: 3, gravity: Toast.BOTTOM);
//       }else{
//         print(valsumber);
//       }



      if (etEmail.text.isEmpty ||
          etPassword.text.isEmpty ||
          etName.text.isEmpty || etNo_hp.text.isEmpty ||
          valsumber == null) {
        Toast.show("Tidak Boleh Kosong", context,
            duration: 3, gravity: Toast.BOTTOM);
      } else {
        // Toast.show("Login", context, duration: 3, gravity: Toast.BOTTOM);
        //login();

        //print("data{$data}");
        //Dialogs.showLoadingDialog(context, _formKey); //invoking login

        if (monVal == false) {

          Toast.show("Anda Belum Ceklis Pernyataan Gawe.id", context,
              duration: 3, gravity: Toast.TOP);
//          setState(() {
//            monVal = true;
//          });
        }else{
          setState(() {
            InSignIn = true;
          });
          register();
        }


      }
    }
    ;
  }

  void sumber() async {
//    dataProvince = await network.getProvince();
    final response =
    await http.get(NetworkConfig().baseUrl + "master_api/get_sumber");
    var listdata = jsonDecode(response.body);
    setState(() {
      dataSumber = listdata;
    });

    print("data : $dataSumber");
  }

  void register() async {
    print("nama${etName.text.toString()}");
    print("email${etName.text.toString()}");
    print("password${etName.text.toString()}");
    print("no_hp${etNo_hp.text.toString()}");
    print("sumber${valsumber}");

    ModelRegister data = await network.register(
      etName.text.toString(),
      etEmail.text.toString(),
      etPassword.text.toString(),
      etNo_hp.text.toString(),
      valsumber,
      etReferal,
    );

    Toast.show("${data.status}", context, duration: 3, gravity: Toast.BOTTOM);

    if (data.status == 200) {
      setState(() {
        status_register = true;
        _loginStatus = LoginStatus.Login;
        globalLevel = "1";
        sessionManager.session_register(status_register, email, hp, name);
      });

      Navigator.of(context)
          .pushNamedAndRemoveUntil(DATADIRI1_DW, (route) => false);

//      Navigator.of(context).push(new MaterialPageRoute(
//        builder: (BuildContext context) => datadiri1_dw(),
//      ));

//      Navigator.of(context)
//          .pushNamedAndRemoveUntil(DATADIRI1_DW, (route) => false);

      Toast.show("Success", context, duration: 3, gravity: Toast.BOTTOM);
    } else if (data.status == 400) {
      Navigator.of(_formKey.currentContext, rootNavigator: true).pop();
      Toast.show("Email Sudah Terdaftar", context,
          duration: 3, gravity: Toast.BOTTOM);
    } else if (data.status == 404) {
      Navigator.of(_formKey.currentContext, rootNavigator: true).pop();
      Toast.show("Akun Anda Belum Aktif", context,
          duration: 3, gravity: Toast.BOTTOM);
    } else {
      print("gagal");
      Toast.show("Gagal", context, duration: 3, gravity: Toast.BOTTOM);
    }
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
    sumber();
    //signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buat Akun"),
        backgroundColor: Color(0xFF005b7f),
      ),
      backgroundColor: Color(0xFF039ec7),
      body: ListView(
        children: <Widget>[
//          Row(
//            mainAxisAlignment: MainAxisAlignment.start,
//            children: <Widget>[
//              FlatButton(
//                child: Icon(
//                  Icons.arrow_back,
//                  color: Colors.black,
//                ),
//                onPressed: () {
//                  Navigator.of(context).pushReplacement(new MaterialPageRoute(
//                      builder: (BuildContext context) => UserDashboard()));
//                },
//              ),
//            ],
//          ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Nama Sesuai KTP",style: TextStyle(color: Colors.white,fontSize: 14)),
                  SizedBox(height: 16),
                  TextFormField(
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                    keyboardType: TextInputType.text,
                    controller: etName,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
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
                      // labelText: "Nama Lengkap",
                      hintText: "Nama Lengkap",
                    ),
                    validator: nameValidator,
                    // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                    onSaved: (value) {
                      name = value;
                    },
                  ),
                  SizedBox(height: 12),

                  SizedBox(height: 16),
                  TextFormField(
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                    keyboardType: TextInputType.emailAddress,
                    controller: etEmail,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
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
                      //labelText: "Email",
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
                    keyboardType: TextInputType.number,
                    controller: etNo_hp,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
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
                      //labelText: "No Hp",
                      hintText: "No Hp",
                    ),
                    validator: nameValidator,
                    // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                    onSaved: (value) {
                      hp = value;
                    },
                  ),
//                  SizedBox(height: 16),
//                  TextFormField(
//                    keyboardType: TextInputType.text,
//                    controller: etReferal,
//                    decoration: InputDecoration(
//                      border: OutlineInputBorder(
//                        borderRadius: BorderRadius.circular(10),
//                      ),
//                      labelText: "Referral Code",
//                      hintText: "Referral Code",
//                    ),
//                    validator: emailValidator,
//                    // validator: (value) => value.length < 6 ? 'Password too short.' : null,
//                    onSaved: (value) {
//                      referal = value;
//                    },
//                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 11,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.7),
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                          value: valsumber,
                          //value: valPendidikan == null ? valPendidikan : buildingTypes.where( (i) => i.name == valPendidikan.name).first as BuildingType,
                          hint: Text("Pilih Sumber"),
                          items: dataSumber.map((item) {
                            return DropdownMenuItem(
                              child: Text(item['title']),
                              value: item['title'],
                            );
                          }).toList(),
                          onChanged: (value) async {
                            // dataCity = await network.getCity(value);
                            setState(() {
                              valsumber = value;
                              // valCity = null;
                            });
                            //print(dataCity);
                          },
                        ),
                      ),
                    ),
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
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
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
                      labelText: "Password",
                      hintText: "Password ..",
                    ),
                    validator: nameValidator,
                    onSaved: (value) {
                      password1 = value;
                    },
                  ),
                  SizedBox(height: 12),
                  Row(children: [
                    Checkbox(
                      value: monVal,
                      onChanged: (bool value) {
                        setState(() {
                          monVal = value;
                        });
                      },
                    ),
                    Text("Saya Setuju terhadap aturan Penggunaan \n dan kebijakan privasi Gawe.id",style: TextStyle(color: Colors.white,fontSize: 14))]),
                  SizedBox(height: 16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: InSignIn
                        ? SpinKitFadingCircle(
                      color: Colors.red,
                    )
                        : RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onPressed: () {
                        checkEmailAndPassowrd();
                      },
                      color: Colors.green,
                      child: Text("Register",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => Login()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Sudah Punya Akun",
                          style: TextStyle(color: Colors.white,fontSize: 14),
                        ),
                      ],
                    ),
                  ),

//                  FlatButton(
//                    child: Text("datadiri1"),
//                    onPressed: () {
//                      Navigator.of(context).push(new MaterialPageRoute(
//                          builder: (BuildContext context) => datadiri1()));
//                    },
//                  ),
//                  FlatButton(
//                    child: Text("datadiri2"),
//                    onPressed: () {
//                      Navigator.of(context).push(new MaterialPageRoute(
//                          builder: (BuildContext context) => datadiri2_dw()));
//                    },
//                  ),
//
//                  FlatButton(
//                    child: Text("datadiri3"),
//                    onPressed: () {
//                      Navigator.of(context).push(new MaterialPageRoute(
//                          builder: (BuildContext context) => datadiri3()));
//                    },
//                  ),
//
//                  FlatButton(
//                    child: Text("datadiri4"),
//                    onPressed: () {
//                      Navigator.of(context).push(new MaterialPageRoute(
//                          builder: (BuildContext context) => datadiri4()));
//                    },
//                  ),
                ],
              ),
            ),
          )
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
