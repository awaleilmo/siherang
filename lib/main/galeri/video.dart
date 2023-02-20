import 'package:dlh/animasi/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class VideoPage extends StatefulWidget {
  int ur;
  String tit;

  VideoPage({required this.tit, required this.ur});

  @override
  _VideoPage createState() => _VideoPage();
}

class _VideoPage extends State<VideoPage> {
  late InAppWebViewController webView;
  double progress = 0;
  late String url;

  @override
  void initState() {
    super.initState();
    url = widget.ur.toString();
  }

  @override
  Future<void> refresh() async {
    widget.tit = widget.tit;
    widget.ur = widget.ur;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: MediaQuery.of(context).size.width * 0.60,
          height: MediaQuery.of(context).size.height * 0.045,
          child: Text(
            'Video',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: ColorPalette.underlineTextField,
      ),
      body: _menu(),
    );
  }

  _menu() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        (progress != 1.0)
            ? LinearProgressIndicator(value: progress)
            : Padding(
                padding: EdgeInsets.all(0),
              ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: refresh,
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                  url: Uri.parse(
                      "${linknya.urlbase}app/video/${widget.ur.toString()}")),
              onWebViewCreated: (InAppWebViewController controller) {
                webView = controller;
              },
              onLoadStart: (controller, url) {
                print("started $widget.ur");
                setState(() {
                  widget.ur = widget.ur;
                });
              },
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                setState(() {
                  this.progress = progress / 100;
                });
              },
            ),
          ),
        )
      ],
    );
  }
}
