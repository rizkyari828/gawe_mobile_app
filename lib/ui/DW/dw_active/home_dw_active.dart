import 'package:flutter/material.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/model/dw/model_check_dw.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/ui/DW/dw_active/list_saldo.dart';
import 'package:gaweid2/ui/DW/dw_active/riwayat_absensi.dart';
import 'package:gaweid2/ui/DW/dw_active/riwayat_pekerjaan.dart';
import 'package:gaweid2/ui/DW/dw_active/riwayat_saldo.dart';
import 'package:gaweid2/ui/DW/dw_active/status_pekerjaan.dart';
import 'package:gaweid2/ui/DW/scan/scan_barcode.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class Home_dw_active extends StatefulWidget {
  final id;
  Home_dw_active({
    this.id,
  });

  @override
  _Home_dw_activeState createState() => _Home_dw_activeState();
}

class _Home_dw_activeState extends State<Home_dw_active> {
  var globalName = "",
      globalEmail = "",
      globalLevel = "",
      id_user = "",
      globalid_employee = "";
  var status = false;
  // var id_user;
//  var value;
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
//        print("id_userid_userid_user${id_user}");
//        print("id_employee${globalid_employee}");
//        print("fullname${globalName}");
//        print("email${globalEmail}");
        print("global $mystatus");
        //_loginStatus = mystatus == true ? LoginStatus.Login : LoginStatus.not_login;
      });
    });
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
    //getLowongan();

    check_dw(globalid_employee.toString());
    getPreferences();
  }

  @override
  Widget build(BuildContext context) {
    check_dw_absensi(status_id_dw.toString());
    print("status_absen${status_absen}");
    print("print${block}");
    check_dw(globalid_employee.toString());

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
                                                    id: widget.id == null
                                                        ? ""
                                                        : widget.id,
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
//          Padding(
//            padding: const EdgeInsets.only(left: 35),
//            child: Flexible(
//              flex: 1,
//              child: Row(
//                children: <Widget>[
//                  Flexible(
//                    flex: 1,
//                    child: Container(
//                      child: Column(
//                        children: [
//                          FlatButton(
//                            child: Image.asset(
//                              'images/slider/riwayat_pekerjaan.png',
//                              height: 100,
//                              width:100,
//                              fit: BoxFit.cover,
//                            ),
//                            onPressed: () {
//                              Navigator.of(context).push(new MaterialPageRoute(
//                                  builder: (BuildContext context) =>
//                                      status_pekerjaan()));
//                            },
//                          ),
//                          Text(
//                            "Status Pekerjaan",
//                            style: TextStyle(
//                                fontWeight: FontWeight.w600, fontSize: 16),
//                          )
//                        ],
//                      ),
//                    ),
//                  ),
//
//                ],
//              ),
//            ),
//          ),
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
