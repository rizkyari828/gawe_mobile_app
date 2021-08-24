import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as Img;
import 'package:path_provider/path_provider.dart';

class Resume extends StatefulWidget {
  final kk, ktp, ijazah, bk, cv;

  Resume({this.kk, this.ktp, this.bk, this.ijazah, this.cv});

  @override
  _ResumeState createState() => _ResumeState();
}

class _ResumeState extends State<Resume> {
  BaseEndPoint network = NetworkProvider();

  var loading_image = false;
  var loading_kk = false;
  var loading_cv = false;
  var loading_bk = false;
  var loading_ijazah = false;

  File image,image_save; //ktp
  File kk,kk_save;
  File cv,cv_save;
  File bk,bk_save;
  File ijazah,ijazah_save;
  TextEditingController ctitle= new TextEditingController();
  accessCameraKtp() async {
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    final title = ctitle.text;

    Img.Image _image = Img.decodeImage(img.readAsBytesSync());
    Img.Image _smallerimg = Img.copyResize(_image,width: 300,height: 300, interpolation: Img.Interpolation.linear);

    var compressImg = new File("$path/image_${globalid_employee}${globalName}.jpg")
      ..writeAsBytesSync(Img.encodeJpg(_smallerimg,quality: 70));



    if (img == null) {
      print('null');
    } else {
      setState(() {
        image = img;
        image_save = compressImg;
        //  uploadimg();
        uploadktp();
      });
    }
  }

  accessGalleryKtp() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    final title = ctitle.text;

    Img.Image _image = Img.decodeImage(img.readAsBytesSync());
    Img.Image _smallerimg = Img.copyResize(_image,width: 300,height: 300, interpolation: Img.Interpolation.linear);

    var compressImg = new File("$path/image_${globalid_employee}${globalName}.jpg")
      ..writeAsBytesSync(Img.encodeJpg(_smallerimg,quality: 70));


    if (img == null) {
      print('null');
    } else {
      setState(() {
        image = img;
        image_save = compressImg;
        //  uploadimg();
        uploadktp();
      });
    }
  }

  accessCamerakk() async {
    File img = await ImagePicker.pickImage(source: ImageSource.camera);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    final title = ctitle.text;

    Img.Image _image = Img.decodeImage(img.readAsBytesSync());
    Img.Image _smallerimg = Img.copyResize(_image,width: 300,height: 300, interpolation: Img.Interpolation.linear);

    var compressImg = new File("$path/image_${globalid_employee}${globalName}.jpg")
      ..writeAsBytesSync(Img.encodeJpg(_smallerimg,quality: 70));


    if (img == null) {
      print('null');
    } else {
      setState(() {
        kk = img;
        kk_save = compressImg;
        uploadkk();
        //  uploadimg();
      });
    }
  }

  accessGallerykk() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    final title = ctitle.text;

    Img.Image _image = Img.decodeImage(img.readAsBytesSync());
    Img.Image _smallerimg = Img.copyResize(_image,width: 300,height: 300, interpolation: Img.Interpolation.linear);

    var compressImg = new File("$path/image_${globalid_employee}${globalName}.jpg")
      ..writeAsBytesSync(Img.encodeJpg(_smallerimg,quality: 70));


    if (img == null) {
      print('null');
    } else {
      setState(() {
        kk = img;
        kk_save = compressImg;
        //  uploadimg();
        uploadkk();
      });
    }
  }

  accessCameracv() async {
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    final title = ctitle.text;

    Img.Image _image = Img.decodeImage(img.readAsBytesSync());
    Img.Image _smallerimg = Img.copyResize(_image,width: 300,height: 300, interpolation: Img.Interpolation.linear);

    var compressImg = new File("$path/image_${globalid_employee}${globalName}.jpg")
      ..writeAsBytesSync(Img.encodeJpg(_smallerimg,quality: 70));

    if (img == null) {
      print('null');
    } else {
      setState(() {
        cv = img;
        cv_save = compressImg;
        //  uploadimg();
        uploadcv();
      });
    }
  }

  accessGallerycv() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    final title = ctitle.text;

    Img.Image _image = Img.decodeImage(img.readAsBytesSync());
    Img.Image _smallerimg = Img.copyResize(_image,width: 300,height: 300, interpolation: Img.Interpolation.linear);

    var compressImg = new File("$path/image_${globalid_employee}${globalName}.jpg")
      ..writeAsBytesSync(Img.encodeJpg(_smallerimg,quality: 70));

    if (img == null) {
      print('null');
    } else {
      setState(() {
        cv = img;
        cv_save = compressImg;
        //  uploadimg();
        uploadcv();
      });
    }
  }

  accessCamerabk() async {
    File img = await ImagePicker.pickImage(source: ImageSource.camera);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    final title = ctitle.text;

    Img.Image _image = Img.decodeImage(img.readAsBytesSync());
    Img.Image _smallerimg = Img.copyResize(_image,width: 300,height: 300, interpolation: Img.Interpolation.linear);

    var compressImg = new File("$path/image_${globalid_employee}${globalName}.jpg")
      ..writeAsBytesSync(Img.encodeJpg(_smallerimg,quality: 70));


    if (img == null) {
      print('null');
    } else {
      setState(() {
        bk = img;
        bk_save = compressImg;
        //  uploadimg();
        uploadbk();
      });
    }
  }

  accessGallerybk() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    final title = ctitle.text;

    Img.Image _image = Img.decodeImage(img.readAsBytesSync());
    Img.Image _smallerimg = Img.copyResize(_image,width: 300,height: 300, interpolation: Img.Interpolation.linear);

    var compressImg = new File("$path/image_${globalid_employee}${globalName}.jpg")
      ..writeAsBytesSync(Img.encodeJpg(_smallerimg,quality: 70));


    if (img == null) {
      print('null');
    } else {
      setState(() {
        bk = img;
        bk_save = compressImg;
        //  uploadimg();
        uploadbk();
      });
    }
  }

  accessCameraijazah() async {
    File img = await ImagePicker.pickImage(source: ImageSource.camera);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    final title = ctitle.text;

    Img.Image _image = Img.decodeImage(img.readAsBytesSync());
    Img.Image _smallerimg = Img.copyResize(_image,width: 300,height: 300, interpolation: Img.Interpolation.linear);

    var compressImg = new File("$path/image_${globalid_employee}${globalName}.jpg")
      ..writeAsBytesSync(Img.encodeJpg(_smallerimg,quality: 70));


    if (img == null) {
      print('null');
    } else {
      setState(() {
        ijazah = img;
        ijazah_save=compressImg;
        uploadijazah();
        //  uploadimg();
      });
    }
  }

  accessGalleryijazah() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    final title = ctitle.text;

    Img.Image _image = Img.decodeImage(img.readAsBytesSync());
    Img.Image _smallerimg = Img.copyResize(_image,width: 300,height: 300, interpolation: Img.Interpolation.linear);

    var compressImg = new File("$path/image_${globalid_employee}${globalName}.jpg")
      ..writeAsBytesSync(Img.encodeJpg(_smallerimg,quality: 70));


    if (img == null) {
      print('null');
    } else {
      setState(() {
        ijazah = img;
        ijazah_save=compressImg;
        uploadijazah();
        //  uploadimg();
      });
    }
  }

  void uploadktp() {
    setState(() {
      loading_image = true;
    });
    network.gantiktp(globalEmail, image_save, context);
    setState(() {
      loading_image = false;
    });
  }

  void uploadkk() {
    setState(() {
      loading_kk = true;
    });
    network.gantikk(globalEmail, kk_save, context);
    setState(() {
      loading_kk = false;
    });
  }

  void uploadcv() {
    setState(() {
      loading_cv = true;
    });
    network.ganticv(globalEmail, cv_save, context);
    setState(() {
      loading_cv = false;
    });
  }

  void uploadbk() {
    setState(() {
      loading_bk = true;
    });
    network.gantibk(globalEmail, bk_save, context);
    setState(() {
      loading_bk = false;
    });
  }

  void uploadijazah() {
    setState(() {
      loading_ijazah = true;
    });
    network.gantiijazah(globalEmail, ijazah_save, context);
    setState(() {
      loading_ijazah = false;
    });
  }


  var globalName = "", globalEmail = "", globalLevel = "";
  var status = false;
  var id_user, globalid_employee;
//  var value;
  var mystatus;

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
//        print("status${mystatus}");
//        print("fullname${globalName}");
//        print("email${globalEmail}");
        print("globalid_employee $globalid_employee");
        //_loginStatus = mystatus == true ? LoginStatus.Login : LoginStatus.not_login;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dokumen"),
        backgroundColor: mainColor,
        elevation: 0,
      ),
      body: Container(
        color: backgroundColor,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: loading_image
                          ? SpinKitFadingCircle(
                        color: Colors.redAccent,
                      )
                          :image == null
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Upload KTP"),
                                            content: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  4,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4,
                                              child: Column(
                                                children: <Widget>[
                                                  FlatButton(
                                                    onPressed: () {
                                                      accessGalleryKtp();
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(Icons.image),
                                                        Text("Select From Gallery"),
                                                      ],
                                                    ),
                                                  ),
                                                  FlatButton(
                                                    onPressed: () {
                                                      accessCameraKtp();
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(Icons.camera),
                                                        Text("Select From Camera"),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: CircleAvatar(
                                    radius: 55,
                                    backgroundColor: Color(0xffFDCF09),
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                          widget.ktp == null ? "" : widget.ktp),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Upload Profil"),
                                            content: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  4,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4,
                                              child: Column(
                                                children: <Widget>[
                                                  FlatButton(
                                                    onPressed: () {
                                                      accessGalleryKtp();
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(Icons.image),
                                                        Text("Select From Gallery"),
                                                      ],
                                                    ),
                                                  ),
                                                  FlatButton(
                                                    onPressed: () {
                                                      accessCameraKtp();
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(Icons.camera),
                                                        Text("Select From Camera"),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Center(
                                    child: Container(
                                      margin: EdgeInsets.all(2),
                                      child: Image.file(
                                        image,
                                        height:
                                            MediaQuery.of(context).size.height / 7,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                    Text("Upload KTP"),
                    Divider(),
                    Container(
                      child: loading_kk
                          ? SpinKitFadingCircle(
                        color: Colors.redAccent,
                      )
                          :kk == null
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Upload KK"),
                                            content: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  4,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4,
                                              child: Column(
                                                children: <Widget>[
                                                  FlatButton(
                                                    onPressed: () {
                                                      accessGallerykk();
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(Icons.image),
                                                        Text("Select From Gallery"),
                                                      ],
                                                    ),
                                                  ),
                                                  FlatButton(
                                                    onPressed: () {
                                                      accessCamerakk();
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(Icons.camera),
                                                        Text("Select From Camera"),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: CircleAvatar(
                                    radius: 55,
                                    backgroundColor: Color(0xffFDCF09),
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                          widget.kk == null ? "" : widget.kk),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Upload KK"),
                                            content: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  4,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4,
                                              child: Column(
                                                children: <Widget>[
                                                  FlatButton(
                                                    onPressed: () {
                                                      accessGallerykk();
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(Icons.image),
                                                        Text("Select From Gallery"),
                                                      ],
                                                    ),
                                                  ),
                                                  FlatButton(
                                                    onPressed: () {
                                                      accessCamerakk();
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(Icons.camera),
                                                        Text("Select From Camera"),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Center(
                                    child: Container(
                                      margin: EdgeInsets.all(2),
                                      child: Image.file(
                                        kk,
                                        height:
                                            MediaQuery.of(context).size.height / 7,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                    Text("Upload KK"),
                    Divider(),
                    Container(
                      child: loading_cv
                          ? SpinKitFadingCircle(
                        color: Colors.redAccent,
                      )
                          : cv == null
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Upload CV"),
                                            content: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  4,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4,
                                              child: Column(
                                                children: <Widget>[
                                                  FlatButton(
                                                    onPressed: () {
                                                      accessGallerycv();
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(Icons.image),
                                                        Text("Select From Gallery"),
                                                      ],
                                                    ),
                                                  ),
                                                  FlatButton(
                                                    onPressed: () {
                                                      accessCameracv();
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(Icons.camera),
                                                        Text("Select From Camera"),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: CircleAvatar(
                                    radius: 55,
                                    backgroundColor: Color(0xffFDCF09),
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                          widget.cv == null ? "" : widget.cv),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Upload CV"),
                                            content: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  4,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4,
                                              child: Column(
                                                children: <Widget>[
                                                  FlatButton(
                                                    onPressed: () {
                                                      accessGallerycv();
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(Icons.image),
                                                        Text("Select From Gallery"),
                                                      ],
                                                    ),
                                                  ),
                                                  FlatButton(
                                                    onPressed: () {
                                                      accessCameracv();
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(Icons.camera),
                                                        Text("Select From Camera"),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Center(
                                    child: Container(
                                      margin: EdgeInsets.all(2),
                                      child: Image.file(
                                        cv,
                                        height:
                                            MediaQuery.of(context).size.height / 7,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                    Text("Upload CV"),
                    Divider(),
                    Container(
                      child: loading_bk
                          ? SpinKitFadingCircle(
                        color: Colors.redAccent,
                      )
                          : bk == null
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Upload Buku Tabungan"),
                                            content: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  4,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4,
                                              child: Column(
                                                children: <Widget>[
                                                  FlatButton(
                                                    onPressed: () {
                                                      accessGallerybk();
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(Icons.image),
                                                        Text("Select From Gallery"),
                                                      ],
                                                    ),
                                                  ),
                                                  FlatButton(
                                                    onPressed: () {
                                                      accessCamerabk();
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(Icons.camera),
                                                        Text("Select From Camera"),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: CircleAvatar(
                                    radius: 55,
                                    backgroundColor: Color(0xffFDCF09),
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                          widget.bk == null ? "" : widget.bk),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Upload Buku Tabungan"),
                                            content: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  4,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4,
                                              child: Column(
                                                children: <Widget>[
                                                  FlatButton(
                                                    onPressed: () {
                                                      accessGallerybk();
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(Icons.image),
                                                        Text("Select From Gallery"),
                                                      ],
                                                    ),
                                                  ),
                                                  FlatButton(
                                                    onPressed: () {
                                                      accessCamerabk();
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(Icons.camera),
                                                        Text("Select From Camera"),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Center(
                                    child: Container(
                                      margin: EdgeInsets.all(2),
                                      child: Image.file(
                                        bk,
                                        height:
                                            MediaQuery.of(context).size.height / 7,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                    Text("Upload Buku Tabungan"),
                    Divider(),
                    Container(
                      child: loading_ijazah
                          ? SpinKitFadingCircle(
                        color: Colors.redAccent,
                      )
                          :  ijazah == null
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Upload Ijazah"),
                                            content: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  4,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4,
                                              child: Column(
                                                children: <Widget>[
                                                  FlatButton(
                                                    onPressed: () {
                                                      accessGalleryijazah();
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(Icons.image),
                                                        Text("Select From Gallery"),
                                                      ],
                                                    ),
                                                  ),
                                                  FlatButton(
                                                    onPressed: () {
                                                      accessCameraijazah();
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(Icons.camera),
                                                        Text("Select From Camera"),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: CircleAvatar(
                                    radius: 55,
                                    backgroundColor: Color(0xffFDCF09),
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                          widget.ijazah == null ? "" : widget.ijazah),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("Upload Ijazah"),
                                            content: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  4,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4,
                                              child: Column(
                                                children: <Widget>[
                                                  FlatButton(
                                                    onPressed: () {
                                                      accessGalleryijazah();
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(Icons.image),
                                                        Text("Select From Gallery"),
                                                      ],
                                                    ),
                                                  ),
                                                  FlatButton(
                                                    onPressed: () {
                                                      accessCameraijazah();
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(Icons.camera),
                                                        Text("Select From Camera"),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Center(
                                    child: Container(
                                      margin: EdgeInsets.all(2),
                                      child: Image.file(
                                        ijazah,
                                        height:
                                            MediaQuery.of(context).size.height / 7,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                    Text("Upload Ijazah"),
                    SizedBox(height: 20,),
                    Divider(),
                    Text("Semua file dapat dikosongkan", style: TextStyle(color:Colors.red, fontSize: 12),),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
