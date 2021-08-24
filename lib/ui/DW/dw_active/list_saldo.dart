import 'package:flutter/material.dart';
import 'package:gaweid2/model/dw/model_riwayat_saldo.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;

class listSaldo extends StatefulWidget {
  @override
  _listSaldoState createState() => _listSaldoState();
}

class _listSaldoState extends State<listSaldo> {
  BaseEndPoint network = NetworkProvider();

  var loading = false;
  Future<List> getriwayat_saldo() async {
    setState(() {
      loading = true;
    });
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/riwayat_saldo", body: {
      'id_employee': globalid_employee,
    });
    ModelRiwayatSaldo listdata = modelRiwayatSaldoFromJson(response.body);

    //print("ts${listdata.dwRiwayatPekerjaan}");

    if (response.statusCode == 200) {
      //print("get data succeessfully detail");
      //print(listdata);
      //print("lowongan${listdata.lowongan}");
    } else {
      print("getNotifikasi");
    }
    return listdata.dwRiwayatSaldo;
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
    getriwayat_saldo();
    getPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Gawe.id"),
          backgroundColor: mainColor,
        ),
        body: Column(
          children: <Widget>[
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Saldo Masuk",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                    Text("Tanggal Saldo Masuk",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: getriwayat_saldo(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.hasData
                      ? ItemList(
                      list: snapshot.data,
                      globalid_employee: globalid_employee)
                      : Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        )
    );
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
        final DwRiwayatSaldo riwayatSaldo = list[i];

        if (riwayatSaldo.id == "0000") {
          return Container(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
//                    Image.asset(
//                      'images/kategori/LowonganTersimpan.png',
//                      height: MediaQuery.of(context).size.height / 2,
//                      width: MediaQuery.of(context).size.width,
//                    ),
                    Text(
                      'Tidak Ada Saldo',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
          );
        } else {
          return SingleChildScrollView(
            child: InkWell(
              onTap: () {},
              child: Card(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text("Rp. ${riwayatSaldo.saldoMasuk}"),
                          Text(riwayatSaldo.tanggalSaldoMasuk),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }



      },
    );
  }
}
