import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dlh/animasi/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class systems {
  static inputText(control, String name, icons) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              height: 25,
              child: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              )),
          TextFormField(
            controller: control,
            decoration: InputDecoration(
              filled: true,
              fillColor: ColorPalette.textFiled,
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                  color: ColorPalette.textFiledBorder,
                  style: BorderStyle.solid,
                  width: 0.2,
                ),
              ),
              prefixIcon: Icon(icons ?? Icons.text_fields,
                  color: ColorPalette.textFiledBorder),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                  style: BorderStyle.none,
                ),
              ),
              hintText: name,
              hintStyle: TextStyle(
                  color: ColorPalette.hintColor, fontWeight: FontWeight.w500),
            ),
            style: TextStyle(color: Colors.black54),
            autofocus: false,
          )
        ],
      );

  static inputNumber(control, String name, icons) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              height: 25,
              child: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              )),
          TextFormField(
            controller: control,
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(
              filled: true,
              fillColor: ColorPalette.textFiled,
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                  color: ColorPalette.textFiledBorder,
                  style: BorderStyle.solid,
                  width: 0.2,
                ),
              ),
              prefixIcon: Icon(icons ?? Icons.text_fields,
                  color: ColorPalette.textFiledBorder),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                  style: BorderStyle.none,
                ),
              ),
              hintText: name,
              hintStyle: TextStyle(
                  color: ColorPalette.hintColor, fontWeight: FontWeight.w500),
            ),
            style: TextStyle(color: Colors.black54),
            autofocus: false,
          )
        ],
      );

  static inputPassword(control, String name, bool passwordVisible, onTaps) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              height: 25,
              child: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              )),
          TextFormField(
            controller: control,
            obscureText: !passwordVisible,
            decoration: new InputDecoration(
              filled: true,
              fillColor: ColorPalette.textFiled,
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                  color: ColorPalette.textFiledBorder,
                  style: BorderStyle.solid,
                  width: 0.2,
                ),
              ),
              prefixIcon: Icon(Icons.lock, color: ColorPalette.textFiledBorder),
              suffixIcon: IconButton(
                icon: Icon(
                  passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: ColorPalette.textFiledBorder,
                ),
                onPressed: onTaps,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                  style: BorderStyle.none,
                ),
              ),
              hintText: name,
              hintStyle: TextStyle(
                  color: ColorPalette.hintColor, fontWeight: FontWeight.w500),
            ),
            style: TextStyle(color: Colors.black54),
            autofocus: false,
          )
        ],
      );

  static alertError(context, pesan) => showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: pesan,
        ),
      );

  static alertInfo(context, pesan) => showTopSnackBar(
        context,
        CustomSnackBar.info(
          message: pesan,
        ),
      );

  static alertSuccess(context, pesan) => showTopSnackBar(
        context,
        CustomSnackBar.success(
          message: pesan,
        ),
      );

  static loadingBar() => Center(
        child: LoadingAnimationWidget.discreteCircle(
          color: Colors.green,
          size: 50,
        ),
      );

  static String capitalize(String value) {
    var result = value[0].toUpperCase();
    bool cap = true;
    for (int i = 1; i < value.length; i++) {
      if (value[i - 1] == " " && cap == true) {
        result = result + value[i].toUpperCase();
      } else {
        result = result + value[i];
        cap = false;
      }
    }
    return result;
  }

  static String capitalizeAllWord(String value) {
    var result = value[0].toUpperCase();
    for (int i = 1; i < value.length; i++) {
      if (value[i - 1] == " ") {
        result = result + value[i].toUpperCase();
      } else {
        result = result + value[i];
      }
    }
    return result;
  }

  static btnDefault(onTaps, name) => InkWell(
        onTap: onTaps,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            name,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          decoration: BoxDecoration(
            color: ColorPalette.underlineTextField,
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      );
}

Future<bool> checkConnection() async {
  bool result = await InternetConnectionChecker().hasConnection;
  return result;
}

Future<dynamic> getSession() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String userId = prefs.getString('userId') ?? '';
  bool login = prefs.getBool('login') ?? false;
  String token = prefs.getString('token') ?? '';
  dynamic result = {'userId': userId, 'token': token, 'login': login};
  return result;
}

Future<dynamic> setSession(userId, token, login) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('userId', userId);
  prefs.setBool('login', login);
  prefs.setString('token', token);
  dynamic result = {'userId': userId, 'token': token, 'login': login};
  return result;
}

Future<dynamic> setDataUser(data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('dataUser', jsonEncode(data).toString());
  dynamic result = {'data': data};
  return result;
}

Future<dynamic> getDataUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var data = prefs.getString('dataUser') ?? '';
  dynamic result = jsonDecode(data);
  return result;
}
