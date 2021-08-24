import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/modules/learning/models/overview_model.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/learning/views/modul.dart';
import 'package:gaweid2/modules/learning/views/penempatan.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class Overview extends StatefulWidget {
  @override
  _OverviewState createState() => _OverviewState();
  final id_landing, kategori, desc, namaPerusahaan,statusBerbayar,codeGenerate;
  Overview({
    this.id_landing,
    this.kategori,
    this.desc,
    this.namaPerusahaan,
    this.statusBerbayar,
    this.codeGenerate
  });
}

class _OverviewState extends State<Overview> {
  var InSignIn = false;

  BaseEndPoint network = NetworkProvider();

  Future<List<Category>> getOverview() async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps_learning/overview", body: {
      'id_landing': "18",
    });

    return modelOverviewFromJson(response.body).category;

  }

  final _formKey = GlobalKey<FormState>();

  String name, email, password1, confrim_password;
  var globalName = "",
      globalEmail = "",
      globalLevel = "",
      globalid_employee = "";

  var status = false;
  var mystatus;

  SessionManager sessionManager = SessionManager();

  void validasi() async {
      //activasi
      //kode_referal

       Toast.show("Harap Tunggu ...", context, duration: 3, gravity: Toast.BOTTOM);
        //login();


        setState(() {
          InSignIn = true;
        });
       overview();

  }

  void overview()async{
    ModelRegister data = await network.overview(
        globalEmail,widget.codeGenerate,"SIM-001");

    if (data.status == 200) {
      setState(() {
        InSignIn = false;
      });

      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => UI_Modul(
          kodelearning: widget.codeGenerate,
        ),
      ));

      Toast.show("Success", context, duration: 3, gravity: Toast.TOP);
    } else if (data.status == 201)
    {
        setState(() {
          InSignIn = false;
        });

        Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => penempatan(
            kodelearning: widget.codeGenerate,
          ),
        ));
    }
    else if (data.status == 202){

      setState(() {
        InSignIn = false;
      });

      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => penempatan(
          kodelearning: widget.codeGenerate,
        ),
      ));

    } else if (data.status == 203){

      setState(() {
        InSignIn = false;
      });

      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => penempatan(
          kodelearning: widget.codeGenerate,
        ),
      ));

    }

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.kategori),
        backgroundColor: mainColor,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
                child: Container(
                    child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [Text("Nama Modul"), Text(widget.kategori)],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text("Tentang Learning"),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: InSignIn
                            ? SpinKitFadingCircle(
                          color: Colors.redAccent,
                        )
                            : RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          onPressed: () {
                            validasi();
                          },
                          color: Colors.blue,
                          child: Text("Ikuti Learning",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [Text("Tentang Learning"), Text(widget.desc)],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text("Penyelenggara"),
                      Text(widget.namaPerusahaan)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [Text("Harga"), Text(widget.statusBerbayar)],
                  ),
                ),
              ],
            ))),
          ),
        ],
      ),
    );
  }
}
