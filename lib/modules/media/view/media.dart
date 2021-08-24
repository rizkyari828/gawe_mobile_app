import 'package:flutter/material.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/media/view/event.dart';
import 'package:gaweid2/modules/media/view/news.dart';
import 'package:gaweid2/modules/media/view/tips.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';

class Media extends StatefulWidget {
  @override
  _MediaState createState() => _MediaState();
}

class _MediaState extends State<Media> with SingleTickerProviderStateMixin{
  BaseEndPoint network = NetworkProvider();
  var loading = false;


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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Media'),
        backgroundColor: mainColor,
        centerTitle: true,
        bottom: TabBar(
          tabs: [
            Tab(
              text: 'Berita',
              icon: Icon(Icons.select_all),
            ),
            Tab(text: 'Tips dan Trik', icon: Icon(Icons.new_releases)),
            Tab(text: 'Event', icon: Icon(Icons.event_available_rounded))
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        NewsPage(),
        TipsPage(),
        EventPage()
      ]),

    );
  }
}
