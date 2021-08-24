import 'package:flutter/material.dart';
import 'package:gaweid2/modules/lowongan/models/lowongan_model_pagination.dart';
import 'package:gaweid2/modules/lowongan/services/lowongan_service.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/user/view/Login.dart';
import 'package:gaweid2/modules/lowongan/view/detail_lowongan.dart';
import 'package:gaweid2/modules/lowongan/view/filter.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class LowonganTerdekat extends StatefulWidget {
  String globalid_employee;

  LowonganTerdekat({this.globalid_employee});
  @override
  _LowonganTerdekatState createState() => _LowonganTerdekatState();
}

class _LowonganTerdekatState extends State<LowonganTerdekat> {
  LowonganPagination coin;
  var scrollController = ScrollController();
  bool updating = false;

  var globalName = "",
      globalEmail = "",
      globalLevel = "",
      id_user = "",
      globalid_employee = "",
      globalprofil_power = "";
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
        globalprofil_power = sessionManager.profile_power;
        globalid_employee = sessionManager.id_employee;
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
    //getLowongan();
    getCoin();
    getPreferences();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getCoin() async {
    coin = await apiHelper.getCoins();
    setState(() {});
  }

  checkUpdate() async {
    setState(() {
      updating = true;
    });
    var scrollpositin = scrollController.position;
    if (scrollpositin.pixels == scrollpositin.maxScrollExtent) {
      // if (mystatus == true) {
      var newapi = apiHelper.getApi(widget.globalid_employee,"terdekat",coin.data.length);
      var newcoin =
      await apiHelper.getCoins(newapi.toString()) as LowonganPagination;
      // print(newcoin);
      coin.data.addAll(newcoin.data);
      // } else {}
      // print("data ${newcoin.data}");
    }
    setState(() {
      updating = false;
    });
  }

  getBody() {
    if (coin == null) return Center(child: CircularProgressIndicator());
    return NotificationListener<ScrollNotification>(
      onNotification: (noti) {
        if (noti is ScrollEndNotification) {
          checkUpdate();
        }
        return true;
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    onPressed: () {

                    },
                    color: mainColor,
                    child: Text("Terbaru",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    onPressed: () {

                    },
                    color: Colors.white,
                    child: Text("Terdekat",
                        style: TextStyle(color: mainColor)),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (c, i) {
                  final xlowongan = coin.data[i];
                  return Card(
                    margin: new EdgeInsets.only(
                        left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
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
                                  xlowongan.pengalamanId.toString() ==
                                      null
                                      ? ""
                                      : xlowongan.pengalamanId.toString(),
                                  rincian:
                                  xlowongan.rincian.toString() == null
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
                                  jenispekerjaan: xlowongan.jenispekerjaan
                                      .toString() ==
                                      null
                                      ? ""
                                      : xlowongan.jenispekerjaan.toString(),
                                  id_perusahaan: xlowongan.id_perusahaan
                                      .toString() ==
                                      null
                                      ? ""
                                      : xlowongan.id_perusahaan.toString(),
                                  directLink: xlowongan.directLink.toString() == null ? "" : xlowongan.directLink.toString(),
                                  id_employee: widget.globalid_employee == null ? "" : widget.globalid_employee,
                                )));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Image.network(
                                    xlowongan.logo,
                                    height:
                                    MediaQuery.of(context).size.height / 12,
                                    width: MediaQuery.of(context).size.width / 5,
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
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        xlowongan.provinceId,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        xlowongan.jenispekerjaan,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: mainColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
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
                                                    fontSize: 10,
                                                  )),
                                            ),
                                            Text(
                                              xlowongan.datePostEnd.toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: mystatus == true
                                                ? Text(
                                                "Ingin Menyimpan Lowongan ?")
                                                : Text(
                                                "Silahkan Anda Login Dulu !!"),
                                            content: Text(xlowongan.posisi),
                                            actions: <Widget>[
                                              FlatButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Tidak"),
                                              ),
                                              FlatButton(
                                                onPressed: () {
                                                  //Navigator.push(context,MaterialPageRoute (builder:(context)=>Myhome()));
                                                  // simpan_lowongan()
                                                  //print(id_user);
                                                  if (mystatus == true) {
                                                    simpanLowongan(
                                                        xlowongan.idLowongan,
                                                        globalid_employee,
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
                                  child: Image.asset(
                                    "images/menu/save_lowongan.png",
                                    height: 25,
                                    width: 25,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  );
                },
                itemCount: coin.data.length,
              ),
            ),
            if (updating)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircularProgressIndicator(),
              ),
            // mystatus == true
            //     ? ""
            //     : FlatButton(
            //         onPressed: () {
            //           showDialog(
            //               context: context,
            //               builder: (BuildContext context) {
            //                 return AlertDialog(
            //                   title: Text("Login"),
            //                   content: Text(
            //                       "Silahkan login untuk melihat lebih banyak lowongan"),
            //                   actions: <Widget>[
            //                     FlatButton(
            //                       onPressed: () {
            //                         Navigator.pop(context);
            //                       },
            //                       child: Text("Tidak"),
            //                     ),
            //                     FlatButton(
            //                       onPressed: () {
            //                         Navigator.push(
            //                             context,
            //                             MaterialPageRoute(
            //                                 builder: (context) => Login()));
            //                       },
            //                       child: Text("Ya"),
            //                     ),
            //                   ],
            //                 );
            //               });
            //         },
            //         child: Container(
            //             width: 150,
            //             height: 40,
            //             child: Card(
            //                 color: mainColor,
            //                 shape: RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.circular(15.0)),
            //                 child: Center(
            //                     child: Text(
            //                   "Lihat lebih banyak",
            //                   style: TextStyle(
            //                       color: Colors.white,
            //                       fontWeight: FontWeight.w500),
            //                 )))),
            //       ),
          ],
        ),
      ),
    );
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
          child: getBody()),
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

  void simpanLowongan(idLowongan, globalid_employee, context) async {
//    Toast.show(globalid_employee, context, duration: 3, gravity: Toast.TOP);
    //Toast.show(idLowongan, context, duration: 10, gravity: Toast.CENTER);

    Toast.show("Lowongan Berhasil Disimpan", context,
        duration: 3, gravity: Toast.TOP);

    final response = await http
        .post(NetworkConfig().baseUrl + "apps/simpan_lowongan", body: {
      'lowongan_id': idLowongan,
      'employee_id': globalid_employee,
    });

    if (response.statusCode == 200) {
      print("berhasi disimpan lowongan");
//
//      //Toast.show("Lowongan Berhasil Disimpan", context, duration: 10, gravity: Toast.CENTER);
////      Navigator.pop();
////      Navigator.of(context).pop();
//      Navigator.pop(context);

    } else {
      print("gagal disimpan lowongan");
    }
  }
}
