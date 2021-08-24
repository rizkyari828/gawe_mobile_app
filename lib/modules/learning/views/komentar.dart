import 'dart:convert';
import 'dart:math';

import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:gaweid2/modules/learning/models/comment_model.dart';
import 'package:gaweid2/modules/learning/providers/LearningProvider.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/modules/user/providers/userProvider.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class Komentar extends StatefulWidget {
  String email;
  String idMateri;

  Komentar({this.email, this.idMateri});

  @override
  _KomentarState createState() => _KomentarState();
}

class _KomentarState extends State<Komentar> {
  BaseEndPointLearning networkLearning = LearningProvider();
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  var globalName = "",
      globalEmail = "",
      globalLevel = "",
      idUser = "",
      globalidEmployee = "",
      globalPicture = "";
  var status = false;
  var mystatus;

  SessionManager sessionManager = SessionManager();

  void getPreferences() async {
    await sessionManager.getPreference().then((value) {
      setState(() {
        mystatus = sessionManager.status;
        globalName = sessionManager.fullname;
        globalEmail = sessionManager.email;
        idUser = sessionManager.iduser;
        globalidEmployee = sessionManager.id_employee;
        globalPicture = sessionManager.picture;
      });
    });
  }

  Future<List<Comment>> getComment() async {
    CommentModel data =
        await networkLearning.getComment(widget.idMateri.toString());

    return data.comment;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComment();
    getPreferences();
  }

  Widget commentChild() {
    return FutureBuilder(
      future: getComment(),
      builder: (context, snapshot) {
        if (snapshot.hasError) print(snapshot.hasError);
        List<Comment> xmodul = snapshot.data;
        return snapshot.hasData
            ? ListView.builder(
                // physics: NeverScrollableScrollPhysics(),
                itemCount: xmodul == null ? 0 : xmodul.length,
                itemBuilder: (BuildContext context, int index) {
                  var xdata = xmodul[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
                              child: ListTile(
                                leading: GestureDetector(
                                  onTap: () async {
                                    // Display the image in large form.
                                    print("Comment Clicked");
                                  },
                                  child: Container(
                                    height: 50.0,
                                    width: 50.0,
                                    decoration: new BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: new BorderRadius.all(
                                            Radius.circular(50))),
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          NetworkImage(xdata.picture),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  xdata.nama,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(xdata.comment),
                              ))
                        ],
                      ),
                    ),
                  );
                },
              )
            : SingleChildScrollView(
                child: Container(
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
                            'Belum ada komentar',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ]),
                  ),
                ),
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Komentar",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        child: CommentBox(
          userImage: "${globalPicture}",
          child: commentChild(),
          labelText: 'Tulis Komentar...',
          withBorder: false,
          errorText: 'Komentar tidak boleh kosong',
          sendButtonMethod: () {
            if (formKey.currentState.validate()) {
              // print(commentController.text);
              setState(() {
                // var value = {
                //   'name': 'New User',
                //   'pic':
                //   'https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400',
                //   'message': commentController.text
                // };
                // filedata.insert(0, value);

                submit(widget.email, widget.idMateri, commentController.text);
              });
              commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
        ),
      ),
    );
  }

  void submit(email, idMateri, comment) async {
    print(email);
    print(idMateri);
    print(comment);
    // print(kodeReferral.toString());
    ModelRegister data = await networkLearning.saveComment(
      widget.email.toString(),
      idMateri.toString(),
      comment.toString(),
    );
    print(data.status);

    if (data.status == 202) {
      Toast.show("Data berhasil disimpan", context,
          duration: 3, gravity: Toast.TOP);
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) =>
              Komentar(idMateri: widget.idMateri, email: widget.email)));
    }
  }
}
