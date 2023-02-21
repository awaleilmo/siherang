import 'dart:async';
import 'dart:convert';

import 'package:dlh/animasi/animasi.dart';
import 'package:dlh/animasi/constant.dart';
import 'package:dlh/based/api.dart';
import 'package:dlh/based/systems.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  bool pw1 = false;
  bool pw2 = false;
  String msg = '';
  bool loading = false;
  TextEditingController email = new TextEditingController();
  TextEditingController nama = new TextEditingController();
  TextEditingController nohp = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  TextEditingController cpass = new TextEditingController();
  String mse = '';

  void _loading() {
    setState(() {
      loading = !loading;
    });
  }

  void _register(context) async {
    setState(() {
      loading = true;
    });
    new Timer(const Duration(seconds: 2), () async {
      if (nama.text == '') {
        _loading();
        systems.alertError(context, 'Nama Harus diisi');
        return;
      }
      if (email.text == '') {
        _loading();
        systems.alertError(context, 'Email Harus diisi');
        return;
      }
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email.text)) {
        _loading();
        systems.alertError(context, 'Alamat Email Tidak Benar');
        return;
      }
      if (nohp.text == '') {
        _loading();
        systems.alertError(context, 'No HP Harus diisi');
        return;
      }
      if (nohp.text.length < 11) {
        _loading();
        systems.alertError(context, 'No HP Tidak Benar');
        return;
      }
      if (pass.text.length < 6) {
        _loading();
        systems.alertError(context, 'Password minimal 6 karakter');
        return;
      }
      if (pass.text == '') {
        _loading();
        systems.alertError(context, 'Password Harus diisi');
        return;
      }
      if (cpass.text == '') {
        _loading();
        systems.alertError(context, 'Konfirm Password Harus diisi');
        return;
      }
      if (cpass.text != pass.text) {
        _loading();
        systems.alertError(context, 'Password Tidak Sama');
        return;
      }
      final response =
          await api().register(nama.text, email.text, nohp.text, pass.text);
      if (response['error'] != null) {
        var emailError = response['error']['email'] ?? null;
        var noHpError = response['error']['nohp'] ?? null;
        if(noHpError != null) {
          systems.alertError(
              context, noHpError[0]);
        }
        if(emailError != null) {
          systems.alertError(
              context, emailError[0]);
        }

      } else if (response['status'] == 'sukses') {
        setState(() {
          email.text = '';
          nama.text = '';
          nohp.text = '';
          pass.text = '';
          cpass.text = '';
        });
        systems.alertSuccess(context, 'Berhasil di Daftarkan, silahkan login');
      } else {
        systems.alertError(
            context, 'Terjadi Kesalahan, Coba ulangi lagi');
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
                  _btn(context),
                  _text(context)
                  // _buildButton(context)
                ],
              ),
      ),
    );
  }

  _iconLogin() {
    return Container(
      child: Text('Register',
          textAlign: TextAlign.left,
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
          systems.inputText(nama, 'Nama Lengkap', Icons.account_box_rounded),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          systems.inputText(email, 'Email', Icons.email),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          systems.inputNumber(email, 'No HP', Icons.phone),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          systems.inputPassword(pass, "Password", pw1, () {
            setState(() {
              pw1 = !pw1;
            });
          }),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          systems.inputPassword(cpass, "Konfirmasi Password", pw2, () {
            setState(() {
              pw2 = !pw2;
            });
          }),
        ],
      ),
    );
  }

  _btn(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50, right: 20, left: 20),
      child: InkWell(
        onTap: () {
          _register(Overlay.of(context));
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          width: 200,
          child: Text(
            "Register",
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
            "Sudah Punya Akun DLH Kota Serang?",
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
                Navigator.pushReplacementNamed(context, '/login');
                setState(() {
                  loading = false;
                });
              });
            },
            child: Container(
              padding: EdgeInsets.only(left: 5.0, top: 20, bottom: 20),
              child: Text(
                "Login",
                textAlign: TextAlign.left,
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
