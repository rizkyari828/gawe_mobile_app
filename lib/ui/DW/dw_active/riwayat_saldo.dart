import 'package:flutter/material.dart';
import 'package:gaweid2/utils/theme.dart';

class riwayat_saldo extends StatefulWidget {
  @override
  _riwayat_saldoState createState() => _riwayat_saldoState();
}

class _riwayat_saldoState extends State<riwayat_saldo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gawe.id"),
        backgroundColor: mainColor,
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: Row(
              children: <Widget>[
                Text("tes"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
