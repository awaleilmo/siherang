import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ColorPalette{
  static const primaryColor = Color.fromRGBO(255, 255, 255, 100);
  static const trans = Color.fromRGBO(255, 255, 255, 0);
  static const primaryDarkColor = Color(0xff607Cbf);
  //static const underlineTextField = Color(0xff99e265);
  static const underlineTextField = Color(0xff70d551);
  static const hintColor = Colors.black26;
}


class linknya{
  static const urlbase = "127.0.0.1:8000/api/";
  static const url = '127.0.0.1:8000/';
}

class struktur{
  static kadis(){
    return InAppWebView(
      initialUrlRequest: URLRequest(url: Uri.parse('${linknya.url}kadis')),
      onWebViewCreated: (InAppWebViewController controller){},
    );
  }
}
