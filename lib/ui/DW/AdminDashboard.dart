import 'package:flutter/material.dart';
import 'package:gaweid2/network/NetworkProvider.dart';

class AdminDashboard extends StatefulWidget {
  final VoidCallback sigOut;
  AdminDashboard({this.sigOut});

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  TextEditingController etEmail = TextEditingController();
  TextEditingController etBody = TextEditingController();
  TextEditingController etTitle = TextEditingController();
  BaseEndPoint netowrk = NetworkProvider();

  void sigOut() {
    widget.sigOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard Admin'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              sigOut();
              print('tes');
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: etEmail,
              decoration: InputDecoration(
                hintText: "Masukan Email",

              ),

            ),
            TextFormField(
              controller: etBody,
              decoration: InputDecoration(
                hintText: "Masukan Body",

              ),

            ),
            TextFormField(
              controller: etTitle,
              decoration: InputDecoration(
                hintText: "Masukan Title",

              ),

            ),

          ],

        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{

        },
      ),
    );
  }
}


