import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gaweid2/modules/media/models/ModelCheck.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/user/view/Login.dart';
import 'package:gaweid2/ui/User/Fragment/AkunUser.dart';
import 'package:gaweid2/modules/lowongan/view/info_pekerjaan.dart';
import 'package:gaweid2/modules/lowongan/view/profil_perushaaan.dart';
import 'package:gaweid2/modules/lowongan/view/spesifikasi.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class Detail_lowongan extends StatefulWidget {
  final String logo,
      provinsi,
      posisi,
      id,
      perusahaan,
      gajimin,
      gajimax,
      jenjang_career_id,
      pendidikan,
      city_id,
      pengalaman,
      rincian,
      kuota,
      kualifikasi,
      alamat,
      deskripsi,
      jenispekerjaan,
      datePostEnd,
      id_perusahaan,
      directLink, id_employee;
  Detail_lowongan(
      {this.logo,
      this.posisi,
      this.provinsi,
      this.id,
      this.perusahaan,
      this.gajimin,
      this.gajimax,
      this.jenjang_career_id,
      this.pendidikan,
      this.city_id,
      this.pengalaman,
      this.rincian,
      this.kuota,
      this.kualifikasi,
      this.alamat,
      this.deskripsi,
      this.jenispekerjaan,
        this.datePostEnd,
      this.id_perusahaan,
      this.directLink, this.id_employee});

  @override
  _Detail_lowonganState createState() => _Detail_lowonganState();
}

class _Detail_lowonganState extends State<Detail_lowongan>
    with TickerProviderStateMixin {
  String no_hp,
      tgl_lahir,
      universitas,
      picture,
      profile_power,
      tahun_keluar,
      ipk,
      tahun_masuk,
      kota,
      provinsi,
      nik,
      nohp,
      no_wa,
      mingaji,
      maxgaji,
      alamatktp,
      alamatdomisli,
      jurusan,
      tgl_lahir2,
      nama,
      agama,
      kodepos,
      kepemilikan_kendaraan,
      kepemilikan_sim,
      pendidikan,
      fb,
      instagram,
      twitter,
      sumber,
      linkedin,
      hubungan_keluarga,
      nama_keluarga,
      no_hp_keluarga,
      gender,
      kk,
      bk,
      ktp,
      cv,
      ijazah,
      tmplahir,
      kepemilikanhp,
      os,
      jobParent,
      jobChild,
      no_rek,
      nama_bank,
      status_perkawinan;

  var loading = false;

  BaseEndPoint network = NetworkProvider();

  double screenSize;
  double screenRatio;
  AppBar appBar;
  List<Tab> tabList = List();
  TabController _tabController;

  var globalName = "",
      globalEmail = "",
      globalLevel = "",
      id_user = "",
      globalid_employee = "",
      globalprofil_power = "";
  var status = false;
  var mystatus, status_check, block_lamaran1;

  // Future<List> getLowongan() async{
  //   final response = await http.post(NetworkConfig().baseUrl + "apps/lowongan_detail_perusahaan_lain", body: {
  //     //'employee_id': '${globalid_employee}',
  //     'id_cabang': widget.id,
  //     'id_lowongan': widget.id,
  //   });
  //
  //   ModelLowongan2 listdata = modelLowongan2FromJson(response.body);
  //   // print(listdata.lowongan);
  //   if(response.statusCode==200){
  //     //print("get data succeessfully");
  //   }else{
  //     // print("Get Data Failed");
  //   }
  //   return listdata.lowongan;
  // }

  SessionManager sessionManager = SessionManager();
  void getPreferences() async {
    await sessionManager.getPreference().then((value) {
      setState(() {
        mystatus = sessionManager.status;
        globalName = sessionManager.fullname;
        globalEmail = sessionManager.email;
        id_user = sessionManager.iduser;
        globalid_employee = sessionManager.id_employee;
        globalprofil_power = sessionManager.profile_power;
        //check_lowongan(globalid_employee);
      });
    });
  }

  void check_lowongan() async {
    print(globalid_employee);
    final response =
    await http.post(NetworkConfig().baseUrl + "apps/check_lowongan", body: {
      //'employee_id': '${globalid_employee}',
      'lowongan_id': widget.id,
      'employee_id': widget.id_employee,
    });
    ModelCheck listData = modelCheckFromJson(response.body);
    if (listData.status == 200) {
      setState(() {
        status_check = "1";
      });
      //  print("listdata ${listData}");
      // return listData;
    } else {
      // print('lowongan belum pernah dikirim');
      setState(() {
        status_check = "0";
      });
    }
  }

  void block_lamaran() async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/block_melamar_gawe", body: {
      'employee_id': widget.id_employee,
    });
    ModelCheck listData = modelCheckFromJson(response.body);

    if (listData.status == 200) {
      // print('lowongan pernah dikirim');
      setState(() {
        block_lamaran1 = "1";
      });
    } else {
      // print('lowongan belum pernah dikirim');
      setState(() {
        block_lamaran1 = "0";
      });
    }
  }

  void myAlert(String idlowongan, id_employee, profile_power) {
    // if (int.parse(profile_power) <= 60) {
    //   showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return AlertDialog(
    //           title: Text(
    //             widget.posisi,
    //             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    //           ),
    //           content: Text(
    //               "Anda Tidak Dapat Melamar pekerjaan \n ayo lengkapi profil kamu terlebih dahulu"),
    //           actions: <Widget>[
    //             FlatButton(
    //               onPressed: () {
    //                 Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                         builder: (context) => (datadiri2akun(
    //                               nik: nik == null ? "" : nik,
    //                               nohp: nohp == null ? "" : nohp,
    //                               nowa: no_wa == null ? "" : no_wa,
    //                               alamatdomisili: alamatdomisli == null
    //                                   ? ""
    //                                   : alamatdomisli,
    //                               alamatktp: alamatktp == null ? "" : alamatktp,
    //                               gender: gender == null ? "" : gender,
    //                               agama: agama == null ? "" : agama,
    //                               kodepos: kodepos == null ? "" : kodepos,
    //                               status_perkawinan: status_perkawinan == null
    //                                   ? ""
    //                                   : status_perkawinan,
    //                               kepemilikan_sim: kepemilikan_sim == null
    //                                   ? ""
    //                                   : kepemilikan_sim,
    //                               kepemilikan_kendaraan:
    //                                   kepemilikan_kendaraan == null
    //                                       ? ""
    //                                       : kepemilikan_kendaraan,
    //                               mingaji: mingaji == null ? "" : mingaji,
    //                               maxgaji: maxgaji == null ? "" : maxgaji,
    //                               os: os == null ? "" : os,
    //                               kota: kota == null ? "" : kota,
    //                               provinsi: provinsi == null ? "" : provinsi,
    //                               fb: fb == null ? "" : fb,
    //                               twitter: twitter == null ? "" : twitter,
    //                               linkedin: linkedin == null ? "" : linkedin,
    //                               instagram: instagram == null ? "" : instagram,
    //                               jobParent: jobParent == null ? "" : jobParent,
    //                               jobChild: jobChild == null ? "" : jobChild,
    //                               sumber: sumber == null ? "" : sumber,
    //                               hubungan_keluarga: hubungan_keluarga == null
    //                                   ? ""
    //                                   : hubungan_keluarga,
    //                               nama_keluarga: nama_keluarga == null
    //                                   ? ""
    //                                   : nama_keluarga,
    //                               no_hp_keluarga: no_hp_keluarga == null
    //                                   ? ""
    //                                   : no_hp_keluarga,
    //                               nama_bank: nama_bank == null ? "" : nama_bank,
    //                               no_rek: no_rek == null ? "" : no_rek,
    //                             ))));
    //               },
    //               child: Text(
    //                 "Edit",
    //                 style: TextStyle(color: Colors.white),
    //               ),
    //               color: Colors.blue,
    //             ),
    //             FlatButton(
    //               onPressed: () {
    //                 Navigator.pop(context);
    //               },
    //               child: Text("Kembali"),
    //               color: Colors.red,
    //             ),
    //           ],
    //         );
    //       });
    // } else {
      if (int.parse(profile_power) >= 75) {
        // print("melamar suksess");
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  widget.posisi,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                content: Text("Apakah anda ingin melamar pekerjaan ini ?"),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Tidak",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    color: Colors.white,
                  ),
                  FlatButton(
                    onPressed: () {
                        Navigator.pushReplacement(context,MaterialPageRoute (builder:(context)=>Spesifikasi(

                          id_lowongan: idlowongan == null ? "" : idlowongan,
                          id_employee: id_employee == null ? "" : id_employee,

                        )));

                     // applylowongan(idlowongan, id_employee);
                      //Navigator.pop(context);
                    },
                    child: Text(
                      "Ya",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    color: Colors.white,
                  ),

                ],
              );
            });
      } else {
        // print("profil belum lengkap");
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  widget.posisi,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                content: Text("Profil Anda Belum Lengkap \n"
                    "Silahkan Isi Profil Dengan Lengkap Terlebih dahulu"),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => (AkunUser(id_employee: widget.id_employee,))));
                          // MaterialPageRoute(
                          //     builder: (context) => (datadiri2akun(
                          //           nik: nik == null ? "" : nik,
                          //           nohp: nohp == null ? "" : nohp,
                          //           nowa: no_wa == null ? "" : no_wa,
                          //           alamatdomisili: alamatdomisli == null
                          //               ? ""
                          //               : alamatdomisli,
                          //           alamatktp:
                          //               alamatktp == null ? "" : alamatktp,
                          //           gender: gender == null ? "" : gender,
                          //           agama: agama == null ? "" : agama,
                          //           kodepos: kodepos == null ? "" : kodepos,
                          //           status_perkawinan: status_perkawinan == null
                          //               ? ""
                          //               : status_perkawinan,
                          //           kepemilikan_sim: kepemilikan_sim == null
                          //               ? ""
                          //               : kepemilikan_sim,
                          //           kepemilikan_kendaraan:
                          //               kepemilikan_kendaraan == null
                          //                   ? ""
                          //                   : kepemilikan_kendaraan,
                          //           mingaji: mingaji == null ? "" : mingaji,
                          //           maxgaji: maxgaji == null ? "" : maxgaji,
                          //           os: os == null ? "" : os,
                          //           kota: kota == null ? "" : kota,
                          //           provinsi: provinsi == null ? "" : provinsi,
                          //           fb: fb == null ? "" : fb,
                          //           twitter: twitter == null ? "" : twitter,
                          //           linkedin: linkedin == null ? "" : linkedin,
                          //           instagram:
                          //               instagram == null ? "" : instagram,
                          //           jobParent:
                          //               jobParent == null ? "" : jobParent,
                          //           jobChild: jobChild == null ? "" : jobChild,
                          //           sumber: sumber == null ? "" : sumber,
                          //           hubungan_keluarga: hubungan_keluarga == null
                          //               ? ""
                          //               : hubungan_keluarga,
                          //           nama_keluarga: nama_keluarga == null
                          //               ? ""
                          //               : nama_keluarga,
                          //           no_hp_keluarga: no_hp_keluarga == null
                          //               ? ""
                          //               : no_hp_keluarga,
                          //           nama_bank:
                          //               nama_bank == null ? "" : nama_bank,
                          //           no_rek: no_rek == null ? "" : no_rek,
                          //         ))));
                    },
                    child: Text(
                      "Edit",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Kembali"),
                    color: Colors.red,
                  ),
                ],
              );
            });
      // }
    }
  }

 void spesifikasi(String idlowongan, id_employee){

   bool _isChecked = true;
   String _currText = '';

   List<String> text = ["InduceSmile.com", "Flutter.io", "google.com"];

   showDialog(
       context: context,
       builder: (BuildContext context) {
         return AlertDialog(
           title: Text(
             "Spesifikasi",
             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
           ),
           content: Text("Spesifikasi"),
           actions: <Widget>[


             Expanded(
               child: Center(
                 child: Text(_currText,
                     style: TextStyle(
                       fontSize: 20.0,
                       fontWeight: FontWeight.bold,
                     )),
               ),
             ),
             Expanded(
                 child: Container(
                   height: 350.0,
                   child: Column(
                     children: text
                         .map((t) => CheckboxListTile(
                       title: Text(t),
                       value: _isChecked,
                       onChanged: (val) {
                         setState(() {
                           _isChecked = val;
                           if (val == true) {
                             _currText = t;
                           }
                         });
                       },
                     ))
                         .toList(),
                   ),
                 )),


//              FlatButton(
//                onPressed: () {
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (context) => Login()));
//                  // applylowongan(idlowongan, id_employee);
//                  //Navigator.pop(context);
//                },
//                child: Text("Yes"),
//                color: Colors.cyan,
//              ),
//              FlatButton(
//                onPressed: () {
//                  Navigator.pop(context);
//                },
//                child: Text("NO"),
//                color: Colors.red,
//              ),
           ],
         );
       });

 }

  void block_login(String idlowongan, id_employee) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              widget.posisi,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            content: Text("Silahkan Anda Login Dulu"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                  // applylowongan(idlowongan, id_employee);
                  //Navigator.pop(context);
                },
                child: Text("Yes"),
                color: Colors.cyan,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("NO"),
                color: Colors.red,
              ),
            ],
          );
        });
  }

  void applylowongan(idlowongam, id_employee) async {
    //  print("melamar lowongan");

    final response =
        await http.post(NetworkConfig().baseUrl + "apps/apply_lowongan", body: {
      'lowongan_id': idlowongam,
      'employee_id': id_employee,
    });

    if (response.statusCode == 200) {
      print("berhasil melamar pekerjaan");
      Toast.show("Berhasil Melamar Pekerjaan", context,
          duration: 3, gravity: Toast.BOTTOM);
      Navigator.pop(context);
    } else {
      print("Gagal Melamar");
    }
  }

  @override
  void initState() {
    getPreferences();
    check_lowongan();
    block_lamaran();
    tabList.add(new Tab(
      child: Text(
        "Info Pekerjaan",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    ));
    tabList.add(new Tab(
      child: Text(
        "Profil Perusahaan",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    ));
    _tabController = new TabController(vsync: this, length: tabList.length);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //screenSize = MediaQuery.of(context).size.width;
    appBar = AppBar(
      title: Text(''),
      backgroundColor: mainColor,
      // backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar,
        body: Container(
          child: SingleChildScrollView(
              child: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.height,
                  height: MediaQuery.of(context).size.height/8,
                  decoration: new BoxDecoration(
                      color: mainColor
                  ),
                ),

                Container(
                  // constraints: BoxConstraints(maxHeight: 150),
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height/30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Card(
                        elevation: 2.0,
                        clipBehavior: Clip.antiAlias,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              widget.logo,
                              height: MediaQuery.of(context).size.height / 8,
                              width: MediaQuery.of(context).size.width / 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    Container(
                      constraints: BoxConstraints(maxHeight: 250),
                      // color: Colors.red,
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height/8,
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            constraints: BoxConstraints(maxHeight: 60),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height/9,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:15.0, right: 15.0),
                            child: Text(
                              widget.posisi == null ? "" : widget.posisi,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          new Text(
                              widget.perusahaan == null ? "" : widget.perusahaan,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,)),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                widget.city_id == "0" ? "" : widget.city_id,
                                style: TextStyle(
                                  fontSize: 16,),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.datePostEnd == null
                                ? ""
                                : widget.datePostEnd,
                            style: TextStyle(
                              fontSize: 16,),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.jenispekerjaan == null
                                ? ""
                                : widget.jenispekerjaan,
                            style: TextStyle(
                              fontSize: 16,),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.center,
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      // decoration: new BoxDecoration(color: Colors.white),
                      child: Card(
                        elevation: 2,
                        child: new TabBar(
                            controller: _tabController,
                            indicatorColor: mainColor,
                            indicatorSize: TabBarIndicatorSize.tab,
                            tabs: tabList),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height/1.1,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom:75.0),
                          child: new TabBarView(
                            controller: _tabController,
                            children: <Widget>[
                              info_pekerjaaan(
                                  id: widget.id,
                                  provinsi: widget.provinsi,
                                  kota: widget.city_id,
                                  pendidikan: widget.pendidikan,
                                  jenjang_karir:
                                      widget.jenjang_career_id,
                                  pengalaman: widget.pengalaman,
                                  gajimin: widget.gajimin,
                                  gajimax: widget.gajimax,
                                  rincian: widget.rincian,
                                  kualifikasi:
                                      widget.kualifikasi,
                                  kuota: widget.kuota),
                              profil_pekerjaan(
                                id: widget.id,
                                alamat: widget.alamat,
                                deskripsi: widget.deskripsi,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

          ),
        ),
      floatingActionButton: Visibility(
        visible: status_check == "0" ? true : false,
        child: Padding(
          padding: const EdgeInsets.only(left:30.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: FloatingActionButton.extended(
            onPressed: () {
              if(widget.directLink != "0"){
                if (mystatus == true) {
                  launch(widget.directLink);
                } else {
                  block_login(widget.id, globalid_employee);
                }
              }else{
                if (mystatus == true) {
                  myAlert(widget.id, globalid_employee,
                      globalprofil_power);
                } else {
                  block_login(widget.id, globalid_employee);
                }
              }
            },
            label: Text('Lamar Sekarang'),
            backgroundColor: mainColor,
            ),
          ),
        ),
      ),);
  }
}
