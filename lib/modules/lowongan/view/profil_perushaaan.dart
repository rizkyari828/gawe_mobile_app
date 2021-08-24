import 'package:flutter/material.dart';
import 'package:gaweid2/model/user/ModelLowonganDetail.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:http/http.dart' as http;

class profil_pekerjaan extends StatefulWidget {
  final id, alamat, deskripsi;
  profil_pekerjaan({this.id, this.alamat, this.deskripsi});
  @override
  _info_pekerjaaanState createState() => _info_pekerjaaanState();
}

class _info_pekerjaaanState extends State<profil_pekerjaan> {
  BaseEndPoint network = NetworkProvider();
  String industri;

  Future<List> getLowongan() async {
    final response = await http
        .post(NetworkConfig().baseUrl + "apps/lowongan_detail", body: {
      'id_lowongan': widget.id.toString(),
    });
    ModelLowonganDetail listdata = modelLowonganDetailFromJson(response.body);
    if (response.statusCode == 200) {
      print("get data succeessfully detail");
      //print(listdata);
      //print("lowongan${listdata.lowongan}");
    } else {
      print("Get Data Failed gagal detail");
    }
    return listdata.perusahaan;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLowongan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width : double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Alamat",
                  style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(widget.alamat,
                    style: TextStyle(fontSize: 16,))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Deskripsi",
                  style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(widget.deskripsi,
                    style: TextStyle(fontSize: 16, ))
              ],
            )
          ],
        ),
      ),
    ));
  }
}

//class ItemList extends StatelessWidget {
//  List list;
//  ItemList({this.list});
//
//  @override
//  Widget build(BuildContext context) {
//    return ListView.builder(
//        itemCount: list == null ? 0 : list.length,
//        itemBuilder: (BuildContext context, int index) {
//          final Perusahaan data = list[index];
//          //final dataTime = DateTime(data.publishedAt);
//
//          return Container(
//            child: Padding(
//              padding: const EdgeInsets.only(left: 50,right: 50,top: 5,bottom: 5),
//              child: Column(
//                children: <Widget>[
//
//                  SizedBox(height: 10,),
//                  Column(
//                    children: <Widget>[
//                      Text("Alamat",),
//                      Text(data.alamat,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600))
//                    ],
//                  ),
//                  SizedBox(height: 20,),
//                  Column(
//                    children: <Widget>[
//                      Text("Deskripsi",),
//                      Text(data.deskripsi,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600))
//                    ],
//                  )
//
//
////                  Row(
////                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
////                    children: <Widget>[
////                      Column(children: <Widget>[
////                        Text("Kualifikasi",style: TextStyle(fontSize: 14),),
////                        Text(data.kualifikasi,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
////                      ]),
////                      Column(children: <Widget>[
////                        Text("Rincian",),
////                        Text(data.rincian,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600))
////                      ]),
////                    ],
////                  ),
//                ],
//
//              ),
//
//
//            ),
//          );
//        });
//  }
//}
//
