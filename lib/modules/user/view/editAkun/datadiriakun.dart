import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/ui/User/Fragment/AkunUser_backup.dart';
import 'package:gaweid2/modules/user/view/menu/UserDashboard.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

class datadiriakun extends StatefulWidget {
  final name, email, tgl_lahir, kota, picture,province_lahir;
  datadiriakun(
      {this.name, this.email, this.kota, this.tgl_lahir, this.picture,this.province_lahir});

  @override
  _datadiriakunState createState() => _datadiriakunState();
}

class _datadiriakunState extends State<datadiriakun> {
  var InSignIn = false;
  var globalName = "",
      globalEmail = "",
      globalLevel = "",
      id_user = "",
      globalid_employee = "",
      globalprofil_power = "";
  var status = false;

  var etname, etemail, mystatus, valProvince_tmp;

  BaseEndPoint network = NetworkProvider();

  DateTime _dueDate = DateTime.now();
  String dateText = "";

  List dataProvince = List();
  List dataCity = [];
  String valtempatlahir, valProvince;

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


  void validasi() async {
    if (etname.text.toString() == null) {
      Toast.show("Tidak boleh Kosong", context,
          duration: 3, gravity: Toast.BOTTOM);
    } else {
      if (_formKey.currentState.validate()) {
        //JIKA TRUE
        _formKey.currentState.save(); //MAKA FUNGSI SAVE() DIJALANKAN
        // Toast.show("success", context, duration: 3, gravity: Toast.BOTTOM);

        setState(() {
          InSignIn = true;
        });

        ModelRegister data = await network.gantidatadiri1(
            globalEmail,
            etname.text.toString(),
            valtempatlahir.toString(),
            dateText.toString(),
            context);

        print("valtempatlahir${valtempatlahir.toString()}");
        print("dateText${dateText.toString()}");

        if (data.status == 200) {
          Toast.show("Success", context, duration: 3, gravity: Toast.BOTTOM);
          Navigator.pop(context);
        } else {
          print("gagal");
          Toast.show("Gagal", context, duration: 3, gravity: Toast.BOTTOM);
        }
        //Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => UserDashboard()));
      }
      ;
    }
  }

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPreferences();
    provinsi();

    etname = TextEditingController(text: widget.name);
    etemail = TextEditingController(text: widget.email);
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
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
                  SizedBox(height: 16),
                  Center(
                      child: Row(children: <Widget>[
                    Text("Nama"),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    )
                  ])),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: etname,
                    //initialValue: widget.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Nama",
                      hintText: "Nama",
                    ),
                    //validator: nikvalidator,
                    // validator: (value) => value.length < 6 ? 'Password too short.' : null,
//            onSaved: (value) {
//              nik = value;
//            },
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(color: Colors.blueGrey)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                          value: valProvince_tmp,
                          hint: Text(
                            widget.province_lahir,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                          items: dataProvince.map((item) {
                            return DropdownMenuItem(
                              child: Text(item['province']),
                              value: item['id'],
                            );
                          }).toList(),
                          onChanged: (value) async {
                            dataCity = await network.getCity(value);
                            setState(() {
                              valProvince_tmp = value;
                              valtempatlahir = null;
                            });
                            //print(dataCity);
                          },
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(color: Colors.blueGrey)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                          isExpanded: true,
                          value: valtempatlahir,
                          hint: Text(
                            widget.kota,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                          items: dataCity.map((item) {
                            return DropdownMenuItem(
                              child: Text(
                                item['type'] + " " + item['city'],
                              ),
                              value: item['id'],
                            );
                          }).toList(),
                          onChanged: (value) async {
                            // dataCity = await network.getCity(value);
                            setState(() {
                              valtempatlahir = value;
                            });
                            //print(dataCity);
                          },
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
                          dateText == "" ? widget.tgl_lahir : dateText,
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      )
                    ],
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
          )
        ],
      ),
    );
  }
}
