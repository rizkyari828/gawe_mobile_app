import 'package:flutter/material.dart';
import 'package:gaweid2/modules/learning/models/model_modul.dart';
import 'package:gaweid2/modules/learning/views/show_video.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;

class UI_Modul extends StatefulWidget {
  @override
  _UI_Modul createState() => _UI_Modul();
  final kodelearning;
  final kodeReferral;
  final namaLearning;

  UI_Modul({
    this.kodelearning,
    this.kodeReferral,
    this.namaLearning,
  });
}

class _UI_Modul extends State<UI_Modul> {
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

  Future<List> getModul() async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps_learning/modul_materi", body: {
      'kode_materi': widget.kodelearning.toString(),
      'referral_code': widget.kodeReferral.toString(),
      'email': globalEmail.toString(),
    });
    // log('data ${response.body}');
    ModelModul listdata = modelModulFromJson(response.body);

    return listdata.modul;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getModul();
    getPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: new AppBar(
        title: Text(""),
        backgroundColor: mainColor,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: backgroundColor,
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                constraints: BoxConstraints(maxHeight: 100.0),
                height: MediaQuery.of(context).size.height / 6,
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.only(
                  //   bottomRight: Radius.circular(35),
                  //   bottomLeft: Radius.circular(35),
                  // ),
                  // borderRadius: BorderRadius.circular(15),
                  color: mainColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.namaLearning.toString(),
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              FutureBuilder(
                future: getModul(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  // print(globalEmail);
                  return snapshot.hasData
                      ? ItemList(
                          list: snapshot.data,
                          email: globalEmail,
                          codeGenerate: widget.kodelearning,
                          kodeReferral: widget.kodeReferral,
                        )
                      : Center(
                          child: mystatus == true
                              ? Container(
                                  margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height / 3,
                                  ),
                                  child: CircularProgressIndicator())
                              : Container(
                                  child: Center(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Image.asset(
                                            'images/kategori/LowonganTersimpan.png',
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                2,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                          ),
                                          Text(
                                            'Learning tidak ditemukan',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ]),
                                  ),
                                ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemList extends StatefulWidget {
  List list;
  String email;
  String codeGenerate;
  String kodeReferral;

  ItemList({this.list, this.email, this.codeGenerate, this.kodeReferral});

  @override
  createState() => _MyWidgetState(list: list);
}

class _MyWidgetState extends State<ItemList> {
  List list;

  _MyWidgetState({this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 50.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(35),
          topLeft: Radius.circular(35),
        ),
        // borderRadius: BorderRadius.circular(15),
        color: mainColor,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height - 100),
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height / 6,
                child: ListView.builder(
                  // physics: NeverScrollableScrollPhysics(),
                  itemCount: list == null ? 0 : list.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Modul xmodul = list[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                xmodul.namaModul == null
                                    ? ""
                                    : xmodul.namaModul,
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                softWrap: false,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    list[index].materiContent.length == null
                                        ? 0
                                        : list[index].materiContent.length,
                                itemBuilder:
                                    (BuildContext context, int index2) {
                                  final materi = xmodul.materiContent[index2];
                                  return InkWell(
                                    onTap: () {
                                      if(materi.statusAccess == "Terbuka"){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => (Video(
                                                  video: xmodul
                                                      .materiContent[index2],
                                                  email: widget.email,
                                                  codeGenerate:
                                                  widget.codeGenerate,
                                                  kodeReferral:
                                                  widget.kodeReferral,
                                                  idMateri: xmodul
                                                      .materiContent[index2]
                                                      .id,
                                                ))));
                                      }else{
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Oops!"),
                                                content: materi.statusRate == "ada"
                                                    ? Text(
                                                    "Kamu belum memberikan rating dan menyelesaikan materi sebelumnya.")
                                                    : Text(
                                                    "Kamu belum menyelesaikan materi sebelumnya."),
                                                actions: <Widget>[
                                                  MaterialButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Ya"),
                                                  ),
                                                ],
                                              );
                                            });
                                      }

                                    },
                                    child: Card(
                                      elevation: 0.5,
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: mainColor, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.all(10),
                                            child: Icon(
                                              Icons.play_circle_fill_rounded,
                                              size: 50,
                                              color: mainColor
                                            )
                                          // Image.network(
                                          //   xmodul.materiContent[index2]
                                          //       .contentPic,
                                          //   height: 80,
                                          //   width: 80,
                                          // ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${materi.namaMateri}',
                                                  overflow: TextOverflow.fade,
                                                  maxLines: 2,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text('Materi ${materi.urutan}'),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(Icons.favorite, size: 15, color: mainColor),
                                                          Text(" ${materi.likeCount}"),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(Icons.remove_red_eye_rounded, size: 15, color: mainColor),
                                                          Text(" ${materi.accessCount}"),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(Icons.chat_bubble, size: 15, color: mainColor),
                                                          Text(" ${materi.commentCount}"),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15),
                                              child: xmodul
                                                              .materiContent[
                                                                  index2]
                                                              .statusSelesai ==
                                                          'selesai' &&
                                                      xmodul
                                                              .materiContent[
                                                                  index2]
                                                              .hasilPostest ==
                                                          "Lulus"
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Center(
                                                          child: Text(
                                                            'Lulus',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                      ))
                                                  : (xmodul
                                                                      .materiContent[
                                                                          index2]
                                                                      .hasilPostest ==
                                                                  "Belum Lulus" ||
                                                              xmodul
                                                                      .materiContent[
                                                                          index2]
                                                                      .hasilPostest ==
                                                                  "Belum Postest") &&
                                                          xmodul
                                                                  .materiContent[
                                                                      index2]
                                                                  .statusSelesai ==
                                                              'selesai'
                                                      ? Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .redAccent,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            child: Center(
                                                              child: Text(
                                                                'Belum Lulus',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12),textAlign: TextAlign.center,
                                                              ),
                                                            ),
                                                          ))
                                                      : Icon(
                                                          xmodul
                                                                      .materiContent[
                                                                          index2]
                                                                      .statusSelesai ==
                                                                  'belum selesai'
                                                              ? Icons
                                                                  .autorenew_rounded
                                                              : Icons
                                                                  .cancel_rounded,
                                                          color: Colors.grey,
                                                        ),
                                            ),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
