import 'package:flutter/material.dart';
import 'package:gaweid2/modules/media/models/ModelCheck.dart';
import 'package:gaweid2/modules/learning/models/aturanmain_model.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/learning/views/kodelearning.dart';
import 'package:gaweid2/modules/learning/views/posttest.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';

class aturanMain extends StatefulWidget {
  @override
  _aturanMainState createState() => _aturanMainState();
  final jenis_access, nama_materi, id_materi,kodelearning;

  aturanMain({this.jenis_access, this.nama_materi, this.id_materi,this.kodelearning});
}

class _aturanMainState extends State<aturanMain> {
  BaseEndPoint network = NetworkProvider();
  String jenis_access;

  var globalName = "", globalEmail = "", globalLevel = "";
  var status = false;
  var id_user, globalid_employee;
  var mystatus;
  var InSignIn = false;

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
    getPreferences();
  }

  void main() async {
    AturanmainModel data = await network.aturanmain_learning(
        globalEmail, widget.jenis_access, widget.id_materi);

    if (data.status == 200) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => (posttest(
                    jenis_access:
                        widget.jenis_access == null ? "" : widget.jenis_access,
                    id_materi: widget.id_materi == null ? "" : widget.id_materi,
                    insert_id: data.insertId == null ? "" : data.insertId,
                  ))));
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    if (widget.jenis_access == "1") {
      jenis_access = "Pre Test";
    } else if (widget.jenis_access == "2") {
      jenis_access = "Post Test";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Gawe.id"),
        backgroundColor: mainColor,
      ),
      body: Card(
        child: ListView(
          children: <Widget>[
            Center(
                child: Text(
              "Halo Sobat Gawe Selamat Datang di e-Learning",
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("Jenis Soal"),
                Text(jenis_access),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Materi"),
                Text(widget.nama_materi),
                Text(widget.id_materi),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("Total Soal"),
                Text("5 Soal"),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("Durasi"),
                Text("15 Menit"),
              ],
            ),
            SizedBox(
              height: 14,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Ketentuan Pengerjaan Soal ${jenis_access}, E-learning Gawe.id :",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "1.  Soal ${jenis_access}, dikerjakan dengan durasi waktu yang sudah ditentukan"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "2.  Dalam pengerjaan soal pretest terdapat tombol next untuk mengerjakan soal berikutnya dan jawaban yang sudah dipilih sebelumnya akan langsung terkunci dan tidak dapat diubah atau dikembalikan"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "3.  Selama mengerjakan soal pretest tidak dapat dan tidak diperbolehkan melihat materi."),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "4.  Pengerjaan soal pretest sebagai syarat untuk dapat mengerjakan soal ${jenis_access},."),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "5.  Setelah selesai mengerjakan soal ${jenis_access}, nilai akan keluar secara otomatis untuk mengetahui tingkat kemampuan e-learning kamu."),
            ),
            SizedBox(
              height: 14,
            ),
            Center(child: Text("Selamat Mencoba")),
            SizedBox(
              height: 14,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RaisedButton(
                onPressed: () {
                  main();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.school),
                    Text(' Mulai ${jenis_access}',
                        style: TextStyle(fontSize: 18)),
                  ],
                ),
                color: mainColor,
                textColor: Colors.white,
                elevation: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
