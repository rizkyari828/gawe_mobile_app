import 'dart:convert';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';

import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/user/view/menu/UserDashboard.dart';
import 'package:gaweid2/modules/user/view/register/datadiri/datadiri1.dart';
import 'package:gaweid2/modules/user/view/register/datadiri/datadiri3.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:toast/toast.dart';

class datadiri2 extends StatefulWidget {
  @override
  _datadiri2State createState() => _datadiri2State();
}

class _datadiri2State extends State<datadiri2> {

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Apakah Anda Yakin ?'),
        content: Text('Apakah Anda Yakin \n Ingin Kembali Ke Halaman Sebelumnya '),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          FlatButton(
            onPressed: (){
              Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => datadiri1(),
              ));
            },

            /*Navigator.of(context).pop(true)*/
            child: Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }


  BaseEndPoint network = NetworkProvider();

  TextEditingController etMinGaji = TextEditingController();
  TextEditingController etMaxGaji = TextEditingController();
  TextEditingController etNoHp = TextEditingController();
  TextEditingController etWa = TextEditingController();

  TextEditingController etFacebook = TextEditingController();
  TextEditingController etInstagram = TextEditingController();
  TextEditingController etLinkedin = TextEditingController();
  TextEditingController etTwitter = TextEditingController();

  List _myActivities;
  String _myActivitiesResult;

  var InSignIn = false;
  String valProvince,
      valposisi,
      valprovince2,
      valkepemilikankendaraan,
      valkepemilikansim;
  String valminatpekerjaan,
      valsistemoperasi,
      valversisistemoperasi;
  String valPendidikan2;
  String valCity, valMinatLokasi;
  List dataProvince = List();
  List dataCity = [];
  List dataCityAll = [];
  List dataminatpekerjaan = [];
  List listversisistemoperasi = [];
  List datasepesialisasiminatpekerjaan = [];
  List listkepemilikansim = [
    {"inisial": "Tidak Ada", "isi": "Tidak Ada"},
    {"inisial": "SIM A", "isi": "SIM A"},
    {"inisial": "SIM A dan SIM B1", "isi": "SIM A & SIM B1"},
    {"inisial": "SIM A dan SIM B2", "isi": "SIM A & SIM B2"},
    {"inisial": "SIM A dan SIM C", "isi": "SIM A & SIM C"},
    {"inisial": "SIM A dan SIM B1 dan B2", "isi": "SIM A & SIM B1 & B2"},
    {"inisial": "SIM A dan SIM C dan B1", "isi": "SIM A & SIM C & B1"},
    {"inisial": "SIM A dan SIM C dan B2", "isi": "SIM A & SIM C & B2"},
    {
      "inisial": "SIM A dan SIM C dan B1 dan B2",
      "isi": "SIM A & SIM C & B1 & B2"
    },
    {"inisial": "SIM B1", "isi": "SIM B1"},
    {"inisial": "SIM B2", "isi": "SIM B2"},
    {"inisial": "SIM B1 dan SIM B2", "isi": "SIM B1 & SIM B2"},
    {"inisial": "SIM C", "isi": "SIM C"},
    {"inisial": "SIM C dan SIM B1", "isi": "SIM C & SIM B1"},
    {"inisial": "SIM C dan SIM B2", "isi": "SIM C & SIM B2"},
    {"inisial": "SIM C dan SIM B1 dan B2", "isi": "SIM C & SIM B1 & B2"},
  ];

  List listkepemilikankendaraan = [
    {"inisial": "tidak ada", "isi": "Tidak Ada"},
    {"inisial": "Motor", "isi": "Motor"},
    {"inisial": "Mobil", "isi": "Mobil"},
    {"inisial": "Motor & Mobil", "isi": "Motor & Mobil"},
  ];

  List listsistemoperasi = [
    {"inisial": "Android", "isi": "Android"},
    {"inisial": "ios", "isi": "Ios"},
    {
      "inisial": "tidak mempunyai handphone",
      "isi": "Tidak mempunyai Handphone"
    },
  ];

  void minatpekerjaan() async {
//    dataProvince = await network.getProvince();
    final response =
        await http.get(NetworkConfig().baseUrl + "master_api/minat_pekerjaan");
    var listdata = jsonDecode(response.body);
    setState(() {
      dataminatpekerjaan = listdata;
    });

    // print("data : $dataProvince");
  }

  void cityAll() async {
//    dataProvince = await network.getProvince();
    final response =
    await http.get(NetworkConfig().baseUrl + "master_api/kota");
    var listdata = jsonDecode(response.body);
    setState(() {
      dataCityAll = listdata;
    });
  }

  SessionManager sessionManager = SessionManager();
  String register_email, register_hp, register_name;
  int register_iduser;
  bool register_status_register;
  void getsession_register() async {
    await sessionManager.getPreference().then((value) {
      setState(() {
        register_status_register = sessionManager.status_register;
        register_iduser = sessionManager.iduser_register;
        register_email = sessionManager.email;
        register_hp = sessionManager.no_hp;
        register_name = sessionManager.name;

        print("register_status_register${register_status_register}");
        print("iduser${register_iduser}");
        print("register_name${register_name}");
        print("register_email${register_email}");
        print("register_hp${register_hp}");
      });
    });
  }

  String gajivalidator(String value) {
    if (value.length < 6) {
      return "gaji must be length 6";
    } else {
      return null;
    }
  }

  String numbervalidator(String value) {
    if (value.length < 10) {
      return "must be length 10";
    } else {
      return null;
    }
  }

  String nik, kodepos;
  void validasi() {
//
    if (valminatpekerjaan == null ||
        valkepemilikankendaraan == null ||
        valkepemilikansim == null) {
      Toast.show("Tidak boleh Kosong", context,
          duration: 3, gravity: Toast.BOTTOM);
    } else {
      if (_formKey.currentState.validate()) {
        //JIKA TRUE
        _formKey.currentState.save(); //MAKA FUNGSI SAVE() DIJALANKAN

        print("etWa${etWa.text.toString()}");
        print("etNoHp${etNoHp.text.toString()}");
        print("valminatpekerjaan${valminatpekerjaan.toString()}");
        print("valkepemilikansim${valkepemilikansim.toString()}");
        print("valkepemilikankendaraan${valkepemilikankendaraan.toString()}");
        print("etMinGaji${etMinGaji.text.toString()}");
        print("etMaxGaji${etMaxGaji.text.toString()}");
        print("valsistemoperasi${valsistemoperasi.toString()}");
        print("valversisistemoperasi${valversisistemoperasi.toString()}");
        print("_myActivities${_myActivities.toString()}");
        print("etFacebook${etFacebook.text.toString()}");
        print("etTwitter${etTwitter.text.toString()}");
        print("etLinkedin${etLinkedin.text.toString()}");
        print("etInstagram${etInstagram.text.toString()}");

        setState(() {
          InSignIn = true;
        });
        //Dialogs.showLoadingDialog(context, _formKey); //invoking login
        register_datadiri2();
        //Toast.show("Success", context, duration: 3, gravity: Toast.BOTTOM);

      };
    }
  }

  void register_datadiri2() async {
    ModelRegister data = await network.register_datadiri2(
        register_email,
        etWa.text.toString(),
        etNoHp.text.toString(),
        valminatpekerjaan.toString(),
        valkepemilikansim.toString(),
        valkepemilikankendaraan.toString(),
        etMinGaji.text.toString(),
        etMaxGaji.text.toString(),
        valsistemoperasi.toString(),
        valversisistemoperasi.toString(),
        "",
        _myActivities.toString(),
        etFacebook.text.toString(),
        etTwitter.text.toString(),
        etLinkedin.text.toString(),
        etInstagram.text.toString(),
        valMinatLokasi.toString());

    Toast.show("${data.status}", context, duration: 3, gravity: Toast.BOTTOM);

    if (data.status == 200) {
      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => datadiri3(),
      ));

      Toast.show("Success", context, duration: 3, gravity: Toast.BOTTOM);
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
    minatpekerjaan();
    cityAll();
    getsession_register();
  }

  bool setsitemoperasi = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    if (valsistemoperasi == "Android") {
      setState(() {
        setsitemoperasi = true;
      });
    } else {
      setsitemoperasi = false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Container(
          color: backgroundColor,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(children: <Widget>[
                            Text("No Whatsapp"),
                            Text(
                              "*",
                              style: TextStyle(color: Colors.red),
                            )
                          ]),
                          SizedBox(height: 5),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: etWa,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
                              ),
                            ),
                            validator: numbervalidator,
                            // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                            onSaved: (value) {
                              // name = value;
                            },
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text("Jika tidak ada, bisa diisi nomor media chat lain", style: TextStyle(fontSize: 11, color: mainColor)),
                          ),
                          SizedBox(height: 16),
                          Row(children: <Widget>[
                            Text("No Handphone"),
                            Text(
                              "*",
                              style: TextStyle(color: Colors.red),
                            )
                          ]),
                          SizedBox(height: 5),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: etNoHp,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
                              ),
                            ),
                            validator: numbervalidator,
                            // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                            onSaved: (value) {
                              // name = value;
                            },
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text("Wajib isi dengan nomor aktif & bisa dihubungi", style: TextStyle(fontSize: 11, color: mainColor)),
                          ),
                          SizedBox(height: 16),
                          Row(children: <Widget>[
                            Text("Minat Pekerjaan"),
                            Text(
                              "*",
                              style: TextStyle(color: Colors.red),
                            )
                          ]),
                          SizedBox(height: 10),
                          //jenis kelamin
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 11,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                  hint: "Pilih",
                                  items: dataminatpekerjaan.map((item) {
                                    return item['JOB_NAME'];
                                  }).toList(),
                                  maxHeight: 300,
                                  onChanged: (value) async {
                                    setState(() {
                                      for(var f in dataminatpekerjaan) {
                                        // print(f['province'].toString());
                                        if (f['JOB_NAME'].toString() == value) {
                                          valminatpekerjaan = f['id'];
                                        }
                                      }
                                    });

                                  },
                                  showSearchBox: true,

                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(children: <Widget>[
                            Text("Kepemilikan kendaraan"),
                            Text(
                              "*",
                              style: TextStyle(color: Colors.red),
                            )
                          ]),
                          SizedBox(height: 10),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 11,
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color : mainColor))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton(
                                  isExpanded: true,
                                  value: valkepemilikankendaraan,
                                  hint: Text("Pilih"),
                                  items: listkepemilikankendaraan.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item['isi']),
                                      value: item['inisial'],
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      valkepemilikankendaraan = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(children: <Widget>[
                            Text("Kepemilikan Sim"),
                            Text(
                              "*",
                              style: TextStyle(color: Colors.red),
                            )
                          ]),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 11,
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color : mainColor))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton(
                                  isExpanded: true,
                                  value: valkepemilikansim,
                                  hint: Text("Pilih"),
                                  items: listkepemilikansim.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item['isi']),
                                      value: item['inisial'],
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      valkepemilikansim = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 16),
                          Text("Minimal Gaji"),
                          SizedBox(height: 5),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: etMinGaji,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
                              ),
                            ),
                            onSaved: (value) {
                              // hp = value;
                            },
                          ),
                          SizedBox(height: 16),
                          Text("Maksimal Gaji"),
                          SizedBox(height: 5),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: etMaxGaji,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
                              ),
                            ),
                            onSaved: (value) {
                              // hp = value;
                            },
                          ),
                          SizedBox(height: 16),
                          Row(children: <Widget>[
                            Text("Minat Lokasi Bekerja"),
                            Text(
                              "*",
                              style: TextStyle(color: Colors.red),
                            )
                          ]),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 11,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                  hint: "Pilih",
                                  items: dataCityAll.map((item) {
                                    return item['city'];
                                  }).toList(),
                                  maxHeight: 300,
                                  onChanged: (value) async {
                                    setState(() {
                                      for(var f in dataCityAll) {
                                        if (f['city'].toString() == value) {
                                          valMinatLokasi = f['id'];
                                        }
                                      }
                                    });
                                  },
                                  showSearchBox: true,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(children: <Widget>[Text("Facebook")]),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: etFacebook,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
                              ),
                            ),
                            // validator: nameValidator,
                            // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                            onSaved: (value) {
                              // hp = value;
                            },
                          ),
                          SizedBox(height: 16),
                          Row(children: <Widget>[Text("Instagram")]),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            // controller: etNo_hp,
                            controller: etInstagram,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
                              ),
                            ),
                            // validator: nameValidator,
                            // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                            onSaved: (value) {
                              // hp = value;
                            },
                          ),
                          SizedBox(height: 16),
                          Row(children: <Widget>[Text("Twitter")]),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: etTwitter,
                            // controller: etNo_hp,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
                              ),
                            ),
                            // validator: nameValidator,
                            // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                            onSaved: (value) {
                              // hp = value;
                            },
                          ),
                          SizedBox(height: 16),
                          Row(children: <Widget>[Text("Linkedin")]),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: etLinkedin,
                            // controller: etNo_hp,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
                              ),
                            ),
                            // validator: nameValidator,
                            // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                            onSaved: (value) {
                              // hp = value;
                            },
                          ),
                          SizedBox(height: 26),
                          Text(" * (Perlu diisi)", style: TextStyle(color:Colors.red, fontSize: 12),),
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
                                      //checkEmailAndPassowrd();
                                    },
                                    color: mainColor,
                                    child: Text("Simpan",
                                        style: TextStyle(color: Colors.white)),
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
        ),
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
