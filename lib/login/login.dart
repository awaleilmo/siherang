import 'dart:async';

import 'package:dlh/animasi/constant.dart';
import 'package:dlh/based/api.dart';
import 'package:dlh/based/systems.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  bool passwordVisible = false;
  bool loading = false;

  Timer? timer = Timer(Duration(milliseconds: 1), () {});

  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  String msg = '';
  String dtid = '';

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _proseslogin(context, konteks) async {
    setState(() {
      loading = true;
    });
    timer = new Timer(const Duration(seconds: 1), () async {
      try {
        var response = await api().login(user.text, pass.text);
        var data = response['data'];
        if (response['status'] == 'gagal') {
          systems.alertError(context, 'Email atau Password salah');
        } else {
          await setSession(data[0]['id'].toString(),
              data[0]['remember_token'].toString(), true);
          await setDataUser(data[0]);
          Navigator.pushReplacementNamed(konteks, '/home');
        }
      } catch (e) {
        systems.alertError(context, "we can't connect to the internet, check if the internet network is connected");
      }
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.underlineTextField,
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                leadingWidth: 0,
                backgroundColor: ColorPalette.underlineTextField,
                expandedHeight: 100.0,
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          size: 18,
                          weight: 15.0,
                        ),
                        color: Colors.white,
                      ),
                      Text("Sign In",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 26.0,
                              fontFamily: 'BluesSmile'))
                    ],
                  ),
                ),
              ),
            ];
          },
          body: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: loading == true
                ? systems.loadingBar()
                : ListView(
                    children: <Widget>[
                      _iconLogin(context),
                      _inputan(),
                      _btn(context),
                      _text(context)
                    ],
                  ),
          )),
    );
  }

  _iconLogin(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        width: double.infinity,
        child: SvgPicture.asset('asset/img/login.svg',
            semanticsLabel: 'Acme Logo'),
      ),
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
          systems.inputPassword(pass, 'Passwords', passwordVisible, () {
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
      padding: EdgeInsets.only(top: 50, right: 20, left: 20),
      child: systems.btnDefault(() {
        _proseslogin(Overlay.of(context), context);
      }, "Sign In"),
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
              timer = new Timer(const Duration(seconds: 1), () {
                Navigator.pushReplacementNamed(context, '/register');
                setState(() {
                  loading = false;
                });
              });
            },
            child: Container(
              padding: EdgeInsets.only(left: 5, top: 20, bottom: 20),
              child: Text(
                "Sign Up",
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
