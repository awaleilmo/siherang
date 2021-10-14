import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:dlh/animasi/animasi.dart';
import 'package:dlh/animasi/constant.dart';
import 'package:dlh/main/pengaduan/detailpeng.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_container/responsive_container.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class uklPage extends StatefulWidget{
  String ur;
  String tit;
  uklPage({this.tit, this.ur});
  @override
  _uklPage createState() => _uklPage();
}
class _uklPage extends State<uklPage>{
  bool awal = false;
  bool _loadingMore = false;
  double progressLo;
  TabController knt;
  ScrollController _scrollController = new ScrollController();
  InAppWebViewController webView;
  List total = List();
  List Peng = List();
  String urlnya = '' ;
  var progress;
  String base64Image;
  File _image;
  int _counter = 1;

  @override
  Future<void> _downloadfile(urlnya)async {
    Dio dio = Dio();
    setState(() {
      awal = true;
      progress = '...';
    });
    try {
      var dir = await getExternalStorageDirectory();
      await dio.download('http://dlh-serangkota.com/upload/dokumenlingkungan/' + urlnya,
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
    final response = await http.get(linknya.urlbase + "app/dokling?nama=UKL" );
    var jsson = jsonDecode(response.body);
    var data = jsson['data'];
    print(data);
    setState(() {
      total.addAll(data);
    });
  }

  @override
  Future<void> _incrementCounter() async {
    setState(() {
      _counter++;
      _loadingMore = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('id');
    String dok = "UKL UPL";
    final response = await http.get(linknya.urlbase + "app/infodok?userId="+userId+"&dok="+dok+"&page=" + _counter.toString());
    var jsson = jsonDecode(response.body);
    var data = jsson['data']['data'];
    setState(() {
      _loadingMore = false;
      Peng.addAll(data);
    });
  }

  @override
  Future<Null> kena() async{
    if(!_loadingMore) {
      setState(() {
        _loadingMore = true;
      });
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString('id');
      String dok = "UKL UPL";
      final response = await http.get(
          linknya.urlbase + "app/infodok?userId=" + userId + "&dok=" + dok +
              "&page=" + _counter.toString());
      var jsson = jsonDecode(response.body);
      var data = jsson['data']['data'];
      setState(() {
        _loadingMore = false;
        Peng.addAll(data);
      });
    }
  }

  Future<Null> onkena() async{
    if(!_loadingMore) {
      setState(() {
        _counter = 1;
        _loadingMore = true;
      });
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString('id');
      String dok = "UKL UPL";
      final response = await http.get(
          linknya.urlbase + "app/infodok?userId=" + userId + "&dok=" + dok +
              "&page=" + _counter.toString());
      var jsson = jsonDecode(response.body);
      var data = jsson['data']['data'];
      setState(() {
        _loadingMore = false;
        Peng = data;
      });
    }
  }

  @override
  Future<void> upload() async{
    Dio dio = Dio();
    setState(() {
      awal = true;
      progress = '...';
    });
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString('id');
      base64Image = base64Encode(_image.readAsBytesSync());
      FormData data = FormData.fromMap({
        'userId': userId,
        'dok': "UKL UPL",
        "foto": await MultipartFile.fromFile(_image.path),
      });
      dio.post(linknya.urlbase +"app/dokupload", data: data, onReceiveProgress: (rec, tota) {
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
  chooseImage() async {
    var image =  await FilePicker.getFile(
        type: FileType.custom,
        allowedExtensions: ['pdf','doc','docx']
    );
    setState(() {
      _image = image;
    });
    //print(_image);
  }

  @override
  Future<Null> notifikasi()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('id');
    await http.get(linknya.urlbase + "app/clearnotif?userId="+ userId +"&menu=2" );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener((){
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent)
        _incrementCounter();
    });
    this.notifikasi();
    this.kena();
    this.kaon();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            title: ResponsiveContainer(
              widthPercent: 60,
              heightPercent: 4.5,
              child: Text(
                widget.tit,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22), textAlign: TextAlign.center,
              ),
            ),
            backgroundColor: ColorPalette.underlineTextField,
            bottom: _tabBar()
        ),
        body: ResponsiveContainer(
          margin: EdgeInsets.all(10),
          widthPercent: 100,
          heightPercent: 100,
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              RefreshIndicator(
                child: _menu(),
                onRefresh: kaon,
              ),
              RefreshIndicator(
                child: _list2(),
                onRefresh: onkena,
              ),

            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(10),
          child: awal == true ? Text("$progress",textAlign: TextAlign.center, style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),): RaisedButton(
            color: ColorPalette.underlineTextField,
            onPressed: (){
              _downloadfile(urlnya = total[0]['forms']);
            },
            child: AutoSizeText('Download Form',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14),),
          ),
        ),
        floatingActionButton: RaisedButton(
          onPressed: ()async{
            await chooseImage();
            await upload();
            onkena();
          },
          color: ColorPalette.underlineTextField,
          padding: EdgeInsets.all(10),
          child: ResponsiveContainer(
            widthPercent: 25,
            heightPercent: 5,
            child: AutoSizeText('Tambah Pengajuan',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
          ),
        ),
      ),
    );
  }
  _tabBar(){
    return TabBar(

      tabs: <Widget>[
        Tab ( child: AutoSizeText('Pengertian UKL UPL',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),), ),
        Tab ( child: AutoSizeText('Pengajuan UKL UPL',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),), ),
      ],
    );
  }

  _menu(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        (progressLo != 1.0) ? LinearProgressIndicator(value: progressLo) : Padding(padding: EdgeInsets.all(0),),
        Expanded(
          child: RefreshIndicator(
            onRefresh: kaon,
            child: InAppWebView(
              initialUrl: widget.ur,
              initialHeaders: {

              },
              initialOptions: {

              },
              onWebViewCreated: (InAppWebViewController controller) {
                webView = controller;
              },
              onLoadStart: (InAppWebViewController controller, String url) {
                print("started $widget.ur");
                setState(() {
                  widget.ur = widget.ur;
                });
              },
              onProgressChanged: (InAppWebViewController controller, int progress) {
                setState(() {
                  this.progressLo = progress/100;
                });
              },
            ),
          ),
        )
      ],
    );
  }

  _list2(){

    return ListView.builder(
      itemCount: Peng == null? 1:Peng.length + 1 ,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        if (index == Peng.length) {
          return _buildProgressIndicator();
        }else {
          return InkWell(
            onTap: () {

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
                  color: Peng[index]['status'] == 'Selesai' ? ColorPalette.underlineTextField: Peng[index]['status'] == 'Ditolak' ? Colors.red : Colors.orange,
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
                          margin: EdgeInsets.only(top: 10),
                          widthPercent: 41, heightPercent: 3, child: SizedBox(
                          child: AutoSizeText(
                            "Tanggal Pengaduan", maxLines: 2,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: Colors.white),),),
                        ),
                        ResponsiveContainer(widthPercent: 41,
                          heightPercent: 2,
                          alignment: Alignment.bottomLeft,
                          child: SizedBox(
                            child: Container(
                              child: AutoSizeText(
                                DateFormat('dd - MMMM - yyyy').format(
                                    DateTime.parse(Peng[index]['created_at'])),
                                maxLines: 2, style: TextStyle(fontSize: 10,color: Colors.white),),
                            ),
                          ),
                        ),
                        ResponsiveContainer(
                          margin: EdgeInsets.only(top: 10),
                          widthPercent: 41, heightPercent: 3, child: SizedBox(
                          child: AutoSizeText(
                            "Keterangan", maxLines: 2,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: Colors.white),),),
                        ),
                        ResponsiveContainer(widthPercent: 41,
                          heightPercent: 2,
                          alignment: Alignment.bottomLeft,
                          child: SizedBox(
                            child: Container(
                              child: AutoSizeText(
                                Peng[index]['keterangan'] == null ? "-" : Peng[index]['keterangan'],
                                maxLines: 2, style: TextStyle(fontSize: 10,color: Colors.white),),
                            ),
                          ),
                        ),

                        ResponsiveContainer(
                          margin: EdgeInsets.only(top: 10),
                          widthPercent: 41, heightPercent: 3, child: SizedBox(
                          child: AutoSizeText(
                            "Nama File", maxLines: 2,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: Colors.white),),),
                        ),
                        ResponsiveContainer(widthPercent: 41,
                          heightPercent: 2,
                          alignment: Alignment.bottomLeft,
                          child: SizedBox(
                            child: AutoSizeText(
                              Peng[index]['file'],
                              maxLines: 5, style: TextStyle(fontSize: 14,color: Colors.white),),
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(left: 5),),
                    Column(children: <Widget>[
                      ResponsiveContainer(
                        margin: EdgeInsets.only(top: 10),
                        widthPercent: 41, heightPercent: 3, child: SizedBox(
                        child: AutoSizeText(
                          "Status", maxLines: 2,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: Colors.white),),),
                      ),
                      ResponsiveContainer(widthPercent: 41,
                        heightPercent: 2,
                        alignment: Alignment.bottomLeft,
                        child: SizedBox(
                          child: AutoSizeText(
                            Peng[index]['status'] == 'Selesai' ? 'Selesai':Peng[index]['status'] == 'Pending' ? 'Pending':'Ditolak',
                            maxLines: 2, style: TextStyle(fontSize: 14,color: Colors.white),),
                        ),
                      ),

                    ],)
                  ],
                ),
              ),
            ),
          );
        }
      }, controller: _scrollController,
    );
  }

  _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: _loadingMore == true ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

}
