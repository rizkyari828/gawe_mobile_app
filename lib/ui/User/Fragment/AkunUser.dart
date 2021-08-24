import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/constant/constant.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/modules/user/models/Model_Profile2.dart';
import 'package:gaweid2/modules/user/models/model_pengalaman_org.dart';
import 'package:gaweid2/modules/user/models/model_pengalamankerja.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/user/view/Login.dart';
import 'package:gaweid2/modules/user/view/editAkun/PengalamanKerja.dart';
import 'package:gaweid2/modules/user/view/editAkun/PengalamanOrganisasi.dart';
import 'package:gaweid2/modules/user/view/editAkun//TambahPengalaman_org.dart';
import 'package:gaweid2/modules/user/view/editAkun/TambahPengalamankerja.dart';
import 'package:gaweid2/modules/user/view/editAkun/datadiri2akun.dart';
import 'package:gaweid2/modules/user/view/editAkun/datadiriakun.dart';
import 'package:gaweid2/modules/user/view/editAkun/gantipassaword.dart';
import 'package:gaweid2/modules/user/view/editAkun/pendidikan.dart';
import 'package:gaweid2/modules/user/view/editAkun/resume.dart';
import 'package:gaweid2/modules/user/view/menu/UserDashboard.dart';
import 'package:gaweid2/modules/maps/view/maps.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:image/image.dart' as Img;
import 'package:path_provider/path_provider.dart';

class AkunUser extends StatefulWidget {
  final String id_employee;

  AkunUser({this.id_employee});
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

  Future getProfile() async {
    loading = false;
    final jsonString =
        await http.post(NetworkConfig().baseUrl + "apps/profile", body: {
      'employee_id': widget.id_employee,
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
    getProfile();
    getPreferences();
    pengalamankerja();

    _kGooglePlex = CameraPosition(target: LatLng(nLat, nLong), zoom: 14.4746);
    getCurrentLocation();

    // getProfile3();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // getProfile(globalid_employee);
    if (mystatus == true) {
      return Scaffold(
        backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 30,),
                Card(
                  color: mainColor,
                  shape: RoundedRectangleBorder(side: BorderSide(
                      color: borderColor, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(30)
                      )),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          children: <Widget>[
                            MaterialButton(
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            UserDashboard()));
                              },

                            ),
                            Text('Profil', style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            loading_foto
                                ? SpinKitFadingCircle(
                              color: Colors.redAccent,
                            )
                                : image == null
                                ? Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top:20.0, bottom:20.0),
                                child: MaterialButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder:
                                            (BuildContext context) {
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
                                                children: <Widget>[
                                                  FlatButton(
                                                    onPressed: () {
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
                                                    onPressed: () {
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
                                                      color: Colors
                                                          .redAccent,
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
                                    radius: 25,
                                    backgroundImage: NetworkImage(
                                        picture == null ? "" : picture),
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
                                        builder:
                                            (BuildContext context) {
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
                                                children: <Widget>[
                                                  FlatButton(
                                                    onPressed: () {
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
                                                    onPressed: () {
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
                                                      color: Colors
                                                          .redAccent,
                                                    )
                                                        : null,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Card(
                                    elevation: 1,
                                    shape: CircleBorder(),
                                    child: Image.file(
                                      image,
                                      height: MediaQuery.of(context)
                                          .size
                                          .height /
                                          7,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  nama == null ? "" : nama,
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      globalEmail,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[

                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(left:10,right: 15),
                          child: Icon(
                            Icons.person_pin,
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          width:
                              MediaQuery.of(context).size.width / 2,
                          child: Text(
                            "Data Diri",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding:
                              const EdgeInsets.only(right: 15),
                              child: IconButton(
                                icon: Icon(Icons.arrow_forward_ios_rounded),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          (datadiri2akun(
                                            nama: nama == null
                                                ? ""
                                                : nama,
                                            nik: nik == null ? "" : nik,
                                            nohp: nohp == null
                                                ? ""
                                                : nohp,
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
                                            status_perkawinan ==
                                                null
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
                                            kota: kota == null
                                                ? ""
                                                : kota,
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
                                            hubungan_keluarga ==
                                                null
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
                                            tmpLahir: tmplahir == null
                                                ? ""
                                                : tmplahir,
                                            tgl_lahir:
                                            tgl_lahir == null
                                                ? ""
                                                : tgl_lahir,
                                            province_lahir:
                                            province_lahir == null
                                                ? ""
                                                : province_lahir,
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
                                            pendidikan:
                                            pendidikan == null
                                                ? ""
                                                : pendidikan,
//
                                          ))));
                                },
                              ),
                            ),
                          ),
                        ),
                      ]),
                      Divider(),
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(left:10, right: 15),
                          child: Icon(
                            Icons.file_copy_rounded,
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          width:
                          MediaQuery.of(context).size.width / 2,
                          child: Text(
                            "Upload Dokumen",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding:
                              const EdgeInsets.only(left:10,right: 15),
                              child: IconButton(
                                icon: Icon(Icons.arrow_forward_ios_rounded),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          (Resume(
                                            ktp: ktp == null
                                                ? ""
                                                : ktp,
                                            cv: cv == null
                                                ? ""
                                                : cv,
                                            kk: kk == null
                                                ? ""
                                                : kk,
                                            bk: bk == null
                                                ? ""
                                                : bk,
                                            ijazah: ijazah == null
                                                ? ""
                                                : ijazah,
                                          ))));
                                },
                              ),
                            ),
                          ),
                        ),
                      ]),
                      Divider(),
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(left:10,right: 15),
                          child: Icon(
                            Icons.school,
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          width:
                          MediaQuery.of(context).size.width / 2,
                          child: Text(
                            "Pendidikan",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding:
                              const EdgeInsets.only(left:10,right: 15),
                              child: IconButton(
                                icon: Icon(Icons.arrow_forward_ios_rounded),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          (Pendidikan_Edit(
                                            universitas:
                                            universitas ==
                                                null
                                                ? ""
                                                : universitas,
                                            ipk: ipk == null
                                                ? ""
                                                : ipk,
                                            tahun_masuk:
                                            tahun_masuk ==
                                                null
                                                ? ""
                                                : tahun_masuk,
                                            tahun_keluar:
                                            tahun_keluar ==
                                                null
                                                ? ""
                                                : tahun_keluar,
                                            jurusan:
                                            jurusan == null
                                                ? ""
                                                : jurusan,
                                            pendidikan:
                                            pendidikan ==
                                                null
                                                ? ""
                                                : pendidikan,
//
                                          ))));
                                },
                              ),
                            ),
                          ),
                        ),
                      ]),
                      Divider(),
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(left:10,right: 15),
                          child: Icon(
                            Icons.location_on_rounded,
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            "Lokasi",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(left:10,right: 15),
                              child: IconButton(
                                icon: Icon(Icons.arrow_forward_ios_rounded),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => (MapsHome(
                                            email: globalEmail,
                                            globalid_employee:
                                            globalid_employee,
                                          ))));
                                },
                              ),
                            ),
                          ),
                        ),
                      ]),
                      Divider(),
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(left:10,right: 15),
                          child: Icon(
                            Icons.vpn_key_rounded,
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            "Ganti Password",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(left:10,right: 15),
                              child: IconButton(
                                icon: Icon(Icons.arrow_forward),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          (Gantipassword())));
                                },
                              ),
                            ),
                          ),
                        ),
                      ]),
                      Divider(),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding:
                            const EdgeInsets.only(left:10, right: 15),
                            child: Icon(
                              Icons.work,
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            width:
                            MediaQuery.of(context).size.width /
                                2,
                            child: Text(
                              "Pengalaman Kerja",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left:15, right: 15),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.add,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            (Tambahpengalamankerja())));
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:10.0, right: 15),
                        child: Container(
                          child: LimitedBox(
                            maxHeight: 200.0,
                            child: FutureBuilder(
                              future: pengalamankerja(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                // print("snap${snapshot.hasData}");
                                return snapshot.hasData
                                    ? ItemList(list: snapshot.data)
                                    : Center(
                                  child:
                                  CircularProgressIndicator(),
                                );
                              },
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(color: mainColor)
                              ]
                          ),
                        ),
                      ),
                      Divider(),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding:
                            const EdgeInsets.only(left:10, right: 15),
                            child: Icon(
                              Icons.group,
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            width:
                            MediaQuery.of(context).size.width /
                                2,
                            child: Text(
                              "Pengalaman Organisasi",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left:15,right: 15),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.add,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            (TambahPengalamanOrganisasi())));
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:10.0, right: 15),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(color: mainColor)
                              ]
                          ),
                          child: LimitedBox(
                            maxHeight: 200.0,
                            child: FutureBuilder(
                              future: pengalamanorg(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                //  print("snap${snapshot.hasData}");
                                return snapshot.hasData
                                    ? ItemListOrg(list: snapshot.data)
                                    : Center(
                                  child:
                                  CircularProgressIndicator(),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onPressed: () {
                              signOut();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.exit_to_app,
                                  size: 14,
                                ),
                                Text(' Logout',
                                    style: TextStyle(fontSize: 14)),
                              ],
                            ),
                            color: Colors.red,
                            textColor: Colors.white,
                            elevation: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ));
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
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
                    child: Text("Login", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ]),
          ),
        ),
      );
    }
  }
}

class ItemList extends StatefulWidget {
  List list;

  ItemList({this.list});
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 200.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.list == null ? 0 : widget.list.length,
        itemBuilder: (BuildContext context, int index) {
          final Pengalaman xpengalamankerja = widget.list[index];

          //   print("pengalamankerja${xpengalamankerja.id}");

          if (xpengalamankerja.id == "0000") {
            return Center(
              child: Container(
                child: Center(
                    child: Text(
                  "Belum memiliki pengalaman kerja",
                  style: TextStyle(fontSize: 16),
                )),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          xpengalamankerja.posisi,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          xpengalamankerja.namaPerusahaan,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(xpengalamankerja.tglMulai),
                            Text(" S/d "),
                            Text(xpengalamankerja.tglBerhenti),
                          ],
                        ),
                      ],
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                xpengalamankerja.namaPerusahaan,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
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
                                                  id: xpengalamankerja.id ==
                                                          null
                                                      ? ""
                                                      : xpengalamankerja.id,
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
                                                      : xpengalamankerja.posisi,
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
                                                      : xpengalamankerja.lokasi,
                                                  gaji: xpengalamankerja.gaji ==
                                                          null
                                                      ? ""
                                                      : xpengalamankerja.gaji,
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
                                                  jenjang_career_id: xpengalamankerja
                                                              .jenjang_career_id ==
                                                          null
                                                      ? ""
                                                      : xpengalamankerja
                                                          .jenjang_career_id,
                                                )));
                                  },
                                  child: Text(
                                    "Edit",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  color: Colors.white,
                                ),
                              ],
                            );
                          });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:15.0, right: 15),
                    child: Divider(),
                  ),
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

class ItemListOrg extends StatefulWidget {
  List list;

  ItemListOrg({this.list});
  @override
  _ItemListOrgState createState() => _ItemListOrgState();
}

class _ItemListOrgState extends State<ItemListOrg> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 200.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.list == null ? 0 : widget.list.length,
        itemBuilder: (BuildContext context, int index) {
          final PengalamanOrg xpengalamankerja = widget.list[index];

          //   print("pengalamankerja${xpengalamankerja.id}");

          if (xpengalamankerja.id == "0000") {
            return Center(
              child: Container(
                child: Center(
                    child: Text(
                  "Belum memiliki pengalaman organisasi",
                  style: TextStyle(fontSize: 16),
                )),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  MaterialButton(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          xpengalamankerja.namaOrganisasi == null
                              ? ""
                              : xpengalamankerja.namaOrganisasi, style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          xpengalamankerja.jabatan == null
                              ? ""
                              : xpengalamankerja.jabatan,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              xpengalamankerja.mulai == null
                                  ? ""
                                  : xpengalamankerja.mulai,
                            ),
                            Text(
                                ' s/d '
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:15.0, right: 15),
                    child: Divider(),
                  ),
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
