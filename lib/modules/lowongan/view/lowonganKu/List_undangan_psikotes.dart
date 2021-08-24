import 'package:flutter/material.dart';
import 'package:gaweid2/model/undangan/Model_Psikotes.dart';

import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/lowongan/view/lowonganKu/psikotes_detail.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;

class List_undangan_psikotes extends StatefulWidget {
  @override
  _List_undangan_psikotesState createState() => _List_undangan_psikotesState();
}

class _List_undangan_psikotesState extends State<List_undangan_psikotes> {
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

  Future<List> getUndanganPsikotes() async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/undangan_psikotes", body: {
      //'employee_id': globalid_employee,
      'employee_id': globalid_employee
    });
    ModelPsikotes listdata = modelPsikotesFromJson(response.body);
    if (response.statusCode == 200) {
      //print("get data succeessfully");
    } else {
      // print("Get Data Failed");
    }
    // print(listdata);
    return listdata.undangan;
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
        future: getUndanganPsikotes(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // print("snap${snapshot.hasData}");

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
                          'belum ada undangan',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ]),
                ),
              );
            }
          } else {
            return snapshot.hasData
                ? ItemList(
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
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
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
        final Undangan xundangan = list[index];

        // print(xundangan.id);

        if (xundangan.id == "0000") {
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
                      'Tidak Ada Undangan Psikotes',
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
                          builder: (context) => psikotes_detail(
                            logo: xundangan.logo == null
                                ? ""
                                : xundangan.logo,

                            nama_perusahaan: xundangan.namaPerusahaan == null
                                ? ""
                                : xundangan.namaPerusahaan,
                            tanggalPsikotes: xundangan.tanggalPsikotes == null
                                ? ""
                                : xundangan.tanggalPsikotes,
                            keteranganUndangan: xundangan.keterangan == null
                                ? ""
                                : xundangan.keterangan,
                            id_interview: xundangan.id == null
                                ? ""
                                : xundangan.id,
                            lowongan_id: xundangan.lowonganId == null
                                ? ""
                                : xundangan.lowonganId,


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
                            xundangan.logo,
                            height: MediaQuery.of(context).size.height / 12,
                            width: MediaQuery.of(context).size.width / 5,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  xundangan.posisi,
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: mainColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  xundangan.namaPerusahaan,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  xundangan.provinceId,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(xundangan.tanggalPsikotes.toString()),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
