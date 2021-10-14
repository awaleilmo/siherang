import 'package:dlh/animasi/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:responsive_container/responsive_container.dart';



class VideoPage extends StatefulWidget{
  int ur;
  String tit;
  VideoPage({this.tit, this.ur});
  @override
  _VideoPage createState() => _VideoPage();

}
class _VideoPage extends State<VideoPage>{

  InAppWebViewController webView;
  double progress = 0;
  String url ;

  @override
  void initState(){
    super.initState();
    url = widget.ur.toString();
  }

  @override
  Future<void> refresh() {
    widget.tit = widget.tit;
    widget.ur = widget.ur;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ResponsiveContainer(widthPercent: 60,heightPercent: 4.5, child: Text('Video', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22), textAlign: TextAlign.center,),),
        backgroundColor: ColorPalette.underlineTextField,
      ),
      body:_menu(),
    );
  }



  _menu(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        (progress != 1.0) ? LinearProgressIndicator(value: progress) : Padding(padding: EdgeInsets.all(0),),
        Expanded(
          child: RefreshIndicator(
            onRefresh: refresh,
            child: InAppWebView(
              initialUrl: "https://dlh-serangkota.com/api/app/video/" + widget.ur.toString(),
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
                  this.progress = progress/100;
                });
              },
            ),
          ),
        )
      ],
    );
  }

}
