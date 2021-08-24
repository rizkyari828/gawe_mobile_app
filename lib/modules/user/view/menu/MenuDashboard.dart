import 'package:flutter/material.dart';
import 'package:gaweid2/modules/lowongan/view/lowongan.dart';
import 'package:gaweid2/utils/theme.dart';

class MenuDashboard extends StatefulWidget {
  @override
  _MenuDashboardState createState() => _MenuDashboardState();
}

class _MenuDashboardState extends State<MenuDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 10, bottom: 0, top: 0),
                        child: FlatButton(
                          child: Image.asset(
                            'images/menu/lowongan.png',
                            width: 100,
                            height: 80,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => (ListLowongan())));
                          },
                        ),
                      ),
                      Text("Lowongan")
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 10, bottom: 0, top: 0),
                        child: Image.asset(
                          'images/menu/pelatihan.png',
                          width: 100,
                          height: 80,
                        ),
                      ),
                      Text("Pelatihan")
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 10, bottom: 0, top: 0),
                        child: Image.asset(
                          'images/menu/tipskarir.png',
                          width: 100,
                          height: 80,
                        ),
                      ),
                      Text("tipskarir")
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 10, bottom: 0, top: 0),
                        child: FlatButton(
                          child: Image.asset(
                            'images/menu/lowongan.png',
                            width: 100,
                            height: 80,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => (ListLowongan())));
                          },
                        ),
                      ),
                      Text("Lowongan")
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 10, bottom: 0, top: 0),
                        child: Image.asset(
                          'images/menu/pelatihan.png',
                          width: 100,
                          height: 80,
                        ),
                      ),
                      Text("Pelatihan")
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 10, bottom: 0, top: 0),
                        child: Image.asset(
                          'images/menu/tipskarir.png',
                          width: 100,
                          height: 80,
                        ),
                      ),
                      Text("tipskarir")
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 10, bottom: 0, top: 0),
                        child: FlatButton(
                          child: Image.asset(
                            'images/menu/lowongan.png',
                            width: 100,
                            height: 80,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => (ListLowongan())));
                          },
                        ),
                      ),
                      Text("Lowongan")
                    ],
                  ),
                ],
              ),
            ),
          ]
        ),
    );
  }
}
