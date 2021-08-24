import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/user/view/menu/UserDashboard.dart';
import 'package:gaweid2/modules/user/view/register/datadiri/datadiri2.dart';
import 'package:gaweid2/ui/User/Fragment/AkunUser.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class datadiri2akun extends StatefulWidget {
  final nama,
      nowa,
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
      tmpLahir,
      no_kk,
      tgl_lahir,
      province_lahir,
      universitas,
      ipk,
      tahun_masuk,
      tahun_keluar,
      jurusan,
      pendidikan;
  datadiri2akun(
      {this.nama,
      this.nowa,
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
      this.no_kk,
      this.tmpLahir,
      this.tgl_lahir,
      this.province_lahir,
      this.universitas,
      this.ipk,
      this.tahun_masuk,
      this.tahun_keluar,
      this.jurusan,
      this.pendidikan});

  @override
  _datadiri2akunState createState() => _datadiri2akunState();
}

class _datadiri2akunState extends State<datadiri2akun> {
  String nik, kodepos, no_kk;

  BaseEndPoint network = NetworkProvider();

  List dataSumber = [];
  String valsumber;

  String valProvince,
      valposisi,
      valprovince2,
      valtempatlahir,
      valGender,
      valAgama,
      valPernikahan;
  String valCity2;
  String valPendidikan2;
  String valCity, valMinatLokasi;
  String valPendidikan;
  List dataProvince = List();
  List dataCity = [];
  List dataPendidikan = [];
  List dataCityAll = [];
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

  List _myActivities;
  String _myActivitiesResult;

  String valkepemilikankendaraan, valkepemilikansim;
  String valminatpekerjaan,
      valspesialisasiminatpekerjaan,
      valsistemoperasi,
      valversisistemoperasi;
  String valjurusan;

  List dataProvinceLahir = List();
  List dataCityLahir = [];
  String valProvinceLahir;
  List datajurusan = [];
  List datapendidikan = [];
  List dataminatpekerjaan = [];
  List listversisistemoperasi = [];
  List datasepesialisasiminatpekerjaan = [];
  List listkepemilikansim = [
    {"inisial": "Tidak Ada", "isi": "Tidak Ada"},
    {"inisial": "SIM A", "isi": "SIM A"},
    {"inisial": "SIM A dan SIM B1", "isi": "SIM A & SIM B1"},
    {"inisial": "SIM A dan SIM B2", "isi": "SIM A & SIM B2"},
    {"inisial": "SIM A dan SIM C", "isi": "SIM A & SIM C"},
    {"inisial": "SIM A dan SIM B1 dan B2", "isi": "SIM A & SIM B1 & B2"},
    {"inisial": "SIM A dan SIM C dan B1", "isi": "SIM A & SIM C & B1"},
    {"inisial": "SIM A dan SIM C dan B2", "isi": "SIM A & SIM C & B2"},
    {
      "inisial": "SIM A dan SIM C dan B1 dan B2",
      "isi": "SIM A & SIM C & B1 & B2"
    },
    {"inisial": "SIM B1", "isi": "SIM B1"},
    {"inisial": "SIM B2", "isi": "SIM B2"},
    {"inisial": "SIM B1 dan SIM B2", "isi": "SIM B1 & SIM B2"},
    {"inisial": "SIM C", "isi": "SIM C"},
    {"inisial": "SIM C dan SIM B1", "isi": "SIM C & SIM B1"},
    {"inisial": "SIM C dan SIM B2", "isi": "SIM C & SIM B2"},
    {"inisial": "SIM C dan SIM B1 dan B2", "isi": "SIM C & SIM B1 & B2"},
  ];

  List listkepemilikankendaraan = [
    {"inisial": "tidak ada", "isi": "Tidak Ada"},
    {"inisial": "Motor", "isi": "Motor"},
    {"inisial": "Mobil", "isi": "Mobil"},
    {"inisial": "Motor & Mobil", "isi": "Motor & Mobil"},
  ];

  List listsistemoperasi = [
    {"inisial": "Android", "isi": "Android"},
    {"inisial": "ios", "isi": "Ios"},
    {
      "inisial": "tidak mempunyai handphone",
      "isi": "Tidak mempunyai Handphone"
    },
  ];

  var etname, etemail, mystatus, valProvince_tmp;

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

  void sumber() async {
//    dataProvince = await network.getProvince();
    final response =
        await http.get(NetworkConfig().baseUrl + "master_api/get_sumber");
    var listdata = jsonDecode(response.body);
    setState(() {
      dataSumber = listdata;
    });
    // print("data : $dataSumber");
  }

  void minatpekerjaan() async {
//    dataProvince = await network.getProvince();
    final response =
        await http.get(NetworkConfig().baseUrl + "master_api/posisi_kerja");
    var listdata = jsonDecode(response.body);
    setState(() {
      dataminatpekerjaan = listdata;
    });

    // print("data : $dataProvince");
  }

  void spesialisasiminatpekerjaan() async {
    final response = await http.get(
        NetworkConfig().baseUrl + "master_api/spesialisasi_minat_pekerjaan");
    var listdata = jsonDecode(response.body);
    setState(() {
      datasepesialisasiminatpekerjaan = listdata;
    });

    // print("data : $dataProvince");
  }

  void versios() async {
    final response =
        await http.get(NetworkConfig().baseUrl + "master_api/versi_os");
    var listdata = jsonDecode(response.body);
    setState(() {
      listversisistemoperasi = listdata;
    });

    // print("listversisistemoperasi : $listversisistemoperasi");
  }

  void jurusan() async {
//    dataProvince = await network.getProvince();
    final response =
        await http.get(NetworkConfig().baseUrl + "master_api/jurusan");
    var listdata = jsonDecode(response.body);
    setState(() {
      datajurusan = listdata;
    });

    // print("data : $datajurusan");
  }

  void pendidikan() async {
    final response =
        await http.get(NetworkConfig().baseUrl + "master_api/pendidikan");
    var listdata = jsonDecode(response.body);
    setState(() {
      datapendidikan = listdata;
    });

    // print("data : $dataProvince");
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

  String gajivalidator(String value) {
    if (value.length < 6) {
      return "gaji must be length 6";
    } else {
      return null;
    }
  }

  String numbervalidator(String value) {
    if (value.length < 10) {
      return "must be length 10";
    } else {
      return null;
    }
  }

  String name, email, password1, confrim_password;
  var globalName = "", globalEmail = "", globalLevel = "";

  var status = false;
  var id_user, globalid_employee;

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

        //_loginStatus = mystatus == true ? LoginStatus.Login : LoginStatus.not_login;
      });
    });
  }

  var InSignIn = false;
  void validasi() async {
    // if (valProvince == null || valCity == null) {
    //   Toast.show("Provinsi dan Kota tidak boleh Kosong", context,
    //       duration: 3, gravity: Toast.BOTTOM);
    // }else if(valtempatlahir == null){
    //   Toast.show("Tempat lahir tidak boleh Kosong", context,
    //       duration: 3, gravity: Toast.BOTTOM);
    // }else if(valGender == null){
    //   Toast.show("Jenis kelamin tidak boleh Kosong", context,
    //       duration: 3, gravity: Toast.BOTTOM);
    // }else if(valAgama == null){
    //   Toast.show("Agama tidak boleh Kosong", context,
    //       duration: 3, gravity: Toast.BOTTOM);
    // }else if(valPernikahan == null){
    //   Toast.show("Status pernikahan tidak boleh Kosong", context,
    //       duration: 3, gravity: Toast.BOTTOM);
    // }else if(dateText == null || dateText == ""){
    //   Toast.show("Tanggal lahir tidak boleh Kosong", context,
    //       duration: 3, gravity: Toast.BOTTOM);
    // }else if(valPendidikan2 == null || valjurusan == null){
    //   Toast.show("Jurusan dan tingkatan tidak boleh Kosong", context,
    //       duration: 3, gravity: Toast.BOTTOM);
    // } else {
      if (_formKey.currentState.validate()) {
        //JIKA TRUE
        _formKey.currentState.save(); //MAKA FUNGSI SAVE() DIJALANKAN

        //Toast.show(valProvince.toString(), context, duration: 3, gravity: Toast.TOP);

        setState(() {
          InSignIn = true;
        });

        ModelRegister data_n = await network.gantidatadiri1(
            globalEmail,
            etname.text.toString(),
            valtempatlahir.toString(),
            dateText.toString(),
            context);

        ModelRegister data = await network.edit_profil_all(
            globalEmail,
            etnik.text.toString(),
            etWa.text.toString(),
            etnohp.text.toString(),
            valGender.toString(),
            valAgama.toString(),
            valProvince.toString(),
            valCity.toString(),
            etkodepos.text.toString(),
            valPernikahan.toString(),
            valminatpekerjaan.toString(),
            valspesialisasiminatpekerjaan.toString(),
            valkepemilikankendaraan.toString(),
            valkepemilikansim.toString(),
            etmingaji.text.toString(),
            etmaxgaji.text.toString(),
            etos.text.toString(),
            valsistemoperasi.toString(),
            etalamatktp.text.toString(),
            etalamatdomisili.text.toString(),
            etfb.text.toString(),
            etinstagram.text.toString(),
            etlinkedin.text.toString(),
            ettwitter.text.toString(),
            valsumber.toString(),
            etnama_keluarga.text.toString(),
            ethubungan_keluarga.text.toString(),
            etno_hp_keluarga.text.toString(),
            etnama_bank.text.toString(),
            etno_rek.text.toString(),
            etkk.text.toString(),
            valMinatLokasi.toString());

        ModelRegister data_pen = await network.edit_pendidikan(
            globalEmail,
            etuniversitas.text.toString(),
            valPendidikan2.toString(),
            valjurusan.toString(),
            etipk.text.toString(),
            ettahunmasuk.text.toString(),
            ettahunkeluar.text.toString());

        if (data.status == 200 && data_n.status == 200) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => (AkunUser(id_employee: globalid_employee,))));

          Toast.show("Success", context, duration: 3, gravity: Toast.BOTTOM);
        } else {
          setState(() {
            InSignIn = false;
          });
          print("gagal");
          Toast.show("Gagal", context, duration: 3, gravity: Toast.BOTTOM);
        }
      }
    // }
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
      etno_hp_keluarga,
      etkk;
  var etuniversitas, etipk, ettahunmasuk, ettahunkeluar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provinsi();
    sumber();
    minatpekerjaan();
    spesialisasiminatpekerjaan();
    // versios();
    getPreferences();
    cityAll();
    etname = TextEditingController(text: widget.nama);
    etnik = TextEditingController(text: widget.nik);
    etkk = TextEditingController(text: widget.no_kk);
    etWa = TextEditingController(text: widget.nowa);
    etnohp = TextEditingController(text: widget.nohp);

    etalamatktp = TextEditingController(text: widget.alamatktp);
    etalamatdomisili = TextEditingController(text: widget.alamatdomisili);
    etkodepos = TextEditingController(text: widget.kodepos);
    etkepemilikan_sim = TextEditingController(text: widget.kepemilikan_sim);
    etkepemilikan_kendaraan =
        TextEditingController(text: widget.kepemilikan_kendaraan);
    etos = TextEditingController(text: widget.os);
    etmingaji = TextEditingController(text: widget.mingaji);
    etmaxgaji = TextEditingController(text: widget.maxgaji);
    etfb = TextEditingController(text: widget.fb);
    etinstagram = TextEditingController(text: widget.instagram);
    ettwitter = TextEditingController(text: widget.twitter);
    etlinkedin = TextEditingController(text: widget.linkedin);

    ethubungan_keluarga = TextEditingController(text: widget.hubungan_keluarga);
    etnama_keluarga = TextEditingController(text: widget.nama_keluarga);
    etno_hp_keluarga = TextEditingController(text: widget.no_hp_keluarga);
    etno_rek = TextEditingController(text: widget.no_rek);
    etnama_bank = TextEditingController(text: widget.nama_bank);

    jurusan();
    pendidikan();
    etuniversitas = TextEditingController(text: widget.universitas);
    etipk = TextEditingController(text: widget.ipk);
    ettahunmasuk = TextEditingController(text: widget.tahun_masuk);
    ettahunkeluar = TextEditingController(text: widget.tahun_keluar);
  }

  bool setsitemoperasi = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    print("globalEmail $globalEmail");

    if (valsistemoperasi == "Android") {
      setState(() {
        setsitemoperasi = true;
      });
    } else {
      setsitemoperasi = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Data Diri"),
        backgroundColor: mainColor,
      ),
      backgroundColor: Colors.white,
      body: Container(
        color: backgroundColor,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 16),
                        Center(
                            child: Row(children: <Widget>[
                          Text("Nama"),
                          Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          )
                        ])),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: etname,
                          //initialValue: widget.name,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                            ),
                            hintText: widget.nama,
                          ),
                          //validator: nikvalidator,
                          // validator: (value) => value.length < 6 ? 'Password too short.' : null,
//            onSaved: (value) {
//              nik = value;
//            },
                        ),
                        SizedBox(height: 16),
                        Row(children: <Widget>[
                          Text("Tempat Lahir"),
                          Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          )
                        ]),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 11,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: mainColor))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton(
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
                                  dataCity = await network.getCity(value);
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
                                border: Border(
                                    bottom: BorderSide(color: mainColor))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton(
                                isExpanded: true,
                                value: valtempatlahir,
                                hint: Text(
                                  widget.tmpLahir,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
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
                          Text("Tanggal lahir"),
                          Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          )
                        ]),
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
                                style:
                                    TextStyle(fontSize: 16, color: Colors.blue),
                              ),
                            )
                          ],
                        ),
                        Row(children: <Widget>[
                          Text("NIK"),
                          Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          )
                        ]),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: etnik,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                            ),
                            hintText: "NIK",
                          ),
                          validator: nikvalidator,
                          // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                          onSaved: (value) {
                            nik = value;
                          },
                        ),
                        SizedBox(height: 16),
                        Row(children: <Widget>[
                          Text("No Kartu Keluarga"),
                          Text(
                            " (dapat di kosongkan)",
                            style: TextStyle(color: Colors.red, fontSize: 10),
                          ),
                        ]),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: etkk,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                            ),
                            hintText: "Kartu Keluarga",
                          ),
                          // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                          onSaved: (value) {
                            no_kk = value;
                          },
                        ),
                        SizedBox(height: 16),
                        Row(children: <Widget>[
                          Text("No Whatshaap"),
                          Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          )
                        ]),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: etWa,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                            ),
                            hintText: "No Whatshaap",
                          ),
                          //validator: numbervalidator,
                          // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                          onSaved: (value) {
                            // name = value;
                          },
                        ),
                        SizedBox(height: 16),
                        Row(children: <Widget>[
                          Text("No Handphone"),
                          Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          )
                        ]),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: etnohp,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                            ),
                            hintText: "08xxxxxxxxxxxx",
                          ),
                          //  validator: numbervalidator,
                          // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                          onSaved: (value) {
                            // name = value;
                          },
                        ),

                        SizedBox(height: 16),
                        Row(children: <Widget>[
                          Text("Gender"),
                          Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          )
                        ]),
                        //jenis kelamin
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 11,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: mainColor))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton(
                                value: valGender,
                                hint: Text(
                                  widget.gender,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
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
                        //agama
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 11,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: mainColor))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton(
                                value: valAgama,
                                hint: Text(
                                  widget.agama,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
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
                          Text("Provinsi"),
                          Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          )
                        ]),
                        Center(
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
                                hint: widget.provinsi,
                                items: dataProvince.map((item) {
                                  return item['province'];
                                }).toList(),
                                maxHeight: 300,
                                onChanged: (value) async {
                                  setState(() {
                                    for (var f in dataProvince) {
                                      // print(f['province'].toString());
                                      if (f['province'].toString() == value) {
                                        valProvince = f['id'];
                                      }
                                    }
                                    valCity = null;
                                  });
                                  dataCity = await network.getCity(valProvince);
                                  setState(() {
                                    dataCity = dataCity;
                                  });
                                },
                                showSearchBox: true,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(children: <Widget>[
                          Text("Kota"),
                          Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          )
                        ]),
                        Center(
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
                                hint: widget.kota,
                                items: dataCity.map((item) {
                                  return item['city'];
                                }).toList(),
                                maxHeight: 300,
                                onChanged: (value) async {
                                  setState(() {
                                    for (var f in dataCity) {
                                      if (f['city'].toString() == value) {
                                        valCity = f['id'];
                                      }
                                    }
                                  });
                                },
                                showSearchBox: true,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 16),
                        Row(children: <Widget>[Text("Kodepos")]),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: etkodepos,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                            ),
                            hintText: "xxxxx",
                          ),
                          // validator: namevalidator,
                          // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                          onSaved: (value) {
                            kodepos = value;
                          },
                        ),
                        SizedBox(height: 16),
                        Row(children: <Widget>[
                          Text("Status Pernikahan"),
                          Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          )
                        ]),
                        //status pernikahan
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 11,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: mainColor))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton(
                                value: valPernikahan,
                                hint: Text(
                                  widget.status_perkawinan,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
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

                        SizedBox(height: 16),
                        Row(children: <Widget>[
                          Text("Minat Pekerjaan"),
                          Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          )
                        ]),
                        //jenis kelamin
                        Center(
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
                                items: dataminatpekerjaan.map((item) {
                                  return item['nama'];
                                }).toList(),
                                maxHeight: 300,
                                onChanged: (value) async {
                                  setState(() {
                                    valminatpekerjaan = value;
                                  });
                                },
                                showSearchBox: true,
                              ),
                            ),
                          ),
                        ),
                        Center(
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
                                hint: "Pilih minat lokasi",
                                items: dataCityAll.map((item) {
                                  return item['city'];
                                }).toList(),
                                maxHeight: 300,
                                onChanged: (value) async {
                                  setState(() {
                                    for (var f in dataCityAll) {
                                      if (f['city'].toString() == value) {
                                        valMinatLokasi = f['id'];
                                      }
                                    }
                                  });
                                },
                                showSearchBox: true,
                              ),
                              // child: DropdownButton(
                              //   isExpanded: true,
                              //   value: valMinatLokasi,
                              //   hint: Text("Pilih lokasi penempatan"),
                              //   items: dataCityAll.map((item) {
                              //     return DropdownMenuItem(
                              //       child: Text(item['city']),
                              //       value: item['id'],
                              //     );
                              //   }).toList(),
                              //   onChanged: (value) {
                              //     setState(() {
                              //       valMinatLokasi = value;
                              //     });
                              //   },
                              // ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(children: <Widget>[
                          Text("Kepemilikan kendaraan"),
                          Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          )
                        ]),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 11,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: mainColor))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton(
                                isExpanded: true,
                                value: valkepemilikankendaraan,
                                hint: Text(
                                  widget.kepemilikan_kendaraan,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                items: listkepemilikankendaraan.map((item) {
                                  return DropdownMenuItem(
                                    child: Text(item['isi']),
                                    value: item['inisial'],
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    valkepemilikankendaraan = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(children: <Widget>[
                          Text("Kepemilikan Sim"),
                          Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          )
                        ]),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 11,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: mainColor))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton(
                                isExpanded: true,
                                value: valkepemilikansim,
                                hint: Text(
                                  widget.kepemilikan_sim,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                items: listkepemilikansim.map((item) {
                                  return DropdownMenuItem(
                                    child: Text(item['isi']),
                                    value: item['inisial'],
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    valkepemilikansim = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 16),
                        Row(children: <Widget>[
                          Text("Minimal Gaji"),
                          Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          )
                        ]),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: etmingaji,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                            ),
                            hintText: "30000000",
                          ),
                          validator: gajivalidator,
                          // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                          onSaved: (value) {
                            // hp = value;
                          },
                        ),
                        SizedBox(height: 16),
                        Row(children: <Widget>[
                          Text("Maxsimal Gaji"),
                          Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          )
                        ]),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: etmaxgaji,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                            ),
                            hintText: "6000000",
                          ),
                          validator: gajivalidator,
                          // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                          onSaved: (value) {
                            // hp = value;
                          },
                        ),
                        SizedBox(height: 16),
                        Row(children: <Widget>[
                          Text("Sumber"),
                          Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          )
                        ]),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 11,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              // child: DropdownButton(
                              //   value: valsumber,
                              //   //value: valPendidikan == null ? valPendidikan : buildingTypes.where( (i) => i.name == valPendidikan.name).first as BuildingType,
                              //   hint: Text(
                              //     widget.sumber  ,
                              //     style: TextStyle(fontSize: 16, color: Colors.black),
                              //   ),
                              //   items: dataSumber.map((item) {
                              //     return DropdownMenuItem(
                              //       child: Text(item['title']),
                              //       value: item['title'],
                              //     );
                              //   }).toList(),
                              //   onChanged: (value) async {
                              //     // dataCity = await network.getCity(value);
                              //     setState(() {
                              //       valsumber = value;
                              //       // valCity = null;
                              //     });
                              //     //print(dataCity);
                              //   },
                              // ),
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
                                hint: widget.sumber,
                                items: dataSumber.map((item) {
                                  return item['title'];
                                }).toList(),
                                maxHeight: 300,
                                onChanged: (value) async {
                                  // dataCity = await network.getCity(value);
                                  setState(() {
                                    valsumber = value.toString();
                                    // valCity = null;
                                  });
                                  //print(dataCity);
                                },
                                showSearchBox: true,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 16),
                        Row(children: <Widget>[
                          Text("Alamat KTP"),
                          Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          )
                        ]),
                        TextFormField(
                          controller: etalamatktp,
                          keyboardType: TextInputType.multiline,
                          // maxLines: 4,
                          maxLength: 500,

                          // controller: etNo_hp,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                            ),
                            hintText: "Alamat sesuai KTP",
                          ),
                          validator: namevalidator,
                          // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                          onSaved: (value) {
                            // hp = value;
                          },
                        ),
                        SizedBox(height: 16),
                        Row(children: <Widget>[
                          Text("Alamat Domisili"),
                          Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          )
                        ]),
                        TextFormField(
                          controller: etalamatdomisili,
                          keyboardType: TextInputType.multiline,
                          //maxLines: 4,
                          maxLength: 500,
                          // controller: etNo_hp,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                            ),
                            hintText: "Alamat sesuai domisili",
                          ),
                          validator: namevalidator,
                          // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                          onSaved: (value) {
                            // hp = value;
                          },
                        ),

                        SizedBox(height: 16),
                        Row(children: <Widget>[Text("Facebook")]),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: etfb,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                            ),
                            hintText: "gaweidn",
                          ),
                          // validator: nameValidator,
                          // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                          onSaved: (value) {
                            // hp = value;
                          },
                        ),
                        SizedBox(height: 16),
                        Row(children: <Widget>[Text("Instagram")]),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          // controller: etNo_hp,
                          controller: etinstagram,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                            ),
                            hintText: "gawe.id",
                          ),
                          // validator: nameValidator,
                          // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                          onSaved: (value) {
                            // hp = value;
                          },
                        ),
                        SizedBox(height: 16),
                        Row(children: <Widget>[Text("Twitter")]),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: ettwitter,
                          // controller: etNo_hp,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                            ),
                            hintText: "gawe_id",
                          ),
                          // validator: nameValidator,
                          // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                          onSaved: (value) {
                            // hp = value;
                          },
                        ),
                        SizedBox(height: 16),
                        Row(children: <Widget>[Text("Linkedin")]),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: etlinkedin,
                          // controller: etNo_hp,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                            ),
                            hintText: "gawe.id",
                          ),
                          // validator: nameValidator,
                          // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                          onSaved: (value) {
                            // hp = value;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          //controller: etName,
                          controller: etnama_bank,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                            ),
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
                          keyboardType: TextInputType.number,
                          //controller: etName,
                          controller: etno_rek,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                            ),
                            hintText: "123xxxxxxxx",
                          ),
                          //validator: nameValidator,
                          // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                          onSaved: (value) {
                            // name = value;
                          },
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Pendidikan",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                        SizedBox(height: 16),
                        Row(children: <Widget>[
                          Text("Sekolah"),
                          Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          )
                        ]),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: etuniversitas,
                          //initialValue: widget.universitas == null ? "" : widget.universitas,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                            ),
                            hintText: "Nama Sekolah",
                          ),
                          validator: namevalidator,
                          // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                          onSaved: (value) {
                            // name = value;
                          },
                        ),
                        SizedBox(height: 16),
                        Row(children: <Widget>[
                          Text("Tingkatan"),
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
                                border: Border(bottom: BorderSide(color : mainColor))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton(
                                value: valPendidikan2,
                                hint: Text(
                                  widget.pendidikan,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                items: datapendidikan.map((item) {
                                  return DropdownMenuItem(
                                    child: Text(item['title']),
                                    value: item['id'],
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    valPendidikan2 = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(children: <Widget>[
                          Text("Jurusan"),
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
                                hint: widget.jurusan,
                                items: datajurusan.map((item) {
                                  return item['jurusan'];
                                }).toList(),
                                maxHeight: 300,
                                onChanged: (value) async {
                                  setState(() {
                                    for (var f in datajurusan) {
                                      // print(f['province'].toString());
                                      if (f['jurusan'].toString() == value) {
                                        valjurusan = f['id'];
                                      }
                                    }
                                  });
                                },
                                showSearchBox: true,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(children: <Widget>[
                          Text("IPK"),
                          Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          )
                        ]),
                        SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: etipk,
                          //  initialValue: widget.ipk,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                            ),
                            hintText: "IPK",
                          ),
                          validator: namevalidator,
                          // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                          onSaved: (value) {
                            // name = value;
                          },
                        ),

                        SizedBox(height: 16),
                        Row(children: <Widget>[
                          Text("Tahun Masuk"),
                          Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          )
                        ]),
                        SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: ettahunmasuk,
                          // initialValue: widget.tahun_masuk,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                            ),
                            hintText: "YYYY",
                          ),
                          validator: namevalidator,
                          // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                          onSaved: (value) {
                            // name = value;
                          },
                        ),
                        SizedBox(height: 16),
                        Row(children: <Widget>[
                          Text("Tahun Keluar"),
                          Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          )
                        ]),
                        SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: ettahunkeluar,
                          //initialValue: widget.tahun_keluar == null ? "" : widget.tahun_keluar,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                            ),
                            hintText: "YYYY",
                          ),
                          validator: namevalidator,
                          // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                          onSaved: (value) {
                            // name = value;
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Keluarga Yang bisa dihubungi",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(children: <Widget>[
                          Text("Nama Keluarga"),
                          Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          )
                        ]),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          //controller: etName,
                          controller: etnama_keluarga,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                            ),
                            hintText: "Nama Keluarga",
                          ),
                          //validator: nameValidator,
                          // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                          onSaved: (value) {
                            // name = value;
                          },
                        ),
                        SizedBox(height: 16),
                        Row(children: <Widget>[
                          Text("Hubungan Keluarga"),
                          Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          )
                        ]),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          //controller: etName,
                          controller: ethubungan_keluarga,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                            ),
                            hintText: "Saudara",
                          ),
                          //validator: nameValidator,
                          // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                          onSaved: (value) {
                            // name = value;
                          },
                        ),
                        SizedBox(height: 16),
                        Row(children: <Widget>[
                          Text("No handphone keluarga"),
                          Text(
                            "*",
                            style: TextStyle(color: Colors.red),
                          )
                        ]),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          //controller: etName,
                          controller: etno_hp_keluarga,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                            ),
                            hintText: "08974443321",
                          ),
                          //validator: nameValidator,
                          // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                          onSaved: (value) {
                            // name = value;
                          },
                        ),
                        SizedBox(height: 26),
                        Text(
                          " * (Perlu diisi)",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: InSignIn
                              ? Container(child: Center(child: CircularProgressIndicator()))
                              : MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  onPressed: () {
                                    validasi();
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
              ),
            )
          ],
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
