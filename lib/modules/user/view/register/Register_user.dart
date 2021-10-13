import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/constant/constant.dart';
import 'package:gaweid2/modules/user/controllers/registerController.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';

import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/user/view/Login.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

enum LoginStatus { not_login, Login }

class _RegisterState extends State<Register> {
  bool _isHidePassword = true;
  final registerC = Get.put(RegisterController());

  List dataSumber = [];
  String valsumber;
  var InSignIn = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  TextEditingController etEmail = TextEditingController();
  TextEditingController etName = TextEditingController();
  TextEditingController etPassword = TextEditingController();
  // TextEditingController etReferal = TextEditingController();
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

  SessionManager sessionManager = SessionManager();

  bool monVal = false;

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
      _formKey.currentState.save();
      if (etEmail.text.isEmpty ||
          etPassword.text.isEmpty ||
          etName.text.isEmpty ||
          etNo_hp.text.isEmpty ||
          valsumber == null) {
        Toast.show("Tidak Boleh Kosong", context,
            duration: 3, gravity: Toast.BOTTOM);
      } else {
        if (monVal == false) {
          Toast.show("Anda Belum Ceklis Pernyataan Gawe.id", context,
              duration: 3, gravity: Toast.TOP);
        } else {
          setState(() {
            InSignIn = true;
          });
          register();
        }
      }
    }
  }

  void sumber() async {
    final response =
        await http.get(NetworkConfig().baseUrl + "master_api/get_sumber");
    var listdata = jsonDecode(response.body);
    setState(() {
      dataSumber = listdata;
    });
  }

  void register() async {
    ModelRegister data = await network.register(
      etName.text.toString(),
      etEmail.text.toString(),
      etPassword.text.toString(),
      etNo_hp.text.toString(),
      valsumber,
      referal.toString(),
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
          .pushNamedAndRemoveUntil(DATADIRI1, (route) => false);

      Toast.show("Success", context, duration: 3, gravity: Toast.BOTTOM);
    } else if (data.status == 400) {
      //Navigator.of(_formKey.currentContext, rootNavigator: true).pop();

      setState(() {
        InSignIn = false;
      });

      Toast.show("Email Sudah Terdaftar", context,
          duration: 3, gravity: Toast.TOP);
    } else if (data.status == 404) {
      // Navigator.of(_formKey.currentContext, rootNavigator: true).pop();
      setState(() {
        InSignIn = false;
      });
      Toast.show("Akun Anda Belum Aktif", context,
          duration: 3, gravity: Toast.TOP);
    } else {
      print("gagal");
      setState(() {
        InSignIn = false;
      });
      Toast.show("Gagal", context, duration: 3, gravity: Toast.TOP);
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.height,
              height: 180,
              decoration: new BoxDecoration(color: mainColor),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 50.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'images/logo_polos.png',
                    height: MediaQuery.of(context).size.height / 8,
                    width: MediaQuery.of(context).size.width / 2.5,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              margin: const EdgeInsets.only(
                top: 180.0,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 10),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: TextFormField(
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                          keyboardType: TextInputType.text,
                          controller: etName,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
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
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text("Nama sesuai KTP", style: TextStyle(fontSize: 11, color: mainColor)),
                      ),
                      SizedBox(height: 10),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: TextFormField(
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
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
                            //labelText: "Email",
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
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                          keyboardType: TextInputType.number,
                          controller: etNo_hp,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            //labelText: "No Hp",
                            hintText: "No Handphone",
                          ),
                          validator: nameValidator,
                          // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                          onSaved: (value) {
                            hp = value;
                          },
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text("Jika tidak ada, bisa diisi nomor media chat lain", style: TextStyle(fontSize: 11, color: mainColor)),
                      ),
                      SizedBox(height: 12),
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.height,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: DropdownSearch<dynamic>(
                              searchBoxDecoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: mainColor),
                                ),
                              ),
                              dropdownSearchDecoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: mainColor),
                                ),
                              ),
                              items: registerC.referrals.map((item) {
                                return item['referral_code'];
                              }).toList(),
                              maxHeight: 300,
                              hint: "Referral Code",
                              onChanged: (value) async {
                                // dataCity = await network.getCity(value);
                                setState(() {
                                  referal = value.toString();
                                  // valCity = null;
                                });
                                //print(dataCity);
                              },
                              showSearchBox: true,

                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text("Pilih jika ada", style: TextStyle(fontSize: 11, color: mainColor)),
                      ),
                      // Card(
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(15.0)),
                      //   child: TextFormField(
                      //     style: TextStyle(fontSize: 16.0, color: Colors.black),
                      //     keyboardType: TextInputType.text,
                      //     controller: etReferal,
                      //     decoration: InputDecoration(
                      //       enabledBorder: UnderlineInputBorder(
                      //         borderSide: BorderSide(color: mainColor),
                      //         borderRadius: BorderRadius.circular(15),
                      //       ),
                      //       filled: true,
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(15),
                      //       ),
                      //       //labelText: "No Hp",
                      //       hintText: "Referral Code",
                      //     ),
                      //     // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                      //     onSaved: (value) {
                      //       referal = value;
                      //     },
                      //   ),
                      // ),

                      SizedBox(height: 10),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: TextFormField(
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
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            //labelText: "Password",
                            hintText: "Password ..",
                          ),
                          validator: nameValidator,
                          onSaved: (value) {
                            password1 = value;
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.height,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Padding(
                            padding: const EdgeInsets.only(left:8.0),
                            child: DropdownSearch<dynamic>(
                                searchBoxDecoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: mainColor),
                                  ),
                                ),
                                dropdownSearchDecoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: mainColor),
                                  ),
                                ),
                              items: dataSumber.map((item) {
                                return item['title'];
                              }).toList(),
                              maxHeight: 300,
                              hint: "Tau info Loker di Gawe dari mana?",
                              onChanged: (value) async {
                                // dataCity = await network.getCity(value);
                                setState(() {
                                  valsumber = value.toString();
                                  // valCity = null;
                                });
                                //print(dataCity);
                              },
                              showSearchBox: true,

                            ),
                          ),
                        ),
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
                        Text(
                            "Saya setuju terhadap aturan penggunaan \ndan kebijakan privasi Gawe.id",
                            style: TextStyle(color: Colors.black, fontSize: 14))
                      ]),
                      SizedBox(height: 16),
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: InSignIn
                            ? SpinKitFadingCircle(
                                color: Colors.red,
                              )
                            : RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                onPressed: () {
                                  checkEmailAndPassowrd();
                                },
                                color: mainColor,
                                child: Text(
                                  "Register",
                                  style: TextStyle(color: Colors.white),
                                ),
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
                              style: TextStyle(color: Colors.white, fontSize: 14),
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
//                          builder: (BuildContext context) => datadiri2()));
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
              ),

            )
          ],
        ),
      ),
    );
  }
}
