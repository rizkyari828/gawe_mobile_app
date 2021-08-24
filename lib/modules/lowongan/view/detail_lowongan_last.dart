import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gaweid2/modules/media/models/ModelCheck.dart';
import 'package:gaweid2/model/user/ModelLowongan.dart';
import 'package:gaweid2/model/user/ModelLowongan2.dart';
import 'package:gaweid2/model/user/ModelLowonganDetail.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/user/view/Login.dart';
import 'package:gaweid2/ui/User/Fragment/AkunUser_backup.dart';
import 'package:gaweid2/modules/lowongan/view/filter.dart';
import 'package:gaweid2/modules/lowongan/view/info_pekerjaan.dart';
import 'package:gaweid2/modules/lowongan/view/lowongan.dart';
import 'package:gaweid2/modules/lowongan/view/profil_perushaaan.dart';
import 'package:gaweid2/modules/user/view/register/LupaPassword.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:http/http.dart' as http;

class Detail_lowongan2 extends StatefulWidget {
  final logo, provinsi, posisi, id, perusahaan, gajimin, gajimax;
  Detail_lowongan2(
      {this.logo,
        this.posisi,
        this.provinsi,
        this.id,
        this.perusahaan,
        this.gajimin,
        this.gajimax});

  @override
  _Detail_lowonganState createState() => _Detail_lowonganState();
}

class _Detail_lowonganState extends State<Detail_lowongan2>
    with TickerProviderStateMixin {
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
      globalid_employee = "";
  var status = false;
  var mystatus, status_check;

  SessionManager sessionManager = SessionManager();
  void getPreferences() async {
    await sessionManager.getPreference().then((value) {
      setState(() {
        mystatus = sessionManager.status;
        globalName = sessionManager.fullname;
        globalEmail = sessionManager.email;
        id_user = sessionManager.iduser;
        globalid_employee = sessionManager.id_employee;
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

  void myAlert(String idlowongan, id_employee) {
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
                  //  Navigator.push(context,MaterialPageRoute (builder:(context)=>Myhome()));
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
                  Navigator.push(context,MaterialPageRoute (builder:(context)=>Login()));
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
      Navigator.pop(context);
    } else {
      print("Gagal Melamar");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("employee_id build${globalid_employee}");

    print("status check ${status_check}");

    check_lowongan(globalid_employee);

    screenSize = MediaQuery.of(context).size.width;
    appBar = AppBar(
      title: Text(widget.perusahaan),
      // backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: appBar,
            body: Center(
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Image.network(
                              widget.logo,
                              height: 200,
                            ),
//                            child: CircleAvatar(
//                              backgroundImage: NetworkImage(widget.logo),
//                              backgroundColor: Colors.cyanAccent,
//                              radius: 50.0,
//                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Container(
                            color: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 15,
                                ),
                                new Text(
                                    widget.perusahaan == null
                                        ? ""
                                        : widget.perusahaan,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.work,
                                        color: Colors.black,
                                        size: 24.0,
                                      ),
                                      Text(
                                        widget.posisi == null
                                            ? ""
                                            : widget.posisi,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
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
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                      color: Colors.green,
                                      onPressed: () {
                                        if(mystatus==true){
                                          myAlert(widget.id, globalid_employee);
                                        }else{
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
                        ),
                      ],
                    ),
                    new Positioned(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      left: -5.0,
                      top: 400,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 40, right: 10, left: 10, top: 10),
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
                            Padding(
                              padding: const EdgeInsets.only(bottom: 40),
                              child: Container(
                                color: Colors.white,
                                height: MediaQuery.of(context).size.height,
                                child: SizedBox(
                                  height: 100,
                                  child: new TabBarView(
                                    controller: _tabController,
                                    children: <Widget>[
                                      SizedBox(
                                          height: 10000,
                                          child: info_pekerjaaan(
                                            id: widget.id,
                                          )),
                                      profil_pekerjaan(
                                        id: widget.id,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
//                  Align(
//                    alignment: Alignment.bottomCenter,
//                    child: Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: ButtonTheme(
//                        minWidth: MediaQuery.of(context).size.width,
//                        child: RaisedButton(
//                          onPressed: () {},
//                          child: const Text('Lamar Sekarang',
//                              style: TextStyle(fontSize: 28)),
//                          color: Colors.green,
//                          textColor: Colors.white,
//                          elevation: 5,
//                        ),
//                      ),
//                    ),
//                  ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
