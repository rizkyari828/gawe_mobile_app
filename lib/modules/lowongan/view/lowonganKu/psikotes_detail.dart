import 'package:flutter/material.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class psikotes_detail extends StatefulWidget {
  @override
  _psikotes_detailState createState() => _psikotes_detailState();
  final logo,
      kehadiran,
      posisi,
      nama_perusahaan,
      keteranganUndangan,
      tanggalPsikotes,
      id_interview,
      lowongan_id;

  psikotes_detail(
      {this.logo,
      this.kehadiran,
      this.posisi,
      this.nama_perusahaan,
      this.keteranganUndangan,
      this.tanggalPsikotes,
      this.id_interview,
      this.lowongan_id});
}

class _psikotes_detailState extends State<psikotes_detail> {
  void kehadiran(String jawaban) async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/intedit_psikotes", body: {
      'id': widget.id_interview,
      'kehadiran': jawaban.toString(),
      'lowongan_id': widget.lowongan_id,
    });

    ModelRegister listdata = modelRegisterFromJson(response.body);

    if (listdata.status == 200) {
      print("berhasil update read");
      Toast.show("Jawaban Anda Kami Kirim", context,
          duration: 3, gravity: Toast.BOTTOM);
    } else {
      print("berhasil update read");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nama_perusahaan),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: Column(
              children: <Widget>[
                Image.network(
                  widget.logo,
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Nama Perusahaan :"),
                      Text(
                        widget.nama_perusahaan,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Keterangan :"),
                      Text(
                        widget.keteranganUndangan,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    "Konfirmasi Kehadiran",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(26.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        color: Colors.lightBlueAccent,
                        child: Text("Hadir"),
                        onPressed: () {
                          kehadiran("Hadir");
                        },
                      ),
                      FlatButton(
                        color: Colors.grey,
                        child: Text("Tidak Hadir"),
                        onPressed: () {
                          kehadiran("Tidak Hadir");
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
