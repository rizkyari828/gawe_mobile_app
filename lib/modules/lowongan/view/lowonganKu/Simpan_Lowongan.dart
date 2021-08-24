import 'package:flutter/material.dart';
import 'package:gaweid2/model/user/ModelLowongan2.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/lowongan/view/detail_lowongan.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;

class Simpan_Lowongan extends StatefulWidget {
  @override
  _Simpan_LowonganState createState() => _Simpan_LowonganState();
}

class _Simpan_LowonganState extends State<Simpan_Lowongan> {
  var globalName = "",
      globalEmail = "",
      globalLevel = "",
      id_user = "",
      globalid_employee = "";
  var status = false;
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

  Future<List> Simpan_Lowongan() async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/lowongan_tersimpan", body: {
      'employee_id': globalid_employee,
    });
    ModelLowongan2 listdata = modelLowongan2FromJson(response.body);
    if (response.statusCode == 200) {
      //print("get data succeessfully");
    } else {
      // print("Get Data Failed");
    }
    return listdata.lowongan;
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
      body: FutureBuilder(
        future: Simpan_Lowongan(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print("snap${snapshot.hasData}");

          if (snapshot.hasData == false) {
            if (mystatus == true) {
              return Container(
                child: Center(child: CircularProgressIndicator()),
              );
            } else {
              return Container(
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'images/kategori/LowonganTersimpan.png',
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Text(
                          'Tidak ada lowongan tersimpan',
                          style: TextStyle(
                              fontSize: 20),
                        ),
                      ]),
                ),
              );
            }
          } else {
            return snapshot.hasData
                ?
            ItemList(
                    list: snapshot.data, globalid_employee: globalid_employee)
                : Center(
                    child: mystatus == true
                        ? CircularProgressIndicator()
                        : Container(
                            child: Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      'images/kategori/LowonganTersimpan.png',
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                    Text(
                                      'Tidak Ada Lowongan Tersimpan',
                                      style: TextStyle(
                                          fontSize: 20,),
                                    ),
                                  ]),
                            ),
                          ),
                  );
          }
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  List list;
  String globalid_employee;
  ItemList({this.list, this.globalid_employee});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (BuildContext context, int index) {
        final xlowongan = list[index];
        if (xlowongan.idLowongan == "0000") {
          return Container(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'images/kategori/LowonganTersimpan.png',
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Text(
                      'Tidak ada lowongan tersimpan',
                      style:
                          TextStyle(fontSize: 20),
                    ),
                  ]),
            ),
          );
        } else {
          return SingleChildScrollView(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 2,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Detail_lowongan(
                            logo: xlowongan.logo == null
                                ? ""
                                : xlowongan.logo,
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
                            deskripsi:
                            xlowongan.deskripsi.toString() == null
                                ? ""
                                : xlowongan.deskripsi.toString(),
                            jenispekerjaan : xlowongan.jenispekerjaan.toString() == null
                                ? "" : xlowongan.jenispekerjaan.toString(),
                            id_perusahaan : xlowongan.id_perusahaan.toString() == null ? "" : xlowongan.id_perusahaan.toString(),
                            directLink: xlowongan.directLink.toString() == null ? "" : xlowongan.directLink.toString(),
                              )));
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 15,),
                            child: Image.network(
                              xlowongan.logo,
                              height:
                              MediaQuery.of(context).size.height / 12,
                              width: MediaQuery.of(context).size.width / 5,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width/1.8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  xlowongan.posisi,
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: mainColor,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  xlowongan.namaPerusahaan,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),

                                Row(
                                  children: [
                                    Icon(Icons.work_rounded, size: 15, color: Colors.grey,),
                                    Text(
                                      " ${xlowongan.jenispekerjaan}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.add_location_rounded, size: 15, color: Colors.grey,),
                                        Text(
                                          " ${xlowongan.provinceId}",
                                          overflow: TextOverflow.fade,
                                          maxLines: 2,
                                          softWrap: false,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left:16.0),
                                      child: Text( xlowongan.distance == null || xlowongan.distance == "-" ? "" :
                                      " ${xlowongan.distance}",
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                        softWrap: false,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: mainColor),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: MediaQuery.of(context)
                                                .size
                                                .height /
                                                100),
                                        child: Text(
                                            xlowongan.totalPelamar
                                                .toString() +
                                                " Pelamar",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            )),
                                      ),
                                      Text(
                                        xlowongan.datePostEnd.toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
