import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaweid2/modules/media/models/ModelNews.dart';
import 'package:gaweid2/model/user/ModelLowongan.dart';
import 'package:gaweid2/model/user/ModelLowongan2.dart';
import 'package:gaweid2/network/NetworkProvider.dart';
import 'package:gaweid2/modules/user/view/menu/UserDashboard.dart';
import 'package:gaweid2/modules/lowongan/view/detail_lowongan.dart';
import 'package:gaweid2/modules/lowongan/view/lowongan.dart';
import 'package:gaweid2/modules/media/view/news_detail.dart';
import 'package:gaweid2/utils/SessionManager.dart';
import 'package:gaweid2/utils/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;


class HomeUser2 extends StatefulWidget {
  @override
  _HomeUser2State createState() => _HomeUser2State();
}

enum LoginStatus { not_login, Login }

class _HomeUser2State extends State<HomeUser2> {
  BaseEndPoint network = NetworkProvider();

  List<ModelLowongan> lowongan = [];
  List<ModelNews> news = [];
  var loading = false;
  String name, email, password1, confrim_password;
  var globalName = "", globalEmail = "", globalLevel = "";
  LoginStatus _loginStatus = LoginStatus.not_login;
  var status = false;
  var id_user;
//  var value;
  var mystatus;
  bool _isSearch=true;
  var keyword = "";


  TextEditingController controller = new TextEditingController();
  TextEditingController etSearch = new TextEditingController();

//  _HomeUser2State() {
//
//    etSearch.addListener((){
//      if(etSearch.text.isEmpty){
//        setState(() {
//          _isSearch = true;
//          keyword = "";
//        });
//      } else {
//        setState(() {
//          _isSearch = false;
//          keyword = etSearch.text.toString();
//        });
//      }
//    });
//
//    print("keyword${keyword}");
//  }



  _HomeUser1State() {
    etSearch.addListener(() {
      if (etSearch.text.isEmpty) {
        setState(() {
          _isSearch = true;
          keyword = "";
        });
      } else {
        setState(() {
          _isSearch = false;
          keyword = etSearch.text.toString();
        });
      }
    });

    print("keyword${keyword}");
  }


  Future<List> getLowongan() async {
    final response = await http.get(NetworkConfig().baseUrl + "apps/lowongan");
    ModelLowongan2 listdata = modelLowongan2FromJson(response.body);
    print("lowongan${listdata}");
    if (response.statusCode == 200) {
      // print("get data succeessfully");
    } else {
      //print("Get Data Failed");
    }
    return listdata.lowongan;
  }

  Future<List> search() async {
//    final response = await http.post(NetworkConfig().baseUrl + "apps/search_lowongan2",body: {
//      'search':"sales",
//    });

    final response = await http.post(NetworkConfig().baseUrl+"apps/search_lowongan2",body: {
      'search' : keyword.toString()
    });

    ModelLowongan2 listdata = modelLowongan2FromJson(response.body);

    print("listadata${listdata}");
    if (response.statusCode == 200) {
      // print("get data succeessfully");
    } else {
      //print("Get Data Failed");
    }

    return listdata.lowongan;
  }

  Future<Null> getNews() async {
    setState(() {
      loading = true;
    });
    final response = await http.get(NetworkConfig().baseUrl + "apps/news");
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

  SessionManager sessionManager = SessionManager();

  void getPreferences() async {
    await sessionManager.getPreference().then((value) {
      setState(() {
        mystatus = sessionManager.status;
        globalName = sessionManager.fullname;
        globalEmail = sessionManager.email;
        globalLevel = sessionManager.level;
        id_user = sessionManager.iduser;
//        print("status${mystatus}");
//        print("fullname${globalName}");
//        print("email${globalEmail}");
        //print("global $globalLevel");
        //_loginStatus = mystatus == true ? LoginStatus.Login : LoginStatus.not_login;
      });
    });
  }



  onSearch(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
  }

  List<ModelLowongan> _search = [];


  var loading1 = false;

  Future<List> getLowongan2() async {
    final response = await http.get(NetworkConfig().baseUrl + "apps/toplist");
    ModelLowongan2 listdata = modelLowongan2FromJson(response.body);
    print("lowongan${listdata}");
    if (response.statusCode == 200) {
      // print("get data succeessfully");
    } else {
      //print("Get Data Failed");
    }
    return listdata.lowongan;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLowongan();
    getNews();
    getPreferences();
    search();
    // loadJsonData();
    //fetchData();
  }





  @override
  Widget build(BuildContext context) {
    //print("status1${mystatus}");
//    print("fullname1${globalName}");
//    print("email1${globalEmail}");

  print("_isSearch${_isSearch}");
  print("keyword${keyword}");

    return Scaffold(
//      appBar: AppBar(
//        title: Text('Gawe.id'),
//      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      bottom: 12, right: 12, left: 12, top: 12),
                  color: mainColor,
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.search),
                      title: TextField(
                        controller: etSearch,
                        onChanged: onSearch,
                        decoration: InputDecoration(
                            hintText: "Search ", border: InputBorder.none),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          etSearch.clear();
                          onSearch('');
                        },
                        icon: Icon(Icons.cancel),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, bottom: 0, top: 0),
                            child: FlatButton(
                              child: Image.asset(
                                'images/menu/lowongan2.png',
                                width: MediaQuery.of(context).size.width / 6.0,
                                height: MediaQuery.of(context).size.width / 6.0,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        (ListLowongan())));
                              },
                            ),
                          ),
                          Text(
                            ' Lowongan',
                            style: blackTextfont.copyWith(fontSize: 16,fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, bottom: 0, top: 0),
                            child: Image.asset(
                              'images/menu/elearning.png',
                              width: MediaQuery.of(context).size.width / 6.0,
                              height: MediaQuery.of(context).size.width / 6.0,
                            ),
                          ),
                          Text("E-Learning")
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, bottom: 0, top: 0),
                            child: Image.asset(
                              'images/menu/media.png',
                              width: MediaQuery.of(context).size.width / 6.0,
                              height: MediaQuery.of(context).size.width / 6.0,
                            ),
                          ),
                          Text("Media")
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width / 1.1,
                  child: Row(
                    //scrollDirection: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, bottom: 0, top: 0),
                            child: FlatButton(
                              child: Image.asset(
                                'images/menu/langganan.png',
                                width: MediaQuery.of(context).size.width / 6.0,
                                height: MediaQuery.of(context).size.width / 6.0,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        (ListLowongan())));
                              },
                            ),
                          ),
                          Text("Langganan")
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, bottom: 0, top: 0),
                            child: Image.asset(
                              'images/menu/poin.png',
                              width: MediaQuery.of(context).size.width / 6.0,
                              height: MediaQuery.of(context).size.width / 6.0,
                            ),
                          ),
                          Text("Poin")
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, bottom: 0, top: 0),
                            child: Image.asset(
                              'images/menu/lainnya.png',
                              width: MediaQuery.of(context).size.width / 6.0,
                              height: MediaQuery.of(context).size.width / 6.0,
                            ),
                          ),
                          Text("Lainnya")
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                Text(
                  'Top List Lowongan',
                  style: blackTextfont.copyWith(fontSize: 22,fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 20,
                ),

                _isSearch ?

                FutureBuilder(
                  future: getLowongan(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return snapshot.hasData
                        ? ItemList(list: snapshot.data)
                        : Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )

                :

                FutureBuilder(
                  future: search(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return snapshot.hasData
                        ? ItemListSearch(list: snapshot.data)
                        : Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),

//
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 350,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: news.length,
                    itemBuilder: (context, index) {
                      final xnews = news[index];
                      return Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Card(
                          child: InkWell(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => NewsDetail(
                              //           title: xnews.title == null
                              //               ? ""
                              //               : xnews.title,
                              //           foto: xnews.foto == null
                              //               ? ""
                              //               : xnews.foto,
                              //           desc: xnews.desc == null
                              //               ? ""
                              //               : xnews.desc,
                              //         )));
                            },
                            child: Column(
                              children: <Widget>[
                                Image.network(
                                  xnews.foto,
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                  MediaQuery.of(context).size.height / 6,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  xnews.title,
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Baca Selengakpnya ...',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.blueAccent),
                                )
//                                SingleChildScrollView(
//                                  child: Container(
//                                    height: 200,
//                                    width: 200,
//                                    child: Html(data: xnews.desc,padding: EdgeInsets.all(8.0),
//                                      linkStyle: const TextStyle(
//                                        color: Colors.redAccent,
//                                        decorationColor: Colors.redAccent,
//                                        decoration: TextDecoration.underline,
//                                      ),
//
//                                    ),
//                                  ),
//                                ),

//                              Text(
//                                xnews.desc,
//                                style: TextStyle(
//                                  fontSize: 14,),
//                              ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                //ProdukTerbaru(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 850,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: list.length,
        itemBuilder: (context, index) {
          final xlowongan = list[index];
          return Container(
            height: MediaQuery.of(context).size.height / 4.9,
            child: Card(
              elevation: 5,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Detail_lowongan(
                            logo: xlowongan.logo == null
                                ? ""
                                : xlowongan.logo,
                            provinsi: xlowongan.provinceId == null
                                ? ""
                                : xlowongan.provinceId,
                            posisi: xlowongan.posisi == null
                                ? ""
                                : xlowongan.posisi,
                            id: xlowongan.idLowongan == null
                                ? ""
                                : xlowongan.idLowongan,
                            perusahaan: xlowongan.namaPerusahaan == null
                                ? ""
                                : xlowongan.namaPerusahaan,
                            gajimin: xlowongan.gajiMin == null
                                ? ""
                                : xlowongan.gajiMin,
                            gajimax: xlowongan.gajiMax == null
                                ? ""
                                : xlowongan.gajiMax,
                          )));
                },
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              xlowongan.logo,
                              height: MediaQuery.of(context).size.height / 7,
                              width: MediaQuery.of(context).size.width / 3,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Text(
                                    xlowongan.posisi,
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  xlowongan.provinceId,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  xlowongan.namaPerusahaan,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Fulltime",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
//                        FlatButton(
//                          onPressed: () {},
//                          child: Icon(Icons.save),
//                        )
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(xlowongan.totalPelamar.toString() + " Pelamar"),
                            Text(xlowongan.datePostEnd.toString()),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
class ItemListSearch extends StatelessWidget {
  List list;
  ItemListSearch({this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 850,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: list.length,
        itemBuilder: (context, index) {
          final xlowongan = list[index];
          return Container(
            height: MediaQuery.of(context).size.height / 4.9,
            child: Card(
              elevation: 5,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Detail_lowongan(
                            logo: xlowongan.logo == null
                                ? ""
                                : xlowongan.logo,
                            provinsi: xlowongan.provinceId == null
                                ? ""
                                : xlowongan.provinceId,
                            posisi: xlowongan.posisi == null
                                ? ""
                                : xlowongan.posisi,
                            id: xlowongan.idLowongan == null
                                ? ""
                                : xlowongan.idLowongan,
                            perusahaan: xlowongan.namaPerusahaan == null
                                ? ""
                                : xlowongan.namaPerusahaan,
                            gajimin: xlowongan.gajiMin == null
                                ? ""
                                : xlowongan.gajiMin,
                            gajimax: xlowongan.gajiMax == null
                                ? ""
                                : xlowongan.gajiMax,
                          )));
                },
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              xlowongan.logo,
                              height: MediaQuery.of(context).size.height / 7,
                              width: MediaQuery.of(context).size.width / 3,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Text(
                                    xlowongan.posisi,
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  xlowongan.provinceId,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  xlowongan.namaPerusahaan,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Fulltime",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
//                        FlatButton(
//                          onPressed: () {},
//                          child: Icon(Icons.save),
//                        )
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(xlowongan.totalPelamar.toString() + " Pelamar"),
                            Text(xlowongan.datePostEnd.toString()),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
