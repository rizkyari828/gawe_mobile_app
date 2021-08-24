import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gaweid2/modules/learning/views/modul.dart';
import 'package:gaweid2/modules/lowongan/Component/detailLowongan.dart';
import 'package:gaweid2/modules/lowongan/view/filter.dart';
import 'package:gaweid2/modules/media/models/ModelBanner.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/model/user/ModelLowongan.dart';
import 'package:gaweid2/model/user/ModelLowongan2.dart';
import 'package:gaweid2/modules/lowongan/view/home.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/lowongan/Component/itemLowongan.dart';
import 'package:gaweid2/ui/User/Fragment/AkunUser.dart';
import 'package:gaweid2/modules/lowongan/view/detail_lowongan.dart';
import 'package:gaweid2/modules/media/view/media.dart';
import 'package:gaweid2/modules/media/view/news_detail.dart';
import 'package:gaweid2/modules/learning/views/menuLearning.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:gaweid2/modules/media/models/ModelNews.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class HomeUser extends StatefulWidget {
  @override
  _HomeUserState createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  BaseEndPoint network = NetworkProvider();
  String link = "";
  String position;
  //List<Wisata> potsList = [];
  double nLat = 0;
  double nLong = 0;

  // LatLng myPostion;
  // CameraPosition _kGooglePlex;
  // dynamic gab;

  // Completer<GoogleMapController> _controller = Completer();
  //
  // final Set<Marker> _markers = {};

  // get Current Location
  void getCurrentLocation() async {
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    try {
      setState(() {
        nLat = currentLocation.latitude;
        nLong = currentLocation.longitude;
        // myPostion = LatLng(nLat, nLong);
        if(mystatus == true){
          if(userLat == 0.1 && userLong == 0.1){
            submit(nLat, nLong);
          }else {

          }
        }

        ///
        // Next Function add to marker
        // mapsCamera();
      });
    } on Exception {
      print("Null");
    }
  }

  void submit(lat, long) async {
    ModelRegister data = await network.saveLocation(
        globalEmail.toString(),
        lat.toString(),
        long.toString());
  }

  void submitPlayerId(playerId) async {
    ModelRegister data = await network.savePlayerId(
        globalEmail.toString(),
        playerId.toString());
  }
  //
  // // Set Camera
  // void mapsCamera() async {
  //   LatLng _center = LatLng(nLat, nLong);
  //   LatLng _lastPosition = _center;
  //
  //   _kGooglePlex = CameraPosition(target: LatLng(nLat, nLong), zoom: 14.4746);
  //   final CameraPosition _kLake = CameraPosition(
  //       bearing: 30,
  //       target: LatLng(nLat, nLong),
  //       tilt: 59.440717697143555,
  //       zoom: 16);
  //   _goToTheLake(_kLake);
  //   _onAddMarkerButtonPressed(_lastPosition);
  //
  //   ModelRegister data = await network.LatLang(globalEmail, nLat, nLong);
  //
  //   if (data.status == 200) {
  //     print("Berhasil lat long");
  //   } else {
  //     print("gagal lat long");
  //   }
  // }
  //
  // Future<void> _goToTheLake(CameraPosition _kLake) async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
  //
  // void _onAddMarkerButtonPressed(LatLng lastPosition) {
  //   setState(() {
  //     _markers.add(Marker(
  //       //This marker id can be anything that uniquely identifier each marker.
  //       markerId: MarkerId(lastPosition.toString()),
  //       position: lastPosition,
  //     ));
  //   });
  // }

  AppUpdateInfo _updateInfo;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  bool _flexibleUpdateAvailable = false;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
      });
    }).catchError((e) {
      showSnack(e.toString());
    });
  }

  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }

  void main() async {
//    var status = await OneSignal.shared.getPermissionSubscriptionState();
//
//    var tokenplayerId = status.subscriptionStatus.userId;
//    setState(() {
//      tokenplayerId2 = tokenplayerId;
//
//    });
//
////    await OneSignal.shared.postNotification(OSCreateNotification(
////        playerIds: [tokenplayerId],
////        content: "this is a test from OneSignal's Flutter SDK",
////        heading: "Test Notification",
////        buttons: [
////          OSActionButton(text: "test1", id: "id1"),
////          OSActionButton(text: "test2", id: "id2")
////        ]
////    ));
//    print("tokenplayerid${tokenplayerId}");

    WidgetsFlutterBinding.ensureInitialized();

    // OneSignal.shared.init(
    //   "c243b1b4-497a-45cb-8895-21ba35e2b8c5",
    //   iOSSettings: null,
    // );
    // OneSignal.shared
    //     .setInFocusDisplayType(OSNotificationDisplayType.notification);
  }

  // AppUpdateInfo _updateInfo;
  // GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  //
  // bool _flexibleUpdateAvailable = false;
  //
  // // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> checkForUpdate() async {
  //   InAppUpdate.checkForUpdate().then((info) {
  //     setState(() {
  //       _updateInfo = info;
  //     });
  //   }).catchError((e) => _showError(e));
  // }
  //
  // void _showError(dynamic exception) {
  //   _scaffoldKey.currentState
  //       .showSnackBar(SnackBar(content: Text(exception.toString())));
  // }

  void updateversion() {
    _updateInfo?.updateAvailability == UpdateAvailability.updateAvailable
        ? () {
            InAppUpdate.performImmediateUpdate()
                .catchError((e) => showSnack(e.toString()));
          }
        : null;

    _updateInfo?.updateAvailability == UpdateAvailability.updateAvailable
        ? () {
            InAppUpdate.startFlexibleUpdate().then((_) {
              setState(() {
                _flexibleUpdateAvailable = true;
              });
            }).catchError((e) {
              showSnack(e.toString());
            });
          }
        : null;

    !_flexibleUpdateAvailable
        ? null
        : () {
            InAppUpdate.completeFlexibleUpdate().then((_) {
              showSnack("Success!");
            }).catchError((e) {
              showSnack(e.toString());
            });
          };
  }

  TextEditingController etSearch = new TextEditingController();
  bool _isSearch = true;
  var keyword = "";

  _HomeUserState() {
    etSearch.addListener(() {
      if (etSearch.text.isEmpty) {
        setState(() {
          _isSearch = true;
          keyword = "";
        });
      } else {
        setState(() {
          _isSearch = false;
          keyword = etSearch.text.toString();
        });
      }
    });

    print("keyword${keyword}");
  }

  List<ModelLowongan> _search = [];

  var loading = false;
  var loading1 = false;
  var idEmp = "";

  Future<List> getLowongan() async {
    setState(() {
      if(globalid_employee == null){
        idEmp = "0";
      }else{
        idEmp = globalid_employee;
      }
    });
    final response = await http.get(NetworkConfig().baseUrl + "apps/toplist?id=" + idEmp);
    ModelLowongan2 listdata = modelLowongan2FromJson(response.body);

    return listdata.lowongan;
  }

  Future<List> search() async {
    final response = await http.post(
        NetworkConfig().baseUrl + "apps/search_lowongan2",
        body: {'search': keyword.toString()});

    ModelLowongan2 listdata = modelLowongan2FromJson(response.body);
    // print("listadata${listdata}");
    if (response.statusCode == 200) {
      // print("get data succeessfully");
    } else {
      //print("Get Data Failed");
    }

    return listdata.lowongan;
  }

  void status_update_otomatis() async {
    final response = await http.get(
        NetworkConfig().baseUrl + "apps/update_status_not_active_otomatis");

    ModelRegister listData = modelRegisterFromJson(response.body);

    if (listData.status == 200) {
      // print("update otomatis berhasil");
    } else {
      // print("update otomatis gagal");
    }
  }

  List<ModelNews> news = [];
  Future<Null> getNews() async {
    setState(() {
      loading = true;
    });
    final response = await http.get(NetworkConfig().baseUrl + "apps/news");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      setState(() {
        for (Map i in data) {
          news.add(ModelNews.fromJson(i));
        }
      });
    }
  }

  var globalName = "",
      globalEmail = "",
      globalLevel = "",
      id_user = "",
      globalid_employee = "",
      globalprofil_power = "";
  var status = false;
  var mystatus;
  double userLat = 0;
  double userLong = 0;

  SessionManager sessionManager = SessionManager();

  void getPreferences() async {
    await sessionManager.getPreference().then((value) {
      setState(() {
        mystatus = sessionManager.status;
        globalName = sessionManager.fullname;
        globalEmail = sessionManager.email;
        id_user = sessionManager.iduser;
        globalprofil_power = sessionManager.profile_power;
        globalid_employee = sessionManager.id_employee;
        userLat = sessionManager.latitude;
        userLong = sessionManager.longitude;
      });
    });
  }

  TextEditingController controller = new TextEditingController();

  onSearch(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
  }

  Future<List<ModelBanner>> getBanner() async {
    final response = await http.get(NetworkConfig().baseUrl + "apps/banner");
    return modelBannerFromJson(response.body);
  }

  String logo,
  provinsi,
  posisi,
  id_lowongan,
  perusahaan,
  gajimin,
  gajimax,
  jenjang_career_id,
  pendidikan,
  city_id,
  pengalaman,
  rincian,
  kuota,
  kualifikasi,
  alamat,
  deskripsi,
  jenispekerjaan,
  datePostEnd,
  id_perusahaan,
  directLink, id_employee;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBanner();
    getPreferences();
    getNews();
    status_update_otomatis();
    checkForUpdate();
    updateversion();
    initUniLinks().then((value) => this.setState(() {
      var url = value;
      String suffix = url.split('/').last;
      print(" llll ${suffix}");
      String decode = utf8.decode(base64.decode(suffix));
      link = value;
      if(decode != null){
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => (singleDetailLowongan(idEmployee: globalid_employee, idLowongan: decode))));
        });
      }


      // print(" llllo ${decode}");


      // List<String> split(String path) => context.split(path);
    }));
    OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      // Will be called whenever a notification is opened/button pressed.
    });

    // OneSignal.shared.setEmail(email: "pandutes@gmail.com", emailAuthHashToken: tokenFromServer).then((result) {
    //request succeeded

    // OneSignal.shared
    //     .setNotificationReceivedHandler((OSNotification notification) {
    //   // will be called whenever a notification is received
    //   title = notification.payload.title;
    //   content = notification.payload.body;
    // });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      // print("Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}");
      print("Opened notification: \n${result.notification.additionalData["id_lowongan"]}");
      print("Opened notification: \n${result.notification.additionalData}");
      var data = result.notification;
      // this.setState(() {!
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Detail_lowongan(
                  logo: data.additionalData["logo"] == null
                      ? ""
                      : data.additionalData["logo"],
                  provinsi: data.additionalData["province_id"] == null
                      ? ""
                      : data.additionalData["province_id"],
                  posisi: data.additionalData["posisi"] == null
                      ? ""
                      : data.additionalData["posisi"],
                  id: data.additionalData["id_lowongan"] == null
                      ? ""
                      : data.additionalData["id_lowongan"],
                  perusahaan: data.additionalData["nama_perusahaan"] == null
                      ? ""
                      : data.additionalData["nama_perusahaan"],
                  gajimin: data.additionalData["gaji_min"] == null
                      ? ""
                      : data.additionalData["gaji_min"],
                  gajimax: data.additionalData["gaji_max"] == null
                      ? ""
                      : data.additionalData["gaji_max"],
                  jenjang_career_id: data.additionalData["jenjang_career_id"]
                      .toString() ==
                      null
                      ? ""
                      : data.additionalData["jenjang_career_id"].toString(),
                  pendidikan:
                  data.additionalData["pendidikan"].toString() == null
                      ? ""
                      : data.additionalData["pendidikan"].toString(),
                  city_id: data.additionalData["city_id"].toString() == ""
                      ? ""
                      : data.additionalData["city_id"].toString(),
                  pengalaman:
                  data.additionalData["pengalaman_id"].toString() == null
                      ? ""
                      : data.additionalData["pengalaman_id"].toString(),
                  rincian: data.additionalData["rincian"].toString() == null
                      ? ""
                      : data.additionalData["rincian"].toString(),
                  kualifikasi:
                  data.additionalData["kualifikasi"].toString() == null
                      ? ""
                      : data.additionalData["kualifikasi"].toString(),
                  kuota: data.additionalData["kuota"].toString() == null
                      ? ""
                      : data.additionalData["kuota"].toString(),
                  alamat: data.additionalData["alamat"].toString() == null
                      ? ""
                      : data.additionalData["alamat"].toString(),
                  deskripsi:
                  data.additionalData["deskripsi"].toString() == null
                      ? ""
                      : data.additionalData["deskripsi"].toString(),
                  jenispekerjaan:
                  data.additionalData["jenis_pekerjaan"].toString() ==
                      null
                      ? ""
                      : data.additionalData["jenis_pekerjaan"].toString(),
                  datePostEnd:
                  data.additionalData["date_post_end"].toString() ==
                      null
                      ? ""
                      : data.additionalData["date_post_end"].toString(),
                  directLink: data.additionalData["direct_link"].toString() == null ? "" : data.additionalData["direct_link"].toString(),
                  id_employee: globalid_employee == null ? "" : globalid_employee,
                )));
        // id_lowongan =
        // _debugLabelString =
        // "Opened notification: \n${result.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
      // });
    });


    // OneSignal.shared.setPermissionObserver((OSPermissionStateChanges linchanges) {
    //   // will be called whenever the permission changes
    //   // (ie. user taps Allow on the permission prompt in iOS)
    // });

    // OneSignal.shared
    //     .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
    //   // will be called whenever the subscription changes
    //   //(ie. user gets registered with OneSignal and gets a user ID)
    // });

    // OneSignal.shared.setEmailSubscriptionObserver(
    //     (OSEmailSubscriptionStateChanges emailChanges) {
    //   // will be called whenever then user's email subscription changes
    //   // (ie. OneSignal.setEmail(email) is called and the user gets registered
    // });

    // void _handleNotificationReceived(OSNotification notification) {}

    // OneSignal.shared
    //     .setNotificationReceivedHandler(_handleNotificationReceived);
    // fetchData();

//    }).catchError((error) {
//      //encountered an error
//    });

// For each of the above functions, you can also pass in a
// reference to a function as well:

    // _kGooglePlex = CameraPosition(target: LatLng(nLat, nLong), zoom: 14.4746);
    getCurrentLocation();

  }

  Future<String> initUniLinks() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final initialLink = await getInitialLink();
      // Parse the link and warn the user, if it is not correct,
      // but keep in mind it could be `null`.
      print("link nya adalah ${initialLink}");
      return initialLink;
    } on PlatformException {
      // Handle exception by warning the user their action did not succeed
      // return?
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(),
      body: Container(
        color: backgroundColor,
        child: _isSearch
            ? SingleChildScrollView(
              child: Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.2,
                      decoration: new BoxDecoration(
                          color: mainColor
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right:10, top: 10),
                          child: Row(
                            children: [
                              MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).push(new MaterialPageRoute(
                                      builder: (BuildContext context) => Filter()));
                                },
                                child: Container(
                                  constraints: BoxConstraints(maxHeight: 60),
                                  width: MediaQuery.of(context).size.width - 100,
                                  height: MediaQuery.of(context).size.height / 13,
                                  child: Card(
                                    elevation: 1,
                                    margin: new EdgeInsets.only(
                                        top: 5.0, bottom: 5.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.search,
                                            color: Colors.grey,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top:3, left: 8.0),
                                            child: Text("Cari lowongan", style: TextStyle(
                                              fontSize: 16, color: Colors.grey,
                                              fontWeight: FontWeight.w300,
                                            ),),
                                          ),
                                          // new Flexible(
                                          //   child: Padding(
                                          //     padding: const EdgeInsets.only(
                                          //         left: 10.0, bottom: 3.0),
                                          //     child:
                                          //     new TextField(
                                          //       controller: etSearch,
                                          //       onChanged: onSearch,
                                          //       decoration: const InputDecoration(
                                          //           hintText: "Cari Lowongan",
                                          //           border: InputBorder.none),
                                          //     ),
                                          //   ),
                                          // ),
                                          // IconButton(
                                          //   onPressed: () {
                                          //     etSearch.clear();
                                          //     onSearch('');
                                          //   },
                                          //   icon: Icon(
                                          //     Icons.cancel,
                                          //     color: Colors.grey,
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: MaterialButton(
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => (AkunUser(id_employee: globalid_employee,))));
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:20),
                          child: Container(
                            child: FutureBuilder(
                                future: getBanner(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) print(snapshot.hasError);
                                  List<ModelBanner> dataSlider = snapshot.data;
                                  return Column(
                                    children: <Widget>[
                                      CarouselSlider.builder(
                                          itemCount: dataSlider == null
                                              ? 0
                                              : dataSlider.length,
                                          itemBuilder: (context, index) {
                                            return snapshot.hasData
                                                ? MaterialButton(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(context)
                                                      .size.width,
                                                        height: MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                            4,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                          child: Image.network(
                                                            dataSlider[index].file,
                                                            fit: BoxFit.fill,
                                                            width: double.infinity,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  onPressed: () {
                                                    print(dataSlider[index].status);
                                                    if(dataSlider[index].status == '2'){

                                                      Navigator.of(context)
                                                          .push(new MaterialPageRoute(
                                                          builder: (BuildContext context) =>
                                                      UI_Modul(
                                                        kodelearning: "854414",
                                                        kodeReferral: "GAWE-001",
                                                        namaLearning: "QUIZ GAWE.ID",
                                                      )));
                                                    }else{
                                                      launch(dataSlider[index].link);
                                                    }

                                                  },
                                                )
                                                : Container(
                                                    child: Center(
                                                        child:
                                                            CircularProgressIndicator()));
                                          },
                                          options: CarouselOptions(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4,
                                            viewportFraction: 1.0,
                                            enlargeCenterPage: false,
                                            autoPlay: true,
                                          ))
                                    ],
                                  );
                                }),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10, left:10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(color: mainColor)
                                    ]
                                ),
                                constraints: BoxConstraints(maxHeight: 100),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 5, bottom:5.0, left:5, right: 5),
                                  child: ListView(
                                    physics: ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      Column(
                                        children: <Widget>[
                                          Container(
                                            width:
                                            MediaQuery.of(context).size.width / 6,
                                            child: MaterialButton(
                                              child: Image.asset(
                                                'images/menu/lowongan_baru.png',
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                        (Home(globalidEmployee: globalid_employee,section: "terbaru",))));
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 5,),
                                          Text(
                                            'Lowongan',
                                            style: blackTextfont.copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                          ),
                                          // Icon(Icons.what)
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Container(
                                            width:
                                            MediaQuery.of(context).size.width / 6,
                                            child: MaterialButton(
                                              child: Image.asset(
                                                'images/menu/learning_baru.png',
                                              ),
                                              onPressed: () {
                                                mystatus == true
                                                    ? Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                        (MenuLearning())))
                                                    : Toast.show(
                                                    "Silahkan login terlebih dahulu",
                                                    context,
                                                    duration: 3,
                                                    gravity: Toast.TOP);
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 5,),
                                          Container(
                                            width:
                                            MediaQuery.of(context).size.width / 6,
                                            child: Center(
                                              child: Text(
                                                'Gawe Edu',
                                                style: blackTextfont.copyWith(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.normal),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Container(
                                            width:
                                            MediaQuery.of(context).size.width / 6,
                                            child: MaterialButton(
                                              child: Image.asset(
                                                'images/menu/media_baru.png',
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                        (Media())));
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 5,),
                                          Container(
                                            width:
                                            MediaQuery.of(context).size.width / 6,
                                            child: Center(
                                              child: Text(
                                                'Media',
                                                style: blackTextfont.copyWith(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.normal),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Container(
                                            width:
                                            MediaQuery.of(context).size.width / 6,
                                            child: MaterialButton(
                                              child: Image.asset(
                                                'images/menu/gawe_harian.png',
                                              ),
                                              onPressed: () {
                                                Toast.show("Coming soon", context,
                                                    duration: 3, gravity: Toast.TOP);
                                                // Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (context) =>
                                                //             (ListLowongan_DW())));
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 5,),
                                          Container(
                                            width:
                                            MediaQuery.of(context).size.width / 4.5,
                                            child: Center(
                                              child: Text(
                                                'Gawe Harian',
                                                style: blackTextfont.copyWith(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.normal),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Container(
                                            width:
                                            MediaQuery.of(context).size.width / 6,
                                            child: MaterialButton(
                                              child: Image.asset(
                                                'images/menu/1.png',
                                              ),
                                              onPressed: () {
                                                Toast.show("Coming soon", context,
                                                    duration: 3, gravity: Toast.TOP);

//                                      Navigator.push(
//                                          context,
//                                          MaterialPageRoute(
//                                              builder: (context) =>
//                                                  (ListLowongan())));
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 5,),
                                          Container(
                                            width:
                                            MediaQuery.of(context).size.width / 4.5,
                                            child: Center(
                                              child: Text(
                                                'Langganan',
                                                style: blackTextfont.copyWith(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.normal),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 14),
                                    child: Text(
                                      'Berita Terkini',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                  ),
                                  MaterialButton(
                                    child: Row(
                                      children: [
                                        Text(
                                          'Lebih Banyak',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: mainColor),
                                        ),
                                        Icon(
                                          Icons.navigate_next,
                                          color: mainColor,
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => (Media())));
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              constraints: BoxConstraints(maxHeight: 170),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: news.length,
                                itemBuilder: (context, index) {
                                  final xnews = news[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: MediaQuery.of(context).size.height / 3,
                                      width: MediaQuery.of(context).size.width / 2.2,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => NewsDetail(
                                                    title: xnews.title == null
                                                        ? ""
                                                        : xnews.title,
                                                    foto: xnews.foto == null
                                                        ? ""
                                                        : xnews.foto,
                                                    desc: xnews.desc == null
                                                        ? ""
                                                        : xnews.desc,
                                                  )));
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Card(
                                              elevation: 1,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  topLeft: Radius.circular(10),
                                                ),
                                                child: Image.network(
                                                  xnews.foto,
                                                  width:
                                                  MediaQuery.of(context).size.width,
                                                  height:
                                                  MediaQuery.of(context).size.height /
                                                      9,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, right: 4),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    xnews.title,
                                                    maxLines: 2,
                                                    // softWrap: false,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.normal,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Text(
                                                      DateFormat('dd-MM-yyyy').format(xnews.dateCreated).toString(),
                                                    maxLines: 2,
                                                    // softWrap: false,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.normal,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Text(
                                    'Lowongan Kerja Terbaru',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                                ),
                                MaterialButton(
                                  child: Row(
                                    children: [
                                      Text(
                                        'Lebih Banyak',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: mainColor),
                                      ),
                                      Icon(
                                        Icons.navigate_next,
                                        color: mainColor,
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => (Home(globalidEmployee: globalid_employee,section: 'terbaru',))));
                                  },
                                ),
                              ],
                            ),
                            FutureBuilder(
                              future: getLowongan(),
                              builder:
                                  (BuildContext context, AsyncSnapshot snapshot) {
                                return snapshot.hasData
                                    ? ItemListLowongan(
                                    list: snapshot.data,
                                    globalid_employee: globalid_employee,
                                    mystatus: mystatus)
                                    : Center(child: CircularProgressIndicator());
                              },
                            ),
                          ],
                        )
                      ],
                    ),

                  ],
                ),
            )
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:10.0, right:10),
                    child: Container(
                      //  color: mainColor,
                      child: Card(
                        child: ListTile(
                          leading: Icon(Icons.search),
                          title: TextField(
                            controller: etSearch,
                            onChanged: onSearch,
                            decoration: InputDecoration(
                                hintText: "Search ", border: InputBorder.none),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              etSearch.clear();
                              onSearch('');
                            },
                            icon: Icon(Icons.cancel),
                          ),
                        ),
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: search(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return snapshot.hasData
                          ? ItemListSearch(list: snapshot.data,globalid_employee:globalid_employee,mystatus:mystatus)
                          : Center(
                              child: CircularProgressIndicator(),
                            );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}

void simpanLowongan(idLowongan, globalid_employee, context) async {
  Toast.show("Lowongan Berhasil Disimpan", context,
      duration: 3, gravity: Toast.TOP);

  final response =
      await http.post(NetworkConfig().baseUrl + "apps/simpan_lowongan", body: {
    'lowongan_id': idLowongan,
    'employee_id': globalid_employee,
  });

  if (response.statusCode == 200) {
    print("berhasi disimpan lowongan");
    Toast.show("Lowongan Berhasil Disimpan", context,
        duration: 3, gravity: Toast.BOTTOM);
  } else {
    print("gagal disimpan lowongan");
  }
}

class ItemListSearch extends StatefulWidget {
  List list;
  bool mystatus;
  String globalid_employee;

  ItemListSearch({this.list,this.globalid_employee,this.mystatus});
  @override
  _ItemListSearchState createState() => _ItemListSearchState();
}

class _ItemListSearchState extends State<ItemListSearch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:10.0, right:10),
      child: Container(
        height: 850,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: widget.list.length,
          itemBuilder: (context, index) {
            final xlowongan = widget.list[index];
            return Card(
              margin: new EdgeInsets.only(
                  left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Detail_lowongan(
                                  logo: xlowongan.logo == null
                                      ? ""
                                      : xlowongan.logo,
                                  provinsi: xlowongan.provinceId == null
                                      ? ""
                                      : xlowongan.provinceId,
                                  posisi: xlowongan.posisi == null
                                      ? ""
                                      : xlowongan.posisi,
                                  id: xlowongan.idLowongan == null
                                      ? ""
                                      : xlowongan.idLowongan,
                                  perusahaan: xlowongan.namaPerusahaan == null
                                      ? ""
                                      : xlowongan.namaPerusahaan,
                                  gajimin: xlowongan.gajiMin == null
                                      ? ""
                                      : xlowongan.gajiMin,
                                  gajimax: xlowongan.gajiMax == null
                                      ? ""
                                      : xlowongan.gajiMax,
                                  jenjang_career_id:
                                      xlowongan.jenjangCareerId.toString() == null
                                          ? ""
                                          : xlowongan.jenjangCareerId.toString(),
                                  pendidikan:
                                      xlowongan.pendidikan.toString() == null
                                          ? ""
                                          : xlowongan.pendidikan.toString(),
                                  city_id: xlowongan.cityId == null
                                      ? ""
                                      : xlowongan.cityId,
                                  pengalaman:
                                      xlowongan.pengalamanId.toString() == null
                                          ? ""
                                          : xlowongan.pengalamanId.toString(),
                                  rincian: xlowongan.rincian.toString() == null
                                      ? ""
                                      : xlowongan.rincian.toString(),
                                  kualifikasi:
                                      xlowongan.kualifikasi.toString() == null
                                          ? ""
                                          : xlowongan.kualifikasi.toString(),
                                  kuota: xlowongan.kouta.toString() == null
                                      ? ""
                                      : xlowongan.kouta.toString(),
                                  alamat: xlowongan.alamat.toString() == null
                                      ? ""
                                      : xlowongan.alamat.toString(),
                                  deskripsi:
                                      xlowongan.deskripsi.toString() == null
                                          ? ""
                                          : xlowongan.deskripsi.toString(),
                                  jenispekerjaan:
                                      xlowongan.jenispekerjaan.toString() == null
                                          ? ""
                                          : xlowongan.jenispekerjaan.toString(),
                                  id_perusahaan:
                                      xlowongan.id_perusahaan.toString() == null
                                          ? ""
                                          : xlowongan.id_perusahaan.toString(),
                                  directLink:
                                      xlowongan.directLink.toString() == null
                                          ? ""
                                          : xlowongan.directLink.toString(),
                              id_employee: widget.globalid_employee == null ? "" : widget.globalid_employee,
                                )));
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 15,),
                              child: Image.network(
                                xlowongan.logo,
                                height:
                                MediaQuery.of(context).size.height / 12,
                                width: MediaQuery.of(context).size.width / 5,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width/1.8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    xlowongan.posisi,
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: mainColor,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    xlowongan.namaPerusahaan,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),

                                  Row(
                                    children: [
                                      Icon(Icons.work_rounded, size: 15, color: Colors.grey,),
                                      Text(
                                        " ${xlowongan.jenispekerjaan}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.add_location_rounded, size: 15, color: Colors.grey,),
                                          Text(
                                            " ${xlowongan.provinceId}",
                                            overflow: TextOverflow.fade,
                                            maxLines: 2,
                                            softWrap: false,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left:16.0),
                                        child: Text( xlowongan.distance == null || xlowongan.distance == "-" ? "" :
                                        " ${xlowongan.distance}",
                                          overflow: TextOverflow.fade,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: mainColor),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                                  100),
                                          child: Text(
                                              xlowongan.pelamarTeks
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                              )),
                                        ),
                                        Text(
                                          xlowongan.duration.toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
