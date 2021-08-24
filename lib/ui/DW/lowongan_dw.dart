import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gaweid2/modules/media/models/ModelNews.dart';
import 'package:gaweid2/modules/media/models/ModelNews2.dart';
import 'package:gaweid2/model/dw/model_check_dw.dart';
import 'package:gaweid2/model/user/ModelLowongan.dart';
import 'package:gaweid2/model/user/ModelLowongan2.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/ui/DW/dw_active/home_dw_active.dart';
import 'package:gaweid2/ui/DW/login_dw.dart';
import 'package:gaweid2/ui/DW/lowongan_detail_dw.dart';
import 'package:gaweid2/modules/user/view/Login2.dart';
import 'package:gaweid2/modules/lowongan/view/detail_lowongan.dart';
import 'package:gaweid2/modules/lowongan/view/filter.dart';
import 'package:gaweid2/modules/lowongan/view/searchLowongan.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class ListLowongan_DW extends StatefulWidget {
  @override
  _LowonganDWState createState() => _LowonganDWState();
}

class _LowonganDWState extends State<ListLowongan_DW> {
  List<ModelLowongan> lowongan = [];
  var loading = false;

  Future<List> getLowongan() async {
    final response =
        await http.get(NetworkConfig().baseUrl + "apps/lowongan_dw");
    ModelLowongan2 listdata = modelLowongan2FromJson(response.body);
    if (response.statusCode == 200) {
      //print("get data succeessfully");
    } else {
      // print("Get Data Failed");
    }
    return listdata.lowongan;
  }

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
  String status_id_dw;
  Future check_dw(String id_employee) async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/check_status_dw", body: {
      'id_employee': id_employee,
    });
    ModelCheckDw listData = modelCheckDwFromJson(response.body);

    if (listData.status == 200) {
      // print('Sudah TTD');
      setState(() {
        status_check = true;
        status_id_dw = listData.id.toString();
      });
    } else {
      setState(() {
        status_check = false;
        status_id_dw = listData.id.toString();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getLowongan();

    getPreferences();
  }

  @override
  Widget build(BuildContext context) {

    check_dw(globalid_employee.toString());
    print("status_id_dw${status_id_dw}");
    print("status_ceh${status_check}");
    print("id_employee${globalid_employee.toString()}");
    // print(id_user);
//    if(widget.posisi!=null){
//      List<ModelLowongan> lowongan = [] = filterLowongan();
//    }else{
//      futureget[] = getLowongan();
//    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Gawe.id'),
        backgroundColor: mainColor,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              // logOut();
              if (mystatus == true) {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => Search()));
              } else {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => Login_Dw()));
              }
            },
            icon: mystatus == true ? Icon(Icons.search) : Icon(Icons.vpn_key),
          ),
          Visibility(
            visible: status_check,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => Home_dw_active(
                          id: status_id_dw,
                        )));
              },
              icon: mystatus == true
                  ? Icon(Icons.account_box)
                  : Icon(Icons.account_box),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getLowongan(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print("snap${snapshot.hasData}");
          return snapshot.hasData
              ? ItemList(
                  list: snapshot.data,
                  globalid_employee: globalid_employee,
                  mystatus: mystatus)
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => Filter()));
        },
        label: Text('Filter'),
        icon: Icon(Icons.search),
        backgroundColor: Colors.pink,
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  List list;
  bool mystatus;
  String globalid_employee;
  ItemList({this.list, this.globalid_employee, this.mystatus});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (BuildContext context, int index) {
        final xlowongan = list[index];
        return SingleChildScrollView(
          child: Card(
            margin: new EdgeInsets.only(
                left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            elevation: 12,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Detail_lowongan_DW(
                          logo: xlowongan.logo == null ? "" : xlowongan.logo ,
                          provinsi : xlowongan.provinceId == null ? "" : xlowongan.provinceId,
                          posisi : xlowongan.posisi == null ? "" : xlowongan.posisi,
                          id : xlowongan.idLowongan == null ? "" : xlowongan.idLowongan,
                          perusahaan : xlowongan.namaPerusahaan == null ? "" : xlowongan.namaPerusahaan,
                          gajimin : xlowongan.gajiMin == null ? "" : xlowongan.gajiMin,
                          gajimax : xlowongan.gajiMax == null ? "" : xlowongan.gajiMax,
                          jenjang_career_id : xlowongan.jenjangCareerId.toString() == null ? "" : xlowongan.jenjangCareerId.toString(),
                          pendidikan : xlowongan.pendidikan.toString() == null ? "" : xlowongan.pendidikan.toString(),
                          city_id : xlowongan.cityId == null ? "" : xlowongan.cityId,
                          pengalaman : xlowongan.pengalamanId.toString() == null ? "" : xlowongan.pengalamanId.toString(),
                          rincian : xlowongan.rincian.toString() == null ? "" : xlowongan.rincian.toString(),
                          kualifikasi : xlowongan.kualifikasi.toString() == null ? "" : xlowongan.kualifikasi.toString(),
                          kuota : xlowongan.kouta.toString() == null ? "" : xlowongan.kouta.toString(),
                          alamat : xlowongan.alamat.toString() == null ? "" : xlowongan.alamat.toString(),
                          deskripsi : xlowongan.deskripsi.toString() == null ? "" : xlowongan.deskripsi.toString(),
                            )));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          xlowongan.logo,
                          height: MediaQuery.of(context).size.height / 7,
                          width: MediaQuery.of(context).size.width / 3,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              xlowongan.posisi,
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: birumuda,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              xlowongan.provinceId,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            Text(
                              xlowongan.namaPerusahaan,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              xlowongan.jenispekerjaan,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
//                      FlatButton(
//                        onPressed: () {
//                          showDialog(
//                              context: context,
//                              builder: (BuildContext context){
//                                return AlertDialog(
//                                  title: mystatus == true ? Text("Ingin Menyimpan Lowongan ?") : Text("Silahkan Anda Login Dulu !!") ,
//                                  content: Text(xlowongan.posisi),
//                                  actions: <Widget>[
////                                    FlatButton(
////                                      onPressed: (){
////                                        //Navigator.push(context,MaterialPageRoute (builder:(context)=>Myhome()));
////                                        // simpan_lowongan()
////                                        //print(id_user);
////                                        if(mystatus==true){
////                                         // simpanLowongan(xlowongan.idLowongan,globalid_employee,context);
////                                          Navigator.pop(context);
////                                        }else{
////                                          Navigator.push(context,MaterialPageRoute (builder:(context)=>Login()));
////                                        }
////
////                                      },
////                                      child: Text("Ya"),
////                                    ),
//                                    FlatButton(
//                                      onPressed: (){
//                                        Navigator.pop(context);
//                                      },
//                                      child: Text("Tidak"),
//                                    ),
//                                  ],
//                                );
//                              }
//                          );
//                        },
//                        child: Icon(Icons.save),
//                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Text(xlowongan.totalPelamar.toString() +
                                " Pelamar",style:TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                          ),
                          Text(
                            xlowongan.datePostEnd.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void simpanLowongan(idLowongan, globalid_employee, context) async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/simpan_lowongan", body: {
      'lowongan_id': idLowongan,
      'employee_id': globalid_employee,
    });

    if (response.statusCode == 200) {
      print("berhasi disimpan lowongan");
      Toast.show("Lowongan Berhasil Disimpan", context,
          duration: 3, gravity: Toast.BOTTOM);
//      Navigator.pop();
//      Navigator.of(context).pop();
//      Navigator.pop(context);

    } else {
      print("gagal disimpan lowongan");
    }

//    print("idlowongan${idLowongan}");
//    print("id_employee${globalid_employee}");
  }
}
