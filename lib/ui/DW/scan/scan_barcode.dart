import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/ui/User/Fragment/Myjob.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class ScanBarcode extends StatefulWidget {
  final id;

  ScanBarcode({
    this.id,
  });

  @override
  _ScanBarcodeState createState() => _ScanBarcodeState();
}

class _ScanBarcodeState extends State<ScanBarcode> {
  String barcode = "";
  String code = "text";
  var InSignIn = false;
  var absen_bloc = true;
  String alasanpulang;

  // Future ScanBarcode() async {
  //   barcode = await FlutterBarcodeScanner.scanBarcode(
  //       "#ff6666", "Cancel", true, ScanMode.QR);
  //   setState(() {
  //     code = barcode;
  //     Absensi(code);
  //     print(barcode);
  //     //Toast.show("${barcode}", context, duration: 3, gravity: Toast.BOTTOM);
  //   });
  // }

  BaseEndPoint network = NetworkProvider();

  void validasi() async {
    if (_formKey.currentState.validate()) {
      //JIKA TRUE
      _formKey.currentState.save(); //MAKA FUNGSI SAVE() DIJALANKAN
      print("etalasanpulangtelat${etalasanpulangtelat.text.toString()}");
      //register_datadiri1();
      ModelRegister data = await network.pulangtelat(
          widget.id.toString(), etalasanpulangtelat.text.toString());

      if (data.status == 200) {
        setState(() {
          InSignIn = true;
        });

        Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => Myjob(),
        ));

        Toast.show("Success", context, duration: 3, gravity: Toast.BOTTOM);
      }
    }
    ;
  }

  String nikvalidator(String value) {
    if (value.length < 4) {
      return "must be length 4";
    } else {
      return null;
    }
  }

  TextEditingController etalasanpulangtelat = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void pulangtelat() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Anda Pulang Telat ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            content: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 16),
                  Row(children: <Widget>[
                    Text("Alasan Pulang Telat"),
                    Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    )
                  ]),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: etalasanpulangtelat,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Alasan Pulang Telat",
                      hintText: "Alasan Pulang Telat",
                    ),
                    validator: nikvalidator,
                    // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                    onSaved: (value) {
                      alasanpulang = value;
                    },
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: InSignIn
                        ? SpinKitFadingCircle(
                            color: Colors.blue,
                          )
                        : RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            onPressed: () {
                              validasi();
                            },
                            color: Colors.green,
                            child: Text("Simpan",
                                style: TextStyle(color: Colors.white)),
                          ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void show(Goto) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Terimakasih ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            content: Text("Anda Telah Melakukan Absen ${Goto}"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  "Kembali",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                color: Colors.white,
              ),
            ],
          );
        });
  }

  bool status_chek_absen = true;

  void Absensi(String code) async {
    ModelRegister data = await network.absensi_dw(widget.id.toString(), code);

    if (data.status == 200) {
      show("Masuk");
      Toast.show("Absen Masuk Berhasil", context,
          duration: 3, gravity: Toast.BOTTOM);
    } else if (data.status == 202) {
      show("Pulang");
      Toast.show("Absen Keluar Berhasil", context,
          duration: 3, gravity: Toast.BOTTOM);
    } else if (data.status == 702) {
      pulangtelat();
    } else {
      show("GAGAL");
      Toast.show("Absen Gagal", context, duration: 3, gravity: Toast.BOTTOM);
    }
  }

  String absen = "Absen";

  Future check_dw() async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/check_absen_masuk_keluar", body: {
      'id_dw_active': widget.id.toString(),
    });
    ModelRegister listData = modelRegisterFromJson(response.body);

    if (listData.status == 200) {
      setState(() {
        absen = "Absen Masuk";
      });
      setState(() {
        absen_bloc = false;
      });
    } else if (listData.status == 702) {
      setState(() {
        absen = "Absen Keluar1";
      });
      setState(() {
        absen_bloc = false;
      });
    } else if (listData.status == 602) {
      absen = "Absen Keluar 2";
      setState(() {
        status_chek_absen = false;
      });
      setState(() {
        absen_bloc = false;
      });
    } else if (listData.status == 402) {
      setState(() {
        absen = "Absen Keluar";
      });
      setState(() {
        absen_bloc = false;
      });
    } else {
      absen = "Absen Masuk /";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_dw();
  }

  @override
  Widget build(BuildContext context) {
    print("status_chek_absen${status_chek_absen}");
    print("absen${absen}");

    return Scaffold(
        appBar: AppBar(
          title: Text('Absensi'),
          backgroundColor: mainColor,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Visibility(
                visible: status_chek_absen,
                child: absen_bloc
                    ? SpinKitFadingCircle(
                  color: Colors.redAccent,
                )
                    : RaisedButton(
                  child: Text(
                    absen,
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    ScanBarcode();
                  },
                ),
              ),
              //Text(code),
            ],
          ),
        ));
  }
}
