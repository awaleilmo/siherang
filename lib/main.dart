import 'dart:io';

import 'package:dlh/based/routes.dart';
import 'package:dlh/based/systems.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'animasi/animasi.dart';
import 'animasi/constant.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      initialRoute: '/splashscreen',
      onGenerateRoute: routes.rute,
      title: "DLH Kota Serang",
    );
  }
}

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  bool autol = false;
  String name = '';
  bool keluar = false;
  late Timer? timer;

  @override
  void initState() {
    super.initState();
    autoLogIn();
  }

  refresh() {
    Navigator.pop(context, 'Cancel');
    autoLogIn();
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  autoLogIn() async {
    timer = new Timer(const Duration(seconds: 3), () async {
      bool result = await checkConnection();
      if (result == true) {
        dynamic session = await getSession();
        Navigator.pushNamed(context, session['login'] ? '/home' : '/');
      } else {
        Future.delayed(Duration.zero, () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: const Text(
                      'Cek Koneksi Internet Anda.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => refresh()
                        // Navigator.pop(context);
                        ,
                        child: const Text('Retry'),
                      ),
                      TextButton(
                        onPressed: () => exit(0),
                        child: const Text(
                          'Exit',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.55,
              height: MediaQuery.of(context).size.height * 0.30,
              child: Image.asset(
                "asset/siherang.png",
                fit: BoxFit.cover,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 15)),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'APLIKASI DINAS LINGKUNGAN HIDUP KOTA SERANG',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    color: ColorPalette.underlineTextField,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 25)),
            systems.loadingBar()
          ],
        ),
      ),
    );
  }
}

class Utama extends StatefulWidget {
  @override
  _Utama createState() => _Utama();
}

class _Utama extends State<Utama> {
  bool loading = false;
  late Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage('asset/left.png'),
            alignment: Alignment.bottomLeft,
          ),
        ),
        child: ListView(
          children: <Widget>[
            _iconLogin(context),
            !loading ? _buildButton(context) : systems.loadingBar()
          ],
        ),
      ),
    );
  }

  Widget _iconLogin(context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.40,
      child: Container(
        padding: EdgeInsets.only(top: 20.0, bottom: 20),
        width: double.infinity,
        child: Image.asset(
          "asset/siherang.png",
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 50.0),
        ),
        InkWell(
          onTap: () {
            setState(() {
              loading = true;
            });
            timer = new Timer(const Duration(seconds: 1), () {
              Navigator.pushNamed(context, '/login');
              setState(() {
                loading = false;
              });
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            width: 255,
            child: Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
              color: ColorPalette.underlineTextField,
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 16.0),
        ),
        InkWell(
          onTap: () {
            setState(() {
              loading = true;
            });
            timer = new Timer(const Duration(seconds: 1), () {
              Navigator.pushNamed(context, '/register');
              setState(() {
                loading = false;
              });
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            width: 255,
            child: Text(
              "Register",
              style: TextStyle(
                color: ColorPalette.underlineTextField,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: ColorPalette.underlineTextField),
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
      ],
    );
  }
}
