import 'package:flutter/material.dart';
import 'package:gaweid2/model/user/ModelLowongan.dart';
import 'package:gaweid2/model/user/ModelLowongan2.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/lowongan/Component/itemLowonganScrool.dart';
import 'package:gaweid2/modules/lowongan/view/filter.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;

class ListLowongan extends StatefulWidget {


  @override
  _LowonganState createState() => _LowonganState();
}

class _LowonganState extends State<ListLowongan> {
  List<ModelLowongan> lowongan = [];
  var loading = false;

  Future<List> getLowongan() async{
    final response = await http.get(NetworkConfig().baseUrl+"apps/lowongan");
    ModelLowongan2 listdata = modelLowongan2FromJson(response.body);
    if(response.statusCode==200){
      //print("get data succeessfully");
    }else{
      // print("Get Data Failed");
    }
    return listdata.lowongan;
  }

  var globalName = "", globalEmail = "", globalLevel = "",id_user = "",globalid_employee = "",globalprofil_power = "";
  var status = false;
  // var id_user;
//  var value;
  var mystatus;

  SessionManager sessionManager = SessionManager();

  void getPreferences()async{
    await sessionManager.getPreference().then((value) {
      setState(() {
        mystatus = sessionManager.status;
        globalName = sessionManager.fullname;
        globalEmail = sessionManager.email;
        id_user = sessionManager.iduser;
        globalprofil_power = sessionManager.profile_power;
        globalid_employee = sessionManager.id_employee;

        print("globalid_employee${globalid_employee}");
        print("profil power${globalprofil_power}");
//        print("fullname${globalName}");
//        print("email${globalEmail}");
//        print("global $globalLevel");
        //_loginStatus = mystatus == true ? LoginStatus.Login : LoginStatus.not_login;
      });
    });
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getLowongan();
    getPreferences();
  }

  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lowongan'),
          backgroundColor: mainColor,
        ),
        body: FutureBuilder(
          future: getLowongan(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return snapshot.hasData
                ? ItemListLowonganScrool(list:snapshot.data,globalid_employee:globalid_employee,mystatus:mystatus)
                : Center(child: CircularProgressIndicator(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator
                .of(context)
                .push(new MaterialPageRoute(builder: (BuildContext context) => Filter()));
          },
          label: Text('Filter'),
          icon: Icon(Icons.search),
          backgroundColor: Colors.orange,
        ),
      ),
    );
  }
}





