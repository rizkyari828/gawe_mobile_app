import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/ui/DW/lowongan_detail_dw.dart';
import 'package:gaweid2/modules/user/view/menu/UserDashboard.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:image/image.dart' as Img;
import 'package:path_provider/path_provider.dart';

class edit_to_dw extends StatefulWidget {
  @override
  _edit_to_dwState createState() => _edit_to_dwState();
  final nowa,
      nohp,
      nik,
      alamatdomisili,
      alamatktp,
      gender,
      agama,
      status_perkawinan,
      mingaji,
      maxgaji,
      kodepos,
      kepemilikan_sim,
      kepemilikan_kendaraan,
      os,
      provinsi,
      kota,
      fb,
      instagram,
      linkedin,
      twitter,
      jobParent,
      jobChild,
      hubungan_keluarga,
      nama_keluarga,
      sumber,
      no_rek,
      nama_bank,
      no_hp_keluarga,
      tmplahir,
      ktp,
      picture,
      bk,
      tgl_lahir,province_lahir;

  edit_to_dw(
      {this.nowa,
      this.nohp,
      this.nik,
      this.alamatdomisili,
      this.alamatktp,
      this.agama,
      this.gender,
      this.status_perkawinan,
      this.mingaji,
      this.maxgaji,
      this.kodepos,
      this.kepemilikan_kendaraan,
      this.kepemilikan_sim,
      this.os,
      this.provinsi,
      this.kota,
      this.fb,
      this.instagram,
      this.linkedin,
      this.twitter,
      this.jobParent,
      this.jobChild,
      this.hubungan_keluarga,
      this.no_hp_keluarga,
      this.sumber,
      this.no_rek,
      this.nama_bank,
      this.nama_keluarga,
      this.tmplahir,
      this.ktp,
      this.picture,
      this.bk,
      this.tgl_lahir,this.province_lahir});
}

class _edit_to_dwState extends State<edit_to_dw> {
  BaseEndPoint network = NetworkProvider();

//  TextEditingController etnik = TextEditingController();
//  TextEditingController etkodepos = TextEditingController();
//  TextEditingController etalamatktp = TextEditingController();
//  TextEditingController etalamatdomisili = TextEditingController();

  var InSignIn = false;
  String valProvince,
      valposisi,
      valprovince2,
      valtempatlahir,
      valGender,
      valAgama,
      valProvince_tmp,
      valPernikahan;
  String valCity2;
  String valPendidikan2;
  String valCity;
  String valPendidikan;
  List dataProvince = List();
  List dataCity = [];
  List dataCitykota = [];
  List dataPendidikan = [];
  List listAgama = [
    {"inisial": "Islam", "isi": "Islam"},
    {"inisial": "Kristen", "isi": "Kristen"},
    {"inisial": "Budha", "isi": "Budha"},
    {"inisial": "Katolik", "isi": "Katolik"},
    {"inisial": "Hindu", "isi": "Hindu"},
    {"inisial": "Konghucu", "isi": "Konghucu"},
  ];

  List listGender = [
    {"inisial": "L", "isi": "Laki-Laki"},
    {"inisial": "P", "isi": "Perempuan"},
  ];
  List listPernikahan = [
    {"inisial": "belum menikah", "isi": "Belum Menikah"},
    {"inisial": "menikah", "isi": "Menikah"},
    {"inisial": "bercerai", "isi": "Bercerai"},
  ];

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

  void provinsi() async {
//    dataProvince = await network.getProvince();
    final response =
        await http.get(NetworkConfig().baseUrl + "master_api/provinsi");
    var listdata = jsonDecode(response.body);
    setState(() {
      dataProvince = listdata;
    });
    // print("data : $dataProvince");
  }

  void kabupaten(String id_province) async {
    final response = await http.post(
        NetworkConfig().baseUrl + "master_api/city",
        body: {'id': id_province});
    var listcity = jsonDecode(response.body);
    setState(() {
      dataCity = listcity;
    });
    // print("DataCity : $dataCity");
  }

  void kota(String id_province) async {
    final response = await http.post(
        NetworkConfig().baseUrl + "master_api/city",
        body: {'id': id_province});
    var listcity = jsonDecode(response.body);
    setState(() {
      dataCitykota = listcity;
    });
    // print("DataCity : $dataCity");
  }

  String nikvalidator(String value) {
    if (value.length < 16) {
      return "Nik must be length 16";
    } else {
      return null;
    }
  }

  String namevalidator(String value) {
    if (value.length < 4) {
      return "must be length 4";
    } else {
      return null;
    }
  }

  String nik, kodepos;
  void validasi() {
    if (_formKey.currentState.validate()) {
      //JIKA TRUE
      _formKey.currentState.save(); //MAKA FUNGSI SAVE() DIJALANKAN
      print("tempatlahir${valtempatlahir.toString()}");

      //Toast.show("tes", context, duration: 3, gravity: Toast.TOP);

      setState(() {
        InSignIn = true;
      });
      register_datadiri1();
    }
  }

  void register_datadiri1() async {
    ModelRegister data = await network.edit_datadiri_dw(
      globalEmail,
      etnik.text.toString(),
      valtempatlahir.toString(),
      dateText.toString(),
      valGender.toString(),
      valAgama.toString(),
      valProvince.toString(),
      valCity.toString(),
      "",
      etalamatdomisili.text.toString(),
      etkodepos.text.toString(),
      valPernikahan.toString(),
      etnama_keluarga.text.toString(),
      ethubungan_keluarga.text.toString(),
      etno_hp_keluarga.text.toString(),
      etnama_bank.text.toString(),
      etno_rek.text.toString(),
    );

     Toast.show("${data.status}", context, duration: 3, gravity: Toast.BOTTOM);

    if (data.status == 200) {
      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => UserDashboard(),
      ));

      Toast.show("Success", context, duration: 3, gravity: Toast.BOTTOM);
    } else {
      setState(() {
        InSignIn = false;
      });
      print("gagal");
      Toast.show("Gagal", context, duration: 3, gravity: Toast.BOTTOM);
    }
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
        print("globalid_employee $globalid_employee");
        //_loginStatus = mystatus == true ? LoginStatus.Login : LoginStatus.not_login;
      });
    });
  }

  var etWa,
      etnohp,
      etnik,
      etalamatktp,
      etalamatdomisili,
      etkodepos,
      etkepemilikan_sim,
      etkepemilikan_kendaraan,
      etos,
      etmingaji,
      etmaxgaji,
      etfb,
      etinstagram,
      etlinkedin,
      ettwitter,
      ethubungan_keluarga,
      etnama_keluarga,
      etno_rek,
      etnama_bank,
      etno_hp_keluarga;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provinsi();
    getPreferences();

    etnik = TextEditingController(text: widget.nik);
    etalamatdomisili = TextEditingController(text: widget.alamatdomisili);
    etkodepos = TextEditingController(text: widget.kodepos);

    ethubungan_keluarga = TextEditingController(text: widget.hubungan_keluarga);
    etnama_keluarga = TextEditingController(text: widget.nama_keluarga);
    etno_hp_keluarga = TextEditingController(text: widget.no_hp_keluarga);
    etno_rek = TextEditingController(text: widget.no_rek);
    etnama_bank = TextEditingController(text: widget.nama_bank);
  }

  TextEditingController ctitle = new TextEditingController();

  File picture, picture_save; //ktp
  File ktp, ktp_save;
  File bk, bk_save;

  accessCameraPicture() async {
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    final title = ctitle.text;

    Img.Image _image = Img.decodeImage(img.readAsBytesSync());
    Img.Image _smallerimg = Img.copyResize(_image,
        width: 300, height: 300, interpolation: Img.Interpolation.linear);

    final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();

    var compressImg = new File("$path/image_${currentTime}${globalEmail}.jpg")
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

    var compressImg = new File("$path/image_${currentTime}${globalEmail}.jpg")
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

    var compressImg = new File("$path/image_${currentTime}${globalEmail}.jpg")
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

    var compressImg = new File("$path/image_${currentTime}${globalEmail}.jpg")
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

    var compressImg = new File("$path/image_${currentTime}${globalEmail}.jpg")
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

    var compressImg = new File("$path/image_${currentTime}${globalEmail}.jpg")
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

  void uploadbk() {
    network.gantibk(globalEmail, bk_save, context);
  }

  void uploadktp() {
    network.gantiktp(globalEmail, ktp_save, context);
  }

  void uploadimg() {
    network.gantipp(globalEmail, picture_save, context);
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gawe.id"),
        backgroundColor: mainColor,
      ),
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
                    Text("Nik (Nomor Induk KTP)"),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    )
                  ]),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: etnik,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "NIK (Nomor Induk KTP)",
                      hintText: "NIK (Nomor Induk KTP)",
                    ),
                    validator: nikvalidator,
                    // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                    onSaved: (value) {
                      nik = value;
                    },
                  ),
                  SizedBox(height: 16),
                  Row(children: <Widget>[
                    Text("Tempat Lahir"),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    )
                  ]),
                  SizedBox(height: 8),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 11,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(color: Colors.blueGrey)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                          isExpanded: true,
                          value: valProvince_tmp,
                          hint: Text(
                            widget.province_lahir,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                          items: dataProvince.map((item) {
                            return DropdownMenuItem(
                              child: Text(item['province']),
                              value: item['id'],
                            );
                          }).toList(),
                          onChanged: (value) async {
                            dataCitykota = await network.getCity2(value);
                            setState(() {
                              valProvince_tmp = value;
                              valtempatlahir = null;
                            });
                            //print(dataCity);
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 11,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(color: Colors.blueGrey)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                          isExpanded: true,
                          value: valtempatlahir,
                          hint: Text(
                            widget.tmplahir,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                          items: dataCitykota.map((item) {
                            return DropdownMenuItem(
                              child: Text(
                                item['type'] + " " + item['city'],
                              ),
                              value: item['id'],
                            );
                          }).toList(),
                          onChanged: (value) async {
                            // dataCity = await network.getCity(value);
                            setState(() {
                              valtempatlahir = value;
                            });
                            //print(dataCity);
                          },
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 16),
                  Row(children: <Widget>[
                    Text("Tanggal Lahir"),
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
                          dateText == "" ? widget.tgl_lahir : dateText,
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(children: <Widget>[
                    Text("Gender"),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    )
                  ]),
                  SizedBox(height: 10),
                  //jenis kelamin
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 11,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(color: Colors.blueGrey)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                          isExpanded: true,
                          value: valGender,
                          hint: Text(
                            widget.gender,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          items: listGender.map((item) {
                            return DropdownMenuItem(
                              child: Text(item['isi']),
                              value: item['inisial'],
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              valGender = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(children: <Widget>[
                    Text("Agama"),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    )
                  ]),
                  SizedBox(height: 10),
                  //agama
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 11,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(color: Colors.blueGrey)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                          isExpanded: true,
                          value: valAgama,
                          hint: Text(
                            widget.agama,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          items: listAgama.map((item) {
                            return DropdownMenuItem(
                              child: Text(item['isi']),
                              value: item['inisial'],
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              valAgama = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  Row(children: <Widget>[
                    Text("Status Pernikahan"),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    )
                  ]),
                  SizedBox(height: 10),
                  //status pernikahan
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 11,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(color: Colors.blueGrey)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                          isExpanded: true,
                          value: valPernikahan,
                          hint: Text(
                            widget.status_perkawinan,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          items: listPernikahan.map((item) {
                            return DropdownMenuItem(
                              child: Text(item['isi']),
                              value: item['inisial'],
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              valPernikahan = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
//                    SizedBox(height: 16),
//                    Row(children: <Widget>[
//                      Text("Alamat KTP"),
//                      Text(
//                        "*",
//                        style: TextStyle(color: Colors.red),
//                      )
//                    ]),
//                    SizedBox(height: 10),
//                    TextFormField(
//                      controller: etalamatktp,
//                      keyboardType: TextInputType.multiline,
//                      // maxLines: 4,
//                      maxLength: 500,
//
//                      // controller: etNo_hp,
//                      decoration: InputDecoration(
//                        border: OutlineInputBorder(
//                          borderRadius: BorderRadius.circular(10),
//                        ),
//                        labelText: "Alamat Ktp",
//                        hintText: "Alamat Ktp",
//                      ),
//                      validator: namevalidator,
//                      // validator: (value) => value.length < 6 ? 'Password too short.' : null,
//                      onSaved: (value) {
//                        // hp = value;
//                      },
//                    ),
                  SizedBox(height: 16),
                  Row(children: <Widget>[
                    Text("Alamat Domisili"),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    )
                  ]),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: etalamatdomisili,
                    keyboardType: TextInputType.multiline,
                    //maxLines: 4,
                    maxLength: 500,
                    // controller: etNo_hp,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Alamat Domisili",
                      hintText: "Alamat Domisili",
                    ),
                    validator: namevalidator,
                    // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                    onSaved: (value) {
                      // hp = value;
                    },
                  ),
                  Row(children: <Widget>[
                    Text("Province"),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    )
                  ]),
                  SizedBox(height: 10),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 11,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(color: Colors.blueGrey)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                          isExpanded: true,
                          value: valProvince,
                          hint: Text(
                            widget.provinsi,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          items: dataProvince.map((item) {
                            return DropdownMenuItem(
                              child: Text(item['province']),
                              value: item['id'],
                            );
                          }).toList(),
                          onChanged: (value) async {
                            dataCity = await network.getCity(value);
                            setState(() {
                              valProvince = value;
                              valCity = null;
                            });
                            //print(dataCity);
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(children: <Widget>[
                    Text("City"),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    )
                  ]),
                  SizedBox(height: 10),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 11,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          border: Border.all(color: Colors.blueGrey)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                          isExpanded: true,
                          value: valCity,
                          hint: Text(
                            widget.kota,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          items: dataCity.map((item) {
                            return DropdownMenuItem(
                              child: Text(
                                item['type'] + " " + item['city'],
                              ),
                              value: item['id'],
                            );
                          }).toList(),
                          onChanged: (value) async {
                            // dataKecamatan = await network.getKecamatan(value);
                            setState(() {
                              valCity = value;
                              // valKecamatan = null;
                            });
                            // await kabupaten(value);
                          },
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 16),
                  Row(children: <Widget>[Text("Kodepos")]),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: etkodepos,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Kode Pos",
                      hintText: "Kode Pos",
                    ),
                    // validator: namevalidator,
                    // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                    onSaved: (value) {
                      kodepos = value;
                    },
                  ),

                  SizedBox(height: 16),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    //controller: etName,
                    controller: etnama_bank,
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
                    controller: etno_rek,
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
                    child: picture == null
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
                                                    accessGalleryPicture();
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
                                  radius: 55,
                                  backgroundColor: Color(0xffFDCF09),
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                        widget.picture == null
                                            ? ""
                                            : widget.picture),
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
                    child: ktp == null
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
                    child: bk == null
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
                    controller: etnama_keluarga,
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
                    controller: ethubungan_keluarga,
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
                    controller: etno_hp_keluarga,
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
                  SizedBox(height: 16),
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
                            child: Text("Simpan",
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
