import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gaweid2/model/user/ModelLowongan2.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/lowongan/view/filter_lowongan.dart';
import 'package:gaweid2/modules/lowongan/view/lowongan.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  BaseEndPoint network = NetworkProvider();

  TextEditingController etPosisi = TextEditingController();
  TextEditingController etProvince = TextEditingController();
  TextEditingController etCity = TextEditingController();
  TextEditingController etPendidikan = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String valProvince, valposisi, valprovince2;
  String valCity2;
  String valPendidikan2;
  String valCity;
  String valPendidikan,valjenispekerjaan;
  List dataProvince = List();
  List dataCity = [];
  List dataPendidikan = [];

  List listjenispekerjaan = [
    {"inisial": "1", "isi": "Fulltime"},
    {"inisial": "2", "isi": "Freelance"},
    {"inisial": "3", "isi": "Magang"},
    {"inisial": "4", "isi": "Pekerjaan Harian"},
  ];

  void cariLowongan() async {
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
        builder: (BuildContext context) => Filter_lowongan(
              posisi: etPosisi.text == null ? "" : etPosisi.text.toString(),
              provinsi: valProvince == null ? "" : valProvince.toString(),
              city: valCity == null ? "" : valCity.toString(),
              pendidikan: valPendidikan == null ? "" : valPendidikan.toString(),
              jenispekerjaan: valjenispekerjaan == null ? "" : valjenispekerjaan.toString(),
            )));
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

  void pendidikan() async {
//    dataProvince = await network.getProvince();
    final response =
        await http.get(NetworkConfig().baseUrl + "master_api/pendidikan");
    var listdata = jsonDecode(response.body);
    setState(() {
      dataPendidikan = listdata;
    });

    //print("pendidikan : $dataPendidikan");
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provinsi();
    pendidikan();
  }

  @override
  Widget build(BuildContext context) {
    //print("dataProvince${dataProvince}");

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Cari Lowongan",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            TextFormField(
                              controller: etPosisi,
                              decoration: InputDecoration(
                                hintText: "Posisi",
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height/11,
                              child: DropdownButton(
                                value: valProvince,
                                hint: Text("Pilih Provinsi"),
                                items: dataProvince.map((item) {
                                  return DropdownMenuItem(
                                    child: Text(item['province']),
                                    value: item['id'],
                                  );
                                }).toList(),
                                onChanged: (value) async {
                                  dataCity = await network.getCity(value);
                                  setState(() {
                                    valProvince = value;
                                    valCity = null;
                                  });
                                  //print(dataCity);
                                },
                              ),
                            ),

                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height/11,
                              child: DropdownButton(
                                isExpanded: true,
                                value: valCity,
                                hint: Text("Pilih Kota"),
                                items: dataCity.map((item) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      item['type'] + " " + item['city'],
                                    ),
                                    value: item['id'],
                                  );
                                }).toList(),
                                onChanged: (value) async {
                                  // dataKecamatan = await network.getKecamatan(value);
                                  setState(() {
                                    valCity = value;
                                    // valKecamatan = null;
                                  });
                                  // await kabupaten(value);
                                },
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height/11,
                              child: DropdownButton(
                                value: valPendidikan,
                                //value: valPendidikan == null ? valPendidikan : buildingTypes.where( (i) => i.name == valPendidikan.name).first as BuildingType,
                                hint: Text("Pilih Pendidikan"),
                                items: dataPendidikan.map((item) {
                                  return DropdownMenuItem(
                                    child: Text(item['title']),
                                    value: item['id'],
                                  );
                                }).toList(),
                                onChanged: (value) async {
                                  // dataCity = await network.getCity(value);
                                  setState(() {
                                    valPendidikan = value;
                                    // valCity = null;
                                  });

                                  //print(dataCity);
                                },
                              ),
                            ),

                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height/11,
                              child: DropdownButton(
                                isExpanded: true,
                                value: valjenispekerjaan,
                                hint: Text("Pilih Jenis Pekerjaan"),
                                items: listjenispekerjaan.map((item) {
                                  return DropdownMenuItem(
                                    child: Text(item['isi']),
                                    value: item['inisial'],
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    valjenispekerjaan = value;
                                  });
                                },
                              ),
                            ),

                            ButtonTheme(
                              minWidth: MediaQuery.of(context).size.width,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                onPressed: () {
                                  cariLowongan();
                                },
                                child: Text("Cari", style: TextStyle(color: Colors.white)),
                                color: mainColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
