import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gaweid2/modules/learning/models/akses_learning.dart';
import 'package:gaweid2/modules/learning/models/isi_video.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/learning/views/aturan_main.dart';
import 'package:gaweid2/modules/learning/views/kodelearning.dart';
import 'package:gaweid2/modules/learning/views/posttest.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:toast/toast.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class videomateri extends StatefulWidget {
  @override
  _videomateriState createState() => _videomateriState();
  final video, nama_materi, id_materi, kodelearning, id_modul;

  videomateri({
    this.video,
    this.nama_materi,
    this.id_materi,
    this.kodelearning,
    this.id_modul,
  });
}

class _videomateriState extends State<videomateri> {
  VideoPlayerController _controller;

  //String namavideo = "200302video21.mp4";
  String namavideo = "", akses_pretest1, akses_materi, akses_posttest,pre_tes_block,post_tes_block;

  Future getAksesMateri() async {
    //loading = false;
    final jsonString = await http.post(
        NetworkConfig().baseUrl + "apps_learning/akses_materi_learning",
        body: {
          'id_materi': widget.id_materi,
          'email': globalEmail,
          'id_modul': widget.id_modul,
        });
    final jsonData = jsonDecode(jsonString.body);

    Akses_learning akses_learning = Akses_learning.fromJson(jsonData);
    //print("akses_learning${akses_learning}");
    setState(() {
      akses_pretest1  = akses_learning.pretest.toString();
      akses_materi    = akses_learning.materi.toString();
      akses_posttest  = akses_learning.posttest.toString();
      pre_tes_block    = akses_learning.pre_tes_block.toString();
      post_tes_block   = akses_learning.pos_tes_block.toString();
    });
  }

  Future<List> isiVideo() async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps_learning/isi_video", body: {
      'id_materi': widget.id_materi.toString(),
//      'email':globalEmail,
//      'id_modul':widget.id_modul,
    });

    IsivideoModel listdata = isivideoModelFromJson(response.body);
    return listdata.videoIsi;
  }

  var globalName = "", globalEmail = "", globalLevel = "";
  var status = false;
  var id_user, globalid_employee;
//  var value;
  var mystatus;
  var InSignIn = false;

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

  @override
  void initState() {
    getPreferences();
    super.initState();
    _controller = VideoPlayerController.network(
        "https://gawe.id/userfiles/learning/isi_materi/video/${namavideo}")
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      });
  }

  @override
  Widget build(BuildContext context) {
    getAksesMateri();
    print("akses${akses_pretest1}");

    return Scaffold(
      appBar: AppBar(
        title: Text("Gawe.id"),
        backgroundColor: mainColor,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child:  pre_tes_block == "0" ? Center(child: Text("Pre Test Tidak Tersedia")) : RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => (aturanMain(
                                jenis_access: "1",
                                nama_materi: widget.nama_materi == null
                                    ? ""
                                    : widget.nama_materi,
                                id_materi: widget.id_materi == null
                                    ? ""
                                    : widget.id_materi,
                                kodelearning: widget.kodelearning == null
                                    ? ""
                                    : widget.kodelearning,
                              ))));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.book),
                    Container(
                      child: pre_tes_block == "0" ? Text("Tidak Tersedia") :
                      Text(
                          'Pre Test  ${akses_pretest1 == null ? "" : akses_pretest1}',
                          style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
                color: mainColor,
                textColor: Colors.white,
                elevation: 5,
              ),
            ),
          ),
          SizedBox(
            height: 2,
          ),

          LimitedBox(
            maxHeight: 200.0,
            child: FutureBuilder(
              future: isiVideo(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                //  print("snap${snapshot.hasData}");
                return snapshot.hasData
                    ? ItemListVideo(
                        list: snapshot.data,
                        controller: _controller,
                        nama_materi: widget.nama_materi,
                        namavideo: namavideo,
                        akses_materi:akses_materi,
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child:  post_tes_block == "0" ? Center(child: Text("Post Test Tidak Tersedia")) : RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => (aturanMain(
                                jenis_access: "2",
                                nama_materi: widget.nama_materi == null
                                    ? ""
                                    : widget.nama_materi,
                                id_materi: widget.id_materi == null
                                    ? ""
                                    : widget.id_materi,
                                kodelearning: widget.kodelearning == null
                                    ? ""
                                    : widget.kodelearning,
                              ))));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.school),
                    Text(
                        'Post Test ${akses_posttest == null ? "" : akses_posttest}  ',
                        style: TextStyle(fontSize: 18)),
                  ],
                ),
                color: mainColor,
                textColor: Colors.white,
                elevation: 5,
              ),
            ),
          ),
        ],
      ),
//        floatingActionButton: FloatingActionButton(
//          onPressed: () {
//            setState(() {
//              _controller.value.isPlaying
//                  ? _controller.pause()
//                  : _controller.play();
//            });
//          },
//          child: Icon(
//            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//          ),
//        ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class ItemListVideo extends StatelessWidget {
  List list;
  String nama_materi, namavideo,akses_materi;
  VideoPlayerController controller;
  ItemListVideo({this.list, this.controller, this.nama_materi, this.namavideo,this.akses_materi});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 200.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (BuildContext context, int index) {
          final VideoIsi xvideo = list[index];

          if (xvideo.id == "0000") {
            return Center(
              child: Container(
                child: Center(
                    child: Text(
                  "Belum Memiliki Video\n",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: RaisedButton(
                              onPressed: () {

                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  //Icon(Icons.school),
                                  Icon(
                                    controller.value.isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                  ),
                                  Text(
                                      controller.value.isPlaying
                                          ? "Video ${xvideo.namaMateri} Stop"
                                          : "Video ${xvideo.namaMateri} Mulai ${akses_materi}",
                                      style: TextStyle(fontSize: 18)),
                                ],
                              ),
                              color: Colors.green,
                              textColor: Colors.white,
                              elevation: 5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
