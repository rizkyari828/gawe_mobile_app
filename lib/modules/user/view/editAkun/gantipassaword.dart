import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:toast/toast.dart';

class Gantipassword extends StatefulWidget {
  @override
  _GantipasswordState createState() => _GantipasswordState();
}

class _GantipasswordState extends State<Gantipassword> {
  bool _isHidePassword = true;
  var InSignIn = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  String name, email, password1, confrim_password;

  TextEditingController etPasswordlama = TextEditingController();
  TextEditingController etPasswordbaru = TextEditingController();
  TextEditingController etPasswordConfrim = TextEditingController();

  String confirmValidator(String value) {
    _formKey.currentState.save();
    print("myPassword" + password1);
    if (value == password1) {
      print("success $value $password1");
      return null;
    } else {
      print("gagal $value $password1");

      if (value.length == 0) {
        return "Password must be more 0";
      } else {
        return "Confirm Password not Same With Password";
      }
    }
  }

  String namevalidator(String value) {
    if (value.length < 4) {
      return "must be length 6";
    } else {
      return null;
    }
  }

  BaseEndPoint network = NetworkProvider();

  var globalName = "", globalEmail = "", globalLevel = "";
  var status = false;
  var id_user, globalid_employee;
//  var value;
  var mystatus;

  SessionManager sessionManager = SessionManager();
  void getPreferences() async {
    await sessionManager.getPreference().then((value) {
      setState(() {
        mystatus = sessionManager.status;
        globalName = sessionManager.fullname;
        globalEmail = sessionManager.email;
        globalLevel = sessionManager.level;
        id_user = sessionManager.iduser;
        globalid_employee = sessionManager.id_employee;
        print("globalid_employee $globalid_employee");
        //_loginStatus = mystatus == true ? LoginStatus.Login : LoginStatus.not_login;
      });
    });
  }

  void validasi() async {


      if (etPasswordConfrim.text.toString() != etPasswordbaru.text.toString()) {
        Toast.show("Password Baru Tidak Sama", context,
            duration: 3, gravity: Toast.TOP);
      } else {
        if (_formKey.currentState.validate()) {
          //JIKA TRUE
          _formKey.currentState.save(); //MAKA FUNGSI SAVE() DIJALANKAN

          setState(() {
            InSignIn = true;
          });

          ModelRegister data = await network.gantipassword(globalEmail,
              etPasswordlama.text.toString(), etPasswordbaru.text.toString());

          if (data.status == 200) {
            Toast.show("Password Berhasil Di Ubah", context,
                duration: 3, gravity: Toast.TOP);
            Navigator.pop(context);
          } else if (data.status == 404) {
            setState(() {
              InSignIn = false;
            });

            Toast.show("Password Lama Anda Salah", context,
                duration: 3, gravity: Toast.TOP);
          }
        }
        ;
      }


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPreferences();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gawe.id'),
        backgroundColor: mainColor,
      ),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 16),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: etPasswordlama,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Password Lama",
                        hintText: "Password Lama",
                      ),
                      validator: namevalidator,
                      // validator: (value) => value.length < 6 ? 'Password too short.' : null,
//            onSaved: (value) {
//              nik = value;
//            },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: etPasswordbaru,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Password Baru",
                        hintText: "Password Baru",
                      ),
                      validator: namevalidator,
                      onSaved: (value) {
                        password1 = value;
                      },
                      //validator: nikvalidator,
                      // validator: (value) => value.length < 6 ? 'Password too short.' : null,
//            onSaved: (value) {
//              nik = value;
//            },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      obscureText: _isHidePassword,
                      autofocus: false,
                      keyboardType: TextInputType.text,
                      //  keyboardType: TextInputType.visiblePassword,
                      controller: etPasswordConfrim,
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
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Password",
                        hintText: "Password ..",
                      ),
                      // validator: nameValidator,
                      validator: namevalidator,
                      onSaved: (value) {
                        confrim_password = value;
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
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
                              color: Colors.green,
                              child: Text("Simpan",
                                  style: TextStyle(color: Colors.white)),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
