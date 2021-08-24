import 'package:flutter/material.dart';
import 'package:gaweid2/modules/learning/views/kelas_saya.dart';
import 'package:gaweid2/modules/learning/views/landing.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';

class MenuLearning extends StatefulWidget {
  @override
  _MenuLearningState createState() => _MenuLearningState();
}

class _MenuLearningState extends State<MenuLearning> with SingleTickerProviderStateMixin{
  BaseEndPoint network = NetworkProvider();
  var loading = false;


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

  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    getPreferences();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('e-Learning'),
        backgroundColor: mainColor,
        centerTitle: true,
        bottom: TabBar(
          tabs: [
            Tab(
              text: 'Katalog',
              icon: Icon(Icons.list_alt_rounded),
            ),
            Tab(text: 'Kelas Saya', icon: Icon(Icons.menu_book)),
            Tab(text: 'e-Sertifikasi', icon: Icon(Icons.fact_check_rounded))
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        Landing(),
        kelasSaya(),
        Center(child: Text('Coming Soon')),
      ]),

    );
  }
}
