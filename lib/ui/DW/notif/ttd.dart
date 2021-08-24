import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:path_provider/path_provider.dart';

class MyHomePage extends StatefulWidget {
   final id,hariini,lokasi_penempatan;
  MyHomePage({
    Key key,
    this.id,
    this.hariini,
    this.lokasi_penempatan
  }): super(
      key: key

  );







  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _WatermarkPaint extends CustomPainter {
  final String price;
  final String watermark;

  _WatermarkPaint(this.price, this.watermark);

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 10.8,
        Paint()..color = Colors.transparent);
  }

  @override
  bool shouldRepaint(_WatermarkPaint oldDelegate) {
    return oldDelegate != this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _WatermarkPaint &&
          runtimeType == other.runtimeType &&
          price == other.price &&
          watermark == other.watermark;

  @override
  int get hashCode => price.hashCode ^ watermark.hashCode;
}

class _MyHomePageState extends State<MyHomePage> {
  BaseEndPoint network = NetworkProvider();

  ByteData _img = ByteData(0);

  var loading_ttd = false;

  File image;
  var color = Colors.black;
  var strokeWidth = 5.0;
  final _sign = GlobalKey<SignatureState>();

  String name, email, password1, confrim_password;
  var globalName = "", globalEmail = "", globalLevel = "";
  var status = false;
  var id_user, globalid_employee;
//  var value;
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
        print("globalid_employee $globalid_employee");
        //_loginStatus = mystatus == true ? LoginStatus.Login : LoginStatus.not_login;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // login();

    getPreferences();

    // getProfile3();
  }

  void show(){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Terimakasih ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            content: Text("Anda telah menandatangai kontrak kerja. Silahkan datang ke lokasi kerja sesuai jadwal kerja anda. Lokasi kerja : ${widget.lokasi_penempatan}"),
            actions: <Widget>[

              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);

                },
                child: Text("Kembali",style: TextStyle(fontWeight: FontWeight.bold),),
                color: Colors.white,
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gawe.id "),
        backgroundColor: mainColor,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Signature(
                  color: color,
                  key: _sign,
                  onSign: () {
                    final sign = _sign.currentState;
                    debugPrint('${sign.points.length} points in the signature');
                  },
                  backgroundPainter: _WatermarkPaint("2.0", "2.0"),
                  strokeWidth: strokeWidth,
                ),
              ),
              color: Colors.black12,
            ),
          ),
          _img.buffer.lengthInBytes == 0
              ? Container()
              : LimitedBox(
                  maxHeight: 200.0,
                  child: Image.memory(_img.buffer.asUint8List())),
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                      color: Colors.green,
                      onPressed: () async {
                        final sign = _sign.currentState;
                        //retrieve image data, do whatever you want with it (send to server, save locally...)
                        final image = await sign.getData();
                        print("image${image}");

                        var data = await image.toByteData(
                            format: ui.ImageByteFormat.png);
                        sign.clear();
                        final encoded =
                            base64.encode(data.buffer.asUint8List());
                        setState(() {
                          _img = data;
                        });

                        final tempDir = await getTemporaryDirectory();
                        final path = tempDir.path;

                        final encoded1 =
                            base64.encode(data.buffer.asUint8List());
                        Uint8List bytes = base64.decode(encoded1);

                        File file = File("$path/" +
                            DateTime.now().millisecondsSinceEpoch.toString() +
                            ".png");
                        await file.writeAsBytes(bytes);

                        setState(() {
                          loading_ttd = true;
                        });

                        network.ganti_ttd(globalEmail,widget.id,widget.hariini,file, context);
                        setState(() {
                          loading_ttd = false;
                        });



                        show();
                        //Navigator.pop(context);
                        debugPrint("onPressed " + encoded);
                      },
                      child:    loading_ttd
                          ? SpinKitFadingCircle(
                        color: Colors.redAccent,
                      )
                          : Text("Save")),


                  MaterialButton(
                      color: Colors.grey,
                      onPressed: () {
                        final sign = _sign.currentState;
                        sign.clear();
                        setState(() {
                          _img = ByteData(0);
                        });
                        debugPrint("cleared");
                      },
                      child: Text("Clear")),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                      onPressed: () {
                        setState(() {
                          color =
                              color == Colors.green ? Colors.black : Colors.blueAccent;
                        });
                        debugPrint("change color");
                      },
                      child: Text("Change color")),
                  MaterialButton(
                      onPressed: () {
                        setState(() {
                          int min = 1;
                          int max = 10;
                          int selection = min + (Random().nextInt(max - min));
                          strokeWidth = selection.roundToDouble();
                          debugPrint("change stroke width to $selection");
                        });
                      },
                      child: Text("Change stroke width")),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
