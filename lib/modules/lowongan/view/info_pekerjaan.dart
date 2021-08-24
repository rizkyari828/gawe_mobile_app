import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gaweid2/model/user/ModelLowonganDetail.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as html;
import 'package:http/http.dart' as http;

class info_pekerjaaan extends StatefulWidget {
  final id,
      provinsi,
      kota,
      pendidikan,
      jenjang_karir,
      pengalaman,
      gajimin,
      gajimax,
      rincian,
      kualifikasi,
      kuota;

  info_pekerjaaan({
    this.id,
    this.provinsi,
    this.kota,
    this.pendidikan,
    this.jenjang_karir,
    this.pengalaman,
    this.gajimin,
    this.gajimax,
    this.rincian,
    this.kualifikasi,
    this.kuota,
  });

  @override
  _info_pekerjaaanState createState() => _info_pekerjaaanState();
}

class _info_pekerjaaanState extends State<info_pekerjaaan> {
  BaseEndPoint network = NetworkProvider();
  String industri;

  Future<List> getLowongan() async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/lowongan_detail", body: {
      'id_lowongan': widget.id.toString(),
    });
    ModelLowonganDetail listdata = modelLowonganDetailFromJson(response.body);
    if (response.statusCode == 200) {
      print("get data succeessfully detail");
      //print(listdata);
      //print("lowongan${listdata.lowongan}");
    } else {
      print("Get Data Failed gagal detail");
    }
    return listdata.lowongan;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLowongan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Pendidikan",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.pendidikan,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Jenjang Karir",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.jenjang_karir,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Gaji",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.gajimin + ' s/d ' + widget.gajimax,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Pengalaman",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.pengalaman,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Kouta",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(widget.kuota,
                        style: TextStyle(
                          fontSize: 16,
                        )),
                  ]),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Kualifikasi",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(widget.kualifikasi,
                      style: TextStyle(
                        fontSize: 16,
                      )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Rincian",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(widget.rincian,
                      style: TextStyle(
                        fontSize: 16,
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
