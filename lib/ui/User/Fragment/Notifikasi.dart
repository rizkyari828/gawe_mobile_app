import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/modules/user/models/Model_Notifikasi.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/ui/DW/notif/notif_offering.dart';
import 'package:gaweid2/ui/User/Fragment/Lowonganku.dart';
import 'package:gaweid2/modules/lowongan/view/lowonganKu/List_undangan_interview.dart';
import 'package:gaweid2/modules/lowongan/view/lowonganKu/List_undangan_psikotes.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../modules/user/view/Login.dart';

class Notifikasi extends StatefulWidget {
  @override
  NotifikasiState createState() => NotifikasiState();
}

class NotifikasiState extends State<Notifikasi> {
  var globalName = "",
      globalEmail = "",
      globalLevel = "",
      id_user = "",
      globalid_employee = "";
  var status = false;
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
      });
    });
  }

//  Future<List> Simpan_Lowongan() async{
//    final response = await http.post(NetworkConfig().baseUrl+"apps/notifikasi",body: {
//      'employee_id':globalid_employee,
//    });
//    ModelNotifikasi listdata = modelNotifikasiFromJson(response.body);
//    if(response.statusCode==200){
//      print(listdata);
//      //print("get data succeessfully");
//    }else{
//      // print("Get Data Failed");
//    }
//    return listdata.notifikasi;
//  }

  List<ModelNotifikasi> listnotif = [];
  var loading = false;

//  Future<Null> getNotifikasi() async {
//    setState(() {
//      loading = true;
//    });
//
//    final response = await http.post(NetworkConfig().baseUrl+"apps/notifikasi",body: {
//      'employee_id':globalid_employee});
//
//    if (response.statusCode == 200) {
//      final data = jsonDecode(response.body);
//      setState(() {
//        for (Map i in data) {
//          listnotif.add(ModelNotifikasi.fromJson(i));
//        }
//      });
//    }
//  }

  Future<List> getNotifikasi() async {
    setState(() {
      loading = true;
    });
    final response = await http.post(
        NetworkConfig().baseUrl + "apps/notifikasi",
        body: {'employee_id': globalid_employee});
    ModelNotifikasi listdata = modelNotifikasiFromJson(response.body);

    // print("ts${listdata.pemberitahuan}");

    if (response.statusCode == 200) {
      //print("get data succeessfully detail");
      //print(listdata);
      //print("lowongan${listdata.lowongan}");
    } else {
      // print("getNotifikasi");
    }
    return listdata.pemberitahuan;
  }

//  _launchURL(String url1) async {
//    const url = url1;
//    if (await canLaunch(url)) {
//      await launch(url);
//    } else {
//      throw 'Could not launch $url';
//    }
//  }

//  Future<void> _launched;
//  String _phone = '';
//
//  Future<void> _launchInBrowser(String url) async {
//    if (await canLaunch(url)) {
//      await launch(
//        url,
//        forceSafariVC: false,
//        forceWebView: false,
//        headers: <String, String>{'my_header_key': 'my_header_value'},
//      );
//    } else {
//      throw 'Could not launch $url';
//    }
//  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getLowongan();
    getNotifikasi();
    getPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: FutureBuilder(
            future: getNotifikasi(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData == false) {
                if (mystatus == true) {
                  return Container(
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return Container(
                    child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'images/kategori/Tidak_Notifikasi.png',
                              height: MediaQuery.of(context).size.height / 2,
                              width: MediaQuery.of(context).size.width,
                            ),
                            Text(
                              'Tidak ada notifikasi',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ),
                  );
                }
              }

              if (snapshot.hasData == true) {
                return snapshot.hasData
                    ? ItemList(
                        list: snapshot.data,
                        globalid_employee: globalid_employee,
                        mystatus: mystatus)
                    : Center(
                        child: mystatus == true
                            ? CircularProgressIndicator()
                            : Container(
                                child: Center(
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                          'images/kategori/Tidak_Notifikasi.png',
                                          height:
                                              MediaQuery.of(context).size.height /
                                                  2,
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                        Text(
                                          'Tidak Ada Notifikasi',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ]),
                                ),
                              ),
                      );
              }
            },
          ),
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  List list;
  String globalid_employee;
  bool mystatus;
  ItemList({this.list, this.globalid_employee, this.mystatus,});

  @override
  Widget build(BuildContext context) {
    if (mystatus == true) {
      return Padding(
        padding: const EdgeInsets.only(left:10.0, right:10),
        child: ListView.builder(
          itemCount: list == null ? 0 : list.length,
          itemBuilder: (BuildContext context, int i) {
            final Pemberitahuan notifikasi = list[i];
            return SingleChildScrollView(
              child: InkWell(
                onTap: () {

                  read(notifikasi.id);
                  if (notifikasi.link_go_to == "Interview") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => (List_undangan_interview())));
                  } else if (notifikasi.link_go_to == "Psikotes") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => (List_undangan_psikotes())));
                  } else if (notifikasi.link_go_to == "dw_accept") {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => (notif_ofer())));
                  } else if (notifikasi.link_go_to == "dw_reject") {
                    Toast.show(
                        "Mohon Maaf Anda Belum Diterima,\n Silahkan Di Coba lagi Lowongan Yang lain",
                        context,
                        duration: 3,
                        gravity: Toast.TOP);
                  } else if (notifikasi.link_go_to == "dw_wl") {
                    // Toast.show("Anda Sedang Dalam Waiting List \n Pekerjaan Daily Worker", context, duration: 3, gravity: Toast.TOP);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => (notif_ofer())));
                  } else if (notifikasi.link_go_to == "dw_wl_konfirmasi") {
                    //Toast.show("Anda Sedang Dalam Waiting List \n Pekerjaan Daily Worker", context, duration: 3, gravity: Toast.TOP);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => (notif_ofer())));
                  } else if (notifikasi.link_go_to == "dw_extends") {

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => (notif_ofer())));


                    Toast.show(
                        "Anda Sedang Dalam Waiting List \n Pekerjaan Daily Worker",
                        context,
                        duration: 3,
                        gravity: Toast.TOP);
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (context) => (notif_ofer())));
                  } else if (notifikasi.relatedType == "psikotes_invitation") {
                    Toast.show("Anda Dapat Undangan E - Psikotes", context,
                        duration: 3, gravity: Toast.TOP);

                    //launch(notifikasi.relatedModule);
                      launch(notifikasi.relatedModule);

                  } else {
                    Toast.show("Terimakasih Anda Sudah Menjadi Bagian Dari Gawe.id", context,
                        duration: 3, gravity: Toast.TOP);

                    //launch(notifikasi.relatedModule);
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (context) => (notif_ofer())));
                  }
                },
                child: Card(
                  color: notifikasi.readIs == "1" ? Colors.white : Color.fromRGBO(137, 207, 240, 0.7),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'images/menu/toa2.png',
                                height: MediaQuery.of(context).size.height / 12,
                                width: MediaQuery.of(context).size.width / 5,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    notifikasi.relatedLinkFrom,
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    notifikasi.relatedName,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    notifikasi.relatedText,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    notifikasi.relatedLast,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
//                    Padding(
//                      padding: const EdgeInsets.only(left: 8, right: 8),
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//                          Text(notifikasi.readAt.toString()),
//                          Text("cek"),
//                        ],
//                      ),
//                    )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'images/kategori/BelumLogin.png',
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Text('Belum Login Login'),
                  FlatButton(
                    child: Text("Login"),
                    color: Colors.green,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => (Login())));
                    },
                  ),
                ]),
          ),
        ),
      );
    }
  }

  void read(String id) async {
    final response = await http.post(
        NetworkConfig().baseUrl + "apps/read_notifikasi",
        body: {'id': id});

    ModelRegister listdata = modelRegisterFromJson(response.body);

    if (listdata.status == 200) {
      print("berhasil update read");
    } else {
      print("berhasil update read");
    }
  }


}
