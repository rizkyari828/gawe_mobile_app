import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/learning/views/modul.dart';
import 'package:gaweid2/modules/learning/views/penempatan.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:toast/toast.dart';

class kodelearning extends StatefulWidget {
  @override
  _kodelearningState createState() => _kodelearningState();
}

class _kodelearningState extends State<kodelearning> {
  BaseEndPoint network = NetworkProvider();

  TextEditingController etreferal = TextEditingController();
  TextEditingController etkode_materi = TextEditingController();

  String name, email, password1, confrim_password;
  var globalName = "", globalEmail = "", globalLevel = "";
  var status = false;
  var id_user, globalid_employee;
//  var value;
  var mystatus;
  var InSignIn = false;

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

  final _formKey = GlobalKey<FormState>();

  String nikvalidator(String value) {
    if (value.length < 4) {
      return "must be length 4";
    } else {
      return null;
    }
  }

  void validasi() {
    if (_formKey.currentState.validate()) {
      //JIKA TRUE
      _formKey.currentState.save();

      setState(() {
        InSignIn = true;
      });

      regis_kode_learning();
    } else {


    }
  }

  void regis_kode_learning() async {
    ModelRegister data = await network.regist_kode_learning(
        globalEmail, etkode_materi.text.toString(), etreferal.text.toString());

    Toast.show("${data.status}", context, duration: 3, gravity: Toast.TOP);

    if (data.status == 200) {
      setState(() {
        InSignIn = false;
      });
      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => penempatan(
          kodelearning: etkode_materi.text.toString(),
        ),
      ));

      Toast.show("Success", context, duration: 3, gravity: Toast.TOP);
    } else if (data.status == 201) {
      setState(() {
        InSignIn = false;
      });
      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => UI_Modul(
          kodelearning: etkode_materi.text.toString(),
        ),
      ));

      Toast.show("Success", context, duration: 3, gravity: Toast.TOP);
    } else if (data.status == 202) {
      setState(() {
        InSignIn = false;
      });
      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => UI_Modul(
          kodelearning: etkode_materi.text.toString(),
        ),
      ));

      Toast.show("Success", context, duration: 3, gravity: Toast.TOP);
    } else if (data.status == 404) {
      setState(() {
        InSignIn = false;
      });
      Toast.show("Kode Learning  atau Materi Learning Tidak Ditemukan", context,
          duration: 3, gravity: Toast.TOP);
    } else {
      setState(() {
        InSignIn = false;
      });
      print("gagal");
      Toast.show("Gagal", context, duration: 3, gravity: Toast.BOTTOM);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Learning"),
        backgroundColor: mainColor,
      ),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'images/menu/elearning.png',
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width / 2,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: etreferal,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "Kode Referal",
                            hintText: "Kode Referal",
                          ),
                          validator: nikvalidator,
                          // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                          onSaved: (value) {
                            // nik = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: etkode_materi,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "Kode Materi",
                            hintText: "Kode Materi",
                          ),
                          validator: nikvalidator,
                          // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                          onSaved: (value) {
                            // nik = value;
                          },
                        ),
                      ),
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
                                  validasi();
                                },
                                color: Colors.green,
                                child: Text("Masuk Learning",
                                    style: TextStyle(color: Colors.white)),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
