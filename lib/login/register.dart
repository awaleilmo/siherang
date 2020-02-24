


import 'dart:convert';

import 'package:dlh/animasi/animasi.dart';
import 'package:dlh/animasi/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

import '../main.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget{
  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage>{

  bool pw1 = false;
  bool pw2 = false;
  String msg='';
  bool loading = false;
  TextEditingController email=new TextEditingController();
  TextEditingController nama=new TextEditingController();
  TextEditingController nohp=new TextEditingController();
  TextEditingController pass=new TextEditingController();
  TextEditingController cpass=new TextEditingController();
  String mse ='';

  @override
  Future<List> _register() async {
    setState(() {
      loading = true;
    });
    if(cpass.text == pass.text) {
      final response = await http.post(linknya.urlbase + "app/register", body: {
        'name': nama.text,
        'email': email.text,
        'nohp': nohp.text,
        'password': pass.text,
        'c_password': pass.text,
      });
      var jsson = jsonDecode(response.body);
      var data = jsson['data'];
      var status = jsson['status'];
      var errors = jsson['error'];
      if (errors != null) {
        print(errors);
        Alert(
          context: context,
          type: AlertType.error,
          title: "Terjadi Kesalahan",
          desc: 'Email Tidak Valid / Email Sudah Terdaftar',
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
      }else if(status == 'sukses'){
        Alert(
          context: context,
          type: AlertType.success,
          title: "Berhasil",
          desc: 'Email dan Password Anda berhasil didaftarkan',
          buttons: [
            DialogButton(
              child: Text(
                "Next",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pushReplacement(context, SlideRightRoute(page: LoginPage())),
              width: 120,
            )
          ],
        ).show();
      }
    }else{
      Alert(
        context: context,
        type: AlertType.error,
        title: "Terjadi Kesalahan",
        desc: 'Password Tidak Sama',
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
        child:loading == true? _buildProgressIndicator():ListView(
          children: <Widget>[
            _iconLogin(),
            _inputan(),
            _btn(context),
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
          'Register',
          textAlign: TextAlign.left,
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
            controller: nama,
            decoration: new InputDecoration(
              border: UnderlineInputBorder(),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: ColorPalette.underlineTextField,
                  width: 1.5,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: ColorPalette.underlineTextField,
                  width: 2.5,
                ),
              ),
              hintText: "Nama Lengkap",
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
            controller: email,
            decoration: new InputDecoration(
              border: UnderlineInputBorder(),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: ColorPalette.underlineTextField,
                  width: 1.5,
                ),
              ),
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
            controller: nohp,
            decoration: new InputDecoration(
              border: UnderlineInputBorder(),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: ColorPalette.underlineTextField,
                  width: 1.5,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: ColorPalette.underlineTextField,
                  width: 2.5,
                ),
              ),
              hintText: "No HP",
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
            controller: pass,
            decoration: new InputDecoration(
              border: UnderlineInputBorder(),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: ColorPalette.underlineTextField,
                  width: 1.5,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: ColorPalette.underlineTextField,
                  width: 2.5,
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(pw1 ? Icons.visibility : Icons.visibility_off, color: ColorPalette.underlineTextField,),
                onPressed: (){
                  setState((){
                    pw1 = !pw1;
                  });
                },
              ),
              hintText: "Password",
              hintStyle: TextStyle(
                  color: ColorPalette.hintColor
              ),

            ),
            style: TextStyle(color: Colors.black54),
            autofocus: false,
            obscureText: !pw1,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          TextFormField(
            controller: cpass,
            decoration: new InputDecoration(
              border: UnderlineInputBorder(),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: ColorPalette.underlineTextField,
                  width: 1.5,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: ColorPalette.underlineTextField,
                  width: 2.5,
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(pw2 ? Icons.visibility : Icons.visibility_off, color: ColorPalette.underlineTextField,),
                onPressed: (){
                  setState((){
                    pw2 = !pw2;
                  });
                },
              ),
              hintText: "Ulangi Password",
              hintStyle: TextStyle(
                  color: ColorPalette.hintColor
              ),

            ),
            style: TextStyle(color: Colors.black54),
            autofocus: false,
            obscureText: !pw2,
          ),
        ],
      ),
    );
  }

 _btn(BuildContext context){
    return Container(
      padding: EdgeInsets.only(top:50, right: 20, left: 20),
      child:
      InkWell(

        onTap:  (){
          _register();
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical:15.0),
          width: 200,
          child: Text(
            "Register",
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
            "Sudah Punya Akun DLH Kota Serang?",
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 11),
          ),
          Padding(padding: EdgeInsets.only(left: 0),),
          InkWell(
            onTap: (){
              Navigator.pushReplacement(context, SlideLeftRoute(page: LoginPage()));
            },
            child: Container(
              padding: EdgeInsets.only(left: 5.0, top: 20, bottom: 20),
              child: Text(
                "Login",
                textAlign: TextAlign.left,
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