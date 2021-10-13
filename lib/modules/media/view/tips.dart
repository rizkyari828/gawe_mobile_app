import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gaweid2/modules/media/models/ModelNews.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/modules/media/view/news_detail.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TipsPage extends StatefulWidget {
  @override
  _TipsPageState createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  BaseEndPoint network = NetworkProvider();
  var loading = false;

  List<ModelNews> tips = [];

  Future<Null> gettips() async {
    setState(() {
      loading = true;
    });
    final response = await http.get(NetworkConfig().baseUrl + "apps/tips");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data) {
          tips.add(ModelNews.fromJson(i));
        }
      });
    }
  }

  var globalName = "",
      globalEmail = "",
      globalLevel = "",
      id_user = "",
      globalid_employee = "";
  var status = false;
  var mystatus;

  SessionManager sessionManager = SessionManager();

  void getPreferences() async {
    await sessionManager.getPreference().then((value) {
      setState(() {
        mystatus = sessionManager.status;
        globalName = sessionManager.fullname;
        globalEmail = sessionManager.email;
        id_user = sessionManager.iduser;
        globalid_employee = sessionManager.id_employee;
      });
    });
  }

  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPreferences();
    gettips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView.builder(
            itemCount: tips.length,
            itemBuilder: (context, index) {
              final tipsx = tips[index];
              var date = DateFormat.yMMMd().format(tipsx.dateCreated);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => NewsDetail(
                    //               title:
                    //                   tipsx.title == null ? "" : tipsx.title,
                    //               foto: tipsx.foto == null ? "" : tipsx.foto,
                    //               desc: tipsx.desc == null ? "" : tipsx.desc,
                    //             )));
                  },
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                tipsx.foto,
                                height: MediaQuery.of(context).size.height / 12,
                                width: MediaQuery.of(context).size.width / 5,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  tipsx.title,
                                  overflow: TextOverflow.fade,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  date.toString(),
                                  overflow: TextOverflow.fade,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],

                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:15.0, right: 15),
                        child: Divider(),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
