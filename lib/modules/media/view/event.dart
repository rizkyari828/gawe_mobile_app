import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gaweid2/modules/media/models/ModelNews.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/modules/media/view/news_detail.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  BaseEndPoint network = NetworkProvider();
  var loading = false;

  List<ModelNews> news = [];

  Future<Null> getNews() async {
    setState(() {
      loading = true;
    });
    final response = await http.get(NetworkConfig().baseUrl + "apps/event");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print(data);
      setState(() {
        for (Map i in data) {
          news.add(ModelNews.fromJson(i));
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPreferences();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: news.length,
            itemBuilder: (context, index) {
              final xnews = news[index];
              var date = DateFormat.yMMMd().format(xnews.dateCreated);
              return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewsDetail(
                                  title:
                                  xnews.title == null ? "" : xnews.title,
                                  foto: xnews.foto == null ? "" : xnews.foto,
                                  desc: xnews.desc == null ? "" : xnews.desc,
                                )));
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
                                    xnews.foto,
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
                                      xnews.title,
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
                        ],
                      ),
                    ),
                  ));
            }));
  }
}
