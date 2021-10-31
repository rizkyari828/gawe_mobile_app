import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gaweid2/modules/lowongan/models/lowongan_model_pagination.dart';
import 'package:gaweid2/modules/lowongan/services/lowongan_service.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/user/view/Login.dart';
import 'package:gaweid2/modules/lowongan/view/detail_lowongan.dart';
import 'package:gaweid2/modules/lowongan/view/filter.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:geolocator/geolocator.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_share/flutter_share.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  String globalidEmployee;
  String section;

  Home({this.globalidEmployee, this.section});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  LowonganPagination coin;
  var scrollController = ScrollController();
  bool updating = false;

  var globalName = "",
      globalEmail = "",
      globalLevel = "",
      idUser = "",
      globalidEmployee = "",
      globalprofilPower = "";
  var status = false;
  var mystatus;
  double userLat;
  double userLong;

  double nLat = 0;
  double nLong = 0;

  SessionManager sessionManager = SessionManager();

  void getPreferences() async {
    await sessionManager.getPreference().then((value) {
      setState(() {
        mystatus = sessionManager.status;
        globalName = sessionManager.fullname;
        globalEmail = sessionManager.email;
        idUser = sessionManager.iduser;
        globalprofilPower = sessionManager.profile_power;
        globalidEmployee = sessionManager.id_employee;
        userLat = sessionManager.longitude;
        userLong = sessionManager.longitude;
      });
    });
  }

  void getCurrentLocation() async {
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    try {
      setState(() {
        nLat = currentLocation.latitude;
        nLong = currentLocation.longitude;
      });
    } on Exception {
      print("Null");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getLowongan();
    getCoin();
    getPreferences();
    getCurrentLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getCoin() async {
    coin = await apiHelper.getCoins(widget.globalidEmployee == null ? "0" : widget.globalidEmployee,widget.section);
    setState(() {});
  }

  checkUpdate() async {
    setState(() {
      updating = true;
    });
    var scrollpositin = scrollController.position;
    if (scrollpositin.pixels == scrollpositin.maxScrollExtent) {
      // if (mystatus == true) {
        var newapi = apiHelper.getApi(widget.globalidEmployee == null ? "0" : widget.globalidEmployee,widget.section, coin.data.length);
        var newcoin =
            await apiHelper.getCoins(widget.globalidEmployee == null ? "0" : widget.globalidEmployee,widget.section,newapi.toString()) as LowonganPagination;
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
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              (Home(globalidEmployee: widget.globalidEmployee, section: "terbaru",))));
                    },
                    color: widget.section == "terbaru" ? mainColor : Colors.white,
                    child: Text("Terbaru",
                        style: TextStyle(color: widget.section == "terbaru" ? Colors.white : mainColor)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    onPressed: () {
                      mystatus != true ?
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Login"),
                              content: Text("Hai, untuk mengakses halaman ini kamu harus login terlebih dahulu!"),
                              actions: <Widget>[
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Tidak"),
                                ),
                                MaterialButton(
                                  onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Login()));
                                  },
                                  child: Text("Ya"),
                                ),
                              ],
                            );
                          }) :
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              (Home(globalidEmployee: widget.globalidEmployee, section: "terdekat",))));

                    },
                    color: widget.section == "terdekat" ? mainColor : Colors.white,
                    child: Text("Terdekat",
                        style: TextStyle(color : widget.section == "terdekat" ? Colors.white : mainColor)),
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
                  Future<void> share() async {
                    final urlImage = xlowongan.logo;
                    final url = Uri.parse(urlImage);
                    final response = await http.get(url);
                    final bytes = response.bodyBytes;
                    final temp = await getTemporaryDirectory();
                    final path = '${temp.path}/image.jpg';
                    File(path).writeAsBytesSync(bytes);
                    await Share.shareFiles([path], text: '${xlowongan.posisi} (${xlowongan.namaPerusahaan})\n https://gawe.id/lowongan/detail/${base64.encode(utf8.encode(xlowongan.idLowongan))}');
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => (Share())));
                    // await FlutterShare.share(
                    //     title: 'Lowongan',
                    //     text: '${xlowongan.posisi}',
                    //     linkUrl: 'https://gawe.id/lowongan/detail/${base64.encode(utf8.encode(xlowongan.idLowongan))}',
                    //     chooserTitle: 'Ayo segera lamar lowongan');
                  }
                  return Card(
                    margin: new EdgeInsets.only(
                        left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    elevation: 1,
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
                                  datePostEnd:
                                  xlowongan.datePostEnd.toString() ==
                                      null
                                      ? ""
                                      : xlowongan.datePostEnd.toString(),
                                      id_perusahaan: xlowongan.id_perusahaan
                                                  .toString() ==
                                              null
                                          ? ""
                                          : xlowongan.id_perusahaan.toString(),
                                  directLink: xlowongan.directLink.toString() == null ? "" : xlowongan.directLink.toString(),
                                  id_employee: widget.globalidEmployee == null ? "" : widget.globalidEmployee,
                                    )));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left:5.0, top: 10, right: 5),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0, right: 15,),
                                      child: Image.network(
                                        xlowongan.logo,
                                        height:
                                            MediaQuery.of(context).size.height / 13,
                                        width: MediaQuery.of(context).size.width / 6,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width/1.7,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        xlowongan.posisi,
                                        overflow: TextOverflow.fade,
                                        maxLines: 2,
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
                          // Divider(),
                          Row(
                            children: <Widget>[
                              IconButton(onPressed: share, icon: Icon(Icons.share, color: Colors.grey, size: 20,),),
                              IconButton(
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
                                                if (mystatus == true) {
                                                  simpanLowongan(
                                                      xlowongan.idLowongan,
                                                      globalidEmployee,
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

  void simpanLowongan(idLowongan, globalidEmployee, context) async {
//    Toast.show(globalid_employee, context, duration: 3, gravity: Toast.TOP);
    //Toast.show(idLowongan, context, duration: 10, gravity: Toast.CENTER);

    Toast.show("Lowongan Berhasil Disimpan", context,
        duration: 3, gravity: Toast.TOP);

    final response = await http
        .post(NetworkConfig().baseUrl + "apps/simpan_lowongan", body: {
      'lowongan_id': idLowongan,
      'employee_id': globalidEmployee,
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
