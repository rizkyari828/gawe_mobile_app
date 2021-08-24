import 'dart:convert';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/user/view/register/datadiri/datadiri3.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:toast/toast.dart';
import 'package:image/image.dart' as Img;
import 'package:path_provider/path_provider.dart';

class datadiri4 extends StatefulWidget {
  @override
  _datadiri4State createState() => _datadiri4State();
}

class _datadiri4State extends State<datadiri4> {

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
                builder: (BuildContext context) => datadiri3(),
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


  BaseEndPoint network = NetworkProvider();

  File image;
  TextEditingController etnamaperusahaan = TextEditingController();
  TextEditingController etlokasiperusahaan = TextEditingController();
  TextEditingController etgaji = TextEditingController();
  TextEditingController etdeskripsi = TextEditingController();
  TextEditingController etnamapelatihan = TextEditingController();
  TextEditingController etnamapenyelenggara = TextEditingController();
  TextEditingController ettahun = TextEditingController();
  TextEditingController etlainnya = TextEditingController();
  TextEditingController etlainnya2 = TextEditingController();
  TextEditingController ettitle_keahlian = TextEditingController();
  TextEditingController ettitle_komputer = TextEditingController();
  TextEditingController etnamakeluarga = TextEditingController();
  TextEditingController etnokeluarga = TextEditingController();
  TextEditingController ethubkeluarga = TextEditingController();


  DateTime _dueDate = DateTime.now();
  DateTime _tglkeluar = DateTime.now();
  String vallisan,
      valtulisan,
      valmembaca,
      valoffice,
      valemail,
      vallainya,
      valpengalaman,
      valfungsi,
      vallevel_pekerjaan,
      valindustri,
      valketerangankemampuan,
      valketerangankeahlian,
      valkomputerketerangan,
      valPosisiPekerjaan,valMinatLokasi;

  List datafungsi = [];
  List datalevel_pekerjaan = [];
  List dataindustri = [];
  List dataPosisi = [];
  List dataCityAll = [];

  bool setpengalaman = false;
  bool monVal = false, valMonval1 = false;

  String dateText = "", tanggal_keluar = "";

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

  selectTanggal_keluar(BuildContext content) async {
    final picked_keluar = await showDatePicker(
      context: context,
      initialDate: _tglkeluar,
      firstDate: DateTime(1955),
      lastDate: DateTime(2040),
    );

    if (picked_keluar != null) {
      setState(() {
        _tglkeluar = picked_keluar;
        tanggal_keluar =
            "${picked_keluar.day}/${picked_keluar.month}/${picked_keluar.year}";
      });
    }
  }

  File image_save;
  TextEditingController ctitle= new TextEditingController();
  accessCamera() async {
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    final title = ctitle.text;

    Img.Image _image = Img.decodeImage(img.readAsBytesSync());
    Img.Image _smallerimg = Img.copyResize(_image,width: 300,height: 300, interpolation: Img.Interpolation.linear);

    var compressImg = new File("$path/image_${register_iduser}${register_name}.jpg")
      ..writeAsBytesSync(Img.encodeJpg(_smallerimg,quality: 70));

    if (img == null) {
      print('null');
    } else {
      setState(() {
        image = img;
        image_save = compressImg;

      });
      Navigator.pop(context);
    }
  }


  accessGallery() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    final title = ctitle.text;

    Img.Image _image = Img.decodeImage(img.readAsBytesSync());
    Img.Image _smallerimg = Img.copyResize(_image,width: 500,height: 500, interpolation: Img.Interpolation.linear);

    var compressImg = new File("$path/image_${register_iduser}${register_name}.jpg")
      ..writeAsBytesSync(Img.encodeJpg(_smallerimg,quality: 70));

    if (img == null) {
      print('null');
    } else {
      setState(() {
        image = img;
        image_save = compressImg;

      });
      Navigator.pop(context);
    }
  }

  List option = [
    {"inisial": "Kurang", "isi": "Kurang"},
    {"inisial": "Cukup", "isi": "Cukup"},
    {"inisial": "Baik", "isi": "Baik"},
  ];

  List pengalaman = [
    {"inisial": "0", "isi": "Freshgraduate"},
    {"inisial": "1", "isi": "Pengalaman"},
  ];

  void getfungsi() async {
    final response =
        await http.get(NetworkConfig().baseUrl + "master_api/fungsi_kerja");
    var listdata = jsonDecode(response.body);
    setState(() {
      datafungsi = listdata;
    });

    // print("data : $dataProvince");
  }

  void getpekerjaan() async {
    final response =
        await http.get(NetworkConfig().baseUrl + "master_api/level_pekerjaan");
    var listdata = jsonDecode(response.body);
    setState(() {
      datalevel_pekerjaan = listdata;
    });

    // print("data : $dataProvince");
  }

  void getindustri() async {
    final response =
        await http.get(NetworkConfig().baseUrl + "master_api/industri");
    var listdata = jsonDecode(response.body);
    setState(() {
      dataindustri = listdata;
    });
    // print("data : $dataProvince");
  }

  void getPosisi() async {
    final response =
    await http.get(NetworkConfig().baseUrl + "master_api/posisi_kerja");
    var listdata = jsonDecode(response.body);
    setState(() {
      dataPosisi = listdata;
    });
    // print("data : $dataPosisi");
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

  var InSignIn = false;
  void validasi() {
    if (valpengalaman == null) {
      Toast.show("Pengalaman tidak boleh Kosong", context,
          duration: 3, gravity: Toast.BOTTOM);
    } else if (image == null) {
        Toast.show("Foto tidak boleh Kosong", context,
            duration: 3, gravity: Toast.BOTTOM);
    } else {
      if (_formKey.currentState.validate()) {
        //JIKA TRUE
        _formKey.currentState.save(); //MAKA FUNGSI SAVE() DIJALANKAN

//          if(valpengalaman=="1"){
//
//          }
//

        setState(() {
          InSignIn = true;
        });
        //Dialogs.showLoadingDialog(context, _formKey); //invoking login
        register_datadiri4();
      }
      ;
    }
  }

  void cityAll() async {
//    dataProvince = await network.getProvince();
    final response =
    await http.get(NetworkConfig().baseUrl + "master_api/kota");
    var listdata = jsonDecode(response.body);
    setState(() {
      dataCityAll = listdata;
    });
  }

  void register_datadiri4() async {
    network.register_datadiri4(
        register_email,
        etnamaperusahaan.text.toString(),
        valindustri.toString(),
        valPosisiPekerjaan.toString(),
        vallevel_pekerjaan.toString(),
        valMinatLokasi.toString(),
        etgaji.text.toString(),
        dateText.toString(),
        tanggal_keluar.toString(),
        monVal.toString(),
        etdeskripsi.text.toString(),
        valfungsi.toString(),
        etnamapelatihan.text.toString(),
        etnamapenyelenggara.text.toString(),
        ettahun.text.toString(),
        ettitle_komputer.text.toString(),
        vallisan.toString(),
        valtulisan.toString(),
        valmembaca.toString(),
        valketerangankemampuan.toString(),
        ettitle_keahlian.text.toString(),
        valketerangankeahlian.toString(),
        valoffice.toString(),
        valemail.toString(),
        ettitle_komputer.text.toString(),
        valketerangankemampuan.toString(),
        valpengalaman.toString(),
        etnamakeluarga.text.toString(),
        ethubkeluarga.text.toString(),
        etnokeluarga.text.toString(),
        image_save,
        context);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getfungsi();
    getpekerjaan();
    getindustri();
    getsession_register();
    getPosisi();
    cityAll();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    if (valpengalaman == 1 || valpengalaman == "1") {
      setState(() {
        setpengalaman = true;
      });
    } else {
      setState(() {
        setpengalaman = false;
      });
    }

    if (monVal == false) {
      setState(() {
        valMonval1 = true;
      });
    } else {
      valMonval1 = false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Container(
          color: backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: <Widget>[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 16),
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
                                            child: Image.asset("images/profil2.png"),
                                          )),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Container(
                                      margin: EdgeInsets.all(16),
                                      child: Image.file(
                                        image,
                                        height: MediaQuery.of(context).size.height / 4,
                                      )),
                                ),
                          SizedBox(height: 16),
                          RaisedButton(
                            //color: Colors.green,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(Icons.image),
                                  SizedBox(width: 4),
                                  Text("Upload Profil"),
                                ],
                              ),
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Upload Profil"),
                                      content: Container(
                                        height: MediaQuery.of(context).size.height / 4,
                                        width: MediaQuery.of(context).size.width / 4,
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
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ),
                          SizedBox(height: 16),

                          Row(children: <Widget>[
                            Text("Pengalaman"),
                            Text(
                              "*",
                              style: TextStyle(color: Colors.red),
                            )
                          ]),
                          SizedBox(height: 12),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 11,
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color : mainColor))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton(
                                  value: valpengalaman,
                                  hint: Text("Pilih "),
                                  items: pengalaman.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item['isi']),
                                      value: item['inisial'],
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      valpengalaman = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Visibility(
                            visible: setpengalaman,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: etnamaperusahaan,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: mainColor),
                                ),
                                labelText: "Nama Perusahaan",
                                hintText: "Nama Perusahaan",
                              ),
                              validator: namevalidator,
                              //validator: nameValidator,
                              // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                              onSaved: (value) {
                                // name = value;
                              },
                            ),
                          ),
                          Visibility(
                              visible: setpengalaman, child: SizedBox(height: 16)),
                          Visibility(
                            visible: setpengalaman,
                            child: Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 11,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownSearch<dynamic>(
                                    searchBoxDecoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: mainColor),
                                      ),
                                    ),
                                    dropdownSearchDecoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: mainColor),
                                      ),
                                    ),
                                    hint: "Pilih Industri",
                                    items: dataindustri.map((item) {
                                      return item['title'];
                                    }).toList(),
                                    maxHeight: 300,
                                    onChanged: (value) async {
                                      setState(() {
                                        for(var f in dataindustri) {
                                          // print(f['province'].toString());
                                          if (f['title'].toString() == value) {
                                            valindustri = f['id'];
                                          }
                                        }
                                      });

                                    },
                                    showSearchBox: true,

                                  ),

                                ),
                              ),
                            ),
                          ),
                          Visibility(
                              visible: setpengalaman, child: SizedBox(height: 16)),
                          Visibility(
                            visible: setpengalaman,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 11,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownSearch<dynamic>(
                                  searchBoxDecoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: mainColor),
                                    ),
                                  ),
                                  dropdownSearchDecoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: mainColor),
                                    ),
                                  ),
                                  hint: "Pilih Posisi",
                                  items: dataPosisi.map((item) {
                                    return item['nama'];
                                  }).toList(),
                                  maxHeight: 300,
                                  onChanged: (value) async {
                                    setState(() {
                                          valPosisiPekerjaan = value;
                                    });

                                  },
                                  showSearchBox: true,

                                ),
                              ),
                            ),
                          ),
                          Visibility(
                              visible: setpengalaman, child: SizedBox(height: 16)),
                          Visibility(
                            visible: setpengalaman,
                            child: Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 11,
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color : mainColor))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButton(
                                    value: vallevel_pekerjaan,
                                    hint: Text("Pilih Level Pekerjaan"),
                                    items: datalevel_pekerjaan.map((item) {
                                      return DropdownMenuItem(
                                        child: Text(item['title']),
                                        value: item['id'],
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        vallevel_pekerjaan = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                              visible: setpengalaman, child: SizedBox(height: 16)),
                          Visibility(
                            visible: setpengalaman,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownSearch<dynamic>(
                                searchBoxDecoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: mainColor),
                                  ),
                                ),
                                dropdownSearchDecoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: mainColor),
                                  ),
                                ),
                                hint: "Pilih lokasi",
                                items: dataCityAll.map((item) {
                                  return item['city'];
                                }).toList(),
                                maxHeight: 300,
                                onChanged: (value) async {
                                  setState(() {
                                    for(var f in dataCityAll) {
                                      if (f['city'].toString() == value) {
                                        valMinatLokasi = f['id'];
                                      }
                                    }
                                  });
                                },
                                showSearchBox: true,
                              ),
                            ),
                          ),
                          Visibility(
                              visible: setpengalaman, child: SizedBox(height: 16)),
                          Visibility(
                            visible: setpengalaman,
                            child: Text("Tanggal Masuk"),
                          ),
                          Visibility(
                            visible: setpengalaman,
                            child: Row(
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
                                    dateText == "" ? "Tanggal Mulai" : dateText,
                                    style: TextStyle(fontSize: 16, color: Colors.blue),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Visibility(
                            visible: valMonval1,
                            child: Visibility(
                                visible: setpengalaman, child: SizedBox(height: 16)),
                          ),
                          Visibility(
                            visible: valMonval1,
                            child: Visibility(
                              visible: setpengalaman,
                              child: Text("Tanggal Keluar"),
                            ),
                          ),
                          Visibility(
                            visible: valMonval1,
                            child: Visibility(
                              visible: setpengalaman,
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.date_range,
                                    color: Colors.blue,
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      selectTanggal_keluar(context);
                                    },
                                    child: Text(
                                      tanggal_keluar == ""
                                          ? "Tanggal Keluar"
                                          : tanggal_keluar,
                                      style:
                                          TextStyle(fontSize: 16, color: Colors.blue),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: setpengalaman,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Checkbox(
                                  value: monVal
                                  ,
                                  onChanged: (bool value) {
                                    setState(() {
                                      monVal = value;
                                    });
                                  },
                                ),
                                Text("Saat ini Saya masih bekerja disini"),
                              ],
                            ),
                          ),
                          Visibility(
                              visible: setpengalaman, child: SizedBox(height: 16)),
                          Visibility(
                            visible: setpengalaman,
                            child: Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 11,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownSearch<dynamic>(
                                    searchBoxDecoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: mainColor),
                                      ),
                                    ),
                                    dropdownSearchDecoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: mainColor),
                                      ),
                                    ),
                                    hint: "Pilih fungsi pekerjaan",
                                    items: datafungsi.map((item) {
                                      return item['title'];
                                    }).toList(),
                                    maxHeight: 300,
                                    onChanged: (value) async {
                                      setState(() {
                                        for(var f in datafungsi) {
                                          if (f['title'].toString() == value) {
                                            valfungsi = f['id'];
                                          }
                                        }
                                      });

                                    },
                                    showSearchBox: true,

                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                              visible: setpengalaman, child: SizedBox(height: 16)),
                          Visibility(
                            visible: setpengalaman,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              //controller: etName,
                              controller: etgaji,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: mainColor),
                                ),
                                labelText: "Gaji",
                                hintText: "Gaji",
                              ),
                              validator: namevalidator,
                              //validator: nameValidator,
                              // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                              onSaved: (value) {
                                // name = value;
                              },
                            ),
                          ),
                          Visibility(
                              visible: setpengalaman, child: SizedBox(height: 16)),
                          Visibility(
                            visible: setpengalaman,
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              // maxLines: 4,
                              controller: etdeskripsi,
                              maxLength: 500,

                              // controller: etNo_hp,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: mainColor),
                                ),
                                labelText: "Deskripsi Pekerjaan",
                                hintText: "Deskripsi Pekerjaan",
                              ),
                              // validator: nameValidator,
                              // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                              onSaved: (value) {
                                // hp = value;
                              },
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Pelatihan",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 12),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            //controller: etName,
                            controller: etnamapelatihan,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
                              ),
                              labelText: "Nama Pelatihan",
                              hintText: "Nama Pelatihan",
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
                            controller: etnamapenyelenggara,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
                              ),
                              labelText: "Penyelenggara",
                              hintText: "Nama Penyelenggara",
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
                            controller: ettahun,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
                              ),
                              labelText: "Tahun",
                              hintText: "Tahun",
                            ),
                            //validator: nameValidator,
                            // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                            onSaved: (value) {
                              // name = value;
                            },
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Bahasa Inggris",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Lisan"),
                          ),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 11,
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color : mainColor))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton(
                                  value: vallisan,
                                  hint: Text("Pilih Kemampuan lisan"),
                                  items: option.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item['isi']),
                                      value: item['inisial'],
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      vallisan = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Tulisan"),
                          ),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 11,
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color : mainColor))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton(
                                  value: valtulisan,
                                  hint: Text("Pilih Kemampuan Tulisan"),
                                  items: option.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item['isi']),
                                      value: item['inisial'],
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      valtulisan = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Membaca"),
                          ),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 11,
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color : mainColor))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton(
                                  value: valmembaca,
                                  hint: Text("Pilih Kemampuan Membaca"),
                                  items: option.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item['isi']),
                                      value: item['inisial'],
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      valmembaca = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Komputer",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Ms.Office"),
                          ),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 11,
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color : mainColor))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton(
                                  value: valoffice,
                                  hint: Text("Pilih Kemampuan"),
                                  items: option.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item['isi']),
                                      value: item['inisial'],
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      valoffice = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Email"),
                          ),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 11,
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color : mainColor))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton(
                                  value: valemail,
                                  hint: Text("Pilih Kemampuan"),
                                  items: option.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item['isi']),
                                      value: item['inisial'],
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      valemail = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Lainnya"),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            //controller: etName,
                            controller: ettitle_komputer,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
                              ),
                              labelText: "Lainnya",
                              hintText: "Lainnya",
                            ),
                            //validator: nameValidator,
                            // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                            onSaved: (value) {
                              // name = value;
                            },
                          ),
                          SizedBox(height: 16),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 11,
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color : mainColor))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton(
                                  value: valkomputerketerangan,
                                  hint: Text("Pilih Kemampuan"),
                                  items: option.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item['isi']),
                                      value: item['inisial'],
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      valkomputerketerangan = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Keahlian",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Kemampuan Penggunanaan Smartphone",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 12),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 11,
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color : mainColor))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton(
                                  value: valketerangankemampuan,
                                  hint: Text("Pilih Kemampuan"),
                                  items: option.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item['isi']),
                                      value: item['inisial'],
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      valketerangankemampuan = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Lainnya"),
                          ),
                          SizedBox(height: 12),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            //controller: etName,
                            controller: ettitle_keahlian,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
                              ),
                              labelText: "Lainnya",
                              hintText: "Lainnya",
                            ),
                            //validator: nameValidator,
                            // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                            onSaved: (value) {
                              // name = value;
                            },
                          ),
                          SizedBox(height: 16),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 11,
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color : mainColor))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton(
                                  value: valketerangankeahlian,
                                  hint: Text("Pilih Kemampuan"),
                                  items: option.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item['isi']),
                                      value: item['inisial'],
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      valketerangankeahlian = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Text("Keluarga Yang bisa dihubungi",style: TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(height: 16),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            //controller: etName,
                            controller: etnamakeluarga,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
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
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
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
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: mainColor),
                              ),
                              labelText: "No Hp keluarga",
                              hintText: "No Hp keluarga",
                            ),
                            //validator: nameValidator,
                            // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                            onSaved: (value) {
                              // name = value;
                            },
                          ),
                          SizedBox(height: 26),
                          Text(" * (Perlu diisi)", style: TextStyle(color:Colors.red, fontSize: 12),),
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
                                      //checkEmailAndPassowrd();
                                    },
                                    color: mainColor,
                                    child: Text("Simpan",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please Wait....",
                          style: TextStyle(color: Colors.blueAccent),
                        )
                      ]),
                    )
                  ]));
        });
  }
}
