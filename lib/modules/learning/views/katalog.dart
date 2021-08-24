import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/modules/learning/views/menuLearning.dart';
import 'package:gaweid2/modules/learning/views/penempatan.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class Katalog extends StatefulWidget {
  @override
  _KatalogState createState() => _KatalogState();
  final email;

  Katalog({this.email});
}

class _KatalogState extends State<Katalog> {
  BaseEndPoint network = NetworkProvider();
  TextEditingController etKodeReferral = TextEditingController();
  TextEditingController etPenempatan = TextEditingController();

  String valPosisiPekerjaan, valLevel;

  List dataPosisi = [];

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
    getPosisi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: mainColor,
        elevation: 0,
      ),
      body: Container(
        color: backgroundColor,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TextFormField(
                      style:
                      TextStyle(fontSize: 16.0, color: Colors.black),
                      controller: etKodeReferral,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                        ),
                        // labelText: "Email",
                        hintText: "Kode Referral",
                      ),
                      // validator: emailValidator,
                      // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                      onSaved: (value) {
                        // email = value;
                      },
                    ),
                    TextFormField(
                      style:
                      TextStyle(fontSize: 16.0, color: Colors.black),
                      // controller: etEmail,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                        ),
                        // labelText: "Email",
                        hintText: "Level",
                      ),
                      // validator: emailValidator,
                      // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                      onSaved: (value) {
                        // email = value;
                      },
                    ),
                    TextFormField(
                      style:
                      TextStyle(fontSize: 16.0, color: Colors.black),
                      controller: etPenempatan,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: mainColor),
                        ),
                        // labelText: "Email",
                        hintText: "Penempatan",
                      ),
                      // validator: emailValidator,
                      // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                      onSaved: (value) {
                        // email = value;
                      },
                    ),
                    Container(
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
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              child: MaterialButton(
                                onPressed: () {
                                  submit(etKodeReferral.text, valLevel, valPosisiPekerjaan, etPenempatan.text);
                                },
                                color: mainColor,
                                child: Text("Submit",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


void submit(kodeReferral, level, posisi, penempatan) async {
    // print(kodeReferral.toString());
    ModelRegister data = await network.Katalog(
        widget.email.toString(),
        kodeReferral.toString(),
        level.toString(),
        posisi.toString(),
        penempatan.toString());
    print(data.status);

    if (data.status == 202 ) {
      Toast.show("Data berhasil disimpan", context,
          duration: 3, gravity: Toast.TOP);
      Navigator.of(context)
          .push(new MaterialPageRoute(
        builder: (BuildContext context) =>
            MenuLearning(),
      ));
  }
}
}
