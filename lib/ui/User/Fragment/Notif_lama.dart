import 'package:flutter/material.dart';


class Notif_lama extends StatefulWidget  {
  @override
  _Fragment2State createState() => _Fragment2State();
}

class _Fragment2State extends State<Notif_lama> with SingleTickerProviderStateMixin {
  TabController tabController;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2,vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: TabBar(
//
//        unselectedLabelColor: Colors.black,
//        labelColor: Colors.red,
//        controller: tabController,
//        tabs: <Widget>[
//          Tab(
//
//              child: Text("Psikotes")
//          ),
//          Tab(
//              child: Text('Interview')
//          )
//        ],
//      ),

      appBar: new TabBar(
        //warna background
//        backgroundColor: Colors.blue,
//        //judul
//        title: new Text("Notif"),
        //bottom
        unselectedLabelColor: Colors.grey,
        labelColor: Colors.red,
          controller: tabController,
            tabs: <Widget>[
          Tab(

              child: Text("Psikotes")
          ),
          Tab(
              child: Text('Interview')
          )
        ],

      ),

      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          Text('1'),
          Text('2'),
        ],
      ),

    );
  }
}
