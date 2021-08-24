import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaweid2/constant/constant.dart';
import 'package:gaweid2/modules/user/models/Model_Profile2.dart';
import 'package:gaweid2/modules/user/models/model_pengalamankerja.dart';
import 'package:gaweid2/modules/user/models/model_profile3.dart';
import 'package:gaweid2/model/user/ModelLowongan.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/user/view/Login.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:http/http.dart' as http;

import 'package:http/http.dart' as http;

class AkunUser2 extends StatefulWidget {
  @override
  _AkunUser2State createState() => _AkunUser2State();
}

enum LoginStatus { not_login, Login }

class _AkunUser2State extends State<AkunUser2> {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  String name, email, password1, confrim_password;
  var globalName = "", globalEmail = "", globalLevel = "";
  LoginStatus _loginStatus = LoginStatus.not_login;
  var status = false;
  var id_user, globalid_employee;
//  var value;
  var mystatus;



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
//        print("status${mystatus}");
//        print("fullname${globalName}");
//        print("email${globalEmail}");
        print("globalid_employee $globalid_employee");
        //_loginStatus = mystatus == true ? LoginStatus.Login : LoginStatus.not_login;
      });
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setBool("status", false);
      preferences.clear();
      preferences.commit();
      _loginStatus = LoginStatus.not_login;
      Navigator.of(context).pushNamedAndRemoveUntil(HOMEPAGE, (route) => false);
    });
  }

  BaseEndPoint network = NetworkProvider();

  String no_hp,
      tgl_lahir,
      universitas,
      picture,
      profile_power,
      tahun_keluar,
      ipk,
      tahun_masuk,
      kota,
      nik,
      nohp,
      no_wa,
      mingaji,
      maxgaji,
      alamatktp,
      alamatdomisli,
      jurusan,tgl_lahir2,nama,
      pendidikan;

  var loading = false;

  //pengalmaan kerja





  Future<List> search() async {
    final response = await http.post(
        NetworkConfig().baseUrl + "apps/pengalaman_kerja",
        body: {
          'employee_id': globalid_employee,
        });

    ModelPengalamankerja listdata = modelPengalamankerjaFromJson(response.body);

    print("listadata${listdata}");
    if (response.statusCode == 200) {
      // print("get data succeessfully");
    } else {
      //print("Get Data Failed");
    }

    return listdata.pengalaman;
  }

  List<ModelProfile3> profile3 = [];


  Future<Null> getProfile3(String employee_id) async {
    setState(() {
      loading = true;
    });
    final response = await http.post(
        NetworkConfig().baseUrl + "apps/profile",
        body: {
          'employee_id': employee_id,
        });


    if(response.statusCode==200){
      final data = jsonDecode(response.body);
      // print(data);
      setState(() {
        for(Map i in data){
          profile3.add(ModelProfile3.fromJson(i));
        }
      });
    }

  }

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
      tgl_lahir =
      sample.tglLahir.toString() == null ? "" : sample.tglLahir.toString();
      tgl_lahir2 =
      sample.tglLahir2.toString() == null ? "" : sample.tglLahir2.toString();
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
    });
  }



  File image;
  accessCamera() async {
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img == null) {
      print('null');
    } else {
      setState(() {
        image = img;
        uploadimg();
      });
    }
  }

  accessGallery() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (img == null) {
      print('null');
    } else {
      setState(() {
        image = img;
        uploadimg();



      });
    }
  }

  void uploadimg(){

    network.gantipp(globalEmail,image,context);


  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // login();
    getProfile(globalid_employee);
    getPreferences();
    getProfile3(globalid_employee);
  }

  @override
  Widget build(BuildContext context) {
    getProfile(globalid_employee);
    getProfile3(globalid_employee);

    print("globalid${globalid_employee}");

    // ModelProfile data = network.akun(globalid_employee);
//    print("tesakun${mystatus}");
//    print("tesakun${globalName}");
//    print("tesakun${globalEmail}");
//    print("id_userakun${id_user}");

    if (mystatus == true) {
      return Scaffold(
          backgroundColor: Colors.white,

          body: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              final xprofile = profile3[index];

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Image.asset(
                        "images/kategori/akun_bg.png",
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        //top: 120,
                        //left: 155,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Card(
                                elevation: 18.0,
                                shape: CircleBorder(),
                                clipBehavior: Clip.antiAlias,

//                                child: CircleAvatar(
//                                  radius: 55,
//                                  backgroundColor: Color(0xffFDCF09),
//                                  child: CircleAvatar(
//                                    radius: 50,
//                                    backgroundImage: NetworkImage(picture == null ? "" : picture),
//                                  ),
//                                ),
                                child:  image == null
                                    ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FlatButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Upload Profil"),
                                                content: Container(
                                                  height:
                                                  MediaQuery.of(context).size.height / 4,
                                                  width:
                                                  MediaQuery.of(context).size.width / 4,
                                                  child: Column(
                                                    children: <Widget>[
                                                      FlatButton(
                                                        onPressed: () {
                                                          accessGallery();
                                                        },
                                                        child: Row(
                                                          children: <Widget>[
                                                            Icon(Icons.image),
                                                            Text("Select From Gallery"),
                                                          ],
                                                        ),
                                                      ),
                                                      FlatButton(
                                                        onPressed: () {
                                                          accessCamera();
                                                        },
                                                        child: Row(
                                                          children: <Widget>[
                                                            Icon(Icons.camera),
                                                            Text("Select From Camera"),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      child: CircleAvatar(
                                        radius: 55,
                                        backgroundColor: Color(0xffFDCF09),
                                        child: CircleAvatar(
                                          radius: 50,
                                          backgroundImage: NetworkImage(
                                              xprofile.picture == null ? "" : xprofile.picture),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                    : Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FlatButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Upload Profil"),
                                                content: Container(
                                                  height:
                                                  MediaQuery.of(context).size.height / 4,
                                                  width:
                                                  MediaQuery.of(context).size.width / 4,
                                                  child: Column(
                                                    children: <Widget>[
                                                      FlatButton(
                                                        onPressed: () {
                                                          accessGallery();
                                                        },
                                                        child: Row(
                                                          children: <Widget>[
                                                            Icon(Icons.image),
                                                            Text("Select From Gallery"),
                                                          ],
                                                        ),
                                                      ),
                                                      FlatButton(
                                                        onPressed: () {
                                                          accessCamera();
                                                        },
                                                        child: Row(
                                                          children: <Widget>[
                                                            Icon(Icons.camera),
                                                            Text("Select From Camera"),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      child: Center(
                                        child: Container(
                                          margin: EdgeInsets.all(2),
                                          child: Image.file(
                                            image,
                                            height: MediaQuery.of(context).size.height / 7,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),


                              ),

//                              IconButton(
//                                icon: Icon(Icons.edit),
//                              ),


                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    xprofile.nama == null
                                        ? ""
                                        : xprofile.nama,
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
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
//                                      Navigator.push(
//                                          context,
//                                          MaterialPageRoute(
//                                              builder: (context) =>
//                                              (datadiriakun(
//                                                name: xprofile.nama == null
//                                                    ? ""
//                                                    : xprofile.nama,
//                                                email: globalEmail == null
//                                                    ? ""
//                                                    : globalEmail,
//                                                kota: kota == null
//                                                    ? ""
//                                                    : kota,
//                                                tgl_lahir: tgl_lahir2 == null
//                                                    ? ""
//                                                    : tgl_lahir2,
//                                                picture: picture == null
//                                                    ? ""
//                                                    : picture,
//                                              ))));
                                    },
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                globalEmail,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    xprofile.cityId == null ? "" : xprofile.cityId,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                  Text(" "),
                                  Text(xprofile.tglLahir == null ? "" : xprofile.tglLahir),
                                  Text(
                                    "",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
//                              Center(
//                                child: LinearPercentIndicator(
//                                  width:
//                                  MediaQuery.of(context).size.width / 1.1,
//                                  lineHeight: 18.0,
//                                  percent: xprofile.profilePower == null
//                                      ? 1.0
//                                      : int.parse(xprofile.profilePower) / 100,
//                                  backgroundColor: Colors.grey,
//                                  progressColor: Colors.blue,
//                                  center: Text(
//                                    "${xprofile.profilePower == null ? "" : xprofile.profilePower}%",
//                                    style: new TextStyle(
//                                        fontSize: 16.0, color: Colors.white),
//                                  ),
//                                ),
//                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    RaisedButton(
                                      onPressed: () {
                                        signOut();
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.exit_to_app),
                                          Text('Logout',
                                              style: TextStyle(fontSize: 18)),
                                        ],
                                      ),
                                      color: Colors.blueAccent,
                                      textColor: Colors.white,
                                      elevation: 5,
                                    ),
                                    Text(" "),
//                                    RaisedButton(
//                                      onPressed: () {
//                                        signOut();
//                                      },
//                                      child: Row(
//                                        mainAxisAlignment:
//                                            MainAxisAlignment.center,
//                                        children: <Widget>[
//                                          Icon(Icons.edit),
//                                          Text('Profile',
//                                              style: TextStyle(fontSize: 18)),
//                                        ],
//                                      ),
//                                      color: Colors.lightBlue,
//                                      textColor: Colors.white,
//                                      elevation: 5,
//                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Datadiri",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward),
                            onPressed: () {
//                              Navigator.push(
//                                  context,
//                                  MaterialPageRoute(
//                                      builder: (context) => (datadiri2akun(
//                                        nik: nik == null ? "" : nik,
//                                        nohp: no_hp == null ? "" : no_hp,
//                                        nowa: no_wa == null ? "" : no_hp,
//                                        alamatdomisili:
//                                        alamatdomisli == null
//                                            ? ""
//                                            : alamatdomisli,
//                                      ))));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Text(xprofile.pengalamanKerja[index].namaPerusahaan),
                        ],
                      ),
                    ),
                  )
                ],


              );
            }
          ));


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
}
