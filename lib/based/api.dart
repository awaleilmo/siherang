import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dlh/animasi/constant.dart';
import 'package:dlh/based/systems.dart';

class api {
  late Dio dio;

  api(){
      BaseOptions options = new BaseOptions(
        baseUrl: linknya.urlbase,
          receiveDataWhenStatusError: true,
          connectTimeout: Duration(seconds: 10), // 30 seconds
          receiveTimeout: Duration(seconds: 30) // 30 seconds
      );

      dio = new Dio(options);
  }

  Future<dynamic> login(email, pass) async {
    late dynamic dataJson;
    try {
      final response = await dio.post("/login",
          data: {'email': email, 'password': pass},
          options: Options(headers: {
            "Content-Type": "application/json",
          }));
      dataJson = response.data;
    } on DioError catch (e) {
      dataJson = e;
    }
    return dataJson;
  }

  Future<dynamic> register(nama, email, nohp, pass) async {
    late dynamic dataJson;
    try {
      final response = await dio.post("/register",
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
      dataJson = e;
    }
    return dataJson;
  }

  Future<dynamic> notifUser() async {
    late dynamic dataJson;
    try {
      var res = await getSession();
      var userId = res['userId'];
      final response =
          await dio.get("/notifuser?userId=" + userId,
              options: Options(headers: {
                "Content-Type": "application/json",
              }));
      dataJson = response.data;
    } on DioError catch (e) {
      dataJson = e;
    }
    return dataJson;
  }

  Future<dynamic> findUser() async {
    late dynamic dataJson;
    try {
      var res = await getSession();
      var userId = res['userId'];
      final response =
          await dio.get("/finduser?id=" + userId,
              options: Options(headers: {
                "Content-Type": "application/json",
              }));
      dataJson = response.data;
    } on DioError catch (e) {
      dataJson = e;
    }
    return dataJson;
  }
}
