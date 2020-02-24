import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dlh/animasi/animasi.dart';
import 'package:dlh/animasi/constant.dart';
import 'package:dlh/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_container/responsive_container.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AkunPage extends StatefulWidget{
  final String id;
  AkunPage({this.id});
  @override
  _AkunPage createState() => _AkunPage();
}

class _AkunPage extends State<AkunPage>{
  String nama='';
  String email='';
  String nohp='';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    datamenu();
  }

  @override
  Future<void> datamenu() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString('id');
      String userToken = prefs.getString('token');
      final response = await http.get(
          linknya.urlbase + "app/finduser?id=" + userId);
      var jsson = jsonDecode(response.body);
      var data = jsson['data'];
      print(data['name']);
      setState(() {
        isLoading = false;
        nama = data['name'].toString();
        email = data['email'].toString();
        nohp = data['nohp'].toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:isLoading == true ? _buildProgressIndicator(): RefreshIndicator(
        child: ResponsiveContainer(
          heightPercent: 100,
          widthPercent: 100,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top:0),
                  ),
                  _top(),
                  Padding( padding: EdgeInsets.only(top: 10),),
                  _center()
                ],
              )
            ],
          ),
        ),
        onRefresh: datamenu,
      ),
    );
  }

  Widget _top(){
    return ResponsiveContainer(
      widthPercent: 95,
      heightPercent: 30,
      child: Container(
        padding: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90), topRight: Radius.circular(90)),
          color: ColorPalette.underlineTextField,
        ),
        alignment: Alignment.center,
        child: ResponsiveContainer(
          heightPercent: 22,
          widthPercent: 45,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
                  color: Colors.white,
                  image: DecorationImage(
                    image:  AssetImage('asset/siherang.png'),
                  ),
            ),
            //child: Image(image: AssetImage('asset/s1.png'), ),
          ),
        ),
      ),
    );
  }

  _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _center(){
    return ResponsiveContainer(
    heightPercent: 100,
    widthPercent: 95,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: ColorPalette.underlineTextField, width: 4.0),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: ColorPalette.underlineTextField
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 20),),
          Text("My Account", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
            Padding(padding: EdgeInsets.only(top: 20),),
          ResponsiveContainer(
            heightPercent: 30,
            widthPercent: 90,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 10),),
                      Text("Nama", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
                      Padding(padding: EdgeInsets.only(left: 55),),
                      ResponsiveContainer(widthPercent: 45, heightPercent: 3,
                        child: AutoSizeText(nama  ,style: TextStyle(color: Colors.black, fontSize: 15), maxLines: 3,),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 10,top:50),),
                      Text("Email", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
                      Padding(padding: EdgeInsets.only(left: 60),),
                      ResponsiveContainer(widthPercent: 45, heightPercent: 5,
                          child: AutoSizeText(email,style: TextStyle(color: Colors.black, fontSize: 15), maxLines: 3,),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 10),),
                      Text("No HP", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
                      Padding(padding: EdgeInsets.only(left: 50),),
                      Text(nohp, style: TextStyle(color: Colors.black, fontSize: 15),),

                    ],
                  ),


                ],
              ),
            ),
          ),
            Padding(padding: EdgeInsets.only(top: 20),),
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                InkWell(
                  onTap:  () async {
                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString('id', null);
                    prefs.setString('token', null);
                    Navigator.pushReplacement(context, SlideRightRoute(page: Utama()));
                  },
                  child: ResponsiveContainer(
                    widthPercent: 50,
                    heightPercent: 8,
                    child: Container(
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        "Logout",
                        minFontSize: 12,
                        style: TextStyle(color: Colors.white, fontSize: 18,),
                        textAlign: TextAlign.center,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2.0),
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  )

                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}