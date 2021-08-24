import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gaweid2/constant/constant.dart';
import 'package:gaweid2/modules/user/view/menu/UserDashboard.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:in_app_update/in_app_update.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
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

  Future<Timer> loadData() async {
    return Timer(Duration(seconds: 4), onDonLoading);
  }

  @override
  void initState() {
    // TODO: implement initState

    loadData();
  }

  void onDonLoading() {
    Navigator.pushReplacement((context), MaterialPageRoute(builder: (context) => UserDashboard()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Image.asset("images/mockup_splashscreen.png", fit: BoxFit.fill)
    );
  }
}
