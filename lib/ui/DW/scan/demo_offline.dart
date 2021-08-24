import 'package:flutter/material.dart';
import 'package:connection_status_bar/connection_status_bar.dart';

class DemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Scaffold(
              backgroundColor: Colors.blueAccent,
              body: Center(
                child: Text(
                  'turn off device internet connection to see the widget animating',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConnectionStatusBar(),
          ),
        ],
      ),
    );
  }
}