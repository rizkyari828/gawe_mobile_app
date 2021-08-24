import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/modules/learning/models/materi_modul.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/learning/views/kodelearning.dart';
import 'package:gaweid2/modules/learning/views/video_materi.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class UI_Materi extends StatefulWidget {
  @override
  _UI_Materi createState() => _UI_Materi();
  final id_modul,kodelearning;


  UI_Materi(
      {this.id_modul,
        this.kodelearning,
      });
}

class _UI_Materi extends State<UI_Materi> {

  var InSignIn = false;

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

  Future<List> getMateri() async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps_learning/list_materi", body: {
      'id': widget.id_modul.toString(),
    });

    MateriModul listdata = materiModulFromJson(response.body);
    return listdata.materi;

  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMateri();
    getPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('List Materi'),
        backgroundColor: mainColor,
      ),
      body: FutureBuilder(
        future: getMateri(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print("snap${snapshot.hasData}");

          return snapshot.hasData
              ? ItemList(list: snapshot.data,kodelearning: widget.kodelearning,email:globalEmail,id_modul:widget.id_modul)
              : Center(
            child: mystatus == true
                ? CircularProgressIndicator()
                : Container(
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'images/kategori/LowonganTersimpan.png',
                        height:
                        MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Text(
                        'Tidak Ada Lowongan Tersimpan',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {

  BaseEndPoint network = NetworkProvider();
  List list;
  String kodelearning,email,id_modul;
  ItemList({this.list,this.kodelearning,this.email,this.id_modul});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (BuildContext context, int index) {
        final Materi xmateri = list[index];
        return SingleChildScrollView(
          child: Card(
            elevation: 5,
            child: InkWell(
              onTap: ()async{

                SpinKitFadingCircle(
                  color: Colors.redAccent,
                );

                ModelRegister data = await network.akses_mater_learning(email, id_modul, xmateri.id);


//                InSignIn
//                    ? SpinKitFadingCircle(
//                  color: Colors.redAccent,
//                )
//                    :

              if(data.status==200){



                Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => videomateri(

                    video: xmateri.video == null
                        ? ""
                        : xmateri.video,
                    nama_materi: xmateri.namaMateri == null
                        ? ""
                        : xmateri.namaMateri,

                    id_materi: xmateri.id == null
                        ? ""
                        : xmateri.id,

                    kodelearning: kodelearning == null
                        ? ""
                        : kodelearning,
                    id_modul: id_modul == null
                        ? ""
                        : id_modul,

                  ),
                ));
              }else{
                Toast.show("Tunggu..", context,
                    duration: 3, gravity: Toast.TOP);
              }



              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                  xmateri.foto,
                                  height: MediaQuery.of(context).size.height / 7,
                                  width: MediaQuery.of(context).size.width / 3,
                                ),
                              ),
                            ),

                            Center(
                              child: Text(
                                xmateri.namaMateri,
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
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                xmateri.kkm,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

//  void aksesmateri(email,id_modul,id_materi)async{
//    BaseEndPoint network = NetworkProvider();
//    ModelRegister data = await network.akses_mater_learning(globalEmail, widget.id_modul, "");
//  }
}
