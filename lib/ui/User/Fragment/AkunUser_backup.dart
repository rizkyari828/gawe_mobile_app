import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/constant/constant.dart';
import 'package:gaweid2/modules/user/models/ModelLogin.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';

import 'package:gaweid2/modules/user/models/ModelUser.dart';
import 'package:gaweid2/modules/user/models/Model_Profile2.dart';
import 'package:gaweid2/model/dw/model_check_dw.dart';
import 'package:gaweid2/modules/user/models/model_pengalaman_org.dart';
import 'package:gaweid2/modules/user/models/model_pengalamankerja.dart';
import 'package:gaweid2/modules/user/models/model_profile3.dart';

import 'package:gaweid2/model/user/ModelLowongan.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/ui/DW/scan/demo_offline.dart';
import 'package:gaweid2/ui/DW/scan/scan_barcode.dart';
import 'package:gaweid2/modules/user/view/Login.dart';
import 'package:gaweid2/modules/user/view/editAkun/PengalamanKerja.dart';
import 'package:gaweid2/modules/user/view/editAkun/PengalamanOrganisasi.dart';
import 'package:gaweid2/modules/user/view/editAkun/TambahPengalaman_org.dart';
import 'package:gaweid2/modules/user/view/editAkun/TambahPengalamankerja.dart';
import 'package:gaweid2/modules/user/view/editAkun/datadiri2akun.dart';
import 'package:gaweid2/modules/user/view/editAkun/datadiriakun.dart';
import 'package:gaweid2/modules/user/view/editAkun/gantipassaword.dart';
import 'package:gaweid2/modules/user/view/editAkun/pendidikan.dart';
import 'package:gaweid2/modules/user/view/editAkun/resume.dart';
import 'package:gaweid2/modules/user/view/menu/UserDashboard.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:image/image.dart' as Img;
import 'package:path_provider/path_provider.dart';

class AkunUser extends StatefulWidget {
  @override
  _AkunUserState createState() => _AkunUserState();
}

enum LoginStatus { not_login, Login }

class _AkunUserState extends State<AkunUser> {
  String position;

  //List<Wisata> potsList = [];
  double nLat = -6.307612065268697;
  double nLong = 106.8271279335022;
  LatLng myPostion;
  CameraPosition _kGooglePlex;
  dynamic gab;

  Completer<GoogleMapController> _controller = Completer();

  final Set<Marker> _markers = {};

  // get Current Location
  void getCurrentLocation() async {
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    try {
      setState(() {
        nLat = currentLocation.latitude;
        nLong = currentLocation.longitude;
        myPostion = LatLng(nLat, nLong);
        print("Lat : ${currentLocation.latitude}");
        print("Lon : ${currentLocation.longitude}");

        ///
        // Next Function add to marker
        mapsCamera();
      });
    } on Exception {
      print("Null");
    }
  }

  // Set Camera
  void mapsCamera() {
    LatLng _center = LatLng(nLat, nLong);
    LatLng _lastPosition = _center;
    _kGooglePlex = CameraPosition(target: LatLng(nLat, nLong), zoom: 14.4746);
    final CameraPosition _kLake = CameraPosition(
        bearing: 30,
        target: LatLng(nLat, nLong),
        tilt: 59.440717697143555,
        zoom: 16);
    _goToTheLake(_kLake);
    _onAddMarkerButtonPressed(_lastPosition);
  }

  Future<void> _goToTheLake(CameraPosition _kLake) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  void _onAddMarkerButtonPressed(LatLng lastPosition) {
    setState(() {
      _markers.add(Marker(
        //This marker id can be anything that uniquely identifier each marker.
        markerId: MarkerId(lastPosition.toString()),
        position: lastPosition,
      ));
    });
  }

  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  String name, email, password1, confrim_password;
  var globalName = "", globalEmail = "", globalLevel = "";
  LoginStatus _loginStatus = LoginStatus.not_login;
  var status = false;
  var id_user, globalid_employee;

//  var value;
  var mystatus;
  var InSignIn = false;

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
        print("globalid_employee $globalid_employee");
        //_loginStatus = mystatus == true ? LoginStatus.Login : LoginStatus.not_login;
      });
    });
  }

  TextEditingController ettariksaldo = TextEditingController();

  bool status_check = false;
  bool status_check_lembur = false;
  bool status_check_total_saldo = false;
  bool status_check_reguler = false;

  // String saldo, saldo_reguler2, saldo_lembur2, ettariksaldo2;
  // Future check_saldo(String id_employee) async {
  //   final response =
  //       await http.post(NetworkConfig().baseUrl + "apps/total_saldo", body: {
  //     'id_employee': id_employee,
  //   });
  //   ModelCheckDw listData = modelCheckDwFromJson(response.body);
  //
  //   if (listData.status == 200) {
  //     // print('Sudah TTD');
  //     print("berhasil");
  //     setState(() {
  //       status_check_total_saldo = true;
  //       saldo = listData.id.toString();
  //     });
  //   } else {
  //     // print("gagal");
  //     setState(() {
  //       status_check_total_saldo = false;
  //       saldo = listData.id.toString();
  //     });
  //   }
  // }
  //
  // Future saldo_reguler(String id_employee) async {
  //   final response =
  //       await http.post(NetworkConfig().baseUrl + "apps/saldo_reguler", body: {
  //     'id_employee': id_employee,
  //   });
  //   ModelCheckDw listData = modelCheckDwFromJson(response.body);
  //
  //   if (listData.status == 200) {
  //     // print('Sudah TTD');
  //     print("berhasil");
  //     setState(() {
  //       status_check_reguler = true;
  //       saldo_reguler2 = listData.id.toString();
  //     });
  //   } else {
  //     // print("gagal");
  //     setState(() {
  //       status_check_reguler = false;
  //       saldo_reguler2 = listData.id.toString();
  //     });
  //   }
  // }
  //
  // Future saldo_lembur(String id_employee) async {
  //   final response =
  //       await http.post(NetworkConfig().baseUrl + "apps/saldo_lembur", body: {
  //     'id_employee': id_employee,
  //   });
  //   ModelCheckDw listData = modelCheckDwFromJson(response.body);
  //
  //   if (listData.status == 200) {
  //     // print('Sudah TTD');
  //     print("berhasil");
  //     setState(() {
  //       status_check_lembur = true;
  //       saldo_lembur2 = listData.id.toString();
  //     });
  //   } else if (listData.status == 404) {
  //     print("berhasil");
  //     setState(() {
  //       status_check_lembur = false;
  //       saldo_lembur2 = listData.id.toString();
  //     });
  //   } else {
  //     // print("gagal");
  //     setState(() {
  //       status_check = false;
  //       saldo_lembur2 = listData.id.toString();
  //     });
  //   }
  // }

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
      province_lahir,
      no_kk;

  var loading = false;

  //pengalmaan kerja

  // List<ModelPengalamankerja> pengalaman = [];
  Future<List> pengalamankerja() async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/pengalaman_kerja", body: {
      'employee_id': globalid_employee,
    });

    ModelPengalamankerja listdata = modelPengalamankerjaFromJson(response.body);

    // print("listadata${listdata.pengalaman}");
    if (response.statusCode == 200) {
      // print("get data succeessfully");
    } else {
      //print("Get Data Failed");
    }

    return listdata.pengalaman;
  }

  Future<List> pengalamanorg() async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/pengalaman_organisasi", body: {
      'employee_id': globalid_employee,
    });

    ModelPengalamanOrg listdata = modelPengalamanOrgFromJson(response.body);

    // print("listadata${listdata.pengalaman}");
    if (response.statusCode == 200) {
      // print("get data succeessfully");
    } else {
      //print("Get Data Failed");
    }

    return listdata.pengalamanOrg;
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
      no_kk = sample.no_kk.toString();
    });
  }

  var loading_foto = false;

  File image, image_save;
  TextEditingController ctitle = new TextEditingController();

  accessCamera() async {
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    final title = ctitle.text;

    Img.Image _image = Img.decodeImage(img.readAsBytesSync());
    Img.Image _smallerimg = Img.copyResize(_image,
        width: 300, height: 300, interpolation: Img.Interpolation.linear);

    final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();

    var compressImg = new File("$path/image_${currentTime}${globalName}.jpg")
      ..writeAsBytesSync(Img.encodeJpg(_smallerimg, quality: 70));

    if (img == null) {
      print('null');
    } else {
      setState(() {
        image = img;
        image_save = compressImg;
        uploadimg();
      });
      Navigator.pop(context);
    }
  }

  accessGallery() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    final title = ctitle.text;

    Img.Image _image = Img.decodeImage(img.readAsBytesSync());
    Img.Image _smallerimg = Img.copyResize(_image,
        width: 500, height: 500, interpolation: Img.Interpolation.linear);

    final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();

    var compressImg = new File("$path/image_${currentTime}${globalName}.jpg")
      ..writeAsBytesSync(Img.encodeJpg(_smallerimg, quality: 70));

    if (img == null) {
      print('null');
    } else {
      setState(() {
        image = img;
        image_save = compressImg;
        uploadimg();
      });
      Navigator.pop(context);
    }
  }

  void uploadimg() {
    setState(() {
      loading_foto = true;
    });
    network.gantipp(globalEmail, image_save, context);
    setState(() {
      loading_foto = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // login();
    getProfile(globalid_employee);
    getPreferences();
    pengalamankerja();

    _kGooglePlex = CameraPosition(target: LatLng(nLat, nLong), zoom: 14.4746);
    getCurrentLocation();

    // getProfile3();
  }

  @override
  Widget build(BuildContext context) {
    getProfile(globalid_employee);
    // check_saldo(globalid_employee.toString());
    // saldo_lembur(globalid_employee.toString());
    // saldo_reguler(globalid_employee.toString());

//     print("saldo${saldo}");

    if (mystatus == true) {
      return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
//          appBar: AppBar(
//            title: Text('Akun'),
//          ),
            body: ListView(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Image.asset(
                          "images/slider/bckg_akun.png",
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 10.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FlatButton(
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        new MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                UserDashboard()));
                                  },
                                ),
                              ),
                            ],
                          ),
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
                                  child: loading_foto
                                      ? SpinKitFadingCircle(
                                          color: Colors.redAccent,
                                        )
                                      : image == null
                                          ? Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: FlatButton(
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                                "Upload Profil"),
                                                            content: Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  4,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  4,
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  FlatButton(
                                                                    onPressed:
                                                                        () {
                                                                      accessGallery();
                                                                    },
                                                                    child: Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Icon(Icons
                                                                            .image),
                                                                        Text(
                                                                            "Select From Gallery"),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  FlatButton(
                                                                    onPressed:
                                                                        () {
                                                                      accessCamera();
                                                                    },
                                                                    child: Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Icon(Icons
                                                                            .camera),
                                                                        Text(
                                                                            "Select From Camera"),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    child: InSignIn
                                                                        ? SpinKitFadingCircle(
                                                                            color:
                                                                                Colors.redAccent,
                                                                          )
                                                                        : null,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 50,
                                                    backgroundImage:
                                                        NetworkImage(
                                                            picture == null
                                                                ? ""
                                                                : picture),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: FlatButton(
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                                "Upload Profil"),
                                                            content: Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  4,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  4,
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  FlatButton(
                                                                    onPressed:
                                                                        () {
                                                                      accessGallery();
                                                                    },
                                                                    child: Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Icon(Icons
                                                                            .image),
                                                                        Text(
                                                                            "Select From Gallery"),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  FlatButton(
                                                                    onPressed:
                                                                        () {
                                                                      accessCamera();
                                                                    },
                                                                    child: Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Icon(Icons
                                                                            .camera),
                                                                        Text(
                                                                            "Select From Camera"),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    child: InSignIn
                                                                        ? SpinKitFadingCircle(
                                                                            color:
                                                                                Colors.redAccent,
                                                                          )
                                                                        : null,
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
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            7,
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
                    Visibility(
                      visible: status_check_total_saldo,
                      child: FlatButton(
                        onPressed: () {
                          // tariksaldo();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 4,
                                child: Container(
                                  margin: const EdgeInsets.all(5.0),
                                  padding: const EdgeInsets.all(3.0),
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 2)),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Saldo Anda",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      // Text('Rp.${saldo}'),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Visibility(
                            visible: status_check_reguler,
                            child: FlatButton(
                              onPressed: () {
                                //tariksaldo();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Card(
                                      elevation: 4,
                                      child: Container(
                                        margin: const EdgeInsets.all(5.0),
                                        padding: const EdgeInsets.all(3.0),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black, width: 2)),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "Saldo Reguler",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            // Text('Rp.${saldo_reguler2}'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Visibility(
                            visible: status_check_lembur,
                            child: FlatButton(
                              onPressed: () {
                                //tariksaldo();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Card(
                                      elevation: 4,
                                      child: Container(
                                        margin: const EdgeInsets.all(5.0),
                                        padding: const EdgeInsets.all(3.0),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black, width: 2)),
                                        child: Expanded(
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                "Saldo Lembur",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              // Text('Rp.${saldo_lembur2}'),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
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
                                      nama == null ? "" : nama,
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
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    (datadiriakun(
                                                      name: nama == null
                                                          ? ""
                                                          : nama,
                                                      email: globalEmail == null
                                                          ? ""
                                                          : globalEmail,
                                                      kota: tmplahir == null
                                                          ? ""
                                                          : tmplahir,
                                                      tgl_lahir:
                                                          tgl_lahir2 == null
                                                              ? ""
                                                              : tgl_lahir2,
                                                      picture: picture == null
                                                          ? ""
                                                          : picture,
                                                      province_lahir:
                                                          province_lahir == null
                                                              ? ""
                                                              : province_lahir,
                                                    ))));
                                      },
                                    ),
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
                                      tmplahir == null ? "" : tmplahir,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                    Text(" "),
                                    Text(tgl_lahir == null ? "" : tgl_lahir),
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
//                                      MediaQuery.of(context).size.width / 1.1,
//                                  lineHeight: 18.0,
//                                  percent: profile_power == null
//                                      ? 1.0
//                                      : int.parse(profile_power) / 100,
//                                  backgroundColor: Colors.grey,
//                                  progressColor: Colors.blue,
//                                  center: Text(
//                                    "${profile_power == null ? "" : profile_power}%",
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
                                        color: mainColor,
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
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(
                                    Icons.person_pin,
                                    color: Colors.grey,
                                    size: 36,
                                  ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Data Diri",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                    // Text(
                                    //   "Kekuatan Profil  ${profile_power == null ? "" : profile_power}%",
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.w600,
                                    //       fontSize: 12),
                                    // ),
                                  ],
                                ),
                                Flexible(
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        side: BorderSide(
                                            color: Colors.blueAccent)),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => (Resume(
                                                    ktp: ktp == null ? "" : ktp,
                                                    cv: cv == null ? "" : cv,
                                                    kk: kk == null ? "" : kk,
                                                    bk: bk == null ? "" : bk,
                                                    ijazah: ijazah == null
                                                        ? ""
                                                        : ijazah,
                                                  ))));
                                    },
                                    child: Text('Upload Dokumen',
                                        style: TextStyle(fontSize: 10)),
                                    color: mainColor,
                                    textColor: Colors.white,
                                    elevation: 5,
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  "[Edit]",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                (datadiri2akun(
                                                  nik: nik == null ? "" : nik,
                                                  nohp:
                                                      nohp == null ? "" : nohp,
                                                  nowa: no_wa == null
                                                      ? ""
                                                      : no_wa,
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
                                                  agama: agama == null
                                                      ? ""
                                                      : agama,
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
                                                  kota:
                                                      kota == null ? "" : kota,
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
                                                  no_kk: no_kk == null
                                                      ? ""
                                                      : no_kk,
                                                ))));
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'NIK',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      nik == null ? "" : nik,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      'No KK',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      no_kk == null ? "" : no_kk,
                                    ),
                                  ],
                                ),

                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'No Handphone',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      no_wa == null ? "" : no_wa,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      'No Whatsapp',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      nohp == null ? "" : nohp,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Provinsi',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      provinsi == null ? "" : provinsi,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      'Kota',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      kota == null ? "" : kota,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Kepemilikan Kendaraan',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      kepemilikan_kendaraan == null
                                          ? ""
                                          : kepemilikan_kendaraan,
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        'Kepemilikan sim',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        kepemilikan_sim == null
                                            ? ""
                                            : kepemilikan_sim,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Min Gaji',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      mingaji == null ? "" : mingaji,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      'Max Gaji',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      maxgaji == null ? "" : maxgaji,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Agama',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      agama == null ? "" : agama,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      'Kodepos',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      kodepos == null ? "" : kodepos,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Gender',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      gender == null ? "" : gender,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      'Status perkawinan',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      status_perkawinan == null
                                          ? ""
                                          : status_perkawinan,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Sumber',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      sumber == null ? "" : sumber,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      'Sistem Operasi',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      os == null ? "" : os,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Instagram',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      instagram == null ? "" : instagram,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      'Facebook',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      fb == null ? "" : fb,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Twitter',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      twitter == null ? "" : twitter,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      'Linkedin',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      linkedin == null ? "" : linkedin,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Nama Keluarga',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      nama_keluarga == null
                                          ? ""
                                          : nama_keluarga,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      'Hubungan Keluarga',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      hubungan_keluarga == null
                                          ? ""
                                          : hubungan_keluarga,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Nama Bank',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      nama_bank == null ? "" : nama_bank,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      'No Rekening',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      no_rek == null ? "" : no_rek,
                                    ),
                                  ],
                                ),

                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Alamat Domisili',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        alamatdomisli == null
                                            ? ""
                                            : alamatdomisli,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        'Alamat KTP',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        alamatktp == null ? "" : alamatktp,
                                      ),
                                    ],
                                  ),
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
                    Card(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(Icons.school),
                                Text(
                                  "Pendidikan",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                IconButton(
                                  icon: Icon(Icons.mode_edit),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                (Pendidikan_Edit(
                                                  universitas:
                                                      universitas == null
                                                          ? ""
                                                          : universitas,
                                                  ipk: ipk == null ? "" : ipk,
                                                  tahun_masuk:
                                                      tahun_masuk == null
                                                          ? ""
                                                          : tahun_masuk,
                                                  tahun_keluar:
                                                      tahun_keluar == null
                                                          ? ""
                                                          : tahun_keluar,
                                                  jurusan: jurusan == null
                                                      ? ""
                                                      : jurusan,
                                                  pendidikan: pendidikan == null
                                                      ? ""
                                                      : pendidikan,
//
                                                ))));
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Universitas',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      universitas == null ? "" : universitas,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      'Pendidikan',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      pendidikan == null ? "" : pendidikan,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'jurusan',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      jurusan == null ? "" : jurusan,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      'Nilai',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      ipk == null ? "" : ipk,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Tahun Masuk',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      tahun_masuk == null ? "" : tahun_masuk,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      'Tahun Keluar',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      tahun_keluar == null ? "" : tahun_keluar,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Ganti Password",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_forward),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            (Gantipassword())));
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(Icons.work),
                                Text(
                                  "Work Experience",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                (Tambahpengalamankerja())));
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    LimitedBox(
                      maxHeight: 200.0,
                      child: FutureBuilder(
                        future: pengalamankerja(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          // print("snap${snapshot.hasData}");
                          return snapshot.hasData
                              ? ItemList(list: snapshot.data)
                              : Center(
                                  child: CircularProgressIndicator(),
                                );
                        },
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(Icons.group),
                            Text(
                              "Pengalaman Organisasi",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            (TambahPengalamanOrganisasi())));
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    LimitedBox(
                      maxHeight: 200.0,
                      child: FutureBuilder(
                        future: pengalamanorg(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          //  print("snap${snapshot.hasData}");
                          return snapshot.hasData
                              ? ItemListOrg(list: snapshot.data)
                              : Center(
                                  child: CircularProgressIndicator(),
                                );
                        },
                      ),
                    ),
                    // Card(
                    //   margin: EdgeInsets.all(20),
                    //   child: Container(
                    //     child: Column(
                    //       children: <Widget>[
                    //         Padding(
                    //           padding: const EdgeInsets.all(8.0),
                    //           child: Center(
                    //               child: Text(
                    //             "Posisi Anda Saat ini",
                    //             style: TextStyle(fontWeight: FontWeight.bold),
                    //           )),
                    //         ),
                    //         Padding(
                    //           padding: const EdgeInsets.all(12),
                    //         ),
                    //         Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: <Widget>[
                    //             Column(
                    //               crossAxisAlignment:
                    //                   CrossAxisAlignment.stretch,
                    //               children: <Widget>[
                    //                 Container(
                    //                   height: 250,
                    //                   width: MediaQuery.of(context).size.width,
                    //                   child: GoogleMap(
                    //                       mapType: MapType.normal,
                    //                       initialCameraPosition:
                    //                           _kGooglePlex == null
                    //                               ? ""
                    //                               : _kGooglePlex,
                    //                       markers: _markers,
                    //                       onMapCreated:
                    //                           (GoogleMapController controller) {
                    //                         _controller.complete(controller);
                    //                         _onAddMarkerButtonPressed(
                    //                             myPostion);
                    //                       }),
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ],
            )),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FlatButton(
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          UserDashboard()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    'images/kategori/BelumLogin.png',
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Text(
                    'Silahkan anda login terlebih dahulu',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => (Login())));
                        },
                        color: mainColor,
                        child: Text("Login",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      );
    }
  }

  final _formKey = GlobalKey<FormState>();

  void tariksaldo() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Tarik saldo",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            content: Container(
              height: 200,
              width: 50,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 16),
                    Row(children: <Widget>[
                      Text("Tarik saldo"),
                      Text(
                        "*",
                        style: TextStyle(color: Colors.red),
                      )
                    ]),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: ettariksaldo,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Tarik saldo",
                        hintText: "Tarik saldo",
                      ),
                      // validator: nikvalidator,
                      validator: (value) =>
                          value.length < 4 ? 'Harus Lebih dari 4 angka.' : null,
                      onSaved: (value) {
                        // ettariksaldo2 = value;
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: InSignIn
                          ? SpinKitFadingCircle(
                              color: Colors.blue,
                            )
                          : RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              onPressed: () {
                                validasi();
                              },
                              color: Colors.green,
                              child: Text("Pengajuan Saldo",
                                  style: TextStyle(color: Colors.white)),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void validasi() async {
    if (_formKey.currentState.validate()) {
      //JIKA TRUE
      _formKey.currentState.save(); //MAKA FUNGSI SAVE() DIJALANKAN

      ModelRegister data = await network.tariksaldo(
          globalid_employee, ettariksaldo.text.toString());

      setState(() {
        InSignIn = true;
      });

      if (data.status == 200) {
        Navigator.pop(context);
        Toast.show("Pengajuan Pencairan Berhasil Dikirim", context,
            duration: 3, gravity: Toast.BOTTOM);
        setState(() {
          InSignIn = false;
        });
      } else {
        setState(() {
          InSignIn = false;
        });
        print("gagal");
        Toast.show("Gagal", context, duration: 3, gravity: Toast.BOTTOM);
      }
    }
    ;
  }
}

class ItemList extends StatelessWidget {
  List list;

  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 200.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (BuildContext context, int index) {
          final Pengalaman xpengalamankerja = list[index];

          //   print("pengalamankerja${xpengalamankerja.id}");

          if (xpengalamankerja.id == "0000") {
            return Center(
              child: Container(
                child: Center(
                    child: Text(
                  "Belum Memiliki Pengalaman",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(xpengalamankerja.posisi),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          xpengalamankerja.namaPerusahaan,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      xpengalamankerja.namaPerusahaan,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: Text(xpengalamankerja.posisi),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EdutPengalamanKerja(
                                                        id: xpengalamankerja
                                                                    .id ==
                                                                null
                                                            ? ""
                                                            : xpengalamankerja
                                                                .id,
                                                        namaPerusahaan: xpengalamankerja
                                                                    .namaPerusahaan ==
                                                                null
                                                            ? ""
                                                            : xpengalamankerja
                                                                .namaPerusahaan,
                                                        posisi: xpengalamankerja
                                                                    .posisi ==
                                                                null
                                                            ? ""
                                                            : xpengalamankerja
                                                                .posisi,
                                                        tglMulai: xpengalamankerja
                                                                    .tglMulai ==
                                                                null
                                                            ? ""
                                                            : xpengalamankerja
                                                                .tglMulai,
                                                        tglBerhenti: xpengalamankerja
                                                                    .tglBerhenti ==
                                                                null
                                                            ? ""
                                                            : xpengalamankerja
                                                                .tglBerhenti,
                                                        lokasi: xpengalamankerja
                                                                    .lokasi ==
                                                                null
                                                            ? ""
                                                            : xpengalamankerja
                                                                .lokasi,
                                                        gaji: xpengalamankerja
                                                                    .gaji ==
                                                                null
                                                            ? ""
                                                            : xpengalamankerja
                                                                .gaji,
                                                        industri: xpengalamankerja
                                                                    .industri ==
                                                                null
                                                            ? ""
                                                            : xpengalamankerja
                                                                .industri,
                                                        fungsiKerjaId: xpengalamankerja
                                                                    .fungsiKerjaId ==
                                                                null
                                                            ? ""
                                                            : xpengalamankerja
                                                                .fungsiKerjaId,
                                                        deskripsi: xpengalamankerja
                                                                    .deskripsiPekerjaan ==
                                                                null
                                                            ? ""
                                                            : xpengalamankerja
                                                                .deskripsiPekerjaan,
                                                        masihBekerja: xpengalamankerja
                                                                    .masihBekerja ==
                                                                null
                                                            ? ""
                                                            : xpengalamankerja
                                                                .masihBekerja,
                                                        jenjang_career_id:
                                                            xpengalamankerja
                                                                        .jenjang_career_id ==
                                                                    null
                                                                ? ""
                                                                : xpengalamankerja
                                                                    .jenjang_career_id,
                                                      )));
                                        },
                                        child: Text(
                                          "Edit",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        color: Colors.white,
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          hapus_pengalaman_kerja(
                                              xpengalamankerja.id, context);
                                        },
                                        child: Text(
                                          "Hapus",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        color: Colors.white,
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(xpengalamankerja.tglMulai),
                        Text(" S/d "),
                        Text(xpengalamankerja.tglBerhenti),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(xpengalamankerja.deskripsiPekerjaan),
                  ),
                  Divider(),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void hapus_pengalaman_kerja(String id, context) async {
    BaseEndPoint network = NetworkProvider();

    ModelRegister data = await network.hapus_pengalaman_kerja(id);
    if (data.status == 200) {
      Toast.show("Success", context, duration: 3, gravity: Toast.BOTTOM);
      Navigator.pop(context);
    } else {
      print("gagal");
      Toast.show("Gagal", context, duration: 3, gravity: Toast.BOTTOM);
      Navigator.pop(context);
    }
  }
}

class ItemListOrg extends StatelessWidget {
  List list;

  ItemListOrg({this.list});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 200.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (BuildContext context, int index) {
          final PengalamanOrg xpengalamankerja = list[index];

          //   print("pengalamankerja${xpengalamankerja.id}");

          if (xpengalamankerja.id == "0000") {
            return Center(
              child: Container(
                child: Center(
                    child: Text(
                  "Belum Memiliki Pengalaman Organisasi\n",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                )),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    xpengalamankerja.namaOrganisasi,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: Text(xpengalamankerja.jabatan),
                                  actions: <Widget>[
                                    FlatButton(
                                      onPressed: () {
                                        Toast.show(xpengalamankerja.id, context,
                                            duration: 4, gravity: Toast.BOTTOM);

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Edit_PengalamanOrganisasi(
                                                    id: xpengalamankerja.id == null
                                                        ? ""
                                                        : xpengalamankerja.id,
                                                    namaOrganisasi:
                                                        xpengalamankerja.id ==
                                                                null
                                                            ? ""
                                                            : xpengalamankerja
                                                                .namaOrganisasi,
                                                    jabatan:
                                                        xpengalamankerja.id ==
                                                                null
                                                            ? ""
                                                            : xpengalamankerja
                                                                .jabatan,
                                                    mulai: xpengalamankerja.id ==
                                                            null
                                                        ? ""
                                                        : xpengalamankerja
                                                            .mulai,
                                                    akhir: xpengalamankerja.id ==
                                                            null
                                                        ? ""
                                                        : xpengalamankerja
                                                            .akhir)));
                                      },
                                      child: Text(
                                        "Edit",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      color: Colors.white,
                                    ),
                                    FlatButton(
                                      onPressed: () {
                                        hapus_pengalaman_org(
                                            xpengalamankerja.id, context);
                                      },
                                      child: Text(
                                        "Hapus",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      color: Colors.white,
                                    ),
                                  ],
                                );
                              });
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Nama Organisasi',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              xpengalamankerja.namaOrganisasi == null
                                  ? ""
                                  : xpengalamankerja.namaOrganisasi,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'Jabatan',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              xpengalamankerja.jabatan == null
                                  ? ""
                                  : xpengalamankerja.jabatan,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Tahun Masuk',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              xpengalamankerja.mulai == null
                                  ? ""
                                  : xpengalamankerja.mulai,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'Tahun Keluar',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              xpengalamankerja.akhir == null
                                  ? ""
                                  : xpengalamankerja.akhir,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void hapus_pengalaman_org(String id, context) async {
    BaseEndPoint network = NetworkProvider();

    //Toast.show(id, context, duration: 3, gravity: Toast.BOTTOM);

    ModelRegister data = await network.hapus_pengalaman_org(id);
    if (data.status == 200) {
      Toast.show("Success", context, duration: 3, gravity: Toast.BOTTOM);
      Navigator.pop(context);
    } else {
      print("gagal");
      Toast.show("Gagal", context, duration: 3, gravity: Toast.BOTTOM);
      Navigator.pop(context);
    }
  }
}
