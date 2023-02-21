import 'dart:async';

import 'package:dlh/animasi/constant.dart';
import 'package:dlh/based/api.dart';
import 'package:dlh/based/systems.dart';

// import 'package:dlh/login/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  bool passwordVisible = false;
  bool loading = false;

  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  String msg = '';
  String dtid = '';

  void _proseslogin(context) async {
    setState(() {
      loading = true;
    });
    new Timer(const Duration(seconds: 2), () async {
      var response = await api().login(user.text, pass.text);
      var data = response['data'];
      if (response['status'] == 'gagal') {
        systems.alertError(context, 'Email atau Password salah');
      } else {
        await setSession(data[0]['id'].toString(),
            data[0]['remember_token'].toString(), true);
        // Navigator.pushReplacement(context, SlideRightRoute(page: HomePage()));
      }
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorPalette.underlineTextField),
        backgroundColor: Colors.white,
      ),
      body: DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(),
        child: loading == true
            ? systems.loadingBar()
            : ListView(
                children: <Widget>[
                  _iconLogin(),
                  _inputan(),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.50,
                    height: MediaQuery.of(context).size.height * 0.05,
                    alignment: Alignment.center,
                    child: Text(
                      msg,
                      style: TextStyle(color: Colors.redAccent, fontSize: 14),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      _btn(context),
                    ],
                  ),
                  _text(context)
                  // _buildButton(context)
                ],
              ),
      ),
    );
  }

  _iconLogin() {
    return Container(
      child: Text('Login',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: ColorPalette.underlineTextField)),
      padding: EdgeInsets.all(20.0),
    );
  }

  _inputan() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          systems.inputText(user, "Email", Icons.account_circle),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          systems.inputPassword(pass, 'Passwords', passwordVisible, (){
            setState(() {
              passwordVisible = !passwordVisible;
            });
          }),
        ],
      ),
    );
  }

  _btn(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 150, right: 20, left: 20),
      child: InkWell(
        onTap: () {
          var sams = Overlay.of(context);
          _proseslogin(sams);
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
    );
  }

  _text(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Belum Punya Akun DLH Kota Serang?",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 11),
          ),
          Padding(
            padding: EdgeInsets.only(left: 0),
          ),
          InkWell(
            onTap: () {
              setState(() {
                loading = true;
              });
              new Timer(const Duration(seconds: 2), () {
                Navigator.pushReplacementNamed(context, '/register');
                setState(() {
                  loading = false;
                });
              });
            },
            child: Container(
              padding: EdgeInsets.only(left: 5, top: 20, bottom: 20),
              child: Text(
                "Register",
                style: TextStyle(
                    color: ColorPalette.underlineTextField, fontSize: 11),
              ),
            ),
          )
        ],
      ),
    );
  }
}
