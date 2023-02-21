import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dlh/animasi/constant.dart';
import 'package:dlh/based/systems.dart';

class api {
  Future<dynamic> login(email, pass) async {
    late dynamic dataJson;
    try {
      final response = await Dio().post("${linknya.urlbase}/login",
          data: {'email': email, 'password': pass},
          options: Options(headers: {
            "Content-Type": "application/json",
          }));
      dataJson = response.data;
    } on DioError catch (e) {
      print(e);
      dataJson = e.response?.data;
    }
    return dataJson;
  }

  Future<dynamic> register(nama, email, nohp, pass) async {
    late dynamic dataJson;
    try {
      final response = await Dio().post("${linknya.urlbase}/register",
          data: {
            'name': nama,
            'email': email,
            'nohp': nohp,
            'password': pass,
            'c_password': pass,
          },
          options: Options(headers: {
            "Content-Type": "application/json",
          }));
      dataJson = response.data;
    } on DioError catch (e) {
      print(e);
      dataJson = e.response?.data;
    }
    return dataJson;
  }

  Future<dynamic> notifUser() async{
    late dynamic dataJson;
    try {
      var res = await getSession();
      var userId = res['userId'];
      final response = await Dio().get("${linknya.urlbase}/notifuser?userId="+ userId,
          options: Options(headers: {
            "Content-Type": "application/json",
          }));
      dataJson = response.data;
    } on DioError catch (e) {
      print(e);
      dataJson = e.response?.data;
    }
    return dataJson;
  }
}
