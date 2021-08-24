import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gaweid2/utils/theme.dart';

class NewsDetail extends StatefulWidget {
  final title,foto,desc;
  NewsDetail(
      {this.title,
        this.foto,
        this.desc});
  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: mainColor,
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            color: Colors.white,
            child:  Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10,),
                  Text(widget.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  SizedBox(height: 10,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      widget.foto,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/4,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(height: 10,),
                   Html(data: widget.desc,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
