import 'dart:async';
import 'dart:convert';

import 'package:dlh/animasi/animasi.dart';
import 'package:dlh/animasi/constant.dart';
import 'package:dlh/login/register.dart';
import 'package:dlh/main/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_container/responsive_container.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class LoginPage extends StatefulWidget{
  @override
  _LoginPage createState() => _LoginPage();

}

class _LoginPage extends State<LoginPage>{
  bool passwordVisible = false;
  bool loading = false;

  TextEditingController user=new TextEditingController();
  TextEditingController pass=new TextEditingController();
  String msg ='';
  String dtid='';

  @override
  Future<List> _proseslogin() async{
    setState(() {
      loading = true;
    });
      final response = await http.post(linknya.urlbase + "app/login", body: {
        'email': user.text,
        'password': pass.text
      }).timeout(const Duration(seconds: 5));
      var datauser = jsonDecode(response.body);
      var data = datauser['data'];
      print(data);
      if (datauser['status'] == 'gagal') {
        Alert(
          context: context,
          type: AlertType.error,
          title: "Terjadi Kesalahan",
          desc: "Password Atau Email Salah.",
          buttons: [
            DialogButton(
              child: Text(
                "Back",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
      } else {
        print(data[0]['id'].toString());
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('id', data[0]['id'].toString());
        prefs.setString('token', data[0]['remember_token'].toString());
        Navigator.pushReplacement(context, SlideRightRoute(page: HomePage()));
      }
      setState(() {
        loading = false;
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
        decoration: BoxDecoration(
        ),
        child:loading == true ? _buildProgressIndicator(): ListView(
          children: <Widget>[
            _iconLogin(),
            _inputan(),
            Padding( padding: EdgeInsets.only(top: 15),),
            ResponsiveContainer(
              widthPercent: 50,
              heightPercent: 5,
              alignment: Alignment.center,
              child: Text(msg, style: TextStyle(color: Colors.redAccent, fontSize: 14),),
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

  _iconLogin(){
    return Container(
      child: Text(
          'Login',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: ColorPalette.underlineTextField)

      ),
      padding: EdgeInsets.all(20.0),

    );
  }

  _inputan(){
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: user,
            decoration: new InputDecoration(
              border: UnderlineInputBorder(),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: ColorPalette.underlineTextField,
                  width: 1.5,
                ),
              ),
              prefixIcon: Icon(Icons.account_circle, color: ColorPalette.underlineTextField),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: ColorPalette.underlineTextField,
                  width: 2.5,
                ),
              ),
              hintText: "Email",
              hintStyle: TextStyle(
                  color: ColorPalette.hintColor
              ),

            ),
            style: TextStyle(color: Colors.black54),
            autofocus: false,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          TextFormField(
            controller: pass ,
            obscureText: !passwordVisible,
            decoration: new InputDecoration(
              border: UnderlineInputBorder(),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: ColorPalette.underlineTextField,
                  width: 1.5,
                ),
              ),
              prefixIcon: Icon(Icons.lock, color: ColorPalette.underlineTextField),
              suffixIcon: IconButton(
                icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off, color: ColorPalette.underlineTextField,),
                onPressed: (){
                  setState((){
                    passwordVisible = !passwordVisible;
                  });
                },
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: ColorPalette.underlineTextField,
                  width: 2.5,
                ),
              ),
              hintText: "Password",
              hintStyle: TextStyle(
                  color: ColorPalette.hintColor
              ),

            ),
            style: TextStyle(color: Colors.black54),
            autofocus: false,
          ),
        ],
      ),
    );
  }

  _btn(BuildContext context){
    return Container(
      padding: EdgeInsets.only(top:150, right: 20, left: 20),
      child:
      InkWell(

        onTap:  (){
         _proseslogin();
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical:15.0),
          width: 255,
          child: Text(
            "Login",
            style: TextStyle(color: Colors.white, fontSize: 18,),
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

  _text(BuildContext context){
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
          Padding(padding: EdgeInsets.only(left: 0),),
          InkWell(
            onTap: (){
              Navigator.pushReplacement(context, SlideLeftRoute(page: RegisterPage()));
            },
            child: Container(
              padding: EdgeInsets.only(left: 5, top: 20, bottom: 20),
              child: Text(
                "Register",
                style: TextStyle(color: ColorPalette.underlineTextField, fontSize: 11),

              ),
            ),
          )
        ],
      ),
    );
  }

  _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: loading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

}