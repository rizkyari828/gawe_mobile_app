import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gaweid2/modules/media/models/ModelCheck.dart';
import 'package:gaweid2/modules/user/models/Model_Profile2.dart';
import 'package:gaweid2/model/user/ModelLowongan.dart';
import 'package:gaweid2/model/user/ModelLowongan2.dart';
import 'package:gaweid2/model/user/ModelLowonganDetail.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/ui/DW/login_dw.dart';
import 'package:gaweid2/ui/DW/scan/edit_to_dw.dart';
import 'package:gaweid2/modules/user/view/Login.dart';
import 'package:gaweid2/ui/User/Fragment/AkunUser_backup.dart';
import 'package:gaweid2/modules/lowongan/view/filter.dart';
import 'package:gaweid2/modules/lowongan/view/info_pekerjaan.dart';
import 'package:gaweid2/modules/lowongan/view/lowongan.dart';
import 'package:gaweid2/modules/lowongan/view/profil_perushaaan.dart';
import 'package:gaweid2/modules/user/view/register/LupaPassword.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class Detail_lowongan_DW extends StatefulWidget {
  final String logo, provinsi, posisi, id, perusahaan, gajimin, gajimax,jenjang_career_id,pendidikan,city_id,pengalaman,
      rincian,kuota,kualifikasi,alamat,deskripsi;
  Detail_lowongan_DW(
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
      });

  @override
  _Detail_lowonganDWState createState() => _Detail_lowonganDWState();
}

class _Detail_lowonganDWState extends State<Detail_lowongan_DW>
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
      status_perkawinan,
      province_lahir;

  var loading = false;


  Future getProfile(employee_id) async {
    loading = false;
    final jsonString =
    await http.post(NetworkConfig().baseUrl + "apps/profile", body: {
      'employee_id': employee_id,
    });
    final jsonData = jsonDecode(jsonString.body);
    Sample sample = Sample.fromJson(jsonData[0]);
    setState(() {
      loading = true;

      no_rek = sample.no_rek.toString();
      nama_bank = sample.nama_bank.toString();

      os = sample.os.toString();
      kk = sample.file_kk.toString();
      cv = sample.file_cv.toString();
      ktp = sample.file_ktp.toString();
      ijazah = sample.file_ijazah.toString();
      bk = sample.file_bk.toString();

      fb = sample.facebook.toString();
      instagram = sample.instagram.toString();
      linkedin = sample.linkedin.toString();
      instagram = sample.instagram.toString();
      twitter = sample.twitter.toString();
      sumber = sample.sumber.toString();

      jobParent = sample.jobParent.toString();
      jobChild = sample.jobChild.toString();

      sumber = sample.sumber.toString();

      hubungan_keluarga = sample.hubungan_keluarga.toString();
      nama_keluarga = sample.nama_keluarga.toString();
      no_hp_keluarga = sample.no_hp_keluarga.toString();

      kepemilikan_kendaraan = sample.kendaraan.toString();
      kepemilikan_sim = sample.sim.toString();
      provinsi = sample.provinceId.toString();

      provinsi = sample.provinceId.toString();
      gender = sample.gender.toString();
      status_perkawinan = sample.statusPerkawinan.toString();
      agama = sample.agama.toString();
      kodepos = sample.kodepos.toString();

      kepemilikanhp = sample.kepemilikanHp.toString();

      nik = sample.nik.toString();
      nama = sample.nama.toString();
      nohp = sample.hp.toString();
      no_wa = sample.nomorTelepon.toString();
      mingaji = sample.minGaji.toString();
      maxgaji = sample.maxGaji.toString();
      alamatktp = sample.alamatKtp.toString();
      alamatdomisli = sample.alamatDomisili.toString();
      jurusan = sample.jurusanId.toString();
      pendidikan = sample.pendidikanId.toString();

      kota = sample.cityId.toString();
      tmplahir = sample.tmpLahir.toString();
      tgl_lahir =
      sample.tglLahir.toString() == null ? "" : sample.tglLahir.toString();
      tgl_lahir2 = sample.tglLahir2.toString() == null
          ? ""
          : sample.tglLahir2.toString();
      universitas = sample.universitas.toString() == null
          ? ""
          : sample.universitas.toString();
      ipk = sample.ipk.toString() == null ? "" : sample.ipk.toString();
      tahun_masuk =
      sample.thnMasuk.toString() == null ? "" : sample.thnMasuk.toString();
      tahun_keluar =
      sample.thnLulus.toString() == null ? "" : sample.thnLulus.toString();
      picture = sample.picture.toString();
      profile_power = sample.profilePower.toString() == null
          ? ""
          : sample.profilePower.toString();

      province_lahir = sample.province_lahir.toString() == null
          ? ""
          : sample.province_lahir.toString();


    });
  }





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
  var mystatus, status_check, block_lamaran1, block_lamaran_status_aktif;

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

  void check_lowongan(String id_employee) async {
    // print("id_employee${id_employee}");
//      ModelCheck data = await network.checkLowongan(881821,1415);
//
//        print("data ${data}");
//      if(data.status==200){
//        print('lowongan pernah dikirim');
//        status_check = "1";
//      }else{
//        status_check = "0";
//        print('lowongan belum pernah dikirim');
//      }

//    print("lowongan_id${widget.id}");
//    print("employee_id${id_employee}");

    final response =
        await http.post(NetworkConfig().baseUrl + "apps/check_lowongan", body: {
      //'employee_id': '${globalid_employee}',
      'lowongan_id': widget.id,
      'employee_id': id_employee,
    });
    ModelCheck listData = modelCheckFromJson(response.body);

    var listData2 = jsonDecode(response.body);
    //print("cek${listData2['check']}");

    //68638

    if (listData.status == 200) {
      print('lowongan pernah dikirim');
      setState(() {
        status_check = "1";
      });

      //  print("listdata ${listData}");
      // return listData;
    } else {
      print('lowongan belum pernah dikirim');
      setState(() {
        status_check = "0";
      });

      //  print("gagal");
      //return null;

    }
  }

  @override
  void initState() {
    getPreferences();
    //getLowongan();
    print("session${globalid_employee}");
    //check_lowongan();
    tabList.add(new Tab(
      text: 'Info Pekerjaan',
    ));
    tabList.add(new Tab(
      text: 'Profil Perusahaan',
    ));
    _tabController = new TabController(vsync: this, length: tabList.length);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void block_lamaran_dw_sedangaktif(String id_employee) async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/block_tanggal_dw", body: {
      'id_employee': id_employee,
    });

    ModelCheck listData = modelCheckFromJson(response.body);

    if (listData.status == 200) {
      print('Tidak Boleh Melamar');
      setState(() {
        block_lamaran_status_aktif = "1";
      });
    } else {
      print('Boleh Melamar');
      setState(() {
        block_lamaran_status_aktif = "0";
      });
    }
  }

  void block_lamaran(String id_employee) async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/block_melamar_dw", body: {
      //'employee_id': '${globalid_employee}',
      // 'lowongan_id': widget.id,
      'employee_id': id_employee,
    });
    ModelCheck listData = modelCheckFromJson(response.body);

    if (listData.status == 200) {
      print('lowongan pernah dikirim');
      setState(() {
        block_lamaran1 = "1";
      });
    } else {
      print('lowongan belum pernah dikirim');
      setState(() {
        block_lamaran1 = "0";
      });
    }
  }

  void myAlert(String idlowongan, id_employee, profile_power) {
    if (int.parse(profile_power) <= 46) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                widget.posisi,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              content: Text(
                  "Anda Tidak Dapat Melamar pekerjaan \n karena kekuatan profile dibawah s 50"),
              actions: <Widget>[
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
    } else {
      if (block_lamaran_status_aktif == "1") {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  "Mohon Maaf ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                content: Text(
                    "Anda Tidak Bisa Melamar  karena status Pekerjaan Anda Masih Aktif "),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Navigator.pop(context);
                    },
                    child: Text(
                      "Kembali",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    color: Colors.white,
                  ),
                ],
              );
            });
      } else {


        if (block_lamaran1 == "1") {
          print("melamar suksess");
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    widget.posisi,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  content: Text("Apakan Anda ingin Melamar ?"),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        applylowongan(idlowongan, id_employee);
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
        } else {
          print("profil belum lengkap");
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    "Profil Anda Belum Lengkap",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  content: Text(
                      "Silahkan Isi Profil Dengan Lengkap Terlebih dahulu \n"
                      "File ktp \n"
                      "Foto Ktp selfi \n"
                      "Keluarga yang dapat dihubungi \n"
                      "No Bank \n"),
                  actions: <Widget>[

                    FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => edit_to_dw(

                              nik: nik == null ? "" : nik,
                              nohp: nohp == null ? "" : nohp,
                              nowa:
                              no_wa == null ? "" : no_wa,
                              alamatdomisili:
                              alamatdomisli == null
                                  ? ""
                                  : alamatdomisli,
                              alamatktp: alamatktp == null
                                  ? ""
                                  : alamatktp,
                              gender: gender == null
                                  ? ""
                                  : gender,
                              agama:
                              agama == null ? "" : agama,
                              kodepos: kodepos == null
                                  ? ""
                                  : kodepos,
                              status_perkawinan:
                              status_perkawinan == null
                                  ? ""
                                  : status_perkawinan,
                              kepemilikan_sim:
                              kepemilikan_sim == null
                                  ? ""
                                  : kepemilikan_sim,
                              kepemilikan_kendaraan:
                              kepemilikan_kendaraan ==
                                  null
                                  ? ""
                                  : kepemilikan_kendaraan,
                              mingaji: mingaji == null
                                  ? ""
                                  : mingaji,
                              maxgaji: maxgaji == null
                                  ? ""
                                  : maxgaji,
                              os: os == null ? "" : os,
                              kota: kota == null ? "" : kota,
                              provinsi: provinsi == null
                                  ? ""
                                  : provinsi,
                              fb: fb == null ? "" : fb,
                              twitter: twitter == null
                                  ? ""
                                  : twitter,
                              linkedin: linkedin == null
                                  ? ""
                                  : linkedin,
                              instagram: instagram == null
                                  ? ""
                                  : instagram,
                              jobParent: jobParent == null
                                  ? ""
                                  : jobParent,
                              jobChild: jobChild == null
                                  ? ""
                                  : jobChild,
                              sumber: sumber == null
                                  ? ""
                                  : sumber,
                              hubungan_keluarga:
                              hubungan_keluarga == null
                                  ? ""
                                  : hubungan_keluarga,
                              nama_keluarga:
                              nama_keluarga == null
                                  ? ""
                                  : nama_keluarga,
                              no_hp_keluarga:
                              no_hp_keluarga == null
                                  ? ""
                                  : no_hp_keluarga,
                              nama_bank: nama_bank == null
                                  ? ""
                                  : nama_bank,
                              no_rek: no_rek == null
                                  ? ""
                                  : no_rek,
                              tgl_lahir:
                              tgl_lahir2 == null
                                  ? ""
                                  : tgl_lahir2,
                              tmplahir: tmplahir == null
                                  ? ""
                                  : tmplahir,
                              ktp: ktp == null ? "" : ktp,
                              picture: picture == null ? "" : picture,

                              bk: bk == null ? "" : bk,

                              province_lahir: province_lahir == null ? "" : province_lahir,




                            )));
                        // applylowongan(idlowongan, id_employee);
                        //Navigator.pop(context);
                      },
                      child: Text("Edit",style: TextStyle(color: Colors.white),),
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
        }
      }
    }
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
                      MaterialPageRoute(builder: (context) => Login_Dw()));
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
          duration: 3, gravity: Toast.TOP);
      Navigator.pop(context);
    } else {
      print("Gagal Melamar");
      Toast.show("Gagal Melamar Pekerjaan", context,
          duration: 3, gravity: Toast.TOP);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("employee_id build${globalid_employee}");

    print("status check ${status_check}");
    block_lamaran(globalid_employee);
    block_lamaran_dw_sedangaktif(globalid_employee);

    check_lowongan(globalid_employee);
    getProfile(globalid_employee);

    //screenSize = MediaQuery.of(context).size.width;
    appBar = AppBar(
      title: Text(widget.perusahaan),
      backgroundColor: mainColor,
      elevation: 0.0,
    );
    return Container(
      color: Colors.white,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: appBar,
          body: Container(
            // height: MediaQuery.of(context).size.height/2.5,

            child: ListView(
              children: <Widget>[
                Center(
                  child: Image.network(
                    widget.logo,
                    height: 200,
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      new Text(
                          widget.perusahaan == null ? "" : widget.perusahaan,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
//                            Icon(
//                              Icons.work,
//                              color: Colors.black,
//                              size: 24.0,
//                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  widget.posisi == null ? "" : widget.posisi,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.attach_money,
                            color: Colors.black,
                            size: 24.0,
                          ),
                          Text(
                            widget.gajimin,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(" - "),
                          Text(
                            widget.gajimax,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 200,
                        child: Visibility(
                          visible: status_check == "0" ? true : false,
                          child: RaisedButton(
                            child: Text(
                              "Lamar Sekarang",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            color: Colors.green,
                            onPressed: () {
                              if (mystatus == true) {
                                myAlert(widget.id, globalid_employee,
                                    profile_power);
                              } else {
                                block_login(widget.id, globalid_employee);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28, top: 10, right: 28),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 1.1,
                    margin: const EdgeInsets.only(bottom: 2),
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          decoration: new BoxDecoration(
                              color: Theme.of(context).primaryColor),
                          child: new TabBar(
                              controller: _tabController,
                              indicatorColor: Colors.pink,
                              indicatorSize: TabBarIndicatorSize.tab,
                              tabs: tabList),
                        ),
                        Container(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height,
                          child: SizedBox(
                            height: 50,
                            child: new TabBarView(
                              controller: _tabController,
                              children: <Widget>[
                                SizedBox(
                                    //height: 10000,
                                    child: info_pekerjaaan(
                                        id: widget.id,
                                        provinsi : widget.provinsi,
                                        kota : widget.city_id,
                                        pendidikan : widget.pendidikan,
                                        jenjang_karir : widget.jenjang_career_id,
                                        pengalaman : widget.pengalaman,
                                        gajimin : widget.gajimin,
                                        gajimax : widget.gajimax,
                                        rincian:widget.rincian,
                                        kualifikasi:widget.kualifikasi,
                                        kuota:widget.kuota
                                )),
                                profil_pekerjaan(
                                  id: widget.id,
                                  alamat : widget.alamat,
                                  deskripsi : widget.deskripsi,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
