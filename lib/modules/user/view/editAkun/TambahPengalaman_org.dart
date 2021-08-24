import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/ui/User/Fragment/AkunUser.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class TambahPengalamanOrganisasi extends StatefulWidget {
  @override
  _TambahPengalamanOrganisasiState createState() =>
      _TambahPengalamanOrganisasiState();
}

class _TambahPengalamanOrganisasiState
    extends State<TambahPengalamanOrganisasi> {
  BaseEndPoint network = NetworkProvider();
  TextEditingController etNamaOrganisasi = TextEditingController();
  TextEditingController etjabatanOrganisasi = TextEditingController();
  TextEditingController etTahunMasukOraganisasi = TextEditingController();
  TextEditingController etTahunAkhirOraganisasi = TextEditingController();

  var InSignIn = false;
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

    // print("data : $dataProvince");
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

  var globalName = "", globalEmail = "", globalLevel = "";
  var status = false;
  var id_user, globalid_employee;
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
//        print("status${mystatus}");
//        print("fullname${globalName}");
//        print("email${globalEmail}");
        print("globalid_employee $globalid_employee");
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

  String nik, kodepos;
  void validasi() async {
//
    if (etNamaOrganisasi.text.toString() == null ||
        etjabatanOrganisasi.text.toString() == null ||
        etTahunMasukOraganisasi.text.toString() == null ||
        etTahunAkhirOraganisasi.text.toString() == null) {
      Toast.show("Tidak boleh Kosong", context,
          duration: 3, gravity: Toast.BOTTOM);
    } else {
      if (_formKey.currentState.validate()) {
        //JIKA TRUE
        _formKey.currentState.save(); //MAKA FUNGSI SAVE() DIJALANKAN

        print("etNamaOrganisasi${etNamaOrganisasi.text.toString()}");
        print("etjabatanOrganisasi${etjabatanOrganisasi.text.toString()}");
        print(
            "etTahunMasukOraganisasi${etTahunMasukOraganisasi.text.toString()}");
        print(
            "etTahunAkhirOraganisasi${etTahunAkhirOraganisasi.text.toString()}");

        setState(() {
          InSignIn = true;
        });

        ModelRegister data = await network.pengalamanorg(
            globalid_employee,
            etNamaOrganisasi.text.toString(),
            etjabatanOrganisasi.text.toString(),
            etTahunMasukOraganisasi.text.toString(),
            etTahunAkhirOraganisasi.text.toString());

        if (data.status == 200) {
          Toast.show("Success", context, duration: 3, gravity: Toast.BOTTOM);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => (AkunUser(id_employee: globalid_employee,))));
        } else {
          print("gagal");
          Toast.show("Gagal", context, duration: 3, gravity: Toast.BOTTOM);
        }

//        Dialogs.showLoadingDialog(context, _formKey); //invoking login
//        register_datadiri3();

      }
      ;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jurusan();
    pendidikan();
    getPreferences();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gawe.id"),
        backgroundColor: mainColor,
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
                    "Pengalaman Organisasi",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: etNamaOrganisasi,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Nama Organisasi",
                      hintText: "Nama Organisasi",
                    ),
                    // validator: nameValidator,
                    // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                    onSaved: (value) {
                      // hp = value;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: etjabatanOrganisasi,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Jabatan",
                      hintText: "Jabatan",
                    ),
                    // validator: nameValidator,
                    // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                    onSaved: (value) {
                      // hp = value;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    //controller: etName,
                    controller: etTahunMasukOraganisasi,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Tahun Masuk Jabatan",
                      hintText: "Tahun Masuk Jabatan",
                    ),
                    //validator: nameValidator,
                    // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                    onSaved: (value) {
                      // name = value;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    //controller: etName,
                    controller: etTahunAkhirOraganisasi,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Tahun Akhir Jabatan",
                      hintText: "Tahun Akhir Jabatan",
                    ),
                    //validator: nameValidator,
                    // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                    onSaved: (value) {
                      // name = value;
                    },
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
