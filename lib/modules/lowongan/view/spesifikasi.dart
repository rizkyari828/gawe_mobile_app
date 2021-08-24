import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gaweid2/main.dart';
import 'package:gaweid2/modules/media/models/ModelCheck.dart';
import 'package:gaweid2/modules/lowongan/view/home.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class Spesifikasi extends StatefulWidget {
  final String id_lowongan, id_employee;

  Spesifikasi({
    this.id_lowongan,
    this.id_employee,
  });

  @override
  _SpesifikasiState createState() => _SpesifikasiState();
}

class _SpesifikasiState extends State<Spesifikasi> {
  var InSignIn = false;

  bool selected = false;
  String _currText = '', _kode;
  var _kode2 = List<String>();
  var userStatus = List<bool>();
  var nilai = List<bool>();

  Future<List<Spesi>> _getUsers() async {
    var data = await http.post(NetworkConfig().baseUrl + "apps/get_spesifikasi",body: {
      "id_employee":widget.id_employee,
    });

    var jsonData = json.decode(data.body);

    List<Spesi> users = [];
    List<Spesi> kode2 = [];

    for (var u in jsonData) {
      Spesi kode3 = Spesi(
          u["index"],
          u["kode"],
          u["nama"],
          u["urut"],
          u["status"],
          u["deskripsi"],
          u["sertifikat"],
          u["filter"],
          u["nilai"]);

      kode2.add(kode3);

      // print("tesasda${user.nama}");
      _kode2.add(kode3.kode);

     // _kode2.remove(kode3.kode);


      // userStatus.add(user.nilai);
    }

    for (var u in jsonData) {
      Spesi user = Spesi(
          u["index"],
          u["kode"],
          u["nama"],
          u["urut"],
          u["status"],
          u["deskripsi"],
          u["sertifikat"],
          u["filter"],
          u["nilai"]);

      users.add(user);

      // print("tesasda${user.nama}");
      userStatus.add(user.nilai);

      // userStatus.add(user.nilai);
    }

    // print(users.length);

    return users;
  }

//  userStatus.clear();
//  _kode2.clear();

  final _formKey = GlobalKey<FormState>();

  var holder_1 = [];

//  getItems(){
//    user.forEach((key, value) {
//      if(value == true)
//      {
//        holder_1.add(key);
//      }
//    });
//
//    // Printing all selected items on Terminal screen.
//    print(holder_1);
//    // Here you will get all your selected Checkbox items.
//
//    // Clear array after use.
//    holder_1.clear();
//  }

  Set _saved = Set();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Informasi Tambahan",),
        backgroundColor: mainColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
         // Text("Silahkan Isi Spesifikasi yang Anda punya, untuk mendukung proses Administrasi ke proses rekrutmen selanjutnya"),
          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: FutureBuilder(
                future: _getUsers(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(child: Center(child: Text("Loading...")));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(snapshot.data[index].nama),
                         // subtitle: Text(snapshot.data[index].kode),
                          trailing: Checkbox(
                              value: userStatus[index],
                              //value: selected,
                              onChanged: (val) {
                                setState(() {
                                  //userStatus[index] = !userStatus[index];
                                  //   nilai[index] = data[index].kode;

                                  userStatus[index] = !userStatus[index];

                                  _kode2[index] = snapshot.data[index].kode;

                                  _kode2.clear();

                                 // userStatus.clear();



                                  // snapshot.data[index].checked = val;

                                 // _kode = snapshot.data[index].kode;

                                   // kode2.add(snapshot.data[index].kode);
//

//
                                  // Toast.show("Tes${userStatus}", context, duration: 3, gravity: Toast.BOTTOM);
                                });
                              }),
                        );
                      },
                    );

                  }
                },
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              width: double.infinity,
              child: InSignIn
                  ? SpinKitFadingCircle(
                      color: Colors.blue,
                    )
                  : RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onPressed: () {
                  setState(() {
                    InSignIn = true;
                  });
                        validasi(userStatus, _kode2);
                        //checkEmailAndPassowrd();
                      },
                      color: mainColor,
                      child: Text("Melamar",
                          style: TextStyle(color: Colors.white)),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  validasi(userStatus, _kode2) {
//    Toast.show("Tes${userStatus.length}", context, duration: 3, gravity: Toast.BOTTOM);
    //Toast.show("Tes${userStatus}", context, duration: 3, gravity: Toast.BOTTOM);
    // Toast.show("Tes${_kode2}", context, duration: 3, gravity: Toast.BOTTOM);

    applylowongan(widget.id_lowongan, widget.id_employee, userStatus, _kode2);
//    userStatus.clear();
//    _kode2.clear();
  }

  void applylowongan(idlowongam, id_employee, userStatus, _kode2) async {
    //  print("melamar lowongan");

    // print("kode${userStatus.toString()}");

    if(_kode2==null){
      // print('null');
      Toast.show("Isi terlebih dahulu", context,
          duration: 3, gravity: Toast.BOTTOM);

    }else {
      final response =
      await http.post(NetworkConfig().baseUrl + "apps/apply_lowongan", body: {
        'lowongan_id': idlowongam,
        'employee_id': id_employee,
        'nilai': userStatus.toString(),
        'kode': _kode2.toString(),
      });

      ModelCheck listData = modelCheckFromJson(response.body);

       if(listData.status == 200){
         setState(() {
           InSignIn = false;
         });

         Toast.show("Lowongan berhasil dilamar", context, duration: 3, gravity: Toast.TOP);
         Navigator.of(context).pushReplacement(new MaterialPageRoute(
             builder: (BuildContext context) =>
                 Home()));
      } else if (listData.status == 404) {
        // Navigator.of(_formKey.currentContext, rootNavigator: true).pop();
        setState(() {
        InSignIn = false;
        });

      Toast.show("Lowongan sudah dilamar", context, duration: 3, gravity: Toast.TOP);
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) =>
                Home()));
      } else {
         setState(() {
           InSignIn = false;
         });

        Toast.show("Gagal melamar pekerjaan", context, duration: 3, gravity: Toast.TOP);
      }
    }

  }
}

class DetailPage extends StatelessWidget {
  final Spesi user;

  DetailPage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text(user.nama),
    ));
  }
}

class Spesi {
  final int index;
  final String kode;
  final String nama;
  final String urut;
  final String status;
  final String deskripsi;
  final String sertifikat;
  final String filter;
  final bool nilai;

  Spesi(this.index, this.kode, this.nama, this.urut, this.status,
      this.deskripsi, this.sertifikat, this.filter, this.nilai);
}
