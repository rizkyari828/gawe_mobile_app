import 'package:flutter/material.dart';
import 'package:gaweid2/model/dw/model_riwayat_pekerjaan.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/ui/DW/dw_active/list_absensi.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class riwayat_absensi extends StatefulWidget {
  @override
  _riwayat_absensiState createState() => _riwayat_absensiState();
}

class _riwayat_absensiState extends State<riwayat_absensi> {
  BaseEndPoint network = NetworkProvider();

  var loading = false;
  Future<List> getriwayat_pekerjaan() async {
    setState(() {
      loading = true;
    });
    final response = await http.post(
        NetworkConfig().baseUrl + "apps/riwayat_pekerjaan",
        body: {'id_employee': globalid_employee});
    ModelRiwayatPekerjaan listdata =
        modelRiwayatPekerjaanFromJson(response.body);

    print("ts${listdata.dwRiwayatPekerjaan}");

    if (response.statusCode == 200) {
      //print("get data succeessfully detail");
      //print(listdata);
      //print("lowongan${listdata.lowongan}");
    } else {
      print("getNotifikasi");
    }
    return listdata.dwRiwayatPekerjaan;
  }

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getLowongan();
    getriwayat_pekerjaan();
    getPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Gawe.id"),
          backgroundColor: mainColor,
        ),
        body: FutureBuilder(
          future: getriwayat_pekerjaan(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return snapshot.hasData
                ? ItemList(
                    list: snapshot.data, globalid_employee: globalid_employee)
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ));
  }
}

class ItemList extends StatelessWidget {
  List list;
  String globalid_employee;

  ItemList({
    this.list,
    this.globalid_employee,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (BuildContext context, int i) {
        final DwRiwayatPekerjaan riwayatPekerjaan = list[i];
        return SingleChildScrollView(
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => (ListAbsensi(
                            idLowongan: riwayatPekerjaan.idLowongan == null
                                ? ""
                                : riwayatPekerjaan.idLowongan,
                            employee_id: globalid_employee == null
                                ? ""
                                : globalid_employee,
                            id: riwayatPekerjaan.id == null
                                ? ""
                                : riwayatPekerjaan.id,
                          ))));

              //Toast.show(globalid_employee, context, duration: 3, gravity: Toast.BOTTOM);
            },
            child: Card(
              child: Column(
                children: <Widget>[
                  Center(
                      child: Text(
                    riwayatPekerjaan.client,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(riwayatPekerjaan.cleintLocation),
                        Text(riwayatPekerjaan.jobOrder),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
