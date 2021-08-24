import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/ui/DW/datadiri1_dw.dart';
import 'package:gaweid2/ui/DW/login_dw.dart';
import 'package:gaweid2/modules/user/view/Login2.dart';
import 'package:gaweid2/modules/user/view/menu/UserDashboard.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:path_provider/path_provider.dart';

import 'package:toast/toast.dart';
import 'package:image/image.dart' as Img;

class datadiri2_dw extends StatefulWidget {
  @override
  _datadiri2_dwState createState() => _datadiri2_dwState();
}

class _datadiri2_dwState extends State<datadiri2_dw> {


  var loading_image1 = false;
  var loading_image2 = false;
  var loading_image3 = false;


  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Apakah Anda Yakin ?'),
        content: Text('Apakah Anda Yakin \n Ingin Kembali Ke Halaman Sebelumnya '),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          FlatButton(
            onPressed: (){
              Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => datadiri1_dw(),
              ));
            },

            /*Navigator.of(context).pop(true)*/
            child: Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }

  var InSignIn = false;

  BaseEndPoint network = NetworkProvider();

  File picture, picture_save; //ktp
  File ktp, ktp_save;
  File bk, bk_save;
  TextEditingController ctitle = new TextEditingController();

//  File image; //ktp * selfi
//  File ktp; //ktp
//  File bk; //ktp
  TextEditingController etnamakeluarga = TextEditingController();
  TextEditingController ethubkeluarga = TextEditingController();
  TextEditingController etnokeluarga = TextEditingController();
  TextEditingController etnamabank = TextEditingController();
  TextEditingController etnorekbank = TextEditingController();

  accessCameraPicture() async {
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    final title = ctitle.text;

    Img.Image _image = Img.decodeImage(img.readAsBytesSync());
    Img.Image _smallerimg = Img.copyResize(_image,
        width: 300, height: 300, interpolation: Img.Interpolation.linear);

    final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();

    var compressImg =
        new File("$path/image_${currentTime}${register_name}.jpg")
          ..writeAsBytesSync(Img.encodeJpg(_smallerimg, quality: 70));

    if (img == null) {
      print('null');
    } else {
      setState(() {
        picture = img;
        picture_save = compressImg;
        //  uploadimg();
        uploadimg();
      });
    }
  }

  accessGalleryPicture() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    final title = ctitle.text;

    Img.Image _image = Img.decodeImage(img.readAsBytesSync());
    Img.Image _smallerimg = Img.copyResize(_image,
        width: 300, height: 300, interpolation: Img.Interpolation.linear);
    final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();

    var compressImg =
        new File("$path/image_${currentTime}${register_name}.jpg")
          ..writeAsBytesSync(Img.encodeJpg(_smallerimg, quality: 70));

    if (img == null) {
      print('null');
    } else {
      setState(() {
        picture = img;
        picture_save = compressImg;
        //  uploadimg();
        uploadimg();
      });
    }
  }

  accessCameraKtp() async {
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    final title = ctitle.text;

    Img.Image _image = Img.decodeImage(img.readAsBytesSync());
    Img.Image _smallerimg = Img.copyResize(_image,
        width: 300, height: 300, interpolation: Img.Interpolation.linear);

    final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();

    var compressImg =
        new File("$path/image_${currentTime}${register_name}.jpg")
          ..writeAsBytesSync(Img.encodeJpg(_smallerimg, quality: 70));

    if (img == null) {
      print('null');
    } else {
      setState(() {
        ktp = img;
        ktp_save = compressImg;
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
    Img.Image _smallerimg = Img.copyResize(_image,
        width: 300, height: 300, interpolation: Img.Interpolation.linear);

    final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();

    var compressImg =
        new File("$path/image_${currentTime}${register_name}.jpg")
          ..writeAsBytesSync(Img.encodeJpg(_smallerimg, quality: 70));

    if (img == null) {
      print('null');
    } else {
      setState(() {
        ktp = img;
        ktp_save = compressImg;
        //  uploadimg();
        uploadktp();
      });
    }
  }

  accessCamerabk() async {
    File img = await ImagePicker.pickImage(source: ImageSource.camera);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    final title = ctitle.text;

    Img.Image _image = Img.decodeImage(img.readAsBytesSync());
    Img.Image _smallerimg = Img.copyResize(_image,
        width: 300, height: 300, interpolation: Img.Interpolation.linear);
    final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();

    var compressImg =
        new File("$path/image_${currentTime}${register_name}.jpg")
          ..writeAsBytesSync(Img.encodeJpg(_smallerimg, quality: 70));

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
    Img.Image _smallerimg = Img.copyResize(_image,
        width: 300, height: 300, interpolation: Img.Interpolation.linear);

    final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();

    var compressImg =
        new File("$path/image_${currentTime}${register_name}.jpg")
          ..writeAsBytesSync(Img.encodeJpg(_smallerimg, quality: 70));

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

  SessionManager sessionManager = SessionManager();
  String register_email, register_hp, register_name;
  int register_iduser;
  bool register_status_register;
  void getsession_register() async {
    await sessionManager.getPreference().then((value) {
      setState(() {
        register_status_register = sessionManager.status_register;
        register_iduser = sessionManager.iduser_register;
        register_email = sessionManager.email;
        register_hp = sessionManager.no_hp;
        register_name = sessionManager.name;

        print("register_status_register${register_status_register}");
        print("iduser${register_iduser}");
        print("register_name${register_name}");
        print("register_email${register_email}");
        print("register_hp${register_hp}");
      });
    });
  }

  void uploadbk() {

    setState(() {
      loading_image1 = true;
    });
    network.gantibk(register_email, bk_save, context);
    setState(() {
      loading_image1 = false;
    });
  }

  void uploadktp() {
    setState(() {
      loading_image2 = true;
    });
    network.gantiktp(register_email, ktp_save, context);
    setState(() {
      loading_image2 = false;
    });
  }

  void uploadimg() {
    setState(() {
      loading_image3 = true;
    });
    network.gantipp(register_email, picture_save, context);
    setState(() {
      loading_image3 = false;
    });
  }

  String namevalidator(String value) {
    if (value.length < 4) {
      return "must be length 4";
    } else {
      return null;
    }
  }

  void validasi() {
    if (ktp_save == null || picture_save == null) {
      Toast.show("Tidak boleh Kosong", context,
          duration: 3, gravity: Toast.TOP);
    } else {
      if (_formKey.currentState.validate()) {
        //JIKA TRUE
        _formKey.currentState.save(); //MAKA FUNGSI SAVE() DIJALANKAN

        // print("image${image.toString()}");

        //Dialogs.showLoadingDialog(context, _formKey); //invoking login
        register_datadiri4();
      }
      ;
    }
  }

  void register_datadiri4() async {


    ModelRegister data = await network.register_datadiri2_dw(
              register_email,
        etnamakeluarga.text.toString(),
        ethubkeluarga.text.toString(),
        etnokeluarga.text.toString(),
        etnamabank.text.toString(),
        etnorekbank.text.toString(),
        context
    );

    Toast.show("${data.status}", context, duration: 3, gravity: Toast.BOTTOM);

    if (data.status == 200) {
      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => Login_Dw(),
      ));

      Toast.show("Success", context, duration: 3, gravity: Toast.BOTTOM);
    } else {
      setState(() {
        InSignIn = false;
      });
      print("gagal");
      Toast.show("Gagal", context, duration: 3, gravity: Toast.BOTTOM);
    }

//    network.register_datadiri2_dw(
//        register_email,
//        etnamakeluarga.text.toString(),
//        ethubkeluarga.text.toString(),
//        etnokeluarga.text.toString(),
//        etnamabank.text.toString(),
//        etnorekbank.text.toString(),
//        context
//        );



  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getsession_register();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
//        appBar: AppBar(
//          title: Text("Gawe.id"),
//          backgroundColor: mainColor,
//        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
//                    Center(
//                      child: new LinearPercentIndicator(
//                        width: MediaQuery.of(context).size.width / 1.1,
//                        lineHeight: 14.0,
//                        percent: 1.0,
//                        backgroundColor: Colors.grey,
//                        progressColor: Colors.blue,
//                        center: Text("100.0%"),
//                      ),
//                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      //controller: etName,
                      controller: etnamabank,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Nama Bank",
                        hintText: "Nama Bank",
                      ),
                      //validator: nameValidator,
                      // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                      onSaved: (value) {
                        // name = value;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      //controller: etName,
                      controller: etnorekbank,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "No Rek",
                        hintText: "No Rek",
                      ),
                      //validator: nameValidator,
                      // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                      onSaved: (value) {
                        // name = value;
                      },
                    ),
                    SizedBox(height: 16),
                    Container(
                      child: loading_image1
                          ? SpinKitFadingCircle(
                        color: Colors.redAccent,
                      )
                          : picture == null
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
                                                      accessCameraPicture();
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(Icons.image),
                                                        Text(
                                                            "Select From Gallery"),
                                                      ],
                                                    ),
                                                  ),
                                                  FlatButton(
                                                    onPressed: () {
                                                      accessCameraPicture();
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(Icons.camera),
                                                        Text(
                                                            "Select From Camera"),
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
                                      radius: (52),
                                      backgroundColor: Colors.white,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.asset(
                                            "images/slider/ktp_selfi.jpeg"),
                                      )),
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
                                                      accessCameraPicture();
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(Icons.image),
                                                        Text(
                                                            "Select From Gallery"),
                                                      ],
                                                    ),
                                                  ),
                                                  FlatButton(
                                                    onPressed: () {
                                                      accessCameraPicture();
                                                    },
                                                    child: Row(
                                                      children: <Widget>[
                                                        Icon(Icons.camera),
                                                        Text(
                                                            "Select From Camera"),
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
                                        picture,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                7,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                    Center(child: Text("Upload KTP Selfi")),
                    SizedBox(height: 16),
                    Container(
                      child: loading_image2
                          ? SpinKitFadingCircle(
                        color: Colors.redAccent,
                      )
                          : ktp == null
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
                                                        Text(
                                                            "Select From Gallery"),
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
                                                        Text(
                                                            "Select From Camera"),
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
                                      radius: (52),
                                      backgroundColor: Colors.white,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child:
                                            Image.asset("images/slider/ktp.jpg"),
                                      )),
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
                                                        Text(
                                                            "Select From Gallery"),
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
                                                        Text(
                                                            "Select From Camera"),
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
                                        ktp,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                7,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                    Center(child: Text("Upload KTP")),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      child: loading_image3
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
                                                        Text(
                                                            "Select From Gallery"),
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
                                                        Text(
                                                            "Select From Camera"),
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
                                      radius: (52),
                                      backgroundColor: Colors.white,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.asset(
                                            "images/slider/bukutabungan.jpeg"),
                                      )),
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
                                                        Text(
                                                            "Select From Gallery"),
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
                                                        Text(
                                                            "Select From Camera"),
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
                                            MediaQuery.of(context).size.height /
                                                7,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                    Center(child: Text("Upload Buku Tabungan")),
                    SizedBox(
                      height: 16,
                    ),

                    Text(
                      "Keluarga Yang dapat dihubungi dalam kondisi darurat",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      //controller: etName,
                      controller: etnamakeluarga,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Nama Keluarga",
                        hintText: "Nama Keluarga",
                      ),
                      //validator: nameValidator,
                      // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                      onSaved: (value) {
                        // name = value;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      //controller: etName,
                      controller: ethubkeluarga,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Hubungan Keluarga",
                        hintText: "Hubungan Keluarga",
                      ),
                      //validator: nameValidator,
                      // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                      onSaved: (value) {
                        // name = value;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      //controller: etName,
                      controller: etnokeluarga,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "No Hp keluarga",
                        hintText: "No Hp keluarga",
                      ),
                     // validator: nameValidator,
                      // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                      onSaved: (value) {
                        // name = value;
                      },
                    ),
                   // SizedBox(height: 16),



                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: InSignIn
                          ? SpinKitFadingCircle(
                        color: Colors.blue,
                      )
                          :


                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        onPressed: () {
                          validasi();
                          //checkEmailAndPassowrd();
                        },
                        color: Colors.green,
                        child:
                            Text("Simpan", style: TextStyle(color: Colors.white)),
                      ),
                    ),
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
