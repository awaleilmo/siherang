import 'package:dlh/login/login.dart';
import 'package:dlh/login/register.dart';
import 'package:dlh/main.dart';
import 'package:dlh/main/menu.dart';
import 'package:flutter/cupertino.dart';

class routes {
  static final rute = (RouteSettings settings) {
    switch (settings.name) {
      case '/splashscreen':
        return CupertinoPageRoute(
            builder: (_) => SplashScreenPage(), settings: settings);
      case '/home':
        return CupertinoPageRoute(builder: (_) => HomePage(), settings: settings);
      case '/':
        return CupertinoPageRoute(builder: (_) => Utama(), settings: settings);
      case '/login':
        return CupertinoPageRoute(
            builder: (_) => LoginPage(), settings: settings);
      case '/register':
        return CupertinoPageRoute(
            builder: (_) => RegisterPage(), settings: settings);
    }
  };
}
