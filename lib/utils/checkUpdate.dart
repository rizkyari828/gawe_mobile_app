import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class CheckUpdate extends StatefulWidget {
  @override
  _CheckUpdateState createState() => _CheckUpdateState();
}

class _CheckUpdateState extends State<CheckUpdate> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  AppUpdateInfo _updateInfo;
  int statusUpdate = 0;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  bool _flexibleUpdateAvailable = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkForUpdate();
    _initPackageInfo();
  }

  // checkLatestVersion(context) async {
  //   await Future.delayed(Duration(seconds: 5));
  //
  //   //Add query here to get the minimum and latest app version
  //
  //   //Change
  //   //Here is a sample query to ParseServer(open-source NodeJs server with MongoDB database)
  //   var queryBuilder = QueryBuilder<AppVersion>(AppVersion())
  //     ..orderByDescending("publishDate")
  //     ..setLimit(1);
  //
  //   var response = await queryBuilder.query();
  //
  //   if (response.success) {
  //     //Change
  //     //Parse the result here to get the info
  //     AppVersion appVersion = response.results[0] as AppVersion;
  //     Version minAppVersion = Version.parse(appVersion.minAppVersion);
  //     Version latestAppVersion = Version.parse(appVersion.version);
  //
  //     PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //     Version currentVersion = Version.parse(packageInfo.version);
  //
  //     if (minAppVersion > currentVersion) {
  //       print('Update available');
  //       // _showCompulsoryUpdateDialog(
  //       //   context,
  //       //   "Please update the app to continue\n${appVersion.about ?? ""}",
  //       // );
  //     } else if (latestAppVersion > currentVersion) {
  //       // SharedPreferences sharedPreferences =
  //       // await SharedPreferences.getInstance();
  //       //
  //       // bool showUpdates = false;
  //       // showUpdates = sharedPreferences.getBool(kUpdateDialogKeyName);
  //       // if (showUpdates != null && showUpdates == false) {
  //       //   return;
  //       // }
  //       //
  //       // _showOptionalUpdateDialog(
  //       //   context,
  //       //   "A newer version of the app is available\n${appVersion.about ?? ""}",
  //       // );
  //       print('Update available');
  //     } else {
  //       print('App is up to date');
  //     }
  //   }
  // }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Widget _infoTile(String title, String subtitle) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle.isNotEmpty ? subtitle : 'Not set'),
    );
  }
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkForUpdate() async {

    InAppUpdate.checkForUpdate().then((info) {
      print(info.updateAvailability);
      setState(() {
        statusUpdate = info.updateAvailability;
        _updateInfo = info;
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await Get.defaultDialog(
            title: "Perbarui Aplikasi",
            middleText: "Yuk, perbarui aplikasi kamu untuk menikmati fitur terbaru",
            onCancel: () => {},
            textCancel: "Nanti",
            onConfirm: () => launch("https://play.google.com/store/apps/details?id=id.gawe.gaweid2&hl=en&gl=US"),
            textConfirm: "Perbarui",
            backgroundColor: Colors.white,
            titleStyle: TextStyle(color: Colors.black54),
            middleTextStyle: TextStyle(color: Colors.black54),

          );
        });
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('In App Update Example App'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              _infoTile('App name', _packageInfo.appName),
              _infoTile('Package name', _packageInfo.packageName),
              _infoTile('App version', _packageInfo.version),
              _infoTile('Build number', _packageInfo.buildNumber),

              Center(
                child: Text('Update info: $_updateInfo'),
              ),
              ElevatedButton(
                child: Text(statusUpdate.toString()),
                onPressed: () => statusUpdate == 1 ? Get.defaultDialog(
                  title: "Perbarui Aplikasi",
                  middleText: "Yuk, perbarui aplikasi kamu untuk menikmati fitur terbaru",
                  onCancel: () => {},
                  textCancel: "Nanti",
                  onConfirm: () => launch("https://play.google.com/store/apps/details?id=id.gawe.gaweid2&hl=en&gl=US"),
                  textConfirm: "Perbarui",
                  backgroundColor: Colors.white,
                  titleStyle: TextStyle(color: Colors.black54),
                  middleTextStyle: TextStyle(color: Colors.black54),

                ) : "",
              ),
              ElevatedButton(
                child: Text('Perform immediate update'),
                onPressed: _updateInfo?.updateAvailability ==
                    UpdateAvailability.updateAvailable
                    ? () {
                  InAppUpdate.performImmediateUpdate()
                      .catchError((e) => showSnack(e.toString()));
                }
                    : null,
              ),
              ElevatedButton(
                child: Text('Start flexible update'),
                onPressed: _updateInfo?.updateAvailability ==
                    UpdateAvailability.updateAvailable
                    ? () {
                  InAppUpdate.startFlexibleUpdate().then((_) {
                    setState(() {
                      _flexibleUpdateAvailable = true;
                    });
                  }).catchError((e) {
                    showSnack(e.toString());
                  });
                }
                    : null,
              ),
              ElevatedButton(
                child: Text('Complete flexible update'),
                onPressed: !_flexibleUpdateAvailable
                    ? null
                    : () {
                  InAppUpdate.completeFlexibleUpdate().then((_) {
                    showSnack("Success!");
                  }).catchError((e) {
                    showSnack(e.toString());
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

