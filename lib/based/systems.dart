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
  static inputText(control, String name, icons) => TextFormField(
        controller: control,
        decoration: new InputDecoration(
          border: UnderlineInputBorder(),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: ColorPalette.underlineTextField,
              width: 1.5,
            ),
          ),
          prefixIcon: Icon(icons ?? Icons.text_fields,
              color: ColorPalette.underlineTextField),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: ColorPalette.underlineTextField,
              width: 2.5,
            ),
          ),
          hintText: name,
          hintStyle: TextStyle(color: ColorPalette.hintColor),
        ),
        style: TextStyle(color: Colors.black54),
        autofocus: false,
      );

  static inputNumber(control, String name, icons) => TextFormField(
        controller: control,
        keyboardType: TextInputType.number,
        decoration: new InputDecoration(
          border: UnderlineInputBorder(),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: ColorPalette.underlineTextField,
              width: 1.5,
            ),
          ),
          prefixIcon: Icon(icons ?? Icons.text_fields,
              color: ColorPalette.underlineTextField),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: ColorPalette.underlineTextField,
              width: 2.5,
            ),
          ),
          hintText: name,
          hintStyle: TextStyle(color: ColorPalette.hintColor),
        ),
        style: TextStyle(color: Colors.black54),
        autofocus: false,
      );

  static inputPassword(control, String name, bool passwordVisible, onTaps) => TextFormField(
    controller: control,
    obscureText: !passwordVisible,
    decoration: new InputDecoration(
      border: UnderlineInputBorder(),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: ColorPalette.underlineTextField,
          width: 1.5,
        ),
      ),
      prefixIcon:
      Icon(Icons.lock, color: ColorPalette.underlineTextField),
      suffixIcon: IconButton(
        icon: Icon(
          passwordVisible ? Icons.visibility : Icons.visibility_off,
          color: ColorPalette.underlineTextField,
        ),
        onPressed: onTaps,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: ColorPalette.underlineTextField,
          width: 2.5,
        ),
      ),
      hintText: name,
      hintStyle: TextStyle(color: ColorPalette.hintColor),
    ),
    style: TextStyle(color: Colors.black54),
    autofocus: false,
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
        child: LoadingAnimationWidget.inkDrop(
          color: Colors.green,
          size: 50,
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
