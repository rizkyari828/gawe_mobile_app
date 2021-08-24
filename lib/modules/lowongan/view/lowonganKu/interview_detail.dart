import 'package:flutter/material.dart';
import 'package:gaweid2/modules/user/models/ModelRegister.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class interview_detail extends StatefulWidget {
  @override
  _interview_detailState createState() => _interview_detailState();

  final logo,
      kehadiran,
      posisi,
      alamatkantor,
      bertemu,
      nama_perusahaan,
      keteranganUndangan,
      tgl_interview,
      id_interview,
      lowongan_id;

  interview_detail(
      {this.logo,
      this.kehadiran,
      this.posisi,
      this.alamatkantor,
      this.bertemu,
      this.nama_perusahaan,
      this.keteranganUndangan,
      this.tgl_interview,
      this.id_interview,
      this.lowongan_id});
}


class _interview_detailState extends State<interview_detail> {

  void kehadiran(String jawaban)async{


       final response = await http.post(
        NetworkConfig().baseUrl + "apps/intedit",
        body: {
          'id':widget.id_interview,
          'kehadiran':jawaban.toString(),
          'lowongan_id':widget.lowongan_id,
        });

    ModelRegister listdata = modelRegisterFromJson(response.body);

    if(listdata.status==200){

      print("berhasil update read");
      Toast.show("Jawaban Anda Kami Kirim", context, duration: 3, gravity: Toast.BOTTOM);

    }else{

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
                      Text("Alamat :"),
                      Text(
                        widget.alamatkantor,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Posisi :"),
                      Text(
                        widget.posisi,
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
                      Text("bertemu :"),
                      Text(
                        widget.bertemu,
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
                      Text("Tanggal Interview :"),
                      Text(
                        widget.tgl_interview,
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
