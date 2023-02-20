import 'package:dlh/animasi/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BankPage extends StatefulWidget {
  String tit;
  String ur;

  BankPage({required this.tit, required this.ur});

  @override
  _BankPage createState() => _BankPage();

}

class _BankPage extends State<BankPage> {

  late InAppWebViewController webView;
  double progress = 0;

  @override
  void initState() {
    super.initState();
    notifikasi();
  }

  @override
  Future<Null> notifikasi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('id') ?? '';
    var url = Uri.https(
        linknya.urlbase, "app/clearnotif?userId=" + userId + "&menu=7");
    await http.get(url);
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
          child: Text('Bank Sampah',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            textAlign: TextAlign.center,),),
        backgroundColor: ColorPalette.underlineTextField,
      ),
      body: _menu(),
    );
  }

  _menu() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        (progress != 1.0) ? LinearProgressIndicator(value: progress) : Padding(
          padding: EdgeInsets.all(0),),
        Expanded(
          child: RefreshIndicator(
            onRefresh: refresh,
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse(widget.ur)),
              onWebViewCreated: (InAppWebViewController controller) {
                webView = controller;
              },
              onLoadStart: (controller, url) {
                print("started $widget.ur");
                setState(() {
                  widget.ur = widget.ur;
                });
              },
              onProgressChanged: (InAppWebViewController controller,
                  int progress) {
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
