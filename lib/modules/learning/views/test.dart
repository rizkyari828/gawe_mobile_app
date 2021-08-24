import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/modules/learning/views/modul.dart';
import 'package:gaweid2/modules/learning/views/show_video.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gaweid2/modules/learning/models/soal_modul.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';
import 'package:toast/toast.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
  final idJenis;
  final idMateri;
  final emailId;
  final codeGenerate;
  var video;
  String kodeReferral;
  String remidial;

  Test({
    this.idJenis,
    this.idMateri,
    this.emailId,
    this.codeGenerate,
    this.video,
    this.kodeReferral,
    this.remidial,
  });
}

class _TestState extends State<Test> {
  var globalName = "",
      globalEmail = "",
      globalLevel = "",
      id_user = "",
      globalid_employee = "";
  var status = false;
  var mystatus;
  BaseEndPoint network = NetworkProvider();

  String radioItem = '';
  var loading;

  var InSignIn = true;

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
    getPreferences();
    getSoal(widget.emailId);
  }

  String statusSoal = "200";
  String idSoal,
      soal,
      jawabanA,
      jawabanB,
      jawabanC,
      jawabanD,
      kunciJawaban,
      skor,
      soalSekarang,
      insertId,
      message;

  Future getSoal(email) async {
    print(widget.idJenis);
    print(widget.idMateri);
    print(widget.emailId);
    print(globalEmail);
    print(widget.remidial);
    // loading = false;
    final jsonString = await http
        .post(NetworkConfig().baseUrl + "apps_learning/startLearning", body: {
      'id_jenis': widget.idJenis,
      'id_materi': widget.idMateri,
      'email': widget.emailId,
      'remidial': widget.remidial,
    });
    final jsonData = jsonDecode(jsonString.body);

    SoalModul soalTest = SoalModul.fromJson(jsonData);
    setState(() {
      loading = true;
      InSignIn = false;
      statusSoal = soalTest.status.toString();
      idSoal = soalTest.idSoal.toString();
      soal = soalTest.soal.toString();
      skor = soalTest.skor.toString();
      kunciJawaban = soalTest.kunciJawaban.toString();
      jawabanA = soalTest.jawabanA.toString();
      jawabanB = soalTest.jawabanB.toString();
      jawabanC = soalTest.jawabanC.toString();
      jawabanD = soalTest.jawabanD.toString();
      soalSekarang = soalTest.soalSekarang.toString();
      insertId = soalTest.insertId.toString();
      message = soalTest.message.toString();
    });
  }

  Duration _duration = Duration(seconds: 180);
  GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.height,
            height: MediaQuery.of(context).size.height,
            decoration: new BoxDecoration(color: mainColor),
          ),
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 9,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                message == "Soal"
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SlideCountdownClock(
                          duration: _duration,
                          slideDirection: SlideDirection.Up,
                          separator: ':',
                          textStyle: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          onDone: () {
                            Navigator.of(context)
                                .pushReplacement(new MaterialPageRoute(
                              builder: (BuildContext context) => Test(
                                idJenis: widget.idJenis,
                                idMateri: widget.idMateri,
                                emailId: globalEmail,
                                codeGenerate: widget.codeGenerate,
                              ),
                            ));
                          },
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: message == "Soal"
                ? SingleChildScrollView(
                  child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Text(
                                //   "Pilih Jawaban Yang Benar",
                                //   style: TextStyle(
                                //       fontSize: 14,
                                //       fontWeight: FontWeight.w600),
                                // ),
                                SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  width: MediaQuery.of(context).size.width / 1.3,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Flexible(
                                        flex: 1,
                                        child: Text(soalSekarang == null
                                            ? ""
                                            : soalSekarang),
                                      ),
                                      Flexible(
                                        flex: 5,
                                        child:
                                            Html(data: soal == null ? "" : soal),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16),
                                Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  width: MediaQuery.of(context).size.width / 1.3,
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
                                        child: Text(
                                            jawabanA == null ? "" : jawabanA),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  width: MediaQuery.of(context).size.width / 1.3,
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
                                        child: Text(
                                            jawabanB == null ? "" : jawabanB),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  width: MediaQuery.of(context).size.width / 1.3,
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
                                        child: Text(
                                            jawabanC == null ? "" : jawabanC),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  width: MediaQuery.of(context).size.width / 1.3,
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
                                        child: Text(
                                            jawabanD == null ? "" : jawabanD),
                                      ),
                                    ],
                                  ),
                                ),
//                          Text(
//                            '$radioItem',
//                            style: TextStyle(fontSize: 23),
//                          ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InSignIn
                                          ? Container(child: Center(child: CircularProgressIndicator()))
                                          : MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        color: Colors.orange,
                                        onPressed: () {
                                          setState(() {
                                            InSignIn = true;
                                          });
                                          jawab_soal(
                                              globalEmail,
                                              idSoal,
                                              kunciJawaban,
                                              widget.idJenis,
                                              widget.idMateri,
                                              skor,
                                              insertId);
                                        },
                                        child:  Text("Simpan",
                                            style:
                                                TextStyle(color: Colors.white70)),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                )
                : message == "Selesai"
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Text(
                                ' Terimakasih, \n soal ini telah anda kerjakan',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacement(new MaterialPageRoute(
                                    builder: (BuildContext context) => Video(
                                      video: widget.video,
                                      email: widget.emailId,
                                      codeGenerate: widget.codeGenerate,
                                      kodeReferral: widget.kodeReferral,
                                      idMateri: widget.idMateri,
                                    ),
                                  ));
                                },
                                color: mainColor,
                                child: Text("Selesai",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Center(child: CircularProgressIndicator()),
            // color: Colors.red,
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 4,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              // borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void jawab_soal(email, id_soal, kunci_jawaban, jenis_access, id_materi, skor,
      insert_id) async {

    if (radioItem == '' || radioItem == null) {
      setState(() {
        InSignIn = true;
      });
      Toast.show("Anda belum menjawab !!", context,
          duration: 3, gravity: Toast.TOP);
    } else {
      // print(id_materi);
      // print(insert_id);
      // print(email);
      ModelRegister data = await network.Jawaban_soal_learning(
          email,
          radioItem.toString(),
          id_soal.toString(),
          kunci_jawaban.toString(),
          jenis_access,
          widget.idMateri,
          skor,
          insert_id.toString());
      // print(data.status);

      if (data.status == 200) {
        // Toast.show("Jawaban Anda Berhasil Disimpan", context,
        //     duration: 3, gravity: Toast.TOP);
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) => Test(
            idJenis: widget.idJenis,
            idMateri: widget.idMateri,
            emailId: email,
            codeGenerate: widget.codeGenerate,
            video: widget.video,
            kodeReferral: widget.kodeReferral,
            remidial: '0',
          ),
        ));
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => (Test(
        //           idJenis: jenis_access == null ? "" : jenis_access,
        //           idMateri: id_materi == null ? "" : id_materi,
        //         ))));
      } else if (data.status == 400) {
        // Toast.show("${data.status}", context, duration: 3, gravity: Toast.TOP);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => (Test(
                      idJenis: jenis_access == null ? "" : jenis_access,
                      idMateri: id_materi == null ? "" : id_materi,
                      emailId: email == null ? "" : email,
                      codeGenerate: widget.codeGenerate == null
                          ? ""
                          : widget.codeGenerate,
                    video: widget.video,
                    kodeReferral: widget.kodeReferral,
                  remidial: '0',
                    ))));
      }

      // Toast.show(radioItem, context, duration: 3, gravity: Toast.TOP);
    }
  }
}
