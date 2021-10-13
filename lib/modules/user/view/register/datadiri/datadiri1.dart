import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/user/view/register/datadiri/datadiri2.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:dropdown_search/dropdown_search.dart';

class datadiri1 extends StatefulWidget {
  @override
  _datadiri1State createState() => _datadiri1State();
}

class _datadiri1State extends State<datadiri1> {

  final loading = false;


  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Apakah Anda Yakin ?'),
        content: Text('Apakah Yakin Ingin Keluar Dari Aplikasi'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          FlatButton(
            onPressed: () => exit(0),
            /*Navigator.of(context).pop(true)*/
            child: Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }


  BaseEndPoint network = NetworkProvider();

  TextEditingController etnik = TextEditingController();
  TextEditingController etkk = TextEditingController();
  TextEditingController etkodepos = TextEditingController();
  TextEditingController etalamatktp = TextEditingController();
  TextEditingController etalamatdomisili = TextEditingController();

  var InSignIn = false;
  String valProvince,
      valposisi,
      valprovince2,
      valtempatlahir,
      valGender,
      valAgama,
      valProvince_tmp,
      valPernikahan;
  String valCity2;
  String valPendidikan2;
  String valCity;
  String valPendidikan;
  List dataProvince = List();
  List dataCity = [];
  List dataCitykota = [];
  List dataPendidikan = [];
  List listAgama = [
    {"inisial": "Islam", "isi": "Islam"},
    {"inisial": "Kristen", "isi": "Kristen"},
    {"inisial": "Budha", "isi": "Budha"},
    {"inisial": "Katolik", "isi": "Katolik"},
    {"inisial": "Hindu", "isi": "Hindu"},
    {"inisial": "Konghucu", "isi": "Konghucu"},
  ];

  List listGender = [
    {"inisial": "L", "isi": "Laki-Laki"},
    {"inisial": "P", "isi": "Perempuan"},
  ];
  List listPernikahan = [
    {"inisial": "belum menikah", "isi": "Belum Menikah"},
    {"inisial": "menikah", "isi": "Menikah"},
    {"inisial": "bercerai", "isi": "Bercerai"},
  ];

  DateTime _dueDate = DateTime.now();
  String dateText = "";

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

  void provinsi() async {
//    dataProvince = await network.getProvince();
    final response =
        await http.get(NetworkConfig().baseUrl + "master_api/provinsi");
    var listdata = jsonDecode(response.body);
    setState(() {
      dataProvince = listdata;
    });
    // print("data : $dataProvince");
  }

  void kabupaten(String id_province) async {
    final response = await http.post(
        NetworkConfig().baseUrl + "master_api/city",
        body: {'id': id_province});
    var listcity = jsonDecode(response.body);
    setState(() {
      dataCity = listcity;
    });
    // print("DataCity : $dataCity");
  }

  // void kota(String id_province) async {
  //   final response = await http.post(
  //       NetworkConfig().baseUrl + "master_api/city",
  //       body: {'id': id_province});
  //   var listcity = jsonDecode(response.body);
  //   setState(() {
  //     dataCitykota = listcity;
  //   });
  //   // print("DataCity : $dataCity");
  // }

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

  String nikvalidator(String value) {
    if (value.length < 16) {
      return "Nik must be length 16";
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

  String nik, kodepos, kk;
  void validasi() {
    if (valtempatlahir == null ||
        dateText == null ||
        dateText == "null" ||
        dateText == "" ||
        valGender == null ||
        valAgama == null ||
        valProvince == null ||
        valCity == null ||
        valPernikahan == null) {
      Toast.show("Tidak boleh Kosong", context,
          duration: 3, gravity: Toast.BOTTOM);
    } else {
      if (_formKey.currentState.validate()) {
        //JIKA TRUE
        _formKey.currentState.save(); //MAKA FUNGSI SAVE() DIJALANKAN
        print("tempatlahir${valtempatlahir.toString()}");

        print("tempatlahir${valtempatlahir.toString()}");
        print("dateText${dateText}");
        print("valGender${valGender}");
        print("valAgama${valAgama}");
        print("valProvince${valProvince}");
        print("valCity${valCity}");
        print("valPernikahan${valPernikahan}");
        print("etalamatdomisili${etalamatdomisili.text.toString()}");
        print("etalamatktp${etalamatktp.text.toString()}");
        //Dialogs.showLoadingDialog(context, _formKey); //invoking login

        setState(() {
          InSignIn = true;
        });
        register_datadiri1();
      };
    }
  }

  void register_datadiri1() async {
    ModelRegister data = await network.register_datadiri1(
        register_email,
        etnik.text.toString(),
        etkk.text.toString(),
        valtempatlahir.toString(),
        dateText.toString(),
        valGender,
        valAgama,
        valProvince,
        valCity,
        etalamatktp.text.toString(),
        etalamatdomisili.text.toString(),
        etkodepos.text.toString(),
        valPernikahan);

    //Toast.show("${data.status}", context, duration: 3, gravity: Toast.BOTTOM);

    if (data.status == 200) {
      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => datadiri2(),
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
    provinsi();
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
                            Text("NIK"),
                            Text(
                              "*",
                              style: TextStyle(color: Colors.red),
                            )
                          ]),
                          SizedBox(height: 5),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: etnik,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
                              ),
                            ),
                            validator: nikvalidator,
                            // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                            onSaved: (value) {
                              nik = value;
                            },
                          ),
                          SizedBox(height: 16),
                          Row(
                              children: <Widget>[
                                Text("No Kartu Keluarga"),
                                Text(" (dapat di kosongkan)", style: TextStyle(color:Colors.red, fontSize: 10),),
                              ]),
                          SizedBox(height: 5),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: etkk,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
                              ),
                            ),
                            // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                            onSaved: (value) {
                              kk = value;
                            },
                          ),
                          SizedBox(height: 16),
                          Row(children: <Widget>[
                            Text("Tempat Lahir"),
                            Text(
                              "*",
                              style: TextStyle(color: Colors.red),
                            )
                          ]),
                          SizedBox(height: 8),
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
                                  items: dataProvince.map((item) {
                                    return item['province'];
                                  }).toList(),
                                  maxHeight: 300,
                                  onChanged: (value) async {
                                    setState(() {
                                      for(var f in dataProvince) {
                                        // print(f['province'].toString());
                                        if (f['province'].toString() == value) {
                                          valProvince_tmp = f['id'];
                                        }
                                      }
                                      valtempatlahir = null;
                                    });
                                    dataCitykota = await network.getCity2(valProvince_tmp);
                                    setState(() {
                                      dataCitykota = dataCitykota;
                                    });

                                  },
                                  showSearchBox: true,

                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
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
                                  items: dataCitykota.map((item) {
                                    return item['city'];
                                  }).toList(),
                                  maxHeight: 300,
                                  onChanged: (value) async {
                                    setState(() {
                                      for(var f in dataCitykota) {
                                        if (f['city'].toString() == value) {
                                          valtempatlahir = f['id'];
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
                            Text("Tanggal Lahir"),
                            Text(
                              "*",
                              style: TextStyle(color: Colors.red),
                            )
                          ]),
                          SizedBox(height: 10),
                          Row(
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
                                  dateText == "" ? "Tanggal Lahir" : dateText,
                                  style: TextStyle(fontSize: 16, color: Colors.blue),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(children: <Widget>[
                            Text("Jenis Kelamin"),
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
                                  border: Border(bottom: BorderSide(color : Colors.blueGrey))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton(
                                  isExpanded: true,
                                  value: valGender,
                                  hint: Text("Pilih jenis kelamin"),
                                  items: listGender.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item['isi']),
                                      value: item['inisial'],
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      valGender = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(children: <Widget>[
                            Text("Agama"),
                            Text(
                              "*",
                              style: TextStyle(color: Colors.red),
                            )
                          ]),
                          SizedBox(height: 10),
                          //agama
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
                                  value: valAgama,
                                  hint: Text("Pilih Agama"),
                                  items: listAgama.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item['isi']),
                                      value: item['inisial'],
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      valAgama = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(children: <Widget>[
                            Text("Province"),
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
                                  items: dataProvince.map((item) {
                                    return item['province'];
                                  }).toList(),
                                  maxHeight: 300,
                                  onChanged: (value) async {
                                    setState(() {
                                      for(var f in dataProvince) {
                                        // print(f['province'].toString());
                                        if (f['province'].toString() == value) {
                                          valProvince = f['id'];
                                        }
                                      }
                                      valCity = null;
                                    });
                                    dataCity = await network.getCity(valProvince);
                                    setState(() {
                                      dataCity = dataCity;
                                    });

                                  },
                                  showSearchBox: true,

                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(children: <Widget>[
                            Text("City"),
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
                                  items: dataCity.map((item) {
                                    return item['city'];
                                  }).toList(),
                                  maxHeight: 300,
                                  onChanged: (value) async {
                                    setState(() {
                                      for(var f in dataCity) {
                                        if (f['city'].toString() == value) {
                                          valCity = f['id'];
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
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: etkodepos,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
                              ),
                              labelText: "Kode Pos",
                              hintText: "Kode Pos",
                            ),
                            // validator: namevalidator,
                            // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                            onSaved: (value) {
                              kodepos = value;
                            },
                          ),
                          SizedBox(height: 16),
                          Row(children: <Widget>[
                            Text("Status Pernikahan"),
                            Text(
                              "*",
                              style: TextStyle(color: Colors.red),
                            )
                          ]),
                          SizedBox(height: 10),
                          //status pernikahan
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
                                  value: valPernikahan,
                                  hint: Text("Pilih Pernikahan"),
                                  items: listPernikahan.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item['isi']),
                                      value: item['inisial'],
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      valPernikahan = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: etalamatktp,
                            keyboardType: TextInputType.multiline,
                            // maxLines: 4,
                            maxLength: 500,

                            // controller: etNo_hp,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
                              ),
                              labelText: "Alamat NIK",
                              hintText: "Alamat NIK",
                            ),
                            validator: namevalidator,
                            // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                            onSaved: (value) {
                              // hp = value;
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: etalamatdomisili,
                            keyboardType: TextInputType.multiline,
                            //maxLines: 4,
                            maxLength: 500,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
                              ),
                              labelText: "Alamat Domisili",
                              hintText: "Alamat Domisili",
                            ),
                            validator: namevalidator,
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
                            child:
                                InSignIn
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
