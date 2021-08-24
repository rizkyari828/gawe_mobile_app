import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'package:image/image.dart' as Img;

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class pengajuan_lembur extends StatefulWidget {
  final id;

  pengajuan_lembur({
    this.id,
  });

  @override
  _pengajuan_lemburState createState() => _pengajuan_lemburState();
}

class _pengajuan_lemburState extends State<pengajuan_lembur> {
  BaseEndPoint network = NetworkProvider();

  var InSignIn = false;
  String picture;

  List jam2 = [
    {"inisial": "00", "isi": "00"},
    {"inisial": "01", "isi": "01"},
    {"inisial": "02", "isi": "02"},
    {"inisial": "03", "isi": "03"},
    {"inisial": "04", "isi": "04"},
    {"inisial": "05", "isi": "05"},
    {"inisial": "06", "isi": "06"},
    {"inisial": "07", "isi": "07"},
    {"inisial": "08", "isi": "08"},
    {"inisial": "09", "isi": "09"},
    {"inisial": "10", "isi": "10"},
    {"inisial": "11", "isi": "11"},
    {"inisial": "12", "isi": "12"},
    {"inisial": "13", "isi": "13"},
    {"inisial": "14", "isi": "14"},
    {"inisial": "15", "isi": "15"},
    {"inisial": "16", "isi": "16"},
    {"inisial": "17", "isi": "17"},
    {"inisial": "18", "isi": "18"},
    {"inisial": "19", "isi": "19"},
    {"inisial": "20", "isi": "20"},
    {"inisial": "21", "isi": "21"},
    {"inisial": "22", "isi": "22"},
    {"inisial": "23", "isi": "23"},
  ];

  List jam = [
    {"inisial": "00", "isi": "00"},
    {"inisial": "01", "isi": "01"},
    {"inisial": "02", "isi": "02"},
    {"inisial": "03", "isi": "03"},
    {"inisial": "04", "isi": "04"},
    {"inisial": "05", "isi": "05"},
    {"inisial": "06", "isi": "06"},
    {"inisial": "07", "isi": "07"},
    {"inisial": "08", "isi": "08"},
    {"inisial": "09", "isi": "09"},
    {"inisial": "10", "isi": "10"},
    {"inisial": "11", "isi": "11"},
    {"inisial": "12", "isi": "12"},
    {"inisial": "13", "isi": "13"},
    {"inisial": "14", "isi": "14"},
    {"inisial": "15", "isi": "15"},
    {"inisial": "16", "isi": "16"},
    {"inisial": "17", "isi": "17"},
    {"inisial": "18", "isi": "18"},
    {"inisial": "19", "isi": "19"},
    {"inisial": "20", "isi": "20"},
    {"inisial": "21", "isi": "21"},
    {"inisial": "22", "isi": "22"},
    {"inisial": "23", "isi": "23"},
  ];

  List menit = [
    {"inisial": "00", "isi": "00"},
    {"inisial": "01", "isi": "01"},
    {"inisial": "02", "isi": "02"},
    {"inisial": "03", "isi": "03"},
    {"inisial": "04", "isi": "04"},
    {"inisial": "05", "isi": "05"},
    {"inisial": "06", "isi": "06"},
    {"inisial": "07", "isi": "07"},
    {"inisial": "08", "isi": "08"},
    {"inisial": "09", "isi": "09"},
    {"inisial": "10", "isi": "10"},
    {"inisial": "11", "isi": "11"},
    {"inisial": "12", "isi": "12"},
    {"inisial": "13", "isi": "13"},
    {"inisial": "14", "isi": "14"},
    {"inisial": "15", "isi": "15"},
    {"inisial": "16", "isi": "16"},
    {"inisial": "17", "isi": "17"},
    {"inisial": "18", "isi": "18"},
    {"inisial": "19", "isi": "19"},
    {"inisial": "20", "isi": "20"},
    {"inisial": "21", "isi": "21"},
    {"inisial": "22", "isi": "22"},
    {"inisial": "23", "isi": "23"},
    {"inisial": "24", "isi": "24"},
    {"inisial": "25", "isi": "25"},
    {"inisial": "26", "isi": "26"},
    {"inisial": "27", "isi": "27"},
    {"inisial": "28", "isi": "28"},
    {"inisial": "29", "isi": "29"},
    {"inisial": "30", "isi": "30"},
    {"inisial": "31", "isi": "31"},
    {"inisial": "32", "isi": "32"},
    {"inisial": "33", "isi": "33"},
    {"inisial": "34", "isi": "34"},
    {"inisial": "35", "isi": "35"},
    {"inisial": "36", "isi": "36"},
    {"inisial": "37", "isi": "38"},
    {"inisial": "39", "isi": "39"},
    {"inisial": "40", "isi": "40"},
    {"inisial": "41", "isi": "41"},
    {"inisial": "42", "isi": "42"},
    {"inisial": "43", "isi": "43"},
    {"inisial": "44", "isi": "44"},
    {"inisial": "45", "isi": "45"},
    {"inisial": "46", "isi": "46"},
    {"inisial": "47", "isi": "47"},
    {"inisial": "48", "isi": "48"},
    {"inisial": "49", "isi": "49"},
    {"inisial": "50", "isi": "50"},
    {"inisial": "51", "isi": "51"},
    {"inisial": "52", "isi": "52"},
    {"inisial": "53", "isi": "53"},
    {"inisial": "54", "isi": "54"},
    {"inisial": "55", "isi": "55"},
    {"inisial": "56", "isi": "56"},
    {"inisial": "57", "isi": "57"},
    {"inisial": "58", "isi": "58"},
    {"inisial": "59", "isi": "59"},
    {"inisial": "60", "isi": "60"},
  ];

  List menit2 = [
    {"inisial": "00", "isi": "00"},
    {"inisial": "01", "isi": "01"},
    {"inisial": "02", "isi": "02"},
    {"inisial": "03", "isi": "03"},
    {"inisial": "04", "isi": "04"},
    {"inisial": "05", "isi": "05"},
    {"inisial": "06", "isi": "06"},
    {"inisial": "07", "isi": "07"},
    {"inisial": "08", "isi": "08"},
    {"inisial": "09", "isi": "09"},
    {"inisial": "10", "isi": "10"},
    {"inisial": "11", "isi": "11"},
    {"inisial": "12", "isi": "12"},
    {"inisial": "13", "isi": "13"},
    {"inisial": "14", "isi": "14"},
    {"inisial": "15", "isi": "15"},
    {"inisial": "16", "isi": "16"},
    {"inisial": "17", "isi": "17"},
    {"inisial": "18", "isi": "18"},
    {"inisial": "19", "isi": "19"},
    {"inisial": "20", "isi": "20"},
    {"inisial": "21", "isi": "21"},
    {"inisial": "22", "isi": "22"},
    {"inisial": "23", "isi": "23"},
    {"inisial": "24", "isi": "24"},
    {"inisial": "25", "isi": "25"},
    {"inisial": "26", "isi": "26"},
    {"inisial": "27", "isi": "27"},
    {"inisial": "28", "isi": "28"},
    {"inisial": "29", "isi": "29"},
    {"inisial": "30", "isi": "30"},
    {"inisial": "31", "isi": "31"},
    {"inisial": "32", "isi": "32"},
    {"inisial": "33", "isi": "33"},
    {"inisial": "34", "isi": "34"},
    {"inisial": "35", "isi": "35"},
    {"inisial": "36", "isi": "36"},
    {"inisial": "37", "isi": "38"},
    {"inisial": "39", "isi": "39"},
    {"inisial": "40", "isi": "40"},
    {"inisial": "41", "isi": "41"},
    {"inisial": "42", "isi": "42"},
    {"inisial": "43", "isi": "43"},
    {"inisial": "44", "isi": "44"},
    {"inisial": "45", "isi": "45"},
    {"inisial": "46", "isi": "46"},
    {"inisial": "47", "isi": "47"},
    {"inisial": "48", "isi": "48"},
    {"inisial": "49", "isi": "49"},
    {"inisial": "50", "isi": "50"},
    {"inisial": "51", "isi": "51"},
    {"inisial": "52", "isi": "52"},
    {"inisial": "53", "isi": "53"},
    {"inisial": "54", "isi": "54"},
    {"inisial": "55", "isi": "55"},
    {"inisial": "56", "isi": "56"},
    {"inisial": "57", "isi": "57"},
    {"inisial": "58", "isi": "58"},
    {"inisial": "59", "isi": "59"},
    {"inisial": "60", "isi": "60"},
  ];

  String valjam, valminutes, valjam_end, valminutes_end;

  DateTime _dueDate = DateTime.now();
  String dateText = "";

  selectDueDate(BuildContext content) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime(1955),
      lastDate: DateTime(2040),
    );

    if (picked != null) {
      setState(() {
        _dueDate = picked;
        dateText = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  TextEditingController jamstart = TextEditingController();
  TextEditingController jamend = TextEditingController();

  File image, image_save;
  TextEditingController ctitle = new TextEditingController();
  accessCamera() async {
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    final title = ctitle.text;

    Img.Image _image = Img.decodeImage(img.readAsBytesSync());
    Img.Image _smallerimg = Img.copyResize(_image,
        width: 300, height: 300, interpolation: Img.Interpolation.linear);

    final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();

    var compressImg = new File("$path/image_${currentTime}.jpg")
      ..writeAsBytesSync(Img.encodeJpg(_smallerimg, quality: 70));

    if (img == null) {
      print('null');
    } else {
      setState(() {
        image = img;
        image_save = compressImg;
        //uploadimg();
        var InSignIn = true;
      });
      Navigator.pop(context);
    }
  }

  accessGallery() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);

    final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    final title = ctitle.text;

    Img.Image _image = Img.decodeImage(img.readAsBytesSync());
    Img.Image _smallerimg = Img.copyResize(_image,
        width: 500, height: 500, interpolation: Img.Interpolation.linear);

    var compressImg = new File("$path/image_${currentTime}.jpg")
      ..writeAsBytesSync(Img.encodeJpg(_smallerimg, quality: 70));

    if (img == null) {
      print('null');
    } else {
      setState(() {
        image = img;
        image_save = compressImg;
        // uploadimg();
      });
      Navigator.pop(context);
    }
  }

  String namevalidator(String value) {
    if (value.length < 5) {
      return "must be length 5";
    } else if (value == ":") {
      return "harus ada karakter :";
    } else {
      return null;
    }
  }

  var globalName = "", globalEmail = "", globalLevel = "";
  var status = false;
  var id_user, globalid_employee;
//  var value;
  var mystatus;

  void validasi() {
    if (dateText == null ||
        dateText == "null" ||
        dateText == "" ||
        valjam == null ||
        valjam_end == null ||
        valminutes == null ||
        valminutes_end == null ||
        image_save == null) {
      Toast.show("Masih ada yang  Harus diisi", context,
          duration: 3, gravity: Toast.TOP);
    } else {
      if (_formKey.currentState.validate()) {
        //JIKA TRUE
        _formKey.currentState.save(); //MAKA FUNGSI SAVE() DIJALANKAN

        //Dialogs.showLoadingDialog(context, _formKey); //invoking login

        setState(() {
          InSignIn = true;
        });

        network.pengajuan_lembur(
            globalid_employee,
            dateText.toString(),
            valjam.toString(),
            valminutes.toString(),
            valjam_end.toString(),
            valminutes_end.toString(),
            widget.id.toString(),
            image_save,
            context);
      }
      ;
    }
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPreferences();
  }

  final _formKey = GlobalKey<FormState>();

  final dateFormat = DateFormat("EEEE, MMMM d, yyyy 'at' h:mma");
  final timeFormat = DateFormat("h:mm a");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pengajuan Lembur ${widget.id}"),
        backgroundColor: mainColor,
      ),
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
                  SizedBox(height: 16),
                  Row(children: <Widget>[
                    Text("Tanggal  Lembur"),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    )
                  ]),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.date_range,
                        color: Colors.blue,
                      ),
                      FlatButton(
                        onPressed: () {
                          selectDueDate(context);
                        },
                        child: Text(
                          dateText == "" ? "Tanggal  Lembur" : dateText,
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 12),
                  Center(child: Text('Jam Start')),
                  Row(
                    children: <Widget>[
                      Column(
                        children: [
                          Text('Jam'),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.5,
                                height: MediaQuery.of(context).size.height / 11,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.0),
                                    border: Border.all(color: Colors.blueGrey)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    value: valjam,
                                    hint: Text("Pilih Jam"),
                                    items: jam.map((item) {
                                      return DropdownMenuItem(
                                        child: Text(item['isi']),
                                        value: item['inisial'],
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        valjam = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Text('Menit'),
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.5,
                                height: MediaQuery.of(context).size.height / 11,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.0),
                                    border: Border.all(color: Colors.blueGrey)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    value: valminutes,
                                    hint: Text("Pilih Menit"),
                                    items: menit.map((item) {
                                      return DropdownMenuItem(
                                        child: Text(item['isi']),
                                        value: item['inisial'],
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        valminutes = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Center(child: Text('Jam End')),
                  Row(
                    children: <Widget>[
                      Column(
                        children: [
                          Text('Jam'),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.5,
                                height: MediaQuery.of(context).size.height / 11,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.0),
                                    border: Border.all(color: Colors.blueGrey)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    value: valjam_end,
                                    hint: Text("Pilih Jam"),
                                    items: jam2.map((item) {
                                      return DropdownMenuItem(
                                        child: Text(item['isi']),
                                        value: item['inisial'],
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        valjam_end = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Text('Menit'),
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.5,
                                height: MediaQuery.of(context).size.height / 11,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.0),
                                    border: Border.all(color: Colors.blueGrey)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    value: valminutes_end,
                                    hint: Text("Pilih Menit"),
                                    items: menit2.map((item) {
                                      return DropdownMenuItem(
                                        child: Text(item['isi']),
                                        value: item['inisial'],
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        valminutes_end = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                      "* Upload Form Approval pengajuan lembur yang dicap & ditandatangani"),
                  image == null
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FlatButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Upload bukti Approval"),
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
                                                  accessGallery();
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
                                                  accessCamera();
                                                },
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(Icons.camera),
                                                    Text("Select From Camera"),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: InSignIn
                                                    ? SpinKitFadingCircle(
                                                        color: Colors.redAccent,
                                                      )
                                                    : null,
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
                                      picture == null ? "" : picture),
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
                                        title: Text("Upload bukti Approval"),
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
                                                  accessGallery();
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
                                                  accessCamera();
                                                },
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(Icons.camera),
                                                    Text("Select From Camera"),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: InSignIn
                                                    ? SpinKitFadingCircle(
                                                        color: Colors.redAccent,
                                                      )
                                                    : null,
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: InSignIn
                        ? SpinKitFadingCircle(
                            color: Colors.blue,
                          )
                        : RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            onPressed: () {
                              validasi();
                            },
                            color: Colors.green,
                            child: Text("Ajukan Lembur",
                                style: TextStyle(color: Colors.white)),
                          ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
