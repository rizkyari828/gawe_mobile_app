import 'package:flutter/material.dart';
import 'package:gaweid2/model/user/ModelLowongan2.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/lowongan/Component/itemLowonganScrool.dart';
import 'package:gaweid2/modules/lowongan/view/detail_lowongan.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;

import 'filter.dart';

class Filter_lowongan extends StatefulWidget {
  String posisi, provinsi, city, pendidikan, jenispekerjaan;

  Filter_lowongan({
    this.posisi,
    this.provinsi,
    this.city,
    this.pendidikan,
    this.jenispekerjaan,
  });

  @override
  _Filter_lowonganState createState() => _Filter_lowonganState();
}

class _Filter_lowonganState extends State<Filter_lowongan> {
  //List<ModelLowongan> lowongan = [];
  var loading = false;

  Future<List> filterLowongan() async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/filter_lowongan", body: {
      'posisi': widget.posisi.toString(),
      'province': widget.provinsi.toString(),
      'city': widget.city.toString(),
      'pendidikan': widget.pendidikan.toString(),
      'jenis_pekerjaan': widget.jenispekerjaan.toString(),
    });

    //final response = await http.get(NetworkConfig().baseUrl+"apps/lowongan");

    ModelLowongan2 listdata = modelLowongan2FromJson(response.body);
    print(listdata);
    if (response.statusCode == 200) {
      print(listdata);
      print("get data succeessfully");
    } else {
      print("Get Data Failed");
    }
    return listdata.lowongan;
  }

  var globalName = "",
      globalEmail = "",
      globalLevel = "",
      id_user = "",
      globalid_employee = "";
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
        globalid_employee = sessionManager.id_employee;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getLowongan();
    getPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(""),
        backgroundColor: mainColor,
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(
          top: 20.0,
        ),
        color: backgroundColor,
        child: FutureBuilder(
          future: filterLowongan(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return snapshot.hasData
                ? ItemListLowonganScrool(
                    list: snapshot.data, globalid_employee: globalid_employee, mystatus: mystatus)
                : Center(
                    child: CircularProgressIndicator(),
                    // Container(
                    //   child: Center(
                    //     child: Column(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: <Widget>[
                    //           Image.asset(
                    //             'images/kategori/Lowongan_T_Ditemukan.png',
                    //             height: MediaQuery.of(context).size.height / 2,
                    //             width: MediaQuery.of(context).size.width,
                    //           ),
                    //           Text(
                    //             'Lowongan tidak ditemukan',
                    //             style: TextStyle(fontSize: 20),
                    //           ),
                    //         ]),
                    //   ),
                    // ),
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => Filter()));
        },
        label: Text('Filter'),
        icon: Icon(Icons.search),
        backgroundColor: Colors.orange,
      ),
    );
  }
}

class ItemList extends StatefulWidget {
  List list;
  String globalid_employee;
  ItemList({this.list, this.globalid_employee});

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list == null ? 0 : widget.list.length,
      itemBuilder: (BuildContext context, int index) {
        final xlowongan = widget.list[index];
        return SingleChildScrollView(
          child: Card(
            margin: new EdgeInsets.only(
                left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            elevation: 12,
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Detail_lowongan(
                          logo:
                          xlowongan.logo == null ? "" : xlowongan.logo,
                          provinsi: xlowongan.provinceId == null
                              ? ""
                              : xlowongan.provinceId,
                          posisi: xlowongan.posisi == null
                              ? ""
                              : xlowongan.posisi,
                          id: xlowongan.idLowongan == null
                              ? ""
                              : xlowongan.idLowongan,
                          perusahaan: xlowongan.namaPerusahaan == null
                              ? ""
                              : xlowongan.namaPerusahaan,
                          gajimin: xlowongan.gajiMin == null
                              ? ""
                              : xlowongan.gajiMin,
                          gajimax: xlowongan.gajiMax == null
                              ? ""
                              : xlowongan.gajiMax,
                          jenjang_career_id:
                          xlowongan.jenjangCareerId.toString() == null
                              ? ""
                              : xlowongan.jenjangCareerId.toString(),
                          pendidikan:
                          xlowongan.pendidikan.toString() == null
                              ? ""
                              : xlowongan.pendidikan.toString(),
                          city_id: xlowongan.cityId == null
                              ? ""
                              : xlowongan.cityId,
                          pengalaman:
                          xlowongan.pengalamanId.toString() == null
                              ? ""
                              : xlowongan.pengalamanId.toString(),
                          rincian: xlowongan.rincian.toString() == null
                              ? ""
                              : xlowongan.rincian.toString(),
                          kualifikasi:
                          xlowongan.kualifikasi.toString() == null
                              ? ""
                              : xlowongan.kualifikasi.toString(),
                          kuota: xlowongan.kouta.toString() == null
                              ? ""
                              : xlowongan.kouta.toString(),
                          alamat: xlowongan.alamat.toString() == null
                              ? ""
                              : xlowongan.alamat.toString(),
                          deskripsi: xlowongan.deskripsi.toString() == null
                              ? ""
                              : xlowongan.deskripsi.toString(),
                          jenispekerjaan:
                          xlowongan.jenispekerjaan.toString() == null
                              ? ""
                              : xlowongan.jenispekerjaan.toString(),
                          directLink: xlowongan.directLink.toString() == null ? "" : xlowongan.directLink.toString(),
                          id_employee: widget.globalid_employee == null ? "" : widget.globalid_employee,
                        )));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          xlowongan.logo,
                          height: MediaQuery.of(context).size.height / 7,
                          width: MediaQuery.of(context).size.width / 3,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              xlowongan.posisi,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              xlowongan.provinceId,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            Text(
                              xlowongan.namaPerusahaan,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              xlowongan.jenispekerjaan,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Ingin Menyimpan Lowongan ??"),
                                  content: Text(xlowongan.posisi),
                                  actions: <Widget>[
                                    FlatButton(
                                      onPressed: () {
                                        //Navigator.push(context,MaterialPageRoute (builder:(context)=>Myhome()));
                                        // simpan_lowongan()
                                        //print(id_user);
                                        simpanLowongan(xlowongan.idLowongan,
                                            widget.globalid_employee);
                                        Navigator.pop(context);
                                      },
                                      child: Text("Ya"),
                                    ),
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Tidak"),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Icon(Icons.save),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(xlowongan.totalPelamar.toString() + " Pelamar"),
                        Text(xlowongan.datePostEnd.toString()),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void simpanLowongan(idLowongan, globalid_employee) async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/simpan_lowongan", body: {
      'lowongan_id': idLowongan,
      'employee_id': globalid_employee,
    });

    if (response.statusCode == 200) {
      print("berhasi disimpan lowongan");
//      Navigator.pop();
//      Navigator.of(context).pop();
//      Navigator.pop(context);

    } else {
      print("gagal disimpan lowongan");
    }

    print("idlowongan${idLowongan}");
    print("id_employee${globalid_employee}");
  }
}


