import 'package:flutter/material.dart';
import 'package:gaweid2/modules/learning/views/kodelearning.dart';
import 'package:gaweid2/modules/learning/views/ui_materi.dart';

class selesai_learning extends StatefulWidget {
  @override
  _selesai_learningState createState() => _selesai_learningState();
}

class _selesai_learningState extends State<selesai_learning> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FlatButton(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
//                  Navigator.of(context).pushReplacement(new MaterialPageRoute(
//                      builder: (BuildContext context) => UI_Materi()));

//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (context) => (kodelearning())));
                },
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            child: Card(
              child: Column(
                children: <Widget>[
                  Text("Terimakasih Telah Melakukan Learning Di Gawe.id",style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
