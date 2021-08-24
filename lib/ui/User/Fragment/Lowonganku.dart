import 'package:flutter/material.dart';
import 'package:gaweid2/modules/lowongan/view/lowonganKu/List_undangan_interview.dart';
import 'package:gaweid2/modules/lowongan/view/lowonganKu/List_undangan_psikotes.dart';
import 'package:gaweid2/modules/lowongan/view/lowonganKu/Simpan_Lowongan.dart';
import 'package:gaweid2/modules/lowongan/view/lowonganKu/Status_Lowongan.dart';
import 'package:gaweid2/utils/theme.dart';

class Lowonganku extends StatefulWidget {
  @override
  _LowongankuState createState() => _LowongankuState();
}

class _LowongankuState extends State<Lowonganku> with SingleTickerProviderStateMixin {
  TabController tabController;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4,vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          color: Colors.white,
          child: TabBar(
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.black,
            controller: tabController,
            isScrollable: true,
            tabs: <Widget>[
              Container(
                width: 150,
                height: 100,
                child: Tab(
                  child: Text("Pekerjaan Tersimpan"),
                ),
              ),
              Container(
                width: 150,
                height: 100,
                child: Tab(
                  child: Text("Status Lamaran"),
                ),
              ),
              Container(
                width: 150,
                height: 100,
                child: Tab(
                  child: Text("Undangan Interview"),
                ),
              ),
              Container(
                width: 150,
                height: 100,
                child: Tab(
                  child: Text("Undangan Psikotes"),
                ),
              ),
//            Container(
//              width: 150,
//              height: 100,
//              child: Tab(
//                child: Text("Tawaran Pekerjaan"),
//              ),
//            ),

            ],
          ),
        ), preferredSize: Size.fromHeight(50),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          Simpan_Lowongan(),
          Status_Lowongan(),
          List_undangan_interview(),
          List_undangan_psikotes(),
        //  List_undangan_interview(),

        ],
      ),
    );
  }
}
