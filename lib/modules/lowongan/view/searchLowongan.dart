import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gaweid2/model/user/ModelLowongan.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/lowongan/view/detail_lowongan.dart';
import 'package:gaweid2/utils/theme.dart';

import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<ModelLowongan> _list = [];
  List<ModelLowongan> _search = [];
  var loading = false;
  Future<Null> fetchData() async {
    setState(() {
      loading = false;
    });
    _list.clear();
    final response =
        await http.get(NetworkConfig().baseUrl + "apps/search_lowongan");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data) {
          _list.add(ModelLowongan.fromJson(i));
          loading = false;
        }
      });
    }
  }

  TextEditingController controller = new TextEditingController();

  onSearch(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _list.forEach((f) {
      if (f.posisi.contains(text) ||
          f.posisi.contains(text.toLowerCase()) ||
          f.posisi.contains(text.toUpperCase()) ||
          f.namaPerusahaan.contains(text) ||
          f.namaPerusahaan.contains(text.toLowerCase()) ||
          f.namaPerusahaan.contains(text.toUpperCase())) _search.add(f);
    });

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
//      appBar: AppBar(),
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(left: 20, top: 10, right: 10, bottom: 10),
              color: mainColor,
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.backspace),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  title: TextField(
                    controller: controller,
                    onChanged: onSearch,
                    decoration: InputDecoration(
                        hintText: "Search", border: InputBorder.none),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      controller.clear();
                      onSearch('');
                    },
                    icon: Icon(Icons.cancel),
                  ),
                ),
              ),
            ),
            Container(
              child: loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: _search.length != 0 || controller.text.isNotEmpty
                          ? ListView.builder(
                              itemCount: _search.length,
                              itemBuilder: (context, i) {
                                final xlowongan = _search[i];
                                return SingleChildScrollView(
                                  child: Card(
                                    margin: new EdgeInsets.only(
                                        left: 5.0,
                                        right: 5.0,
                                        top: 5.0,
                                        bottom: 5.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    elevation: 12,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Detail_lowongan(
                                                      logo:
                                                          xlowongan.logo == null
                                                              ? ""
                                                              : xlowongan.logo,
                                                      provinsi: xlowongan
                                                                  .provinceId ==
                                                              null
                                                          ? ""
                                                          : xlowongan
                                                              .provinceId,
                                                      posisi: xlowongan
                                                                  .posisi ==
                                                              null
                                                          ? ""
                                                          : xlowongan.posisi,
                                                      id: xlowongan
                                                                  .idLowongan ==
                                                              null
                                                          ? ""
                                                          : xlowongan
                                                              .idLowongan,
                                                      perusahaan: xlowongan
                                                                  .namaPerusahaan ==
                                                              null
                                                          ? ""
                                                          : xlowongan
                                                              .namaPerusahaan,
                                                      gajimin: xlowongan
                                                                  .gajiMin ==
                                                              null
                                                          ? ""
                                                          : xlowongan.gajiMin,
                                                      gajimax: xlowongan
                                                                  .gajiMax ==
                                                              null
                                                          ? ""
                                                          : xlowongan.gajiMax,
                                                      jenjang_career_id: xlowongan
                                                                  .jenjangCareerId
                                                                  .toString() ==
                                                              null
                                                          ? ""
                                                          : xlowongan
                                                              .jenjangCareerId
                                                              .toString(),
                                                      pendidikan: xlowongan
                                                                  .pendidikan
                                                                  .toString() ==
                                                              null
                                                          ? ""
                                                          : xlowongan.pendidikan
                                                              .toString(),
                                                      city_id: xlowongan
                                                                  .cityId ==
                                                              null
                                                          ? ""
                                                          : xlowongan.cityId,
                                                      pengalaman: xlowongan
                                                                  .pengalamanId
                                                                  .toString() ==
                                                              null
                                                          ? ""
                                                          : xlowongan
                                                              .pengalamanId
                                                              .toString(),
                                                      rincian: xlowongan.rincian
                                                                  .toString() ==
                                                              null
                                                          ? ""
                                                          : xlowongan.rincian
                                                              .toString(),
                                                      kualifikasi: xlowongan
                                                                  .kualifikasi
                                                                  .toString() ==
                                                              null
                                                          ? ""
                                                          : xlowongan
                                                              .kualifikasi
                                                              .toString(),
                                                      kuota: xlowongan.kouta
                                                                  .toString() ==
                                                              null
                                                          ? ""
                                                          : xlowongan.kouta
                                                              .toString(),
                                                      alamat: xlowongan.alamat
                                                                  .toString() ==
                                                              null
                                                          ? ""
                                                          : xlowongan.alamat
                                                              .toString(),
                                                      deskripsi: xlowongan
                                                                  .deskripsi
                                                                  .toString() ==
                                                              null
                                                          ? ""
                                                          : xlowongan.deskripsi
                                                              .toString(),
                                                      jenispekerjaan: xlowongan
                                                                  .jenisPekerjaan
                                                                  .toString() ==
                                                              null
                                                          ? ""
                                                          : xlowongan
                                                              .jenisPekerjaan
                                                              .toString(),
                                                      // jenispekerjaan : "tes",
                                                      id_perusahaan: xlowongan
                                                                  .idPerusahaan
                                                                  .toString() ==
                                                              null
                                                          ? ""
                                                          : xlowongan
                                                              .idPerusahaan
                                                              .toString(),
                                                    )));
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.network(
                                                  xlowongan.logo,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      7,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      xlowongan.posisi,
                                                      overflow:
                                                          TextOverflow.fade,
                                                      maxLines: 1,
                                                      softWrap: false,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                      textAlign:
                                                          TextAlign.justify,
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
                                                      textAlign:
                                                          TextAlign.justify,
                                                    ),
                                                    Text(
                                                      xlowongan.namaPerusahaan,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                      textAlign:
                                                          TextAlign.justify,
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      xlowongan.jenisPekerjaan,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.blue,
                                                      ),
                                                      textAlign:
                                                          TextAlign.justify,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              FlatButton(
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              "Ingin Menyimpan Lowongan ??"),
                                                          content: Text(
                                                              xlowongan.posisi),
                                                          actions: <Widget>[
                                                            FlatButton(
                                                              onPressed: () {
                                                                //Navigator.push(context,MaterialPageRoute (builder:(context)=>Myhome()));
                                                              },
                                                              child: Text("Yes"),
                                                            ),
                                                            FlatButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text("NO"),
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                },
                                                child: Image.asset("images/menu/save_lowongan.png",height: 50,width: 50,),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(xlowongan.totalPelamar
                                                        .toString() +
                                                    " Pelamar"),
                                                Text(xlowongan.datePostEnd
                                                    .toString()),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: new Wrap(
                                spacing: 5.0,
                                runSpacing: 5.0,
                                direction: Axis
                                    .horizontal, // main axis (rows or columns)
                                children: <Widget>[
                                  Center(
                                    child: Image.asset(
                                      'images/kategori/CariLowongan.png',
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2.6,
                                      //width: MediaQuery.of(context).size.width,
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Cari Lowongan',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
//                  Column(
//                    children: <Widget>[
//                      Image.asset(
//                        'images/kategori/CariLowongan.png',
//                        height:
//                        MediaQuery.of(context).size.height / 2.6,
//                        //width: MediaQuery.of(context).size.width,
//                      ),
////                      Text(
////                        'Cari Lowongan',
////                        style: TextStyle(
////                            fontSize: 20,
////                            fontWeight: FontWeight.bold),
////                      ),
//                    ],
//                  ),
                            ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
