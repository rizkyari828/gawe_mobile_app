import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gaweid2/modules/user/models/Model_Notifikasi.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/user/view/Login.dart';
import 'package:gaweid2/ui/User/Fragment/HomeUser.dart';
import 'package:gaweid2/ui/User/Fragment/Lowonganku.dart';
import 'package:gaweid2/ui/User/Fragment/Myjob.dart';
import 'package:gaweid2/ui/User/Fragment/Notifikasi.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;

class UserDashboard extends StatefulWidget {
  final VoidCallback sigOut;

  UserDashboard({this.sigOut});

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<UserDashboard>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  void sigOut() {
    widget.sigOut();
  }

  String name, email, password1, confrim_password, globalid_employee;
  var globalName = "", globalEmail = "", globalLevel = "";
  var status = false;
  var id_user;
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
      });
    });
  }

  String not_read;

  Future getNotifikasi(id_employee) async {
    final response = await http.post(
        NetworkConfig().baseUrl + "apps/notifikasi",
        body: {'employee_id': id_employee});

    final listdata = jsonDecode(response.body);
    ModelNotifikasi notif = ModelNotifikasi.fromJson(listdata);

    setState(() {
      not_read = notif.not_read;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPreferences();
    getNotifikasi(globalid_employee);
    tabController = new TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    //print("statustes${globalid_employee}");
    return Scaffold(
        backgroundColor: mainColor,
      body: Padding(
        padding: const EdgeInsets.only(top:25.0),
        child: Column(children: <Widget>[
          _index == 0 ? HomeUserPage(context) : (_index == 1 ? LowongankuPage(context) : _index == 2 ? MyjobPage(context) : NotifikasiPage(context)),
          // Spacer(),
          Container(
            height: MediaQuery.of(context).size.height / 10,
            constraints: BoxConstraints(maxHeight: 50),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 2.0,
                ),
              ],
            ),
            // color: Colors.white,
            child: Row(
              children: <Widget>[
                Spacer(),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      _index = 0;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(color: _index == 0 ? mainColor : Colors.transparent, borderRadius: BorderRadius.circular(25)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height/ 250, horizontal: MediaQuery.of(context).size.width/ 50),
                      child: Row(
                        children: <Widget>[
                            Icon(Icons.home_rounded, color: _index == 0 ? Colors.white : Colors.blueGrey,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(_index == 0 ? 'Beranda' : "", style: TextStyle(color: _index == 0 ? Colors.white : Colors.blueGrey,),)
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      _index = 1;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(color: _index == 1 ? mainColor : Colors.transparent, borderRadius: BorderRadius.circular(25)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height/ 250, horizontal: MediaQuery.of(context).size.width/ 50),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.assignment_rounded, color: _index == 1 ? Colors.white : Colors.blueGrey,),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(_index == 1 ? 'Aktifitas' : "", style: TextStyle(color: _index == 1 ? Colors.white : Colors.blueGrey,),)
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        _index = 2;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(color: _index == 2 ? mainColor : Colors.transparent, borderRadius: BorderRadius.circular(25)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height/ 250, horizontal: MediaQuery.of(context).size.width/ 50),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.work_rounded, color: _index == 2 ? Colors.white : Colors.blueGrey,),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(_index == 2 ? 'Pekerjaan' : "", style: TextStyle(color: _index == 2 ? Colors.white : Colors.blueGrey,),)
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      _index = 3;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(color: _index == 3 ? mainColor : Colors.transparent, borderRadius: BorderRadius.circular(25)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.height/ 250, horizontal: MediaQuery.of(context).size.width/ 50),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.notifications, color: _index == 3 ? Colors.white : Colors.blueGrey,),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(_index == 3 ? 'Notifikasi' : "", style: TextStyle(color: _index == 3 ? Colors.white : Colors.blueGrey,),)
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          )
        ],),
      )
    );
  }

  @override
  Widget HomeUserPage(BuildContext context){
    return Expanded(
      child: HomeUser(),
    );
  }

  @override
  Widget LowongankuPage(BuildContext context){
    return Expanded(
      child: Lowonganku(),
    );
  }

  @override
  Widget MyjobPage(BuildContext context){
    return Expanded(
      child: Myjob(),
    );
  }

  @override
  Widget NotifikasiPage(BuildContext context){
    return Expanded(
      child: Notifikasi(),
    );
  }

  Widget ShowDialog() {
    return AlertDialog(
      title: Text("Akun"),
      content: Text("Anda Belum Login"),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(new MaterialPageRoute(
                builder: (BuildContext context) => Login()));
          },
          child: Text("Login"),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(new MaterialPageRoute(
                builder: (BuildContext context) => UserDashboard()));
          },
          child: Text("Kembali"),
        ),
      ],
    );
  }
}
