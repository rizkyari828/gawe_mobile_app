import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/modules/user/models/model_edit_pengalaman_org.dart';
import 'package:gaweid2/modules/user/models/model_pengalaman_org.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class Edit_PengalamanOrganisasi extends StatefulWidget {
  final id,namaOrganisasi,jabatan,mulai,akhir;

  Edit_PengalamanOrganisasi({
    this.id,
    this.namaOrganisasi,
    this.jabatan,
    this.mulai,
    this.akhir
  });

  @override
  _PengalamanOrganisasiState createState() => _PengalamanOrganisasiState();
}

class _PengalamanOrganisasiState extends State<Edit_PengalamanOrganisasi> {
  String id, employee_id, jabatan, mulai, akhir, nama_organisasi;
  var InSignIn = false;

  Future getpengalamanOrg(id) async {
    //loading = false;
    final jsonString = await http.post(
        NetworkConfig().baseUrl + "apps/edit_pengalaman_org_detail",
        body: {
          'id': id,
        });
    final jsonData = jsonDecode(jsonString.body);

    ModelEditPengalamanOrg Org = ModelEditPengalamanOrg.fromJson(jsonData);

//    print("tes${Org.id}");
//    print("nama_organisasi${Org.nama_organisasi}");

    setState(() {
      id = Org.id.toString();
      employee_id = Org.employee_id.toString();
      nama_organisasi = Org.nama_organisasi.toString() == null
          ? ""
          : Org.nama_organisasi.toString();
      jabatan = Org.jabatan.toString() == null ? "" : Org.jabatan.toString();
      mulai = Org.mulai.toString() == null ? "" : Org.mulai.toString();
      akhir = Org.akhir.toString() == null ? "" : Org.akhir.toString();
    });
  }

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
  void validasi() {
//
//    if (nama_organisasi == null) {
//      Toast.show("Tidak boleh Kosong", context,
//          duration: 3, gravity: Toast.BOTTOM);
//    } else {

    if (_formKey.currentState.validate()) {
      //JIKA TRUE
      _formKey.currentState.save(); //MAKA FUNGSI SAVE() DIJALANKAN

      setState(() {
        InSignIn = false;
      });

      print(nama_organisasi.toString());
      edit_pengalamanorg();
      // Toast.show(nama_organisasi, context, duration: 3, gravity: Toast.BOTTOM);
    }
    ;
    //}
  }

  var etNamaOrganisasi1, etjabatanOrganisasi1, etmulai, etakhir;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    jurusan();
    pendidikan();
    getsession_register();
    getpengalamanOrg(widget.id);
    etNamaOrganisasi1 = TextEditingController(text: widget.namaOrganisasi);
    etjabatanOrganisasi1 = TextEditingController(text: widget.jabatan);
    etmulai = TextEditingController(text: widget.mulai);
    etakhir = TextEditingController(text: widget.akhir);
  }

  void edit_pengalamanorg() async {
    ModelRegister data = await network.edit_pengalaman_org(
        widget.id,
        etNamaOrganisasi1.text.toString(),
        etjabatanOrganisasi1.text.toString(),
        etmulai.text.toString(),
        etakhir.text.toString());

    if (data.status == 200) {
      Navigator.pop(context);
      Toast.show("Success", context, duration: 3, gravity: Toast.BOTTOM);
    } else {
      print("gagal");
      Navigator.pop(context);
      Toast.show("Gagal", context, duration: 3, gravity: Toast.BOTTOM);
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    getpengalamanOrg(widget.id);

    print("pengalaman_id${widget.id}");


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
//                  Visibility(visible: true, child: Text(nama_organisasi == null ? "" : nama_organisasi)),
                  // Text(jabatan),
//                  Text(mulai),
//                  Text(akhir),
                  Text(
                    "Pengalaman Organisasi",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    // initialValue: nama_organisasi,
                    controller: etNamaOrganisasi1,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Nama Organisasi",
                      hintText: nama_organisasi,

                    ),
                    // validator: namevalidator,
//                    onSaved: (value) {
//                      nama_organisasi = value;
//                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: etjabatanOrganisasi1,
                    // initialValue: jabatan == null ? "" : jabatan,
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
                    controller: etmulai,
                    //controller: etTahunMasukOraganisasi,
                    //initialValue: etmulai,
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
                    controller: etakhir,
                    // initialValue: akhir,
                    // controller: etTahunAkhirOraganisasi,
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
