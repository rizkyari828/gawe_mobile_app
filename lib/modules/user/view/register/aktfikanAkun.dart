import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/modules/user/providers/userProvider.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/user/view/Login.dart';

import 'package:gaweid2/modules/user/view/menu/UserDashboard.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:toast/toast.dart';

class aktifkanAkun extends StatefulWidget {
  final String email;

  aktifkanAkun({this.email});

  @override
  _aktifkanAkunState createState() => _aktifkanAkunState();
}

class _aktifkanAkunState extends State<aktifkanAkun> {

  TextEditingController etOtp = TextEditingController();

  BaseEndPointUser networkUser = UserProvider();
  BaseEndPoint network = NetworkProvider();
  final _formKey = GlobalKey<FormState>();

  String name, email, password1, confrim_password;
  var globalName = "", globalEmail = "", globalLevel = "";

  var InSignIn = false;
  var status = false;
  var loading = false;
//  var value;
  var mystatus;

  String emailValidator(String value) {
    //Toast.show(value, context, duration: 3, gravity: Toast.BOTTOM);
    if (value.length == 0) {
      return "Kode OTP tidak boleh kosong";
    } else if (value.length > 6) {
      return "Kode OTP tidak lebih dari 6 digit";
    } else if (value.length < 6) {
      return "Kode OTP tidak kurang dari 6 digit";
    } else {
      return null;
    }
  }

  void validasi() async {
    if (_formKey.currentState.validate()) {
      //JIKA TRUE
      _formKey.currentState.save(); //MAKA FUNGSI SAVE() DIJALANKAN

      if (etOtp.text.isEmpty) {
        Toast.show("kode OTP tidak boleh kosong", context,
            duration: 3, gravity: Toast.BOTTOM);
      } else {
        setState(() {
          InSignIn = true;
        });

        ModelRegister data =
        await networkUser.aktifkanAkunUser(widget.email,etOtp.text.toString());

        if (data.status == 200) {

          Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => Login(),
          ));

          Toast.show("Akun anda telah aktif", context,
              duration: 3, gravity: Toast.TOP);
        } else if (data.status == 404) {
          setState(() {
            InSignIn = false;
          });

          Toast.show("Kode OTP salah", context,
              duration: 3, gravity: Toast.TOP);
        }
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FlatButton(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(new MaterialPageRoute(
                      builder: (BuildContext context) => UserDashboard()));
                },
              ),
            ],
          ),
          Image.asset(
            'images/kategori/LowonganTersimpan.png',
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 26),
                  Text(' Hallo ${widget.email}, \n akun kamu belum aktif', style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                  ),),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Masukkan kode OTP"),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: etOtp,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                            ),
                            hintText: "_ _ _ _ _ _",
                          ),
                          validator: emailValidator,
                          // validator: (value) => value.length < 6 ? 'Password too short.' : null,
                          onSaved: (value) {
                            email = value;
                          },
                        ),
                        loading == false ? TextButton(
                          onPressed: () {
                            reSend();
                          },
                          child: Row(
                            children: [
                              Text(
                                "Belum terima kode? ",
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400,),
                              ),
                              Text(
                                "Kirim ulang",
                                style: TextStyle(color: mainColor, fontWeight: FontWeight.bold,),
                              ),
                            ],
                          ),
                        ) : Container(child: CircularProgressIndicator()),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: InSignIn
                              ? SpinKitFadingCircle(
                            color: Colors.blue,
                          )
                              : MaterialButton(
                                shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                ),
                                onPressed: () {
                                      validasi();
                                },
                                color: mainColor,
                                child: Text("Aktifkan akun",
                                        style: TextStyle(color: Colors.white)),
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void reSend() async {
    setState(() {
      loading = true;
    });
    // print(kodeReferral.toString());
    ModelRegister data = await network.reSendOTPCode(
        widget.email.toString());
    print(data.status);

    if (data.status == 202 ) {
      setState(() {
        loading = false;
      });
      Toast.show("Sukses, segera cek email kamu", context,
          duration: 3, gravity: Toast.TOP);
      Navigator.of(context)
          .push(new MaterialPageRoute(
        builder: (BuildContext context) =>
            aktifkanAkun(email: widget.email.toString()),
      ));
    }
  }
}
