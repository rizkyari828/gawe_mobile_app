import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class EdutPengalamanKerja extends StatefulWidget {
  final id,
      namaPerusahaan,
      posisi,
      tglMulai,
      tglBerhenti,
      lokasi,
      gaji,
      industri,
      fungsiKerjaId,
      deskripsi,
      masihBekerja,
      jenjang_career_id;
  EdutPengalamanKerja(
      {this.id,
      this.namaPerusahaan,
      this.posisi,
      this.tglMulai,
      this.tglBerhenti,
      this.lokasi,
      this.gaji,
      this.industri,
      this.fungsiKerjaId,
      this.deskripsi,
      this.masihBekerja,
      this.jenjang_career_id});

  @override
  _pengalamankerjaState createState() => _pengalamankerjaState();
}

class _pengalamankerjaState extends State<EdutPengalamanKerja> {
  var InSignIn = false;
  DateTime _dueDate = DateTime.now();
  DateTime _tglkeluar = DateTime.now();
  BaseEndPoint network = NetworkProvider();

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

  void getPosisi() async {
    final response =
    await http.get(NetworkConfig().baseUrl + "master_api/posisi_kerja");
    var listdata = jsonDecode(response.body);
    setState(() {
      dataPosisi = listdata;
    });
    // print("data : $dataPosisi");
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


  var etnamaperusahaan,
      etlokasiperusahaan,
      etgaji,
      etdeskripsi;

  void validasi() async {
    if (etnamaperusahaan.text.toString() == null ||
        valPosisiPekerjaan.toString() == null ||
        etlokasiperusahaan.text.toString() == null ||
        etgaji.text.toString() == null) {
      Toast.show("Tidak boleh Kosong", context,
          duration: 3, gravity: Toast.BOTTOM);
    } else {
      if (_formKey.currentState.validate()) {
        //JIKA TRUE
        _formKey.currentState.save(); //MAKA FUNGSI SAVE() DIJALANKAN

        setState(() {
          InSignIn = true;
        });

        ModelRegister data = await network.edit_pengalaman_kerja(
            widget.id,
            etnamaperusahaan.text.toString(),
            valindustri.toString(),
            valPosisiPekerjaan.toString(),
            vallevel_pekerjaan.toString(),
            valMinatLokasi.toString(),
            etgaji.text.toString(),
            dateText.toString(),
            _tglkeluar.toString(),
            monVal.toString(),
            etdeskripsi.text.toString(),
            valfungsi.toString());

        //Toast.show("${data.status}", context, duration: 3, gravity: Toast.BOTTOM);

        if (data.status == 200) {
          Navigator.pop(context);
          Toast.show("Success", context, duration: 3, gravity: Toast.BOTTOM);
        } else {
          setState(() {
            InSignIn = false;
          });
          print("gagal");
          Toast.show("Gagal", context, duration: 3, gravity: Toast.BOTTOM);
        }
      }
      ;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getfungsi();
    getpekerjaan();
    getindustri();
    getPosisi();
    cityAll();

    etnamaperusahaan = TextEditingController(text: widget.namaPerusahaan);
    etlokasiperusahaan = TextEditingController(text: widget.lokasi);
    etgaji = TextEditingController(text: widget.gaji);
    etdeskripsi = TextEditingController(text: widget.deskripsi);

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
        elevation: 0,
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
                            hint: Text(
                              widget.jenjang_career_id,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
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
                            dateText == "" ? widget.tglMulai : dateText,
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
                                  ? widget.tglBerhenti
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
                          child: DropdownButton(
                            value: valfungsi,
                            hint: Text(
                              widget.fungsiKerjaId,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            items: datafungsi.map((item) {
                              return DropdownMenuItem(
                                child: Text(item['title']),
                                value: item['id'],
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                valfungsi = value;
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
    );
  }
}
