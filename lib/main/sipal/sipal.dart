import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:dlh/animasi/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_container/responsive_container.dart';
import 'package:http/http.dart' as http;

class sipalPage extends StatefulWidget{
  @override
  _sipalPage createState() => _sipalPage();
}
class _sipalPage extends State<sipalPage>{
  bool awal = false;
  bool loading = false;
  bool downloading = false;
  var progressLo = "";
  List total = List();
  String urlnya = '' ;
  ScrollController _scroll2Controller = new ScrollController();
  var progress;

  @override
  Future<void> _downloadfile(urlnya)async {
    Dio dio = Dio();
    setState(() {
      awal = true;
      progress = '...';
    });
    try {
      var dir = await getExternalStorageDirectory();
      await dio.download('http://dlh-serangkota.com/upload/limbah/' + urlnya,
          dir.path + "/" + urlnya, onReceiveProgress: (rec, tota) {
            print('Rec: $rec, Total: $tota');
            setState(() {
              progress = ((rec / tota) * 100).toStringAsFixed(0) + '%';
            });
          });
    } catch (e) {
      print(e);
    }
    setState(() {
      awal = false;
      progress = 'Selesai';
    });
  }

  @override
  Future<void> kaon() async {
    final response = await http.get(linknya.urlbase + "app/cek/sipal" );
    var jsson = jsonDecode(response.body);
    var data = jsson['data'];
    print('sipal');
    setState(() {
      total.addAll(data);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.kaon();
  }

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: ResponsiveContainer(
            widthPercent: 60,
            heightPercent: 4.5,
            child: Text( 'SIPAL',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22), textAlign: TextAlign.center,
            ),
          ),
          backgroundColor: ColorPalette.underlineTextField,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(child: Text("Pengertian"),),
              Tab(child: Text("Forms"),)
            ],
          ),
        ),
        body:_menu(),
        bottomNavigationBar: awal == true ? ResponsiveContainer(
          heightPercent: 10,
          widthPercent: 100,
          child: FlatButton(
            onPressed: (){},
            child: Text("Download $progress"),
          ),
        ):Padding(padding: EdgeInsets.all(0),),
      ),
    );
  }

  _menu(){
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        _sipal(),
        loading == true ? _buildProgressIndicator() : Padding(padding: EdgeInsets.only(top: 20), child: _list2(),)
      ],
    );
  }

  _sipal(){
    return Padding(
        padding: EdgeInsets.only(top: 10),
          child: InAppWebView(
            initialUrl: linknya.url + "mobile/sipal",
           )
        ) ;
  }

  _list2(){
    return ListView.builder(
      itemCount: total == null? 1:total.length + 1 ,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        if (index == total.length) {
          return _buildProgressIndicator();
        }else {
          return ResponsiveContainer(
            margin: EdgeInsets.only(bottom: 20),
            widthPercent: 90,
            heightPercent: 15,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  boxShadow:[ BoxShadow(color: Colors.grey, spreadRadius: 0.5,offset: Offset(3.0,4.0), blurRadius: 5)],
                  color: ColorPalette.underlineTextField,
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Column(
                children: <Widget>[
                  ResponsiveContainer(
                    widthPercent: 90,
                    heightPercent: 6.5,
                    alignment: Alignment.topLeft,
                    child: AutoSizeText(
                      total[index]['nama'],
                      maxLines: 2,
                      maxFontSize: 28,
                      minFontSize: 14 ,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),

                  ResponsiveContainer(
                    widthPercent: 90,
                    heightPercent: 5,
                    alignment: Alignment.topLeft,
                    child: RaisedButton(
                      onPressed: (){
                        _downloadfile(urlnya = total[index]['forms']);


                      },
                      child: AutoSizeText('Download',),
                    ),
                  ),

                ],
              ),
            ),
          );
        }
      },
      controller: _scroll2Controller,
    );
  }

  _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: loading == true ? 1.0:0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

}
