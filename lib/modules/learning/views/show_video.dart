import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gaweid2/modules/learning/models/count_like_comment.dart';
import 'package:gaweid2/modules/learning/models/model_modul.dart';
import 'package:gaweid2/modules/learning/models/status_model.dart';
import 'package:gaweid2/modules/learning/providers/LearningProvider.dart';
import 'package:gaweid2/modules/learning/views/komentar.dart';
import 'package:gaweid2/modules/learning/views/component/video_player.dart';
import 'package:gaweid2/modules/learning/views/component/youtube_video.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/learning/views/test.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class Video extends StatefulWidget {
  var video;
  String email;
  String codeGenerate;
  String kodeReferral;
  String idMateri;
  List dataStatus = [];

  Video(
      {this.video,
      this.email,
      this.codeGenerate,
      this.kodeReferral,
      this.idMateri});

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  BaseEndPointLearning networkLearning = LearningProvider();
  List dataStatus = [];
  String statusMateri;
  String statusPretest;
  String statusPostest;

  Future<List> getModul() async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps_learning/modul_materi", body: {
      'kode_materi': widget.codeGenerate.toString(),
      'referral_code': widget.kodeReferral.toString(),
      'email': widget.email.toString(),
    });
    // log('data ${response.body}');
    ModelModul listdata = modelModulFromJson(response.body);
    // log('data ${response.body}');
    return listdata.modul;
  }

  void getStatus() async {
    print(widget.email.toString());
    print(widget.idMateri.toString());

    final response = await http.post(
        NetworkConfig().baseUrl + "apps_learning/status_employee_learning",
        body: {
          'email': widget.email.toString(),
          'id_materi': widget.idMateri.toString(),
        });
    final jsonData = jsonDecode(response.body);

    StatusMateriModel listdata = StatusMateriModel.fromJson(jsonData);

    setState(() {
      statusMateri = listdata.statusMateri;
      statusPretest = listdata.statusPretest;
      statusPostest = listdata.statusPostest;
    });
  }

  int countLike = 0;
  int countComment = 0;
  int statusRate = 0;
  String lastCommentPicture = "";
  String lastCommentNama = "";
  String lastCommentKomentar = "";

  Future getLikeComment() async {
    CountLikeCommentModel data = await networkLearning.countLikeComment(
        widget.email, widget.idMateri.toString());
    print(data.like);

    setState(() {
      countLike = data.like.countLike;
      countComment = data.like.countComment;
      statusRate = data.like.statusRate;
      lastCommentPicture = data.like.lastComment.picture;
      lastCommentNama = data.like.lastComment.nama;
      lastCommentKomentar = data.like.lastComment.komentar;
      if (data.like.statusLike == 1) {
        liked = true;
      } else {
        liked = false;
      }
    });
    // return data.like;
  }

  @override
  void initState() {
    // TODO: implement initState
    getModul();
    getStatus();
    getLikeComment();
    super.initState();
  }

  bool liked = false;
  bool showHearthOverlay = false;

  _pressed() {
    setState(() {
      liked = !liked;
      submitLike(widget.idMateri, liked);
      if (liked == true) {
        countLike = countLike + 1;
      } else {
        countLike = countLike - 1;
      }
    });
  }

  _pressedButton() {
    setState(() {
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) =>
              Komentar(idMateri: widget.idMateri, email: widget.email)));
    });
  }

  @override
  Widget build(BuildContext context) {
    IconButton hearthButton = IconButton(
      iconSize: 25,
      icon: Icon(liked ? Icons.favorite : Icons.favorite_border,
          color: liked ? Colors.red : null),
      tooltip: 'suka materi ini',
      onPressed: () => _pressed(),
    );

    IconButton commentButton = IconButton(
      iconSize: 25,
      icon: Icon(Icons.chat_bubble_outline, color: null),
      onPressed: () => _pressedButton(),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: backgroundColor,
          child: Column(
            children: [
              widget.video.preTest == '0' && widget.video.postTest == '2'
                  ? widget.video.statusContent == 'link'
                      ? youtubePlayer(
                          link: widget.video.contentVideo,
                        )
                      : VideoP(
                          link: widget.video.contentVideo,
                        )
                  : statusPretest == '0'
                      ? Container(
                          color: Colors.white,
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.videocam_off_rounded,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                                Text("Selesaikan Pre-Test terlebih dahulu", style: TextStyle(
                                  fontSize: 16,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),)
                              ],
                            ),
                          ),
                        )
                      : widget.video.statusContent == 'link'
                          ? youtubePlayer(
                              link: widget.video.contentVideo,
                            )
                          : VideoP(
                              link: widget.video.contentVideo,
                            ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          '${widget.video.namaMateri}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      // Text(
                      //   '${widget.video.id}',
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                      // Text('${widget.video.scorePostest}'),
                      // Text('${widget.video.hasilPostest}'),
                      Container(
                        height: 140,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            widget.video == null
                                ? Container()
                                : widget.video.preTest == null ||
                                        widget.video.preTest == '0'
                                    ? Container()
                                    : Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: mainColor,
                                        ),
                                        height: 35,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.2,
                                        child: MaterialButton(
                                          elevation: 0,
                                          onPressed: () {
                                            Navigator.of(context)
                                                .push(new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  Test(
                                                idJenis: '1',
                                                idMateri: widget.video.id,
                                                emailId: widget.email,
                                                codeGenerate:
                                                    widget.codeGenerate,
                                                video: widget.video,
                                                kodeReferral:
                                                    widget.kodeReferral,
                                                remidial: '0',
                                              ),
                                            ));
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.assignment_rounded,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(" Pre Test",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ],
                                          ),
                                        ),
                                      ),
                            widget.video == null
                                ? Container()
                                : widget.video.postTest == null ||
                                        widget.video.postTest == '0'
                                    ? Container()
                                    : Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: mainColor,
                                        ),
                                        height: 35,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.2,
                                        child: MaterialButton(
                                          elevation: 0,
                                          onPressed: () {
                                            widget.video.preTest == '0' &&
                                                    widget.video.postTest == '2'
                                                ? Navigator.of(context)
                                                    .push(new MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        Test(
                                                      idJenis: '2',
                                                      idMateri: widget.video.id,
                                                      emailId: widget.email,
                                                      codeGenerate:
                                                          widget.codeGenerate,
                                                      video: widget.video,
                                                      kodeReferral:
                                                          widget.kodeReferral,
                                                      remidial: '0',
                                                    ),
                                                  ))
                                                : statusPretest == '0'
                                                    ? Toast.show(
                                                        "Pre test belum selesai",
                                                        context,
                                                        duration: 3,
                                                        gravity: Toast.TOP)
                                                    : Navigator.of(context).push(
                                                        new MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            Test(
                                                          idJenis: '2',
                                                          idMateri:
                                                              widget.video.id,
                                                          emailId: widget.email,
                                                          codeGenerate: widget
                                                              .codeGenerate,
                                                          video: widget.video,
                                                          kodeReferral: widget
                                                              .kodeReferral,
                                                          remidial: '0',
                                                        ),
                                                      ));
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.assignment_rounded,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                " Post Test",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                          ],
                        ),
                      ),
                      widget.video.hasilPostest == "Belum Lulus" &&
                              widget.video.statusUserRemidial == "Bisa"
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Container(
                                margin: const EdgeInsets.only(
                                  top: 100.0,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.redAccent,
                                ),
                                height: 35,
                                child: MaterialButton(
                                  elevation: 0,
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(new MaterialPageRoute(
                                      builder: (BuildContext context) => Test(
                                        idJenis: '2',
                                        idMateri: widget.video.id,
                                        emailId: widget.email,
                                        codeGenerate: widget.codeGenerate,
                                        video: widget.video,
                                        kodeReferral: widget.kodeReferral,
                                        remidial: '1',
                                      ),
                                    ));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.assignment_rounded,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        " Remidial",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(
                              top: 150.0,
                            ),
                            child: statusRate == 1
                                ? SizedBox(
                                    height: 0,
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: MaterialButton(
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: mainColor,
                                              width: 1,
                                              style: BorderStyle.solid),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      color: Colors.white60,
                                      padding:
                                          EdgeInsets.only(left: 30, right: 30),
                                      child: Text(
                                        'Beri Rating',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ),
                                      onPressed: _showRatingAppDialog,
                                    ),
                                  ),
                          ),
                          Row(
                            children: [
                              hearthButton,
                              commentButton,
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 10, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                      "${countLike} like, ${widget.video.accessCount} akses"),
                                ),
                                countComment == 0
                                    ? SizedBox(
                                        height: 0,
                                      )
                                    : ListTile(
                                        leading: GestureDetector(
                                          onTap: () async {
                                            if(widget.video.statusAccess == "Terbuka"){
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => (Video(
                                                        video: widget.video,
                                                        email: widget.email,
                                                        codeGenerate:
                                                        widget.codeGenerate,
                                                        kodeReferral:
                                                        widget.kodeReferral,
                                                        idMateri: widget.video
                                                            .id,
                                                      ))));
                                            }else{
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text("Oops!"),
                                                      content: widget.video.statusRate == "ada"
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
                                          child: Container(
                                            height: 40.0,
                                            width: 40.0,
                                            decoration: new BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    new BorderRadius.all(
                                                        Radius.circular(50))),
                                            child: CircleAvatar(
                                              radius: 50,
                                              backgroundImage: NetworkImage(
                                                  lastCommentPicture == null
                                                      ? ""
                                                      : lastCommentPicture),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          lastCommentNama,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(lastCommentKomentar),
                                      ),
                                countComment == 0
                                    ? SizedBox(
                                        height: 0,
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Text(
                                          "${countComment} Komentar lainnya",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                // constraints: BoxConstraints(maxHeight: 330),
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height / 2.3,
                child: FutureBuilder(
                  future: getModul(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    // print(globalEmail);
                    return snapshot.hasData
                        ? ItemList(
                            list: snapshot.data,
                            email: widget.email,
                            codeGenerate: widget.codeGenerate,
                            kodeReferral: widget.kodeReferral,
                            idMateri: widget.idMateri,
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
      starColor: Colors.amber,
      title: Text('Beri Penilaian'),
      message:
          Text('Ayo, berikan penilaianmu untuk membantu kami memberikan materi yang lebih baik lagi.'),
      image: Image.asset(
        "assets/images/devs.jpg",
        height: 100,
      ),
      submitButtonText: 'Submit',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, '
            'comment: ${response.comment}');
        submit(widget.idMateri, response.rating, response.comment);
        // if (response.rating < 3.0) {
        //   print('response.rating: ${response.rating}');
        // } else {
        //   Container();
        // }
      },
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _ratingDialog,
    );
  }

  void submit(idMateri, rating, comment) async {
    // print(kodeReferral.toString());
    ModelRegister data = await networkLearning.saveRating(
        widget.email.toString(),
        idMateri.toString(),
        rating.toString(),
        comment.toString());
    // print(data.status);

    if (data.status == 202) {
      Toast.show("Data berhasil disimpan", context,
          duration: 3, gravity: Toast.TOP);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => (Video(
                    video: widget.video,
                    email: widget.email,
                    codeGenerate: widget.codeGenerate,
                    kodeReferral: widget.kodeReferral,
                    idMateri: widget.idMateri,
                  ))));
    }
  }

  void submitLike(idMateri, status) async {
    // print(kodeReferral.toString());
    ModelRegister data = await networkLearning.saveLike(
        widget.email.toString(), idMateri.toString(), status.toString());
  }
}

class ItemList extends StatefulWidget {
  List list;
  String email;
  String codeGenerate;
  String kodeReferral;
  String idMateri;

  ItemList(
      {this.list,
      this.email,
      this.codeGenerate,
      this.kodeReferral,
      this.idMateri});

  @override
  createState() => _MyWidgetState(list: list);
}

class _MyWidgetState extends State<ItemList> {
  List list;

  _MyWidgetState({this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // constraints: BoxConstraints(
              //     maxHeight: MediaQuery.of(context).size.height),
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).size.height / 2,
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
                              xmodul.namaModul == null ? "" : xmodul.namaModul,
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
                              itemBuilder: (BuildContext context, int index2) {
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
                                            color: materi.id == widget.idMateri
                                                ? mainColor
                                                : Colors.grey,
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(children: [
                                      Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Icon(
                                            Icons.play_circle_fill_rounded,
                                            size: 50,
                                            color: materi.id == widget.idMateri
                                                ? mainColor
                                                : Colors.grey,
                                          )
                                          // Image.network(
                                          //   xmodul.materiContent[index2]
                                          //       .contentPic,
                                          //   height: 80,
                                          //   width: 80,
                                          // ),
                                          ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
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
                                                        Icon(Icons.favorite, size: 15, color: materi.id == widget.idMateri
                                                            ? mainColor
                                                            : Colors.grey,),
                                                        Text(" ${materi.likeCount}"),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.remove_red_eye_rounded, size: 15, color: materi.id == widget.idMateri
                                                            ? mainColor
                                                            : Colors.grey,),
                                                        Text(" ${materi.accessCount}"),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.chat_bubble, size: 15, color: materi.id == widget.idMateri
                                                            ? mainColor
                                                            : Colors.grey,),
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
                                            child: xmodul.materiContent[index2]
                                                            .statusSelesai ==
                                                        'selesai' &&
                                                    xmodul.materiContent[index2]
                                                            .hasilPostest ==
                                                        "Lulus"
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Center(
                                                        child: Text(
                                                          'Lulus',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                    ))
                                                : (xmodul.materiContent[index2]
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
                                                          color:
                                                              Colors.redAccent,
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
                                                              'Belum Lulus',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
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
          ],
        ),
      ),
    );
  }
}
