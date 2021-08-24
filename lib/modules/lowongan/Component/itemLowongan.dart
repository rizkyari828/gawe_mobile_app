import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gaweid2/ui/DW/lowongan_detail_dw.dart';
import 'package:gaweid2/modules/user/view/Login.dart';
import 'package:gaweid2/modules/lowongan/view/detail_lowongan.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:toast/toast.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_share/flutter_share.dart';

class ItemListLowongan extends StatefulWidget {
  List list;
  bool mystatus;
  String globalid_employee;
  ItemListLowongan({this.list, this.globalid_employee, this.mystatus});

  @override
  _ItemListLowonganState createState() => _ItemListLowonganState();

}

class _ItemListLowonganState extends State<ItemListLowongan> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:10.0, right:10),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: widget.list.length,
        itemBuilder: (context, index) {
          final xlowongan = widget.list[index];
          Future<void> share() async {
            await FlutterShare.share(
                title: 'Lowongan',
                text: '${xlowongan.posisi}',
                linkUrl: 'https://gawe.id/lowongan/detail/${base64.encode(utf8.encode(xlowongan.idLowongan))}',
                chooserTitle: 'Share Lowongan');
          }
          return Card(
            margin: new EdgeInsets.only(
                left: 5.0, right: 5.0,bottom: 5.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 1,
            child: InkWell(
              onTap: () {
                if (xlowongan.jenispekerjaan == "Daily Worker") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Detail_lowongan_DW(
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
                            jenjang_career_id: xlowongan.jenjangCareerId
                                .toString() ==
                                null
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
                            // jenispekerjaan : xlowongan.jenispekerjaan.toString() == null ? "" : xlowongan.jenispekerjaan.toString(),
                          )));
                } else {
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
                            jenjang_career_id: xlowongan.jenjangCareerId
                                .toString() ==
                                null
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
                            jenispekerjaan:
                            xlowongan.jenispekerjaan.toString() ==
                                null
                                ? ""
                                : xlowongan.jenispekerjaan.toString(),
                            datePostEnd:
                            xlowongan.datePostEnd.toString() ==
                                null
                                ? ""
                                : xlowongan.datePostEnd.toString(),
                            directLink: xlowongan.directLink.toString() == null ? "" : xlowongan.directLink.toString(),
                            id_employee: widget.globalid_employee == null ? "" : widget.globalid_employee,
                          )));
                }
              },
              child: SingleChildScrollView(
                // shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            width: MediaQuery.of(context).size.width/1.6,
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
                                            fontSize: 14,
                                            color: mainColor),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(onPressed: share, icon: Icon(Icons.share, color: Colors.grey, size: 20,),),
                        IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: widget.mystatus == true
                                        ? Text(
                                        "Ingin Menyimpan Lowongan ?")
                                        : Text(
                                        "Silahkan Anda Login Dulu !!"),
                                    content: Text(xlowongan.posisi),
                                    actions: <Widget>[
                                      MaterialButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Tidak"),
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          //Navigator.push(context,MaterialPageRoute (builder:(context)=>Myhome()));
                                          // simpan_lowongan()
                                          //print(id_user);
                                          if (widget.mystatus == true) {
                                            simpanLowongan(
                                                xlowongan.idLowongan,
                                                widget.globalid_employee,
                                                context);
                                            Navigator.pop(context);
                                          } else {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Login()));
                                          }
                                        },
                                        child: Text("Ya"),
                                      ),
                                    ],
                                  );
                                });
                          },
                          icon: Icon(Icons.bookmark_border_rounded, color: Colors.grey, size: 20,),),
                        Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context)
                                  .size
                                  .height /
                                  100),
                          child: Text(
                              xlowongan.pelamarTeks
                                  .toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              )),
                        ),
                        Text(
                          xlowongan.duration.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

void simpanLowongan(idLowongan, globalid_employee, context) async {
  Toast.show("Lowongan Berhasil Disimpan", context,
      duration: 3, gravity: Toast.TOP);

  final response =
  await http.post(NetworkConfig().baseUrl + "apps/simpan_lowongan", body: {
    'lowongan_id': idLowongan,
    'employee_id': globalid_employee,
  });

  if (response.statusCode == 200) {
    print("berhasi disimpan lowongan");
    Toast.show("Lowongan Berhasil Disimpan", context,
        duration: 3, gravity: Toast.BOTTOM);
//      Navigator.pop();
//      Navigator.of(context).pop();
//      Navigator.pop(context);

  } else {
    print("gagal disimpan lowongan");
  }

//    print("idlowongan${idLowongan}");
//    print("id_employee${globalid_employee}");
}
