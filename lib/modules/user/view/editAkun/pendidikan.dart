import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/ui/User/Fragment/AkunUser_backup.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class Pendidikan_Edit extends StatefulWidget {
  final universitas, ipk, tahun_masuk, tahun_keluar, jurusan, pendidikan;
  Pendidikan_Edit(
      {this.universitas,
      this.ipk,
      this.tahun_masuk,
      this.tahun_keluar,
      this.jurusan,
      this.pendidikan});

  @override
  _PendidikanState createState() => _PendidikanState();
}

class _PendidikanState extends State<Pendidikan_Edit> {
  var InSignIn = false;
  BaseEndPoint network = NetworkProvider();
  String valProvince,
      valposisi,
      valprovince2,
      valkepemilikankendaraan,
      valkepemilikansim;
  String valjurusan;
  String valPendidikan2;
  String valCity;
  List dataProvince = List();
  List dataCity = [];
  List datajurusan = [];
  List datapendidikan = [];
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

  void jurusan() async {
//    dataProvince = await network.getProvince();
    final response =
    await http.get(NetworkConfig().baseUrl + "master_api/jurusan");
    var listdata = jsonDecode(response.body);
    setState(() {
      datajurusan = listdata;
    });

    // print("data : $datajurusan");
  }

  void pendidikan() async {
    final response =
        await http.get(NetworkConfig().baseUrl + "master_api/pendidikan");
    var listdata = jsonDecode(response.body);
    setState(() {
      datapendidikan = listdata;
    });

    // print("data : $dataProvince");
  }

  var globalName = "",
      globalEmail = "",
      globalLevel = "",
      id_user = "",
      globalid_employee = "",
      globalprofil_power = "";
  var status = false;
  // var id_user;
//  var value;
  var mystatus;

  SessionManager sessionManager = SessionManager();

  void getPreferences() async {
    await sessionManager.getPreference().then((value) {
      setState(() {
        mystatus = sessionManager.status;
        globalName = sessionManager.fullname;
        globalEmail = sessionManager.email;
        id_user = sessionManager.iduser;
        globalprofil_power = sessionManager.profile_power;

        print("email${globalEmail}");
        //print("profil power${globalprofil_power}");
//        print("fullname${globalName}");
//        print("email${globalEmail}");
//        print("global $globalLevel");
        //_loginStatus = mystatus == true ? LoginStatus.Login : LoginStatus.not_login;
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

  String namevalidator(String value) {
    if (value.length < 4) {
      return "must be length 4";
    } else {
      return null;
    }
  }

  void validasi() {
//
    if (etuniversitas.text.toString() == null ||
        etipk.text.toString() == null) {
      Toast.show("Tidak boleh Kosong", context,
          duration: 3, gravity: Toast.BOTTOM);
    } else {
      if (_formKey.currentState.validate()) {
        //JIKA TRUE
        _formKey.currentState.save(); //MAKA FUNGSI SAVE() DIJALANKAN

//        Dialogs.showLoadingDialog(context, _formKey); //invoking login

        print("tingkata${valPendidikan2.toString()}");

        setState(() {
          InSignIn = true;
        });


        edit_pendidikan();
      }
      ;
    }
  }

  void edit_pendidikan() async {
    // print(valjurusan);
    ModelRegister data = await network.edit_pendidikan(
        globalEmail,
        etuniversitas.text.toString(),
        valPendidikan2.toString(),
        valjurusan.toString(),
        etipk.text.toString(),
        ettahunmasuk.text.toString(),
        ettahunkeluar.text.toString());


    if (data.status == 200) {
//      Navigator.of(context).push(new MaterialPageRoute(
//        builder: (BuildContext context) => AkunUser(),
//      ));

      Toast.show("Success", context, duration: 3, gravity: Toast.BOTTOM);
      Navigator.pop(context);
    } else {
      print("gagal");
      Toast.show("Gagal", context, duration: 3, gravity: Toast.BOTTOM);
    }
  }

  var etuniversitas, etipk, ettahunmasuk, ettahunkeluar;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPreferences();
    jurusan();
    pendidikan();
    etuniversitas = TextEditingController(text: widget.universitas);
    etipk = TextEditingController(text: widget.ipk);
    ettahunmasuk = TextEditingController(text: widget.tahun_masuk);
    ettahunkeluar = TextEditingController(text: widget.tahun_keluar);
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // print("pendidikan${widget.universitas}");

    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: mainColor,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Pendidikan",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  SizedBox(height: 16),
                  Row(children: <Widget>[
                    Text("Sekolah"),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    )
                  ]),
                  SizedBox(height: 10),
                  SizedBox(height: 12),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: etuniversitas,
                    //initialValue: widget.universitas == null ? "" : widget.universitas,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Nama Sekolah",
                    ),
                    validator: namevalidator,
                    // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                    onSaved: (value) {
                      // name = value;
                    },
                  ),
                  SizedBox(height: 16),
                  Row(children: <Widget>[
                    Text("Tingkatan"),
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
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(color: Colors.blueGrey)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                          value: valPendidikan2,
                          hint: Text(
                            widget.pendidikan
                            ,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          items: datapendidikan.map((item) {
                            return DropdownMenuItem(
                              child: Text(item['title']),
                              value: item['id'],
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              valPendidikan2 = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(children: <Widget>[
                    Text("Jurusan"),
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(color: Colors.blueGrey)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownSearch<dynamic>(
                          hint: widget.jurusan,
                          items: datajurusan.map((item) {
                            return item['jurusan'];
                          }).toList(),
                          maxHeight: 300,
                          onChanged: (value) async {
                            setState(() {
                              for(var f in datajurusan) {
                                // print(f['province'].toString());
                                if (f['jurusan'].toString() == value) {
                                  valjurusan = f['id'];
                                }
                              }
                            });

                          },
                          showSearchBox: true,

                        ),
                        // child: DropdownButton(
                        //   value: valjurusan,
                        //   hint: Text(
                        //     widget.jurusan,
                        //     style: TextStyle(fontSize: 16, color: Colors.black),
                        //   ),
                        //   items: datajurusan.map((item) {
                        //     return DropdownMenuItem(
                        //       child: Text(item['jurusan']),
                        //       value: item['id'],
                        //     );
                        //   }).toList(),
                        //   onChanged: (value) {
                        //     setState(() {
                        //       valjurusan = value;
                        //     });
                        //   },
                        // ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(children: <Widget>[
                    Text("IPK"),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    )
                  ]),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: etipk,
                    //  initialValue: widget.ipk,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "IPK",
                    ),
                    //validator: namevalidator,
                    // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                    onSaved: (value) {
                      // name = value;
                    },
                  ),

                  SizedBox(height: 16),
                  Row(children: <Widget>[
                    Text("Tahun Masuk"),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    )
                  ]),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: ettahunmasuk,
                    // initialValue: widget.tahun_masuk,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "YYYY",
                    ),
                    validator: namevalidator,
                    // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                    onSaved: (value) {
                      // name = value;
                    },
                  ),
                  SizedBox(height: 16),
                  Row(children: <Widget>[
                    Text("Tahun Keluar"),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    )
                  ]),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: ettahunkeluar,
                    //initialValue: widget.tahun_keluar == null ? "" : widget.tahun_keluar,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "YYYY",
                    ),
                    validator: namevalidator,
                    // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                    onSaved: (value) {
                      // name = value;
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
                              //checkEmailAndPassowrd();
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
          )
        ],
      ),
    );
  }
}
