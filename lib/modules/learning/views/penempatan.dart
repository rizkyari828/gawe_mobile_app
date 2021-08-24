import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/modules/learning/views/kodelearning.dart';
import 'package:gaweid2/utils/theme.dart';

class penempatan extends StatefulWidget {
  @override
  _penempatanState createState() => _penempatanState();
  final kodelearning;
  penempatan({
    this.kodelearning,
  });

}

class _penempatanState extends State<penempatan> {

  var InSignIn = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Penempatan"),
        backgroundColor: mainColor,
      ),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'images/menu/elearning.png',
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.width/2,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        //controller: etnik,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "NPO/SIM ID",
                          hintText: "NPO/SIM ID",
                        ),
                        //validator: nikvalidator,
                        // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                        onSaved: (value) {
                          // nik = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        //controller: etnik,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "LOKASI PENEMPATAN",
                          hintText: "LOKASI PENEMPATAN",
                        ),
                        //validator: nikvalidator,
                        // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                        onSaved: (value) {
                          // nik = value;
                        },
                      ),
                    ),
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
                          // checkEmailAndPassowrd();
//                          Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (context) => UI_Modul(
//
//                                  )));

                        },
                        // color: Colors.green,
                        // child: Text("Masuk Learning",
                        //     style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

