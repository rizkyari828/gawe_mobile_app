//import 'dart:convert';
//
//import 'package:flutter/material.dart';
//import 'package:flutter_html/flutter_html.dart';
//
//import 'package:flutter_spinkit/flutter_spinkit.dart';
//import 'package:gaweid2/model/ModelRegister.dart';
//import 'package:gaweid2/model/learning/landing_model.dart';
//import 'package:gaweid2/model/learning/soal2_model.dart';
//import 'package:gaweid2/model/learning/soal_modul.dart';
//import 'package:gaweid2/network/NetworkProvider.dart';
//import 'package:gaweid2/ui/User/Fragment/HomeUser1.dart';
//import 'package:gaweid2/ui/User/UserDashboard.dart';
//import 'package:gaweid2/ui/learning/kodelearning.dart';
//import 'package:gaweid2/ui/learning/modul.dart';
//import 'package:gaweid2/ui/learning/selesai.dart';
//import 'package:gaweid2/utils/SessionManager.dart';
//import 'package:gaweid2/utils/theme.dart';
//import 'package:slide_countdown_clock/slide_countdown_clock.dart';
//import 'package:toast/toast.dart';
//import 'package:http/http.dart' as http;
//
//class posttest_pakefuture extends StatefulWidget {
//  @override
//  _posttest_pakefutureState createState() => _posttest_pakefutureState();
//  final jenis_access, id_materi, insert_id, kodelearning;
//  posttest_pakefuture({
//    this.jenis_access,
//    this.id_materi,
//    this.insert_id,
//    this.kodelearning,
//  });
//}
//
//class _posttest_pakefutureState extends State<posttest_pakefuture> {
//  Future<bool> _onWillPop() {
//    return showDialog(
//      context: context,
//      builder: (context) => AlertDialog(
//        title: Text('Learning Gawe.id.'),
//        content: Text('Mohon Maaf \n Anda Tidak Dapat Halaman Sebelumnya '),
//        actions: <Widget>[
//          FlatButton(
//            onPressed: () => Navigator.of(context).pop(false),
//            child: Text('Kembali'),
//          ),
//        ],
//      ),
//    ) ??
//        false;
//  }
//
//  BaseEndPoint network = NetworkProvider();
//
//  String radioItem = '';
//  var loading;
//
//  var InSignIn = true;
//
//  var globalName = "", globalEmail = "", globalLevel = "";
//  var status = false;
//  var id_user, globalid_employee;
//  var mystatus;
//
//  String status_soal;
//  String id_soal,
//      soal,
//      jawaban_a,
//      jawaban_b,
//      jawaban_c,
//      jawaban_d,
//      kunci_jawaban,
//      skor,
//      soal_sekarang,
//      insert_id;
//
////  Future getSoal(email) async {
////    loading = false;
////    final jsonString =
////        await http.post(NetworkConfig().baseUrl + "apps_learning/learn", body: {
////      'jenis_access': widget.jenis_access,
////      'id_materi': widget.id_materi,
////      'id1': '1',
////      'email': "ajie.darmawan106@gmail.com",
////    });
////    final jsonData = jsonDecode(jsonString.body);
////    Soal_modul soal_modul = Soal_modul.fromJson(jsonData);
////    setState(() {
////      loading = true;
////      InSignIn = false;
////      status_soal = soal_modul.status.toString();
////      id_soal = soal_modul.id_soal.toString();
////      soal = soal_modul.soal.toString();
////      skor = soal_modul.skor.toString();
////      kunci_jawaban = soal_modul.kunci_jawaban.toString();
////      jawaban_a = soal_modul.jawaban_a.toString();
////      jawaban_b = soal_modul.jawaban_b.toString();
////      jawaban_c = soal_modul.jawaban_c.toString();
////      jawaban_d = soal_modul.jawaban_d.toString();
////      soal_sekarang = soal_modul.soal_sekarang.toString();
////      insert_id = soal_modul.insert_id.toString();
////    });
////  }
//
//  Future<List<Soal>> getSoal2() async {
//    final response =
//    await http.post(NetworkConfig().baseUrl + "apps_learning/learn", body: {
//      'jenis_access': widget.jenis_access,
//      'id_materi': widget.id_materi,
//      'id1': '1',
//      'email': "ajie.darmawan106@gmail.com",
//    });
//
//    return soal2ModelFromJson(response.body).soal;
//  }
//
//  SessionManager sessionManager = SessionManager();
//  void getPreferences() async {
//    await sessionManager.getPreference().then((value) {
//      setState(() {
//        mystatus = sessionManager.status;
//        globalName = sessionManager.fullname;
//        globalEmail = sessionManager.email;
//        globalLevel = sessionManager.level;
//        id_user = sessionManager.iduser;
//        globalid_employee = sessionManager.id_employee;
//        print("globalid_employee $globalid_employee");
//      });
//    });
//  }
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    //getSoal(globalEmail.toString());
//    getPreferences();
//  }
//
//  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
//  @override
//  Widget build(BuildContext context) {
//    // getSoal(globalEmail.toString());
//    print("globalEmail${globalEmail}");
//    print("status_soal${status_soal}");
//    return WillPopScope(
//      onWillPop: _onWillPop,
//      child: Scaffold(
//        key: _scaffoldKey,
//        body: ListView(
//          children: [
////            Container(
////              margin: EdgeInsets.all(8),
////              alignment: Alignment.topCenter,
////              child: SlideCountdownClock(
////                duration: Duration(minutes: 1),
////                slideDirection: SlideDirection.Up,
////                separator: ":",
////                tightLabel: true,
////                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
////                onDone: () {
//////                          Toast.show("Waktu Habis", context,
//////                              duration: 3, gravity: Toast.TOP);
////
////                  _scaffoldKey.currentState
////                      .showSnackBar(SnackBar(content: Text('Waktu Habis')));
////
////                  Navigator.push(
////                      context,
////                      MaterialPageRoute(
////                          builder: (context) => (posttest(
////                            jenis_access: widget.jenis_access == null
////                                ? ""
////                                : widget.jenis_access,
////                            id_materi: widget.id_materi == null
////                                ? ""
////                                : widget.id_materi,
////                          ))));
////                },
////              ),
////            ),
////            Container(
////              height: 800,
////              child: FutureBuilder(
////                future: getSoal2(),
////                builder: (context, snapshot) {
////
////                  if (snapshot.hasError) print(snapshot.hasError);
////                  List<Soal> xsoal = snapshot.data;
////
////
////                  return snapshot.hasData
////                      ?
////
////                  ListView.builder(
////                    itemCount: xsoal == null ? 0 : xsoal.length,
////                    itemBuilder: (BuildContext context, int index) {
////                      return Container(
////                        // height: 60,
////                        child: Card(
////                          semanticContainer: true,
////                          clipBehavior: Clip.antiAliasWithSaveLayer,
////                          elevation: 5,
////                          child: InkWell(
////                            onTap: () {},
////                            child: Column(
////                              mainAxisAlignment: MainAxisAlignment.start,
////                              children: <Widget>[
////                                Row(
////                                  mainAxisAlignment:
////                                  MainAxisAlignment.spaceBetween,
////                                  children: <Widget>[
////                                    Expanded(
////                                      child: Column(
////                                        crossAxisAlignment:
////                                        CrossAxisAlignment.start,
////                                        children: <Widget>[
////                                          Center(
////                                            child: Html(
////                                              data: xsoal[index].soal,
////                                            ),
////                                          ),
////
////                                          SizedBox(height: 16),
////                                          Container(
////                                            margin: EdgeInsets.only(
////                                                bottom: 8),
////                                            width: MediaQuery.of(context)
////                                                .size
////                                                .width /
////                                                1.3,
////                                            color: Colors.grey[200],
////                                            child: Row(
////                                              children: <Widget>[
////                                                Flexible(
////                                                  flex: 1,
////                                                  child: Radio(
////                                                    groupValue: radioItem,
////                                                    value: "A",
////                                                    onChanged: (val) {
////                                                      setState(() {
////                                                        radioItem = val;
////                                                      });
////                                                    },
////                                                    //subtitle: new Text("Pilih salah satu"),
////                                                  ),
////                                                ),
////                                                Flexible(
////                                                  flex: 5,
////                                                  child: Text(xsoal[index]
////                                                      .jawabanA ==
////                                                      null
////                                                      ? ""
////                                                      : xsoal[index]
////                                                      .jawabanA),
////                                                ),
////                                              ],
////                                            ),
////                                          ),
////                                          Container(
////                                            margin: EdgeInsets.only(
////                                                bottom: 8),
////                                            width: MediaQuery.of(context)
////                                                .size
////                                                .width /
////                                                1.3,
////                                            color: Colors.grey[200],
////                                            child: Row(
////                                              children: <Widget>[
////                                                Flexible(
////                                                  flex: 1,
////                                                  child: Radio(
////                                                    groupValue: radioItem,
////                                                    value: "B",
////                                                    onChanged: (val) {
////                                                      setState(() {
////                                                        radioItem = val;
////                                                      });
////                                                    },
////                                                    //subtitle: new Text("Pilih salah satu"),
////                                                  ),
////                                                ),
////                                                Flexible(
////                                                  flex: 5,
////                                                  child: Text(xsoal[index]
////                                                      .jawabanB ==
////                                                      null
////                                                      ? ""
////                                                      : xsoal[index]
////                                                      .jawabanB),
////                                                ),
////                                              ],
////                                            ),
////                                          ),
////                                          Container(
////                                            margin: EdgeInsets.only(
////                                                bottom: 8),
////                                            width: MediaQuery.of(context)
////                                                .size
////                                                .width /
////                                                1.3,
////                                            color: Colors.grey[200],
////                                            child: Row(
////                                              children: <Widget>[
////                                                Flexible(
////                                                  flex: 1,
////                                                  child: Radio(
////                                                    groupValue: radioItem,
////                                                    value: "C",
////                                                    onChanged: (val) {
////                                                      setState(() {
////                                                        radioItem = val;
////                                                      });
////                                                    },
////                                                    //subtitle: new Text("Pilih salah satu"),
////                                                  ),
////                                                ),
////                                                Flexible(
////                                                  flex: 5,
////                                                  child: Text(xsoal[index]
////                                                      .jawabanC ==
////                                                      null
////                                                      ? ""
////                                                      : xsoal[index]
////                                                      .jawabanC),
////                                                ),
////                                              ],
////                                            ),
////                                          ),
////                                          Container(
////                                            margin: EdgeInsets.only(
////                                                bottom: 8),
////                                            width: MediaQuery.of(context)
////                                                .size
////                                                .width /
////                                                1.3,
////                                            color: Colors.grey[200],
////                                            child: Row(
////                                              children: <Widget>[
////                                                Flexible(
////                                                  flex: 1,
////                                                  child: Radio(
////                                                    groupValue: radioItem,
////                                                    value: "D",
////                                                    onChanged: (val) {
////                                                      setState(() {
////                                                        radioItem = val;
////                                                      });
////                                                    },
////                                                    //subtitle: new Text("Pilih salah satu"),
////                                                  ),
////                                                ),
////                                                Flexible(
////                                                  flex: 5,
////                                                  child: Text(xsoal[index]
////                                                      .jawabanD ==
////                                                      null
////                                                      ? ""
////                                                      : xsoal[index]
////                                                      .jawabanD),
////                                                ),
////                                              ],
////                                            ),
////                                          ),
////
////                                          Row(
////                                            mainAxisAlignment:
////                                            MainAxisAlignment.end,
////                                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
////                                            children: <Widget>[
////                                              RaisedButton(
////                                                shape:
////                                                RoundedRectangleBorder(
////                                                    borderRadius:
////                                                    BorderRadius
////                                                        .circular(
////                                                        8)),
////                                                color: Colors.green,
////                                                onPressed: () {
////                                                  jawab_soal(
////                                                      globalEmail,
////                                                      xsoal[index].idSoal,
////                                                      xsoal[index]
////                                                          .kunciJawaban,
////                                                      widget.jenis_access,
////                                                      widget.id_materi,
////                                                      xsoal[index].skor,
////                                                      widget.insert_id);
////                                                },
////                                                child: Text("Next",
////                                                    style: TextStyle(
////                                                        color: Colors
////                                                            .white70)),
////                                              ),
////                                            ],
////                                          )
////
//////                                            SizedBox(
//////                                              height: 10,
//////                                            ),
//////                                            Center(
//////                                              child: Text(
//////                                                xmodul[index].desc == null
//////                                                    ? ""
//////                                                    : xmodul[index].desc,
//////                                                style: TextStyle(
//////                                                  fontSize: 14,
//////                                                  color: Colors.black,
//////                                                ),
//////                                                textAlign:
//////                                                TextAlign.justify,
//////                                              ),
//////                                            ),
////                                        ],
////                                      ),
////                                    ),
////                                  ],
////                                ),
////                              ],
////                            ),
////                          ),
////                        ),
////                      );
////                    },
////                  )
////
////
////                      : Center(
////                    child: CircularProgressIndicator(),
////                  );
////                },
////              ),
////            ),
//          ],
//        ),
//      ),
//    );
//  }
//
////  void jawab_soal(email, id_soal, kunci_jawaban, jenis_access, id_materi, skor,
////      insert_id) async {
////    if (radioItem == '' || radioItem == null) {
////      Toast.show("Anda Belum Menjawab !!", context,
////          duration: 3, gravity: Toast.TOP);
////    } else {
////      ModelRegister data = await network.Jawaban_soal_learning(
////          email,
////          radioItem.toString(),
////          id_soal.toString(),
////          kunci_jawaban.toString(),
////          jenis_access,
////          widget.id_materi,
////          skor,
////          insert_id.toString());
////
////      if (data.status == 200) {
//////        Toast.show("Jawaban Anda Berhasil Disimpan", context,
//////            duration: 3, gravity: Toast.TOP);
////
//////        Navigator.push(
//////            context,
//////            MaterialPageRoute(
//////                builder: (context) => (posttest(
//////                  jenis_access: jenis_access == null ? "" : jenis_access,
//////                  id_materi: id_materi == null ? "" : id_materi,
//////                ))));
//////      } else if (data.status == 400) {
//////        // Toast.show("${data.status}", context, duration: 3, gravity: Toast.TOP);
//////        Navigator.push(
//////            context,
//////            MaterialPageRoute(
//////                builder: (context) => (posttest(
//////                  jenis_access: jenis_access == null ? "" : jenis_access,
//////                  id_materi: id_materi == null ? "" : id_materi,
//////                ))));
//////      }
////
////      // Toast.show(radioItem, context, duration: 3, gravity: Toast.TOP);
////    }
////  }
////}
