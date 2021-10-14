import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:dlh/animasi/animasi.dart';
import 'package:dlh/animasi/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_container/responsive_container.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../artikelpage.dart';


class InfoData extends StatefulWidget{
  _InfoData createState() => _InfoData();
}

class _InfoData extends State<InfoData>{
  bool loading=false;
  String Judul = '';
  String nmmenu ='';
  bool downloading = false;
  List total = new List();
  var ikon;
  String urlnya = '';
  var tujuan;
  var progressLo = "";
  ScrollController _scroll2Controller = new ScrollController();
  int _counterpe = 1;

  @override
  Future<Null> notifikasi()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('id');
    await http.get(linknya.urlbase + "app/clearnotif?userId="+ userId +"&menu=8" );
  }

  @override
  void initState() {
    super.initState();
    notifikasi();
    kaon();
    _scroll2Controller.addListener((){
      if(_scroll2Controller.position.pixels == _scroll2Controller.position.maxScrollExtent)
        _incrementpe();
    });

  }

  @override
  Future<void> _incrementpe() async {
    setState(() {
      _counterpe++;
      loading = true;
    });
    final response = await http.get(linknya.urlbase + "app/info_data?page=" + _counterpe.toString());
    var jsson = jsonDecode(response.body);
    var data = jsson['data']['data'];
    print('Info Data');
    setState(() {
      loading = false;
      total.addAll(data);
    });
  }

  @override
  Future<void> kaon() async {
    setState(() {
      loading=true;
    });
    final response = await http.get(linknya.urlbase + "app/info_data?page=1" );
    var jsson = jsonDecode(response.body);
    var data = jsson['data']['data'];
    setState(() {
      loading = false;
      total.addAll(data);
    });
  }

  @override
  Future<void> _downloadfile(urlnya)async{
    Dio dio = Dio();

    try  {
      var dir = await getExternalStorageDirectory();
      await dio.download('http://dlh-serangkota.com/upload/data/' + urlnya,
          dir.path + "/" + urlnya, onReceiveProgress: (rec, tota) {
            print('Rec: $rec, Total: $tota');
            setState((){
              downloading = true;
              progressLo = ((rec / tota) * 100).toStringAsFixed(0) + '%';
            });
          });
    }catch(e){
      print(e);
    }

    setState(() {
      downloading = false;
      progressLo = 'Selesai';
    });
    print('download selesai');
  }

  @override
  Future<void> _showdownload() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: new ResponsiveContainer(widthPercent: 20, heightPercent: 15,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                downloading == true ? Icon(Icons.check_circle_outline, size: 50, color: ColorPalette.underlineTextField,) :CircularProgressIndicator(),
                SizedBox(
                  height: 25,
                ),
                Text('Downloading $progressLo')
              ],
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.underlineTextField,
        title: ResponsiveContainer(widthPercent: 60,heightPercent: 4.5, child: Text(downloading ? 'Download $progressLo':'Informasi Data', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22), textAlign: TextAlign.center,),),
        elevation: 0,
      ),
      body:loading == true ? _buildProgressIndicator():  RefreshIndicator(
        child: ResponsiveContainer(
          widthPercent: 100,
          heightPercent: 100,
          padding: EdgeInsets.only(top:25),
          child: _list2(),
        ),
        onRefresh: kaon,
      ),
    );


  }

  _padding(){
    return Padding(
      padding: EdgeInsets.only(top: 25),
    );
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
                      heightPercent: 5,
                      alignment: Alignment.topLeft,
                      child: AutoSizeText(
                        total[index]['nama'],
                        maxLines: 2,
                        maxFontSize: 28,
                        minFontSize: 20 ,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),

                    ResponsiveContainer(
                      widthPercent: 90,
                      heightPercent: 5,
                      alignment: Alignment.topLeft,
                      child: RaisedButton(
                        onPressed: (){
                          _downloadfile(urlnya = total[index]['files']);


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