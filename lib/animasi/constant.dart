import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';

class ColorPalette{
  static const primaryColor = Color.fromRGBO(255, 255, 255, 100);
  static const trans = Color.fromRGBO(255, 255, 255, 0);
  static const primaryDarkColor = Color(0xff607Cbf);
  //static const underlineTextField = Color(0xff99e265);
  static const underlineTextField = Color(0xff70d551);
  static const hintColor = Colors.black26;
}


class linknya{
  static const urlbase = "https://dlh-serangkota.com/api/";
  static const url = 'https://dlh-serangkota.com/';
}

class struktur{
  static kadis(){
    return InAppWebView(
      initialUrl: linknya.url + 'kadis',
      onWebViewCreated: (InAppWebViewController controller){},
    );
  }
}
