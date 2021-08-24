import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/user/view/Login.dart';

import 'package:gaweid2/modules/user/view/menu/UserDashboard.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:toast/toast.dart';

class LupaPassword extends StatefulWidget {
  @override
  _LupaPasswordState createState() => _LupaPasswordState();
}

class _LupaPasswordState extends State<LupaPassword> {
  TextEditingController etEmail = TextEditingController();
  TextEditingController etPassword = TextEditingController();

  BaseEndPoint network = NetworkProvider();
  final _formKey = GlobalKey<FormState>();

  String name, email, password1, confrim_password;
  var globalName = "", globalEmail = "", globalLevel = "";

  var InSignIn = false;
  var status = false;
//  var value;
  var mystatus;

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

  void validasi() async {
    if (_formKey.currentState.validate()) {
      //JIKA TRUE
      _formKey.currentState.save(); //MAKA FUNGSI SAVE() DIJALANKAN

      if (etEmail.text.isEmpty) {
        Toast.show("Email/Password Tidak Boleh Kosong", context,
            duration: 3, gravity: Toast.BOTTOM);
      } else {
        setState(() {
          InSignIn = true;
        });

        ModelRegister data =
            await network.lupakatasandi(etEmail.text.toString());

        if (data.status == 200) {

          Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => Login(),
          ));

          Toast.show("Check Email Anda", context,
              duration: 3, gravity: Toast.TOP);
        } else if (data.status == 404) {
          setState(() {
            InSignIn = false;
          });

          Toast.show("Email Anda Tidak Terdaftar", context,
              duration: 3, gravity: Toast.TOP);
        }
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Image.asset(
            'images/kategori/LowonganTersimpan.png',
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
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
                      hintText: "Email",
                    ),
                    validator: emailValidator,
                    // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                    onSaved: (value) {
                      email = value;
                    },
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: InSignIn
                        ? SpinKitFadingCircle(
                            color: Colors.blue,
                          )
                        : RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            onPressed: () {
                              validasi();
                            },
                            color: mainColor,
                            child: Text("Reset Password",
                                style: TextStyle(color: Colors.white)),
                          ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
