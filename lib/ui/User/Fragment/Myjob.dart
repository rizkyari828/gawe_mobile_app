import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/model/dw/model_check_dw.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/ui/DW/dw_active/list_saldo.dart';
import 'package:gaweid2/ui/DW/dw_active/pengajuan_lembur.dart';
import 'package:gaweid2/ui/DW/dw_active/riwayat_absensi.dart';
import 'package:gaweid2/ui/DW/dw_active/riwayat_pekerjaan.dart';
import 'package:gaweid2/ui/DW/scan/scan_barcode.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class Myjob extends StatefulWidget {
  @override
  _MyjobState createState() => _MyjobState();
}

class _MyjobState extends State<Myjob> {
  var globalName = "",
      globalEmail = "",
      globalLevel = "",
      id_user = "",
      globalid_employee = "";
  var status = false;
  var InSignIn = true;
  var mystatus;
  SessionManager sessionManager = SessionManager();
  void getPreferences() async {
    await sessionManager.getPreference().then((value) {
      setState(() {
        mystatus = sessionManager.status;
        globalName = sessionManager.fullname;
        globalEmail = sessionManager.email;
        id_user = sessionManager.iduser;
        globalid_employee = sessionManager.id_employee;
        print("global $mystatus");
        //_loginStatus = mystatus == true ? LoginStatus.Login : LoginStatus.not_login;
      });
    });
  }

  bool status_check2 = false;
  String status_id_dw2;
  Future check_dw2(String id_employee) async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/check_status_dw", body: {
      'id_employee': id_employee,
    });
    ModelCheckDw listData = modelCheckDwFromJson(response.body);

    if (listData.status == 200) {
      // print('Sudah TTD');
      setState(() {
        status_check2 = true;
        status_id_dw = listData.id.toString();
        InSignIn = false;
      });
    } else {
      setState(() {
        status_check2 = false;
        status_id_dw = listData.id.toString();
        InSignIn = false;
      });
    }
  }

  bool status_check = false;
  String status_id_dw,
      client,
      penempatan,
      status_active,
      mulai,
      selesai,
      job_order,
      id_dw_aktive,
      block;
  Future check_dw(String id_employee) async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/check_pekerjaan_result", body: {
      'id_employee': id_employee,
    });
    ModelCheckDw listData = modelCheckDwFromJson(response.body);

    if (listData.status == 200) {
      // print('Sudah TTD');
      setState(() {
        status_check = true;
        status_id_dw = listData.id.toString();
        client = listData.client.toString();
        penempatan = listData.penempatan.toString();
        status_active = listData.status_active.toString();
        mulai = listData.mulai.toString();
        selesai = listData.selesai.toString();
        job_order = listData.job_order.toString();
        id_dw_aktive = listData.id.toString();
        block = listData.status_bloc.toString();
      });
    } else {
      setState(() {
        status_check = false;
        status_id_dw = listData.id.toString();
      });
    }
  }

  String status_absen;
  Future check_dw_absensi(String status_id_active) async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/check_absen_masuk_keluar", body: {
      'id_dw_active': status_id_active,
    });
    ModelRegister listData = modelRegisterFromJson(response.body);

    print("listddata${listData}");

    if (listData.status == 200) {
      setState(() {
        status_absen = "12";
      });
    } else if (listData.status == 202) {
      status_absen = "2";
    } else {
      status_absen = "100";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPreferences();
    check_dw2(globalid_employee.toString());
    check_dw_absensi(status_id_dw.toString());
    check_dw(globalid_employee.toString());
  }

  @override
  Widget build(BuildContext context) {
    // check_dw2(globalid_employee.toString());
    // check_dw_absensi(status_id_dw.toString());
    // check_dw(globalid_employee.toString());
    //print(globalid_employee);
    return Scaffold(
      body: ListView(
        children: [
          Container(
            child: mystatus == true
                ? Container(
                    child: status_check2 == true
                        ?

//                    home_dw_active(
//                        block: block,
//                        status_active: status_active,
//                        job_order: job_order,
//                        penempatan: penempatan,
//                        client: client,
//                        mulai: mulai,
//                        selesai: selesai,
//                        status_id_dw: status_id_dw,
//                    )

                        Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        FlatButton(
                                          child: Image.asset(
                                            'images/slider/absensi.png',
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            fit: BoxFit.fill,
                                          ),
                                          onPressed: () {
                                            if (block == "0") {
                                              Toast.show("Akun Anda Tidak Aktif",
                                                  context,
                                                  duration: 3,
                                                  gravity: Toast.TOP);
                                            } else if (block == "1") {
                                              if (status_active == "1") {
                                                Navigator.of(context).push(
                                                    new MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            ScanBarcode(
                                                              id: status_id_dw ==
                                                                      null
                                                                  ? ""
                                                                  : status_id_dw,
                                                            )));
                                              } else if (status_active == "0") {
                                                Toast.show(
                                                    "Akun Anda Belum Tidak Aktif",
                                                    context,
                                                    duration: 3,
                                                    gravity: Toast.TOP);
                                              }
                                            }
                                          },
                                        ),
                                        Text(
                                          "Absensi",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        FlatButton(
                                          child: Image.asset(
                                            'images/slider/riwayat_absensi.png',
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            fit: BoxFit.fill,
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                new MaterialPageRoute(
                                                    builder:
                                                        (BuildContext context) =>
                                                            riwayat_absensi()));
                                          },
                                        ),
                                        Text(
                                          "Riwayat Absensi",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        FlatButton(
                                          child: Image.asset(
                                            'images/slider/riwayat_pekerjaan.png',
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            fit: BoxFit.fill,
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                new MaterialPageRoute(
                                                    builder:
                                                        (BuildContext context) =>
                                                            riwayat_pekerjaan()));
                                          },
                                        ),
                                        Text(
                                          "Riwayat Pekerjaan",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        FlatButton(
                                          child: Image.asset(
                                            'images/slider/riwayat_saldo.png',
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            fit: BoxFit.fill,
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                new MaterialPageRoute(
                                                    builder:
                                                        (BuildContext context) =>
                                                            listSaldo()));
                                          },
                                        ),
                                        Text(
                                          "Riwayat Saldo",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        FlatButton(
                                          child: Image.asset(
                                            'images/slider/lembur.png',
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4,
                                            width:
                                                MediaQuery.of(context).size.width/4,
                                            fit: BoxFit.fill,
                                          ),
                                          onPressed: () {
//                                  if (block == "0") {
//                                    Toast.show("Akun Anda Tidak Aktif", context,
//                                        duration: 3, gravity: Toast.TOP);
//                                  } else if (block == "1") {
//                                    if (status_active == "1") {
//                                      Navigator.of(context).push(
//                                          new MaterialPageRoute(
//                                              builder: (BuildContext context) =>
//                                                  pengajuan_lembur(
//                                                    id: status_id_dw == null
//                                                        ? ""
//                                                        : status_id_dw,
//                                                  )));
//                                    } else if (status_active == "0") {
//                                      Toast.show("Akun Anda Belum Tidak Aktif",
//                                          context,
//                                          duration: 3, gravity: Toast.TOP);
//                                    }
//                                  }

                                            Navigator.of(context).push(
                                                new MaterialPageRoute(
                                                    builder:
                                                        (BuildContext context) =>
                                                            pengajuan_lembur(
                                                              id: status_id_dw ==
                                                                      null
                                                                  ? ""
                                                                  : status_id_dw,
                                                            )));
                                          },
                                        ),
                                        Text(
                                          "Pengajuan Lembur",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        FlatButton(
                                          child: Image.asset(
                                            'images/slider/riwayat.png',
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4,
                                            width:
                                                MediaQuery.of(context).size.width/4,
                                            fit: BoxFit.fill,
                                          ),
                                          onPressed: () {
//                                            Navigator.of(context).push(
//                                                new MaterialPageRoute(
//                                                    builder:
//                                                        (BuildContext context) =>
//                                                            listSaldo()));

                                            Toast.show("Cooming soon", context,
                                                duration: 3, gravity: Toast.BOTTOM);
                                          },
                                        ),
                                        Text(
                                          "Riwayat Lembur",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),


                              Center(child: Text("Status Pekerjaan")),
                              Card(
                                elevation: 6,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("ID :"),
                                          Text(job_order == null
                                              ? ""
                                              : job_order)
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("Client :"),
                                          Text(client == null ? "" : client),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("Penempatan :"),
                                          Text(penempatan == null
                                              ? ""
                                              : penempatan),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("Tanggal Mulai Bekerja :"),
                                          Text(mulai == null ? "" : mulai),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("Tanggal Selesai :"),
                                          Text(selesai == null ? "" : selesai)
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("Status :"),
                                          Text(status_active == "1"
                                              ? "Aktif"
                                              : "Tidak Aktif")
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text("Status Active :"),
                                          Text(block == "1"
                                              ? "Aktif"
                                              : "Tidak Aktif")
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )

//                    Column(
//                      children: <Widget>[
//                        Padding(
//                          padding: const EdgeInsets.all(8.0),
//                          child: Flexible(
//                            flex: 1,
//                            child: Row(
//                              children: <Widget>[
//                                Flexible(
//                                  flex: 1,
//                                  child: Container(
//                                    child: Column(
//                                      children: [
//                                        FlatButton(
//                                          child: Image.asset(
//                                            'images/slider/absensi.png',
//                                            height:
//                                            MediaQuery.of(context).size.height / 4,
//                                            width: MediaQuery.of(context).size.width,
//                                            fit: BoxFit.cover,
//                                          ),
//                                          onPressed: () {
//                                            if (block == "0") {
//                                              Toast.show("Akun Anda Tidak Aktif", context,
//                                                  duration: 3, gravity: Toast.TOP);
//                                            } else if (block == "1") {
//                                              if (status_active == "1") {
//                                                Navigator.of(context).push(
//                                                    new MaterialPageRoute(
//                                                        builder: (BuildContext context) =>
//                                                            ScanBarcode(
//                                                              id: status_id_dw == null
//                                                                  ? ""
//                                                                  : status_id_dw,
//                                                            )));
//                                              } else if (status_active == "0") {
//                                                Toast.show("Akun Anda Belum Tidak Aktif",
//                                                    context,
//                                                    duration: 3, gravity: Toast.TOP);
//                                              }
//                                            }
//                                          },
//                                        ),
//                                        Text(
//                                          "Absensi",
//                                          style: TextStyle(
//                                              fontWeight: FontWeight.w600, fontSize: 16),
//                                        )
//                                      ],
//                                    ),
//                                  ),
//                                ),
//                                Flexible(
//                                  flex: 1,
//                                  child: Container(
//                                    child: Column(
//                                      children: [
//                                        FlatButton(
//                                          child: Image.asset(
//                                            'images/slider/riwayat_absensi.png',
//                                            height:
//                                            MediaQuery.of(context).size.height / 4,
//                                            width: MediaQuery.of(context).size.width,
//                                            fit: BoxFit.cover,
//                                          ),
//                                          onPressed: () {
//                                            Navigator.of(context).push(
//                                                new MaterialPageRoute(
//                                                    builder: (BuildContext context) =>
//                                                        riwayat_absensi()));
//                                          },
//                                        ),
//                                        Text(
//                                          "Riwayat Absensi",
//                                          style: TextStyle(
//                                              fontWeight: FontWeight.w600, fontSize: 16),
//                                        )
//                                      ],
//                                    ),
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.all(8.0),
//                          child: Flexible(
//                            flex: 1,
//                            child: Row(
//                              children: <Widget>[
//                                Flexible(
//                                  flex: 1,
//                                  child: Container(
//                                    child: Column(
//                                      children: [
//                                        FlatButton(
//                                          child: Image.asset(
//                                            'images/slider/riwayat_pekerjaan.png',
//                                            height:
//                                            MediaQuery.of(context).size.height / 4,
//                                            width: MediaQuery.of(context).size.width,
//                                            fit: BoxFit.cover,
//                                          ),
//                                          onPressed: () {
//                                            Navigator.of(context).push(
//                                                new MaterialPageRoute(
//                                                    builder: (BuildContext context) =>
//                                                        riwayat_pekerjaan()));
//                                          },
//                                        ),
//                                        Text(
//                                          "Riwayat Pekerjaan",
//                                          style: TextStyle(
//                                              fontWeight: FontWeight.w600, fontSize: 16),
//                                        )
//                                      ],
//                                    ),
//                                  ),
//                                ),
//                                Flexible(
//                                  flex: 1,
//                                  child: Container(
//                                    child: Column(
//                                      children: [
//                                        FlatButton(
//                                          child: Image.asset(
//                                            'images/slider/riwayat_saldo.png',
//                                            height:
//                                            MediaQuery.of(context).size.height / 4,
//                                            width: MediaQuery.of(context).size.width,
//                                            fit: BoxFit.cover,
//                                          ),
//                                          onPressed: () {
//                                            Navigator.of(context).push(
//                                                new MaterialPageRoute(
//                                                    builder: (BuildContext context) =>
//                                                        listSaldo()));
//                                          },
//                                        ),
//                                        Text(
//                                          "Riwayat Saldo",
//                                          style: TextStyle(
//                                              fontWeight: FontWeight.w600, fontSize: 16),
//                                        )
//                                      ],
//                                    ),
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                        ),
//                        SizedBox(
//                          height: 16,
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.all(8.0),
//                          child: Flexible(
//                            flex: 1,
//                            child: Row(
//                              children: <Widget>[
//                                Flexible(
//                                  flex: 1,
//                                  child: Container(
//                                    child: Column(
//                                      children: [
//                                        FlatButton(
//                                          child: Image.asset(
//                                            'images/slider/lembur.png',
//                                            height:
//                                            MediaQuery.of(context).size.height / 4,
//                                            width: MediaQuery.of(context).size.width,
//                                            fit: BoxFit.cover,
//                                          ),
//                                          onPressed: () {
//
////                                  if (block == "0") {
////                                    Toast.show("Akun Anda Tidak Aktif", context,
////                                        duration: 3, gravity: Toast.TOP);
////                                  } else if (block == "1") {
////                                    if (status_active == "1") {
////                                      Navigator.of(context).push(
////                                          new MaterialPageRoute(
////                                              builder: (BuildContext context) =>
////                                                  pengajuan_lembur(
////                                                    id: status_id_dw == null
////                                                        ? ""
////                                                        : status_id_dw,
////                                                  )));
////                                    } else if (status_active == "0") {
////                                      Toast.show("Akun Anda Belum Tidak Aktif",
////                                          context,
////                                          duration: 3, gravity: Toast.TOP);
////                                    }
////                                  }
//
//
//                                            Navigator.of(context).push(
//                                                new MaterialPageRoute(
//                                                    builder: (BuildContext context) =>
//                                                        pengajuan_lembur(
//                                                          id: status_id_dw == null
//                                                              ? ""
//                                                              : status_id_dw,
//
//                                                        )));
//                                          },
//                                        ),
//                                        Text(
//                                          "Pengajuan Lembur",
//                                          style: TextStyle(
//                                              fontWeight: FontWeight.w600, fontSize: 16),
//                                        )
//                                      ],
//                                    ),
//                                  ),
//                                ),
//                                Flexible(
//                                  flex: 1,
//                                  child: Container(
//                                    child: Column(
//                                      children: [
//                                        FlatButton(
//                                          child: Image.asset(
//                                            'images/slider/riwayat.png',
//                                            height:
//                                            MediaQuery.of(context).size.height / 4,
//                                            width: MediaQuery.of(context).size.width,
//                                            fit: BoxFit.cover,
//                                          ),
//                                          onPressed: () {
//                                            Navigator.of(context).push(
//                                                new MaterialPageRoute(
//                                                    builder: (BuildContext context) =>
//                                                        listSaldo()));
//                                          },
//                                        ),
//                                        Text(
//                                          "Riwayat Lembur",
//                                          style: TextStyle(
//                                              fontWeight: FontWeight.w600, fontSize: 16),
//                                        )
//                                      ],
//                                    ),
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                        ),
//                        SizedBox(
//                          height: 26,
//                        ),
//                        Center(child: Text("Status Pekerjaan")),
//                        Card(
//                          elevation: 6,
//                          child: Column(
//                            children: <Widget>[
//                              Padding(
//                                padding: const EdgeInsets.all(8.0),
//                                child: Row(
//                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                  children: <Widget>[
//                                    Text("ID :"),
//                                    Text(job_order == null ? "" : job_order)
//                                  ],
//                                ),
//                              ),
//                              Padding(
//                                padding: const EdgeInsets.all(8.0),
//                                child: Row(
//                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                  children: <Widget>[
//                                    Text("Client :"),
//                                    Text(client == null ? "" : client),
//                                  ],
//                                ),
//                              ),
//                              Padding(
//                                padding: const EdgeInsets.all(8.0),
//                                child: Row(
//                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                  children: <Widget>[
//                                    Text("Penempatan :"),
//                                    Text(penempatan == null ? "" : penempatan),
//                                  ],
//                                ),
//                              ),
//                              Padding(
//                                padding: const EdgeInsets.all(8.0),
//                                child: Row(
//                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                  children: <Widget>[
//                                    Text("Tanggal Mulai Bekerja :"),
//                                    Text(mulai == null ? "" : mulai),
//                                  ],
//                                ),
//                              ),
//                              Padding(
//                                padding: const EdgeInsets.all(8.0),
//                                child: Row(
//                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                  children: <Widget>[
//                                    Text("Tanggal Selesai :"),
//                                    Text(selesai == null ? "" : selesai)
//                                  ],
//                                ),
//                              ),
//                              Padding(
//                                padding: const EdgeInsets.all(8.0),
//                                child: Row(
//                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                  children: <Widget>[
//                                    Text("Status :"),
//                                    Text(status_active == "1" ? "Aktif" : "Tidak Aktif")
//                                  ],
//                                ),
//                              ),
//                              Padding(
//                                padding: const EdgeInsets.all(8.0),
//                                child: Row(
//                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                  children: <Widget>[
//                                    Text("Status Active :"),
//                                    Text(block == "1" ? "Aktif" : "Tidak Aktif")
//                                  ],
//                                ),
//                              ),
//                            ],
//                          ),
//                        ),
//                      ],
//                    )

                        : SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: InSignIn
                                ? SpinKitFadingCircle(
                                    color: Colors.redAccent,
                                  )
                                : Container(
                                    child: Center(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image.asset(
                                              'images/kategori/LowonganProses.png',
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  2,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
                                            Text(
                                              'Anda belum bekerja saat ini',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ]),
                                    ),
                                  )),
                  )
                : Container(
                    child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'images/kategori/LowonganProses.png',
                              height: MediaQuery.of(context).size.height / 2,
                              width: MediaQuery.of(context).size.width,
                            ),
                            Text(
                              'Anda Belum Bekerja Saat ini',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class home_dw_active extends StatelessWidget {
  List list;
  bool mystatus;
  String globalid_employee,
      block,
      status_active,
      job_order,
      client,
      penempatan,
      mulai,
      selesai,
      status_id_dw;
  home_dw_active({
    this.list,
    this.globalid_employee,
    this.mystatus,
    this.block,
    this.job_order,
    this.client,
    this.status_id_dw,
    this.penempatan,
    this.mulai,
    this.selesai,
    this.status_active,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Pekerjaan Harian'),
        backgroundColor: mainColor,
      ),
      body: ListView(
        children: [
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flexible(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: Column(
                            children: [
                              FlatButton(
                                child: Image.asset(
                                  'images/slider/absensi.png',
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                ),
                                onPressed: () {
                                  if (block == "0") {
                                    Toast.show("Akun Anda Tidak Aktif", context,
                                        duration: 3, gravity: Toast.TOP);
                                  } else if (block == "1") {
                                    if (status_active == "1") {
                                      Navigator.of(context).push(
                                          new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  ScanBarcode(
                                                    id: status_id_dw == null
                                                        ? ""
                                                        : status_id_dw,
                                                  )));
                                    } else if (status_active == "0") {
                                      Toast.show("Akun Anda Belum Tidak Aktif",
                                          context,
                                          duration: 3, gravity: Toast.TOP);
                                    }
                                  }
                                },
                              ),
                              Text(
                                "Absensi",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: Column(
                            children: [
                              FlatButton(
                                child: Image.asset(
                                  'images/slider/riwayat_absensi.png',
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              riwayat_absensi()));
                                },
                              ),
                              Text(
                                "Riwayat Absensi",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flexible(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: Column(
                            children: [
                              FlatButton(
                                child: Image.asset(
                                  'images/slider/riwayat_pekerjaan.png',
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              riwayat_pekerjaan()));
                                },
                              ),
                              Text(
                                "Riwayat Pekerjaan",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: Column(
                            children: [
                              FlatButton(
                                child: Image.asset(
                                  'images/slider/riwayat_saldo.png',
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              listSaldo()));
                                },
                              ),
                              Text(
                                "Riwayat Saldo",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flexible(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: Column(
                            children: [
                              FlatButton(
                                child: Image.asset(
                                  'images/slider/lembur.png',
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                ),
                                onPressed: () {
//                                  if (block == "0") {
//                                    Toast.show("Akun Anda Tidak Aktif", context,
//                                        duration: 3, gravity: Toast.TOP);
//                                  } else if (block == "1") {
//                                    if (status_active == "1") {
//                                      Navigator.of(context).push(
//                                          new MaterialPageRoute(
//                                              builder: (BuildContext context) =>
//                                                  pengajuan_lembur(
//                                                    id: status_id_dw == null
//                                                        ? ""
//                                                        : status_id_dw,
//                                                  )));
//                                    } else if (status_active == "0") {
//                                      Toast.show("Akun Anda Belum Tidak Aktif",
//                                          context,
//                                          duration: 3, gravity: Toast.TOP);
//                                    }
//                                  }

                                  Navigator.of(context).push(
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              pengajuan_lembur(
                                                id: status_id_dw == null
                                                    ? ""
                                                    : status_id_dw,
                                              )));
                                },
                              ),
                              Text(
                                "Pengajuan Lembur",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: Column(
                            children: [
                              FlatButton(
                                child: Image.asset(
                                  'images/slider/riwayat.png',
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              listSaldo()));
                                },
                              ),
                              Text(
                                "Riwayat Lembur",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Center(child: Text("Status Pekerjaan")),
              Card(
                elevation: 6,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("ID :"),
                          Text(job_order == null ? "" : job_order)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Client :"),
                          Text(client == null ? "" : client),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Penempatan :"),
                          Text(penempatan == null ? "" : penempatan),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Tanggal Mulai Bekerja :"),
                          Text(mulai == null ? "" : mulai),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Tanggal Selesai :"),
                          Text(selesai == null ? "" : selesai)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Status :"),
                          Text(status_active == "1" ? "Aktif" : "Tidak Aktif")
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Status Active :"),
                          Text(block == "1" ? "Aktif" : "Tidak Aktif")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
