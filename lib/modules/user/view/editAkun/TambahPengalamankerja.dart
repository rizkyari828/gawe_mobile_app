import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/ui/User/Fragment/AkunUser.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class Tambahpengalamankerja extends StatefulWidget {
  @override
  _TambahpengalamankerjaState createState() => _TambahpengalamankerjaState();
}

class _TambahpengalamankerjaState extends State<Tambahpengalamankerja> {
  BaseEndPoint network = NetworkProvider();

  TextEditingController etnamaperusahaan = TextEditingController();
  TextEditingController etposisiperusahaan = TextEditingController();
  TextEditingController etlokasiperusahaan = TextEditingController();
  TextEditingController etgaji = TextEditingController();
  TextEditingController etdeskripsi = TextEditingController();
  TextEditingController etnamapelatihan = TextEditingController();
  TextEditingController etnamapenyelenggara = TextEditingController();
  TextEditingController ettahun = TextEditingController();
  TextEditingController etlainnya = TextEditingController();
  TextEditingController etlainnya2 = TextEditingController();
  TextEditingController ettitle_keahlian = TextEditingController();
  TextEditingController ettitle_komputer = TextEditingController();
  DateTime _dueDate = DateTime.now();
  DateTime _tglkeluar = DateTime.now();

  var InSignIn = false;
  String vallisan,
      valtulisan,
      valmembaca,
      valoffice,
      valemail,
      vallainya,
      valpengalaman,
      valfungsi,
      vallevel_pekerjaan,
      valindustri,
      valketerangankemampuan,
      valketerangankeahlian,
      valkomputerketerangan,
      valPosisiPekerjaan,valMinatLokasi;

  List datafungsi = [];
  List datalevel_pekerjaan = [];
  List dataindustri = [];
  List dataPosisi = [];
  List dataCityAll = [];

  bool setpengalaman = true;
  bool monVal = false, valMonval1 = false;

  String dateText = "", tanggal_keluar = "";

  selectDueDate(BuildContext content) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime(1955),
      lastDate: DateTime(2040),
    );

    if (picked != null) {
      setState(() {
        _dueDate = picked;
        dateText = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  selectTanggal_keluar(BuildContext content) async {
    final picked_keluar = await showDatePicker(
      context: context,
      initialDate: _tglkeluar,
      firstDate: DateTime(1955),
      lastDate: DateTime(2040),
    );

    if (picked_keluar != null) {
      setState(() {
        _tglkeluar = picked_keluar;
        tanggal_keluar =
            "${picked_keluar.day}/${picked_keluar.month}/${picked_keluar.year}";
      });
    }
  }

  void getfungsi() async {
    final response =
        await http.get(NetworkConfig().baseUrl + "master_api/fungsi_kerja");
    var listdata = jsonDecode(response.body);
    setState(() {
      datafungsi = listdata;
    });

    // print("data : $dataProvince");
  }

  void getpekerjaan() async {
    final response =
        await http.get(NetworkConfig().baseUrl + "master_api/level_pekerjaan");
    var listdata = jsonDecode(response.body);
    setState(() {
      datalevel_pekerjaan = listdata;
    });

    // print("data : $dataProvince");
  }

  void getindustri() async {
    final response =
        await http.get(NetworkConfig().baseUrl + "master_api/industri");
    var listdata = jsonDecode(response.body);
    setState(() {
      dataindustri = listdata;
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
        print("globalid_employee $globalid_employee");
        //_loginStatus = mystatus == true ? LoginStatus.Login : LoginStatus.not_login;
      });
    });
  }

  void validasi() async {
    if (etnamaperusahaan.text.toString() == null ||
        valindustri.toString() == null || valPosisiPekerjaan.toString() == null ||
        vallevel_pekerjaan.toString() == null) {
      Toast.show("Tidak boleh Kosong", context,
          duration: 3, gravity: Toast.BOTTOM);
    } else {
      if (_formKey.currentState.validate()) {
        //JIKA TRUE
        _formKey.currentState.save(); //MAKA FUNGSI SAVE() DIJALANKAN

        setState(() {
          InSignIn = true;
        });

        ModelRegister data = await network.pengalamankerja(
            globalid_employee,
            etnamaperusahaan.text.toString(),
            valindustri.toString(),
            valPosisiPekerjaan.toString(),
            vallevel_pekerjaan.toString(),
            valMinatLokasi.toString(),
            etgaji.text.toString(),
            dateText.toString(),
            tanggal_keluar.toString(),
            valMonval1.toString(),
            etdeskripsi.text.toString(),
            valfungsi.toString());

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
      }
      ;
    }
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

  void getPosisi() async {
    final response =
    await http.get(NetworkConfig().baseUrl + "master_api/posisi_kerja");
    var listdata = jsonDecode(response.body);
    setState(() {
      dataPosisi = listdata;
    });
    // print("data : $dataPosisi");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getfungsi();
    getpekerjaan();
    getindustri();
    getPreferences();
    getPosisi();
    cityAll();
    //getsession_register();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (monVal == false) {
      setState(() {
        valMonval1 = true;
      });
    } else {
      valMonval1 = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: mainColor,
      ),
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
                    "Pengalaman Kerja",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10,),
                  Visibility(
                    visible: setpengalaman,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: etnamaperusahaan,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Nama Perusahaan",
                        hintText: "Nama Perusahaan",
                      ),
                      //validator: nameValidator,
                      // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                      onSaved: (value) {
                        // name = value;
                      },
                    ),
                  ),
                  Visibility(
                      visible: setpengalaman, child: SizedBox(height: 16)),
                  Visibility(
                    visible: setpengalaman,
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 11,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            border: Border.all(color: Colors.blueGrey)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownSearch<dynamic>(
                            hint: "Pilih Industri",
                            items: dataindustri.map((item) {
                              return item['title'];
                            }).toList(),
                            maxHeight: 300,
                            onChanged: (value) async {
                              setState(() {
                                for(var f in dataindustri) {
                                  // print(f['province'].toString());
                                  if (f['title'].toString() == value) {
                                    valindustri = f['id'];
                                  }
                                }
                              });

                            },
                            showSearchBox: true,

                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                      visible: setpengalaman, child: SizedBox(height: 16)),
                  Visibility(
                    visible: setpengalaman,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 11,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(color: Colors.blueGrey)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownSearch<dynamic>(
                          hint: "Pilih Posisi",
                          items: dataPosisi.map((item) {
                            return item['nama'];
                          }).toList(),
                          maxHeight: 300,
                          onChanged: (value) async {
                            setState(() {
                              valPosisiPekerjaan = value;
                            });

                          },
                          showSearchBox: true,

                        ),
                        // child: DropdownButton(
                        //   hint: Text(
                        //     'Pilih posisi',
                        //     style: TextStyle(fontWeight: FontWeight.w600),
                        //   ),
                        //   isExpanded: true,
                        //   value: valPosisiPekerjaan,
                        //   items: dataPosisi.map((item) {
                        //     return DropdownMenuItem(
                        //       child: Text(item['nama']),
                        //       value: item['nama'],
                        //     );
                        //   }).toList(),
                        //   onChanged: (value) {
                        //     setState(() {
                        //       valPosisiPekerjaan = value;
                        //     });
                        //   },
                        // ),
                      ),
                    ),
                    // child: TextFormField(
                    //   keyboardType: TextInputType.text,
                    //   //controller: etName,
                    //   controller: etposisiperusahaan,
                    //   decoration: InputDecoration(
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     labelText: "Posisi",
                    //     hintText: "Posisi",
                    //   ),
                    //   //validator: nameValidator,
                    //   // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                    //   onSaved: (value) {
                    //     // name = value;
                    //   },
                    // ),
                  ),
                  Visibility(
                      visible: setpengalaman, child: SizedBox(height: 16)),
                  Visibility(
                    visible: setpengalaman,
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 11,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            border: Border.all(color: Colors.blueGrey)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton(
                            value: vallevel_pekerjaan,
                            hint: Text("Pilih Level Pekerjaan"),
                            items: datalevel_pekerjaan.map((item) {
                              return DropdownMenuItem(
                                child: Text(item['title']),
                                value: item['id'],
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                vallevel_pekerjaan = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                      visible: setpengalaman, child: SizedBox(height: 16)),
                  Visibility(
                    visible: setpengalaman,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 11,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(color: Colors.blueGrey)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownSearch<dynamic>(
                        hint: "Pilih lokasi",
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
                    // child: TextFormField(
                    //   keyboardType: TextInputType.text,
                    //   //controller: etName,
                    //   controller: etlokasiperusahaan,
                    //   decoration: InputDecoration(
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     labelText: "Lokasi",
                    //     hintText: "Lokasi",
                    //   ),
                    //   //validator: nameValidator,
                    //   // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                    //   onSaved: (value) {
                    //     // name = value;
                    //   },
                    // ),
                  ),
                  Visibility(
                      visible: setpengalaman, child: SizedBox(height: 16)),
                  Visibility(
                    visible: setpengalaman,
                    child: Text("Tanggal Masuk"),
                  ),
                  Visibility(
                    visible: setpengalaman,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.date_range,
                          color: Colors.blue,
                        ),
                        FlatButton(
                          onPressed: () {
                            selectDueDate(context);
                          },
                          child: Text(
                            dateText == "" ? "Tanggal Mulai" : dateText,
                            style: TextStyle(fontSize: 16, color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: valMonval1,
                    child: Visibility(
                        visible: setpengalaman, child: SizedBox(height: 16)),
                  ),
                  Visibility(
                    visible: valMonval1,
                    child: Visibility(
                      visible: setpengalaman,
                      child: Text("Tanggal Keluar"),
                    ),
                  ),
                  Visibility(
                    visible: valMonval1,
                    child: Visibility(
                      visible: setpengalaman,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.date_range,
                            color: Colors.blue,
                          ),
                          FlatButton(
                            onPressed: () {
                              selectTanggal_keluar(context);
                            },
                            child: Text(
                              tanggal_keluar == ""
                                  ? "Tanggal Keluar"
                                  : tanggal_keluar,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: setpengalaman,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Checkbox(
                          value: monVal,
                          onChanged: (bool value) {
                            setState(() {
                              monVal = value;
                            });
                          },
                        ),
                        Text("Saat ini Saya masih bekerja disini"),
                      ],
                    ),
                  ),
                  Visibility(
                      visible: setpengalaman, child: SizedBox(height: 16)),
                  Visibility(
                    visible: setpengalaman,
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 11,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            border: Border.all(color: Colors.blueGrey)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownSearch<dynamic>(
                            hint: "Pilih fungsi pekerjaan",
                            items: datafungsi.map((item) {
                              return item['title'];
                            }).toList(),
                            maxHeight: 300,
                            onChanged: (value) async {
                              setState(() {
                                for(var f in datafungsi) {
                                  if (f['title'].toString() == value) {
                                    valfungsi = f['id'];
                                  }
                                }
                              });

                            },
                            showSearchBox: true,

                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                      visible: setpengalaman, child: SizedBox(height: 16)),
                  Visibility(
                    visible: setpengalaman,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      //controller: etName,
                      controller: etgaji,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Gaji",
                        hintText: "Gaji",
                      ),
                      //validator: nameValidator,
                      // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                      onSaved: (value) {
                        // name = value;
                      },
                    ),
                  ),
                  Visibility(
                      visible: setpengalaman, child: SizedBox(height: 16)),
                  Visibility(
                    visible: setpengalaman,
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      // maxLines: 4,
                      controller: etdeskripsi,
                      maxLength: 500,

                      // controller: etNo_hp,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Deskripsi Pekerjaan",
                        hintText: "Deskripsi Pekerjaan",
                      ),
                      // validator: nameValidator,
                      // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                      onSaved: (value) {
                        // hp = value;
                      },
                    ),
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
