import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:dlh/animasi/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_container/responsive_container.dart';
import 'package:http/http.dart' as http;

class SpplPage extends StatefulWidget{
  String ur;
  String tit;
  SpplPage({this.tit, this.ur});
  @override
  _SpplPage createState() => _SpplPage();
}
class _SpplPage extends State<SpplPage>{
  bool awal = false;
  List total = List();
  double progressLo;
  InAppWebViewController webView;
  String urlnya = '' ;
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
    final response = await http.get(linknya.urlbase + "app/dokling?nama=SPPL" );
    var jsson = jsonDecode(response.body);
    var data = jsson['data'];
    print(data);
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
    return Scaffold(
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
      ),
      body: _menu(),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        child: awal == true ? Text("Download $progress",textAlign: TextAlign.center, style: TextStyle(
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

}
