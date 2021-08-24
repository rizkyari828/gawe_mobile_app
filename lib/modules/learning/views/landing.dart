import 'package:flutter/material.dart';
import 'package:gaweid2/modules/learning/models/landing_model.dart';
import 'package:gaweid2/modules/learning/views/katalog.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/learning/views/modul.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  BaseEndPoint network = NetworkProvider();

  var globalName = "",
      globalEmail = "",
      globalLevel = "",
      idUser = "",
      globalidEmployee = "";
  var status = false;
  var mystatus;

  SessionManager sessionManager = SessionManager();

  void getPreferences() async {
    await sessionManager.getPreference().then((value) {
      setState(() {
        mystatus = sessionManager.status;
        globalName = sessionManager.fullname;
        globalEmail = sessionManager.email;
        idUser = sessionManager.iduser;
        globalidEmployee = sessionManager.id_employee;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPreferences();
  }

  Future<List<Learning>> getList() async {
    final response =
        await http.post(NetworkConfig().baseUrl + "apps_learning/list_test", body: {
      'email': globalEmail,
    });

    // return modelLandingFromJson(response.body).learning;
    ModelLanding listdata = modelLandingFromJson(response.body);
    // print(listdata.learning);
    return listdata.learning;
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController kodePassword = TextEditingController();
  String passwordValidator(String value) {
    if (value.length < 4) {
      return "must be length 4";
    } else {
      return null;
    }
  }

  void checkEmailAndPassowrd() async {
    print('hai');
    if (_formKey.currentState.validate()) {
      //JIKA TRUE
      _formKey.currentState.save(); //MAKA FUNGSI SAVE() DIJALANKAN
      if (kodePassword.text.isEmpty) {
        Toast.show("Email/Password Tidak Boleh Kosong", context,
            duration: 3, gravity: Toast.BOTTOM);
      } else {

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: backgroundColor,
        child: FutureBuilder(
          future: getList(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.hasError);
            List<Learning> xmodul = snapshot.data;
            return snapshot.hasData
                ? Padding(
                  padding: const EdgeInsets.only(left:15.0, right: 15),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: xmodul == null ? 0 : xmodul.length,
                      itemBuilder: (BuildContext context, int index) {
                        return xmodul[index].namaPerusahaan == 'data kosong' ?  Container(
                          color: Colors.white,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      'images/kategori/LowonganTersimpan.png',
                                      height: MediaQuery.of(context)
                                          .size
                                          .height /
                                          2,
                                      width:
                                      MediaQuery.of(context).size.width,
                                    ),
                                    Text(
                                      'Rekomendasi \n learning belum ada',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                            ),
                          ),
                        ):
                          Card(
                            margin: new EdgeInsets.only(
                                left: 5.0,
                                right: 5.0,
                                top: 5.0,
                                bottom: 5.0),
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            elevation: 1,
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.only(topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10),),
                                  child: Image.network(
                                    xmodul[index].image == null
                                        ? ""
                                        : xmodul[index].image,
                                    height: MediaQuery.of(context)
                                            .size
                                            .height /
                                        6,
                                    width: MediaQuery.of(context)
                                            .size
                                            .width /
                                        1,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          xmodul[index].kategori == null
                                              ? ""
                                              : xmodul[index].kategori,
                                          overflow: TextOverflow.fade,
                                          maxLines: 2,
                                          softWrap: false,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          xmodul[index].description ==
                                                  null || xmodul[index].description == "0"
                                              ? "Belum ada deskripsi"
                                              : xmodul[index]
                                                  .description,
                                          overflow: TextOverflow.fade,
                                          maxLines: 2,
                                          // softWrap: false,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        xmodul[index].statusSertifikasi == null ||
                                            xmodul[index].statusSertifikasi == ""
                                            ? SizedBox(height: 10,)
                                            : Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(10.0),
                                              ),
                                                color: Colors.orange,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets
                                                          .only(
                                                    left: 6.0,
                                                    right: 6.0,
                                                    top: 3,
                                                    bottom: 3,
                                                  ),
                                                  child: Text(
                                                    xmodul[index]
                                                        .statusSertifikasi,
                                                    overflow:
                                                        TextOverflow
                                                            .fade,
                                                    maxLines: 2,
                                                    softWrap: false,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color:
                                                          Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                          children: [
                                            Text(
                                              xmodul[index]
                                                          .statusBerbayar ==
                                                      null
                                                  ? ""
                                                  : xmodul[index]
                                                      .statusBerbayar,
                                              overflow:
                                                  TextOverflow.fade,
                                              maxLines: 2,
                                              softWrap: false,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              xmodul[index]
                                                          .statusLevel ==
                                                      null
                                                  ? ""
                                                  : xmodul[index]
                                                      .statusLevel,
                                              overflow:
                                                  TextOverflow.fade,
                                              maxLines: 2,
                                              softWrap: false,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Text(
                                              xmodul[index]
                                                          .namaPerusahaan ==
                                                      null
                                                  ? ""
                                                  : xmodul[index]
                                                      .namaPerusahaan,
                                              overflow: TextOverflow.fade,
                                              maxLines: 2,
                                              softWrap: false,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.play_circle_fill_rounded, size: 24, color: Colors.grey,),
                                                Text(" ${xmodul[index].accessCount.toString()} Akses"),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, right: 12.0),
                                      child: xmodul[index].aktif == '0' ?
                                      Container(
                                        width: MediaQuery.of(context)
                                            .size
                                            .width,
                                        child: AbsorbPointer(
                                          absorbing: true, // by default is true
                                          child: MaterialButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                            ),
                                            onPressed: (){
                                              print('pending to implement onPressed function');
                                            },
                                            child: Text("Terkunci"),
                                          ),
                                        ),
                                      ) :
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width,
                                          child: MaterialButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            color:
                                            xmodul[index].statusSelesai == 'Selesai'
                                                ? mainColor
                                                : Colors.orange,
                                            onPressed: () {
                                              xmodul[index].statusActivasi == 'public' || xmodul[index].statusSelesai == 'Selesai' || xmodul[index].statusSelesai == 'Lanjutkan'
                                                  ? Navigator.of(context)
                                                  .push(new MaterialPageRoute(
                                                builder: (BuildContext context) =>
                                                    UI_Modul(
                                                      kodelearning: xmodul[index].codeGenerate,
                                                      kodeReferral: xmodul[index].kodeReferral,
                                                      namaLearning: xmodul[index].kategori,
                                                    ),
                                              ))
                                                  :
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext context){
                                                    return AlertDialog(
                                                      title: Text("Masukkan password ?") ,
                                                      content: Form(
                                                        key: _formKey,
                                                        child: TextFormField(
                                                          keyboardType: TextInputType.text,
                                                          controller: kodePassword,
                                                            validator: (String value){
                                                              if (value.isEmpty) {
                                                                return 'Enter some text';
                                                              }else{
                                                                if(value == xmodul[index].codeGenerate){
                                                                  Navigator.of(context)
                                                                      .push(new MaterialPageRoute(
                                                                    builder: (BuildContext context) =>
                                                                        UI_Modul(
                                                                          kodelearning: xmodul[index].codeGenerate,
                                                                          kodeReferral: xmodul[index].kodeReferral,
                                                                          namaLearning: xmodul[index].kategori,
                                                                        ),
                                                                  ));
                                                                }else{
                                                                  return 'Kode salah';
                                                                }
                                                              }
                                                              return null;
                                                            },
                                                          //validator: nameValidator,
                                                          // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                                                          // onSaved: (value) {
                                                          //   // name = value;
                                                          // },
                                                        ),
                                                      ),
                                                      actions: <Widget>[
                                                        MaterialButton(
                                                          onPressed: (){
                                                            if (_formKey.currentState.validate()) {}
                                                            return false;
                                                            //Navigator.push(context,MaterialPageRoute (builder:(context)=>Myhome()));
                                                            // simpan_lowongan()
                                                            //print(id_user);
                                                          },
                                                          child: Text("Ya"),
                                                        ),
                                                      ],
                                                    );
                                                  }
                                              );
                                            },
                                            child: Text(
                                              xmodul[index].statusSelesai ==
                                                      null
                                                  ? ""
                                                  : xmodul[index]
                                                      .statusSelesai,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                      },
                    ),
                )
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator
              .of(context)
              .push(new MaterialPageRoute(builder: (BuildContext context) => Katalog(email: globalEmail)));
        },
        label: Text('Katalog'),
        icon: Icon(Icons.settings),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
