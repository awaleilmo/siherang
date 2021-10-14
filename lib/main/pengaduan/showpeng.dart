import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dlh/animasi/animasi.dart';
import 'package:dlh/animasi/constant.dart';
import 'package:dlh/main/pengaduan/detailpeng.dart';
import 'package:dlh/main/pengaduan/pengaduan.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:responsive_container/responsive_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PengPage extends StatefulWidget{

  @override
  _PengPage createState()=> _PengPage();
}

class _PengPage extends State<PengPage>{
  int _counter = 0;
  List total = new List();
  bool loading = false;


  @override
  void initState(){
    super.initState();
    notifikasi();
    kaon();
  }

  @override
  Future<Null> notifikasi()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('id');
    await http.get(linknya.urlbase + "app/clearnotif?userId="+ userId +"&menu=6" );
  }

  @override
  Future<void> kaon() async {
    setState(() {
      loading = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('id');
    final response = await http.get(linknya.urlbase + "app/showpengaduan?userId=" + userId);
    var jsson = jsonDecode(response.body);
    var datat = jsson['data'];
    //print(datat);
    setState(() {
      total.addAll(datat);
      loading = false;
    });
  }

  @override
  Future<void> kaon1() async {
    setState(() {
      loading = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('id');
    final response = await http.get(linknya.urlbase + "app/showpengaduan?userId=" + userId);
    var jsson = jsonDecode(response.body);
    var datat = jsson['data'];
    setState(() {
      total = datat;
      loading = false;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ResponsiveContainer(widthPercent: 60,heightPercent: 4.5, child: Text('Pengaduan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22), textAlign: TextAlign.center,),),
        backgroundColor: ColorPalette.underlineTextField,
      ),
      body:loading == true ? _buildProgressIndicator(): RefreshIndicator(
        child: _list2(),
        onRefresh: kaon1,
      ),
      floatingActionButton: RaisedButton(
        onPressed: (){
          Navigator.push(context, SlideRightRoute(page: PengaduanMaps()));
        },
        color: ColorPalette.underlineTextField,
        padding: EdgeInsets.all(10),
        child: ResponsiveContainer(
          widthPercent: 25,
          heightPercent: 5,
          child: AutoSizeText('Tambah Pengaduan',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
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
          return InkWell(
            onTap: () {
             Navigator.push(context, SlideRightRoute(page: DetailPeng(idnya: total[index]['id'],)));
              print('ok');
            },
            child: ResponsiveContainer(
              margin: EdgeInsets.only(top: 20, left: 10, right: 10),
              widthPercent: 90,
              heightPercent: 25,
              child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    boxShadow:[ BoxShadow(color: Colors.grey, spreadRadius: 0.5,offset: Offset(3.0,4.0), blurRadius: 5)],
                    color: total[index]['status'] == 'Selesai' ? ColorPalette.underlineTextField: Colors.orange,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  verticalDirection: VerticalDirection.up,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        ResponsiveContainer(
                          widthPercent: 50, heightPercent: 3, child: SizedBox(
                          child: AutoSizeText(
                            "Nama Pengadu", maxLines: 2,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: Colors.white),),),
                        ),
                        ResponsiveContainer(
                          widthPercent: 50, heightPercent: 3, child: SizedBox(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.white))
                            ),
                            child: AutoSizeText(
                              total[index]['nama'], maxLines: 2,style: TextStyle(color: Colors.white),),
                          )

                          ,),
                        ),
                        ResponsiveContainer(
                          margin: EdgeInsets.only(top: 10),
                          widthPercent: 50, heightPercent: 3, child: SizedBox(
                          child: AutoSizeText(
                            "Tanggal Pengaduan", maxLines: 2,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: Colors.white),),),
                        ),
                        ResponsiveContainer(widthPercent: 50,
                          heightPercent: 2,
                          alignment: Alignment.bottomLeft,
                          child: SizedBox(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.white))
                              ),
                              child: AutoSizeText(
                                DateFormat('dd - MMMM - yyyy').format(
                                    DateTime.parse(total[index]['created_at'])),
                                maxLines: 2, style: TextStyle(fontSize: 10,color: Colors.white),),
                            ),
                          ),
                        ),
                        ResponsiveContainer(
                          margin: EdgeInsets.only(top: 10),
                          widthPercent: 50, heightPercent: 3, child: SizedBox(
                          child: AutoSizeText(
                            "Status", maxLines: 2,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: Colors.white),),),
                        ),
                        ResponsiveContainer(widthPercent: 50,
                          heightPercent: 2,
                          alignment: Alignment.bottomLeft,
                          child: SizedBox(
                            child: AutoSizeText(
                              total[index]['status'] == 'Selesai' ? 'Selesai':total[index]['status'] == 'Pending' ? 'Pending':'Ditolak',
                              maxLines: 2, style: TextStyle(fontSize: 14,color: Colors.white),),
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(left: 5),),
                    ResponsiveContainer(
                      widthPercent: 35,
                      heightPercent: 100,
                      alignment: Alignment.topLeft,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(5),
                            image: new DecorationImage(
                                image: NetworkImage(linknya.url + '/upload/pengaduan/' + total[index]['foto'], scale: 1.0),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          );
        }
      },
//      controller: _scroll2Controller,
    );
  }

  _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: loading == true ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
}