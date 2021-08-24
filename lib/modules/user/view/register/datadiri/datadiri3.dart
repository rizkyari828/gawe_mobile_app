import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/user/view/register/datadiri/datadiri2.dart';
import 'package:gaweid2/modules/user/view/register/datadiri/datadiri4.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:toast/toast.dart';

class datadiri3 extends StatefulWidget {
  @override
  _datadiri3State createState() => _datadiri3State();
}

class _datadiri3State extends State<datadiri3> {

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
                builder: (BuildContext context) => datadiri2(),
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
  TextEditingController etsekolah = TextEditingController();
  TextEditingController etTahunMasuk = TextEditingController();
  TextEditingController etipk = TextEditingController();
  TextEditingController etTahunLulus = TextEditingController();
  TextEditingController etNamaOrganisasi = TextEditingController();
  TextEditingController etjabatanOrganisasi = TextEditingController();
  TextEditingController etTahunMasukOraganisasi = TextEditingController();
  TextEditingController etTahunAkhirOraganisasi = TextEditingController();

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

  String namevalidator(String value) {
    if (value.length < 4) {
      return "must be length 4";
    } else {
      return null;
    }
  }

  String ipkvalidator(String value) {
    if (value.length < 1) {
      return "cannot empty";
    } else {
      return null;
    }
  }

  String nik, kodepos;
  var InSignIn = false;
  void validasi() {
//
    if (valjurusan == null ||
        valPendidikan2 == null ||
        etipk.text.toString() == null) {
      Toast.show("Tidak boleh Kosong", context,
          duration: 3, gravity: Toast.BOTTOM);
    } else {
      if (_formKey.currentState.validate()) {
        //JIKA TRUE
        _formKey.currentState.save(); //MAKA FUNGSI SAVE() DIJALANKAN

        print("sekolah${etsekolah.text.toString()}");
        print("jurusan${valjurusan.toString()}");
        print("pendidikan${valPendidikan2.toString()}");
        print("ipk${etipk.text.toString()}");
        print("tahunmasuk${etTahunMasuk.text.toString()}");
        print("tahunkeluar${etTahunLulus.text.toString()}");

        print("etNamaOrganisasi${etNamaOrganisasi.text.toString()}");
        print(
            "etTahunMasukOraganisasi${etTahunMasukOraganisasi.text.toString()}");
        print(
            "etTahunAkhirOraganisasi${etTahunAkhirOraganisasi.text.toString()}");
        print("jabatan${etjabatanOrganisasi.text.toString()}");

        setState(() {
          InSignIn = true;
        });
        //Dialogs.showLoadingDialog(context, _formKey); //invoking login
        register_datadiri3();
      }
      ;
    }
  }

  void register_datadiri3() async {
    ModelRegister data = await network.register_datadiri3(
        register_email,
        valPendidikan2.toString(),
        etsekolah.text.toString(),
        valjurusan.toString(),
        etipk.text.toString(),
        etTahunMasuk.text.toString(),
        etTahunLulus.text.toString(),
        etNamaOrganisasi.text.toString(),
        etjabatanOrganisasi.text.toString(),
        etTahunMasukOraganisasi.text.toString(),
        etTahunLulus.text.toString());

    Toast.show("${data.status}", context, duration: 3, gravity: Toast.BOTTOM);

    if (data.status == 200) {
      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => datadiri4(),
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
    jurusan();
    pendidikan();
    getsession_register();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Container(
          color: backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              child: ListView(
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
                          SizedBox(height: 5),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: etsekolah,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
                              ),
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
                                  border: Border(bottom: BorderSide(color : mainColor))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton(
                                  value: valPendidikan2,
                                  hint: Text("Pilih"),
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
                                  hint: "Pilih jurusan",
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
                            validator: ipkvalidator,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
                              ),
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
                            controller: etTahunMasuk,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
                              ),
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
                            controller: etTahunLulus,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
                              ),
                            ),
                            validator: namevalidator,
                            // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                            onSaved: (value) {
                              // name = value;
                            },
                          ),

                          SizedBox(height: 16),
                          Text(
                            "Pengalaman Organisasi",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 12),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: etNamaOrganisasi,
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
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: etjabatanOrganisasi,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
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
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
                              ),
                              labelText: "Tahun Masuk",
                              hintText: "Tahun Masuk",
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
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
                              ),
                              labelText: "Tahun Akhir",
                              hintText: "Tahun Akhir",
                            ),
                            //validator: nameValidator,
                            // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                            onSaved: (value) {
                              // name = value;
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
                                      //checkEmailAndPassowrd();
                                      validasi();
                                    },
                                    color: mainColor,
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
            ),
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
