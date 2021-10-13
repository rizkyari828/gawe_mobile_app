import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/modules/learning/models/soal_modul.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/ui/User/Fragment/HomeUser1.dart';
import 'package:gaweid2/modules/user/view/menu/UserDashboard.dart';
import 'package:gaweid2/modules/learning/views/kodelearning.dart';
import 'package:gaweid2/modules/learning/views/modul.dart';
import 'package:gaweid2/modules/learning/views/selesai.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class posttest extends StatefulWidget {
  @override
  _posttestState createState() => _posttestState();
  final jenis_access, id_materi, insert_id;
  posttest({
    this.jenis_access,
    this.id_materi,
    this.insert_id,
  });
}

class _posttestState extends State<posttest> {
  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Learning Gawe.id.'),
        content: Text('Mohon Maaf \n Anda Tidak Dapat Halaman Sebelumnya '),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Kembali'),
          ),
        ],
      ),
    ) ??
        false;
  }

  BaseEndPoint network = NetworkProvider();

  String radioItem = '';
  var loading;

  var InSignIn = true;

  var globalName = "", globalEmail = "", globalLevel = "";
  var status = false;
  var id_user, globalid_employee;
  var mystatus;

  String status_soal = "200";
  String id_soal,
      soal,
      jawaban_a,
      jawaban_b,
      jawaban_c,
      jawaban_d,
      kunci_jawaban,
      skor,
      soal_sekarang,
      insert_id;

  Future getSoal(email) async {
    loading = false;
    final jsonString =
    await http.post(NetworkConfig().baseUrl + "apps_learning/learn", body: {
      'jenis_access': widget.jenis_access,
      'id_materi': widget.id_materi,
      'id1': '1',
      'email': email.toString(),
    });
    final jsonData = jsonDecode(jsonString.body);
//    SoalModul soal_modul = Soal_modul.fromJson(jsonData);
//    setState(() {
//      loading = true;
//      InSignIn = false;
//      status_soal = soal_modul.status.toString();
//      id_soal = soal_modul.id_soal.toString();
//      soal = soal_modul.soal.toString();
//      skor = soal_modul.skor.toString();
//      kunci_jawaban = soal_modul.kunci_jawaban.toString();
//      jawaban_a = soal_modul.jawaban_a.toString();
//      jawaban_b = soal_modul.jawaban_b.toString();
//      jawaban_c = soal_modul.jawaban_c.toString();
//      jawaban_d = soal_modul.jawaban_d.toString();
//      soal_sekarang = soal_modul.soal_sekarang.toString();
//      insert_id = soal_modul.insert_id.toString();
//    });
  }

  SessionManager sessionManager = SessionManager();
  void getPreferences() async {
    await sessionManager.getPreference().then((value) {
      setState(() {
        mystatus = sessionManager.status;
        globalName = sessionManager.fullname;
        globalEmail = sessionManager.email;
        globalLevel = sessionManager.level;
        id_user = sessionManager.iduser;
        globalid_employee = sessionManager.id_employee;
        print("globalid_employee $globalid_employee");
        //_loginStatus = mystatus == true ? LoginStatus.Login : LoginStatus.not_login;
      });
    });
  }

//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    //getSoal(globalEmail.toString());
//    getPreferences();
//  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {

    final NetworkProvider networkProvider =
    Provider.of<NetworkProvider>(context);
    networkProvider.getPost();
    SoalModul data = networkProvider.posts;

    //getSoal(globalEmail.toString());
    print("globalEmail${globalEmail}");
    print("status_soal${status_soal}");



//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Latihan"),
//        backgroundColor: Colors.white70,
//      ),
//      body: data == null
//          ? Center(child: CircularProgressIndicator())
//          :
//      ListView(
//        children: <Widget>[
//          Container(
//            margin: EdgeInsets.all(8),
//            alignment: Alignment.topCenter,
//            child: SlideCountdownClock(
//              duration: Duration(seconds: 5),
//              slideDirection: SlideDirection.Up,
//              separator: ":",
//              tightLabel: true,
//              textStyle:
//              TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//              onDone: () {
//                networkProvider.idPost = networkProvider.idPost + 1;
//              },
//            ),
//          ),
//          Padding(
//            padding: EdgeInsets.all(8),
//            child: Card(
//              child: Padding(
//                padding: const EdgeInsets.all(8.0),
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Text(
//                      "Pilih Jawaban Yang Benar",
//                      style: TextStyle(
//                          fontSize: 19, fontWeight: FontWeight.w600),
//                    ),
//                    SizedBox(
//                      height: 16,
//                    ),
//                    Text(data == null ? "" : "${data.soalSekarang}"),
//                    SizedBox(height: 16),
//                    Container(
//                      margin: EdgeInsets.only(bottom: 8),
//                      width: MediaQuery.of(context).size.width / 1.3,
//                      color: Colors.grey[200],
//                      child: Row(
//                        children: <Widget>[
//                          Flexible(
//                            flex: 1,
//                            child: Radio(
//                              groupValue: 0,
//                              value: 1,
//                              onChanged: (value) {},
//                            ),
//                          ),
//                          Flexible(
//                            flex: 5,
//                            child:
//                            Text(data == null ? "" : "${data.jawabanA}"),
//                          ),
//                        ],
//                      ),
//                    ),
//                    Container(
//                      margin: EdgeInsets.only(bottom: 8),
//                      width: MediaQuery.of(context).size.width / 1.3,
//                      color: Colors.grey[200],
//                      child: Row(
//                        children: <Widget>[
//                          Radio(
//                            groupValue: 0,
//                            value: 1,
//                            onChanged: (value) {},
//                          ),
//                          Text("Jawaban 2"),
//                        ],
//                      ),
//                    ),
//                    Container(
//                      margin: EdgeInsets.only(bottom: 8),
//                      width: MediaQuery.of(context).size.width / 1.3,
//                      color: Colors.grey[200],
//                      child: Row(
//                        children: <Widget>[
//                          Radio(
//                            groupValue: 0,
//                            value: 1,
//                            onChanged: (value) {},
//                          ),
//                          Text("Jawaban 3"),
//                        ],
//                      ),
//                    ),
//                    Container(
//                      margin: EdgeInsets.only(bottom: 8),
//                      width: MediaQuery.of(context).size.width / 1.3,
//                      color: Colors.grey[200],
//                      child: Row(
//                        children: <Widget>[
//                          Radio(
//                            groupValue: 0,
//                            value: 1,
//                            onChanged: (value) {},
//                          ),
//                          Text("Jawaban 4"),
//                        ],
//                      ),
//                    ),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        Padding(
//                          padding: const EdgeInsets.all(8.0),
//                          child: RaisedButton(
//                            shape: RoundedRectangleBorder(
//                                borderRadius: BorderRadius.circular(8)),
//                            color: Colors.red,
//                            onPressed: () {
//                              networkProvider.idPost =
//                                  networkProvider.idPost - 1;
//                            },
//                            child: Text("Previous",
//                                style: TextStyle(color: Colors.white70)),
//                          ),
//                        ),
//                        RaisedButton(
//                          shape: RoundedRectangleBorder(
//                              borderRadius: BorderRadius.circular(8)),
//                          color: Colors.green,
//                          onPressed: () {
//                            networkProvider.idPost =
//                                networkProvider.idPost + 1;
//                          },
//                          child: Text("Next",
//                              style: TextStyle(color: Colors.white70)),
//                        ),
//                      ],
//                    )
//                  ],
//                ),
//              ),
//            ),
//          )
//        ],
//      ),
//    );












    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(8),
              alignment: Alignment.topCenter,
              child: SlideCountdownClock(
                duration: Duration(minutes: 1),
                slideDirection: SlideDirection.Up,
                separator: ":",
                tightLabel: true,
                textStyle: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
                onDone: () {

                  networkProvider.idPost = networkProvider.idPost + 1;
//                          Toast.show("Waktu Habis", context,
//                              duration: 3, gravity: Toast.TOP);

                  _scaffoldKey.currentState.showSnackBar(
                      SnackBar(content: Text('Waktu Habis')));

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => (posttest(
                            jenis_access:
                            widget.jenis_access == null
                                ? ""
                                : widget.jenis_access,
                            id_materi:
                            widget.id_materi == null
                                ? ""
                                : widget.id_materi,
                          ))));
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Pilih Jawaban Yang Benar",
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        width:
                        MediaQuery.of(context).size.width /
                            1.3,
                        color: Colors.grey[200],
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: Text(data.soalSekarang == null
                                  ? ""
                                  : data.soalSekarang),
                            ),
                            Flexible(
                              flex: 5,
                              child: Html(
                                  data:
                                  data.soal == null ? "" : data.soal),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        width:
                        MediaQuery.of(context).size.width /
                            1.3,
                        color: Colors.grey[200],
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: Radio(
                                groupValue: radioItem,
                                value: "A",
                                onChanged: (val) {
                                  setState(() {
                                    radioItem = val;
                                  });
                                },
                                //subtitle: new Text("Pilih salah satu"),
                              ),
                            ),
                            Flexible(
                              flex: 5,
                              child: Text(data.jawabanA == null
                                  ? ""
                                  : data.jawabanA),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        width:
                        MediaQuery.of(context).size.width /
                            1.3,
                        color: Colors.grey[200],
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: Radio(
                                groupValue: radioItem,
                                value: "B",
                                onChanged: (val) {
                                  setState(() {
                                    radioItem = val;
                                  });
                                },
                                //subtitle: new Text("Pilih salah satu"),
                              ),
                            ),
                            Flexible(
                              flex: 5,
                              child: Text(data.jawabanB == null
                                  ? ""
                                  : data.jawabanB),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        width:
                        MediaQuery.of(context).size.width /
                            1.3,
                        color: Colors.grey[200],
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: Radio(
                                groupValue: radioItem,
                                value: "C",
                                onChanged: (val) {
                                  setState(() {
                                    radioItem = val;
                                  });
                                },
                                //subtitle: new Text("Pilih salah satu"),
                              ),
                            ),
                            Flexible(
                              flex: 5,
                              child: Text(data.jawabanC == null
                                  ? ""
                                  : data.jawabanC),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        width:
                        MediaQuery.of(context).size.width /
                            1.3,
                        color: Colors.grey[200],
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: Radio(
                                groupValue: radioItem,
                                value: "D",
                                onChanged: (val) {
                                  setState(() {
                                    radioItem = val;
                                  });
                                },
                                //subtitle: new Text("Pilih salah satu"),
                              ),
                            ),
                            Flexible(
                              flex: 5,
                              child: Text(data.jawabanD == null
                                  ? ""
                                  : data.jawabanD),
                            ),
                          ],
                        ),
                      ),
//                          Text(
//                            '$radioItem',
//                            style: TextStyle(fontSize: 23),
//                          ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.end,
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(8)),
                            color: Colors.green,
                            onPressed: () {
                              jawab_soal(
                                  globalEmail,
                                  data.idSoal,
                                  data.kunciJawaban,
                                  widget.jenis_access,
                                  widget.id_materi,
                                  data.skor,
                                  widget.insert_id);
                            },
                            child: Text("Next",
                                style: TextStyle(
                                    color: Colors.white70)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void jawab_soal(email, id_soal, kunci_jawaban, jenis_access, id_materi, skor,
      insert_id) async {
    if (radioItem == '' || radioItem == null) {
      Toast.show("Anda Belum Menjawab !!", context,
          duration: 3, gravity: Toast.TOP);
    } else {
      ModelRegister data = await network.Jawaban_soal_learning(
          email,
          radioItem.toString(),
          id_soal.toString(),
          kunci_jawaban.toString(),
          jenis_access,
          widget.id_materi,
          skor,
          insert_id.toString());

      if (data.status == 200) {
//        Toast.show("Jawaban Anda Berhasil Disimpan", context,
//            duration: 3, gravity: Toast.TOP);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => (posttest(
                  jenis_access: jenis_access == null ? "" : jenis_access,
                  id_materi: id_materi == null ? "" : id_materi,
                ))));
      } else if (data.status == 400) {
        // Toast.show("${data.status}", context, duration: 3, gravity: Toast.TOP);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => (posttest(
                  jenis_access: jenis_access == null ? "" : jenis_access,
                  id_materi: id_materi == null ? "" : id_materi,
                ))));
      }

      // Toast.show(radioItem, context, duration: 3, gravity: Toast.TOP);
    }
  }
}