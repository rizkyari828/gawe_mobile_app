import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:connection_status_bar/connection_status_bar.dart';
import 'package:flutter/material.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/modules/user/models/block_psikotes.dart';
import 'package:gaweid2/model/user/ModelLowongan.dart';
import 'package:gaweid2/model/user/ModelLowongan2.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/ui/DW/lowongan_detail_dw.dart';
import 'package:gaweid2/ui/DW/lowongan_dw.dart';
import 'package:gaweid2/modules/lowongan/view/detail_lowongan.dart';
import 'package:gaweid2/modules/lowongan/view/lowongan.dart';
// import 'package:gaweid2/ui/learning/kodelearning.dart';
import 'package:gaweid2/modules/learning/views/landing.dart';
// import 'package:gaweid2/ui/learning/video_materi.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:in_app_update/in_app_update.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../modules/user/view/Login.dart';
import 'package:geolocator/geolocator.dart';

class HomeUser1 extends StatefulWidget {
  @override
  _HomeUser1State createState() => _HomeUser1State();
}

class _HomeUser1State extends State<HomeUser1> {
  Future<void> _launched;

  BaseEndPoint network = NetworkProvider();

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
        print("Lat home: ${currentLocation.latitude}");
        print("Lon home: ${currentLocation.longitude}");

        ///
        // Next Function add to marker
        mapsCamera();
      });
    } on Exception {
      print("Null");
    }
  }

  // Set Camera
  void mapsCamera() async {
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

    ModelRegister data = await network.LatLang(globalEmail, nLat, nLong);

    if (data.status == 200) {
      print("Berhasil lat long");
    } else {
      print("gagal lat long");
    }
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

  AppUpdateInfo _updateInfo;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  bool _flexibleUpdateAvailable = false;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
      });
    }).catchError((e) => _showError(e));
  }

  void _showError(dynamic exception) {
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text(exception.toString())));
  }

  // void updateversion() {
  //   !_flexibleUpdateAvailable
  //       ? null
  //       : () {
  //           InAppUpdate.completeFlexibleUpdate().then((_) {
  //             _scaffoldKey.currentState
  //                 .showSnackBar(SnackBar(content: Text('Success!')));
  //           }).catchError((e) => _showError(e));
  //         };
  //
  //   _updateInfo?.updateAvailable == true
  //       ? () {
  //           InAppUpdate.startFlexibleUpdate().then((_) {
  //             setState(() {
  //               _flexibleUpdateAvailable = true;
  //             });
  //           }).catchError((e) => _showError(e));
  //         }
  //       : null;
  //
  //   _updateInfo?.updateAvailable == true
  //       ? () {
  //           InAppUpdate.performImmediateUpdate()
  //               .catchError((e) => _showError(e));
  //         }
  //       : null;
  // }

  TextEditingController etSearch = new TextEditingController();
  bool _isSearch = true;
  var keyword = "";

  _HomeUser1State() {
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

  List<ModelLowongan> _list = [];
  List<ModelLowongan> _search = [];

  var loading = false;
  var loading1 = false;

  Future<List> getLowongan() async {
    final response = await http.get(NetworkConfig().baseUrl + "apps/toplist");
    ModelLowongan2 listdata = modelLowongan2FromJson(response.body);
    print("lowongan${listdata}");
    if (response.statusCode == 200) {
      // print("get data succeessfully");
    } else {
      //print("Get Data Failed");
    }
    return listdata.lowongan;
  }

  Future<List> search() async {
    final response = await http.post(
        NetworkConfig().baseUrl + "apps/search_lowongan2",
        body: {'search': keyword.toString()});

    ModelLowongan2 listdata = modelLowongan2FromJson(response.body);

    print("listadata${listdata}");
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
      print("update otomatis berhasil");
    } else {
      print("update otomatis gagal");
    }
  }

  var globalName = "",
      globalEmail = "",
      globalLevel = "",
      id_user = "",
      globalid_employee = "",
      globalprofil_power = "";
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
        globalprofil_power = sessionManager.profile_power;
        globalid_employee = sessionManager.id_employee;

        print("email${globalEmail}");
        print("profil power${globalprofil_power}");
//        print("fullname${globalName}");
//        print("email${globalEmail}");
//        print("global $globalLevel");
        //_loginStatus = mystatus == true ? LoginStatus.Login : LoginStatus.not_login;
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

  String link1, planStartDate, planEndDate;
  Future psikotes_api(employee_id) async {
    loading = false;
    final jsonString =
        await http.post(NetworkConfig().baseUrl + "apps/epsikotes", body: {
      'id_employee': employee_id,
    });
    final jsonData = jsonDecode(jsonString.body);

    print("teslink${jsonData}");

    Block_psikotes sample = Block_psikotes.fromJson(jsonData);
    setState(() {
      link1 = sample.link.toString();
      planStartDate = sample.planStartDate.toString();
      planEndDate = sample.planEndDate.toString();
    });
    //_launchURL(link1);
  }

  String linknya;
//  _launchURL(link1) async {
//    linknya = link1;
//     url = "http://epsikotest.gawe.id/auth/${linknya}";
//    if (await canLaunch(url)) {
//      await launch(url);
//    } else {
//      throw 'Could not  launch $url';
//    }
//  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  String title = "title";
  String content = "content";

  String tokenplayerId2 = "tokenplayerId";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPreferences();
    status_update_otomatis();
    // updateversion();

    String tokenFromServer = "";

    // OneSignal.shared.setEmail(email: "pandutes@gmail.com", emailAuthHashToken: tokenFromServer).then((result) {
    //request succeeded

    // OneSignal.shared
    //     .setNotificationReceivedHandler((OSNotification notification) {
    //   // will be called whenever a notification is received
    //   title = notification.payload.title;
    //   content = notification.payload.body;
    // });

    // OneSignal.shared
    //     .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
    //   // will be called whenever a notification is opened/button pressed.
    //   print("notifikasi ditab");
    // });

    // OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
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

    _kGooglePlex = CameraPosition(target: LatLng(nLat, nLong), zoom: 14.4746);
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    String toLaunch = link1;
    print("link ${link1}");

    psikotes_api(globalid_employee);
    main();
    return Material(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Scaffold(
              backgroundColor: Colors.white,
//      appBar: AppBar(),
              body: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          bottom: 12, right: 12, left: 12, top: 12),
                      color: mainColor,
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
                    loading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Expanded(
                            child: _isSearch
                                ? Column(
                                    children: <Widget>[
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                          child: Column(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  // color: Colors.yellowAccent,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Flexible(
                                                        flex: 1,
                                                        child: Container(
                                                         // height: 200,
                                                          //color: Colors.yellowAccent,
                                                          child: Column(
                                                            children: <
                                                                Widget>[
                                                              Flexible(
                                                                flex: 1,
                                                                child:
                                                                    Container(
                                                                  child:
                                                                      FlatButton(
                                                                    child: Image
                                                                        .asset(
                                                                      'images/menu/1.png',
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(builder: (context) => (ListLowongan())));
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                              Flexible(
                                                                flex: 1,
                                                                child:
                                                                    Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Container(
                                                                  child: Text(
                                                                      'Lowongan',
                                                                      style: blackTextfont.copyWith(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                  ),
                                                                ),
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        flex: 1,
                                                        child: Container(
                                                          //color: Colors.redAccent,
                                                          child: Column(
                                                            children: <
                                                                Widget>[
                                                              Flexible(
                                                                flex: 1,
                                                                child:
                                                                    Container(
                                                                  child:
                                                                      FlatButton(
                                                                    child: Image
                                                                        .asset(
                                                                      'images/menu/2.png',
                                                                      width: MediaQuery.of(context).size.width /
                                                                          2.0,
                                                                      height: MediaQuery.of(context).size.height /
                                                                          11.0,
                                                                    ),
                                                                    onPressed:
                                                                        () {
//                                                                Toast.show("Cooming Soon", context,
//                                                                    duration: 4, gravity: Toast.BOTTOM);

                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(builder: (context) => (Landing())));
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                              Flexible(
                                                                flex: 1,
                                                                child:
                                                                    Container(
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: Text(
                                                                      'E learning',
                                                                      style: blackTextfont.copyWith(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        flex: 1,
                                                        child: Container(
                                                          //color: Colors.blueAccent,
                                                          child: Column(
                                                            children: <
                                                                Widget>[
                                                              Flexible(
                                                                flex: 1,
                                                                child:
                                                                    Container(
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            10,
                                                                        left:
                                                                            10,
                                                                        bottom:
                                                                            0,
                                                                        top:
                                                                            0),
                                                                    child:
                                                                        FlatButton(
                                                                      child: Image
                                                                          .asset(
                                                                        'images/menu/3.png',
                                                                        width:
                                                                            MediaQuery.of(context).size.width / 2.0,
                                                                        height:
                                                                            MediaQuery.of(context).size.height / 11.0,
                                                                      ),
                                                                      onPressed:
                                                                          () =>
                                                                              setState(() {
                                                                        _launched =
                                                                            _launchInBrowser(toLaunch);
                                                                      }),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Flexible(
                                                                flex: 1,
                                                                child:
                                                                    Container(
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: Text(
                                                                      'E-Psikotes',
                                                                      style: blackTextfont.copyWith(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        flex: 1,
                                                        child: Container(
                                                          //color: Colors.pink,
                                                          child: Column(
                                                            children: <
                                                                Widget>[
                                                              Flexible(
                                                                flex: 1,
                                                                child:
                                                                    Container(
                                                                  height: 200,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            10,
                                                                        left:
                                                                            10,
                                                                        bottom:
                                                                            0,
                                                                        top:
                                                                            0),
                                                                    child:
                                                                        FlatButton(
                                                                      child: Image
                                                                          .asset(
                                                                        'images/menu/4.png',
                                                                        width:
                                                                            MediaQuery.of(context).size.width / 2.0,
                                                                        height:
                                                                            MediaQuery.of(context).size.height / 11.0,
                                                                      ),

                                                                      // onPressed: _updateInfo?.updateAvailable ==
                                                                      //         true
                                                                      //     ? () {
                                                                      //         InAppUpdate.startFlexibleUpdate().then((_) {
                                                                      //           setState(() {
                                                                      //             _flexibleUpdateAvailable = true;
                                                                      //           });
                                                                      //         }).catchError((e) => _showError(e));
                                                                      //       }
                                                                      //     : null,
                                                             onPressed: () {

//                                                                Toast.show("Cooming Soon", context,
//                                                                    duration: 4, gravity: Toast.BOTTOM);

                                                             },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Flexible(
                                                                flex: 1,
                                                                child:
                                                                    Container(
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: Text(
                                                                      'Langganan',
                                                                      style: blackTextfont.copyWith(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              // pembatas

                                              Flexible(
                                                flex: 1,
                                                child: Container(
                                                  // color: Colors.yellowAccent,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 4),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Flexible(
                                                          flex: 1,
                                                          child: Container(
                                                            //color: Colors.yellowAccent,
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                Flexible(
                                                                  flex: 1,
                                                                  child:
                                                                      Container(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              10,
                                                                          left:
                                                                              10,
                                                                          bottom:
                                                                              0,
                                                                          top:
                                                                              0),
                                                                      child:
                                                                          FlatButton(
                                                                        child: Image
                                                                            .asset(
                                                                          'images/menu/5.png',
                                                                          width:
                                                                              MediaQuery.of(context).size.width / 2.0,
                                                                          height:
                                                                              MediaQuery.of(context).size.height / 11.0,
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(builder: (context) => (ListLowongan_DW())));
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Flexible(
                                                                  flex: 1,
                                                                  child:
                                                                      Container(
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Text(
                                                                        'Daily worker',
                                                                        style: blackTextfont.copyWith(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Flexible(
                                                          flex: 1,
                                                          child: Container(
                                                            //color: Colors.redAccent,
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                Flexible(
                                                                  flex: 1,
                                                                  child:
                                                                      Container(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              10,
                                                                          left:
                                                                              0,
                                                                          bottom:
                                                                              0,
                                                                          top:
                                                                              0),
                                                                      child:
                                                                          FlatButton(
                                                                        child: Image
                                                                            .asset(
                                                                          'images/menu/6.png',
                                                                          width:
                                                                              MediaQuery.of(context).size.width / 2.0,
                                                                          height:
                                                                              MediaQuery.of(context).size.height / 11.0,
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          Toast.show(
                                                                              "Cooming Soon",
                                                                              context,
                                                                              duration: 4,
                                                                              gravity: Toast.BOTTOM);
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Flexible(
                                                                  flex: 1,
                                                                  child:
                                                                      Container(
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.only(left: 8,top: 8,bottom: 8,right: 12),
                                                                      child: Text(
                                                                        'News',
                                                                        style: blackTextfont.copyWith(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Flexible(
                                                          flex: 1,
                                                          child: Container(
                                                            //color: Colors.blueAccent,
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                Flexible(
                                                                  flex: 1,
                                                                  child:
                                                                      Container(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              10,
                                                                          left:
                                                                              0,
                                                                          bottom:
                                                                              0,
                                                                          top:
                                                                              0),
                                                                      child:
                                                                          FlatButton(
                                                                        child: Image
                                                                            .asset(
                                                                          'images/menu/7.png',
                                                                          width:
                                                                              MediaQuery.of(context).size.width / 2.0,
                                                                          height:
                                                                              MediaQuery.of(context).size.height / 11.0,
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          Toast.show(
                                                                              "Cooming Soon",
                                                                              context,
                                                                              duration: 4,
                                                                              gravity: Toast.BOTTOM);
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Flexible(
                                                                  flex: 1,
                                                                  child:
                                                                      Container(
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Text(
                                                                        'Tips & Trick',
                                                                        style: blackTextfont.copyWith(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Flexible(
                                                          flex: 1,
                                                          child: Container(
                                                            //color: Colors.pink,
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                Flexible(
                                                                  flex: 1,
                                                                  child:
                                                                      Container(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              10,
                                                                          left:
                                                                              0,
                                                                          bottom:
                                                                              0,
                                                                          top:
                                                                              0),
                                                                      child:
                                                                          FlatButton(
                                                                        child: Image
                                                                            .asset(
                                                                          'images/menu/8.png',
                                                                          width:
                                                                              MediaQuery.of(context).size.width / 2.0,
                                                                          height:
                                                                              MediaQuery.of(context).size.height / 11.0,
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          Toast.show(
                                                                              "Cooming Soon",
                                                                              context,
                                                                              duration: 4,
                                                                              gravity: Toast.BOTTOM);
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Flexible(
                                                                  flex: 1,
                                                                  child:
                                                                      Container(
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Text(
                                                                        'Lainnya',
                                                                        style: blackTextfont.copyWith(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
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
                                      SizedBox(
                                        height: 4,
                                      ),
//                                      Container(
//                                        padding: EdgeInsets.only(
//                                            bottom: 12,
//                                            right: 12,
//                                            left: 12,
//                                            top: 12),
//                                        color: mainColor,
//                                        child: Card(
//                                          child: Text(
//                                            'Top Lowongan',
//                                            style: blackTextfont.copyWith(
//                                                fontSize: 16,
//                                                fontWeight: FontWeight.w600),
//                                          ),
//                                        ),
//                                      ),

                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                16,
                                        decoration:
                                            new BoxDecoration(color: birumuda),
                                        child: new Center(
                                          child: new Text("TOP LOWONGAN KERJA",
                                              style: whiteNumberFont.copyWith(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 14,
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                          color: Colors.white,
                                          child: _isSearch
                                              ? FutureBuilder(
                                                  future: getLowongan(),
                                                  builder: (BuildContext
                                                          context,
                                                      AsyncSnapshot snapshot) {
                                                    return snapshot.hasData
                                                        ? ItemList(
                                                            list: snapshot.data,
                                                            globalid_employee:
                                                                globalid_employee,
                                                            mystatus: mystatus)
                                                        : Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          );
                                                  },
                                                )
                                              : FutureBuilder(
                                                  future: search(),
                                                  builder: (BuildContext
                                                          context,
                                                      AsyncSnapshot snapshot) {
                                                    return snapshot.hasData
                                                        ? ItemListSearch(
                                                            list: snapshot.data)
                                                        : Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          );
                                                  },
                                                ),
                                        ),
                                      ),
                                    ],
                                  )
                                : FutureBuilder(
                                    future: search(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      return snapshot.hasData
                                          ? ItemListSearch(list: snapshot.data)
                                          : Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                    },
                                  ),
                          ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConnectionStatusBar(),
          ),
        ],
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
    return Container(
      height: 450,
      child: ListView.builder(

        scrollDirection: Axis.vertical,
        itemCount: list.length,
        itemBuilder: (context, index) {
          final xlowongan = list[index];
          return Container(
            height: MediaQuery.of(context).size.height / 4.9,
            child: Card(
              elevation: 2,
              child: InkWell(
                onTap: () {
                  if (xlowongan.jenispekerjaan == "Daily Worker") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Detail_lowongan_DW(
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
                                  jenjang_career_id: xlowongan.jenjangCareerId
                                              .toString() ==
                                          null
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
                             // jenispekerjaan : xlowongan.jenispekerjaan.toString() == null ? "" : xlowongan.jenispekerjaan.toString(),
                                )));
                  } else {
                    Navigator.push(
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
                                  jenjang_career_id: xlowongan.jenjangCareerId
                                              .toString() ==
                                          null
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
                              jenispekerjaan : xlowongan.jenispekerjaan.toString() == null ? "" : xlowongan.jenispekerjaan.toString(),
                                )));
                  }
                },
                child: SingleChildScrollView(
//                  shrinkWrap: true,
//                  physics: NeverScrollableScrollPhysics(),
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
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 3,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    xlowongan.posisi,
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: birumuda,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
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
                                      fontWeight: FontWeight.bold
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: mystatus == true
                                          ? Text("Ingin Menyimpan Lowongan ?")
                                          : Text("Silahkan Anda Login Dulu !!"),
                                      content: Text(xlowongan.posisi),
                                      actions: <Widget>[
                                        FlatButton(
                                          onPressed: () {
                                            //Navigator.push(context,MaterialPageRoute (builder:(context)=>Myhome()));
                                            // simpan_lowongan()
                                            //print(id_user);
                                            if (mystatus == true) {
                                              simpanLowongan(
                                                  xlowongan.idLowongan,
                                                  globalid_employee,
                                                  context);
                                              Navigator.pop(context);
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Login()));
                                            }
                                          },
                                          child: Text("Ya"),
                                        ),
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Tidak"),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Image.asset(
                              "images/menu/save_lowongan.png",
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ],
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
            ),
          );
        },
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
//      Navigator.pop();
//      Navigator.of(context).pop();
//      Navigator.pop(context);

  } else {
    print("gagal disimpan lowongan");
  }

//    print("idlowongan${idLowongan}");
//    print("id_employee${globalid_employee}");
}

class ItemListSearch extends StatelessWidget {
  List list;
  ItemListSearch({this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 850,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: list.length,
        itemBuilder: (context, index) {
          final xlowongan = list[index];
          return Container(
            height: MediaQuery.of(context).size.height / 4.9,
            child: Card(
              elevation: 5,
              child: InkWell(
                onTap: () {
                  Navigator.push(
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
                            jenispekerjaan : xlowongan.jenispekerjaan.toString() == null
                                ? "" : xlowongan.jenispekerjaan.toString(),


                              )));
                },
                child: SingleChildScrollView(
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
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Text(
                                    xlowongan.posisi,
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  xlowongan.provinceId,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  xlowongan.namaPerusahaan,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Fulltime",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
//                        FlatButton(
//                          onPressed: () {},
//                          child: Icon(Icons.save),
//                        )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                                xlowongan.totalPelamar.toString() + " Pelamar"),
                            Text(xlowongan.datePostEnd.toString()),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
