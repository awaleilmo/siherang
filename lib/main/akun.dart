import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dlh/animasi/animasi.dart';
import 'package:dlh/animasi/constant.dart';
import 'package:dlh/based/api.dart';
import 'package:dlh/based/systems.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AkunPage extends StatefulWidget {
  @override
  _AkunPage createState() => _AkunPage();
}

class _AkunPage extends State<AkunPage> {
  TextEditingController email = new TextEditingController();
  TextEditingController nama = new TextEditingController();
  TextEditingController nohp = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  bool loading = false;
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    dataMenu();
  }

  Future<void> dataMenu() async {
    setState(() {
      loading = true;
    });
    var data = await getDataUser();
    setState(() {
      nama.text = data['name'];
      email.text = data['email'];
      nohp.text = data['nohp'];
      loading = false;
    });
  }

  void logout(context) async {
    setState(() {
      loading = true;
    });
    new Timer(const Duration(seconds: 3), () async {
      await setSession('', '', false);
      Navigator.pushReplacementNamed(context, '/');
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: ColorPalette.underlineTextField,
        body: Center(
          child: loading == true
              ? Container(
                  color: Colors.white,
                  child: systems.loadingBar(),
                )
              : RefreshIndicator(
                  child: SafeArea(
                    child: Container(
                      child: loading == true
                          ? systems.loadingBar()
                          : Column(
                              children: <Widget>[
                                _top(),
                                _inputan(),
                                _btn(context)
                              ],
                            ),
                    ),
                  ),
                  onRefresh: dataMenu,
                ),
        ));
  }

  _title() {
    return Center(
      child: ColoredBox(
        color: ColorPalette.underlineTextField,
        child: Text("Sign In",
            style: TextStyle(
                color: Colors.white, fontSize: 26.0, fontFamily: 'BluesSmile')),
      ),
    );
  }

  _top() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.bottomStart,
      children: [
        Container(
          decoration: BoxDecoration(
            color: ColorPalette.underlineTextField,
          ),
          height: 200.0,
        ),
        Container(
          height: 100.0,
          width: MediaQuery.of(context).size.width * 0.78,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(50))),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(50))),
          height: 50.0,
        ),
        Container(
          height: 120,
          alignment: Alignment.center,
          child: SvgPicture.asset('asset/img/my_documents.svg'),
        ),
        Positioned(
          top: 25,
          left: 170,
          child: _title(),
        ),
      ],
    );
  }

  _inputan() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          systems.inputText(nama, 'Nama Lengkap', Icons.account_box_rounded),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          systems.inputText(email, 'Email', Icons.email),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          systems.inputNumber(nohp, 'No HP', Icons.phone),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          // Padding(
          //   padding: EdgeInsets.only(top: 20.0),
          // ),
          // systems.inputPassword(pass, 'Passwords', passwordVisible, () {
          //   setState(() {
          //     passwordVisible = !passwordVisible;
          //   });
          // }),
        ],
      ),
    );
  }

  _btn(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: systems.btnDefault(() {
        logout(context);
      }, "Logout"),
    );
  }
}
