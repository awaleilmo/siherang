import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dlh/animasi/constant.dart';
import 'package:dlh/based/api.dart';
import 'package:dlh/based/systems.dart';
import 'package:dlh/main/akun.dart';
// import 'package:dlh/main/berita.dart';
// import 'package:dlh/main/contoh.dart';
// import 'package:dlh/main/galeri/galeri.dart';
// import 'package:dlh/main/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ASDF extends StatelessWidget {
  final int index;
  ASDF({required this.index});
  @override
  Widget build(BuildContext context) {
    //Navigator.pop(context, SlideLeftRoute(page: CatalogHome()));

    return Container(
      child: Center(
          child: !(index == 0)
              ? Text("sip ${index}")
              : InkWell(
                  child: TextButton(
                    onPressed: () {
                      setSession('', '', false);
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    child: Text('logout'),
                  ),
                  onTap: () {})),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _BottomNavPageState createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<HomePage> {
  int _selectedTabIndex = 0;
  late Timer timer;
  int menu1 = 1;
  int menu2 = 0;
  int menu3 = 0;
  int menu4 = 0;
  int menu5 = 0;
  int sppl = 0;
  int amdal = 0;
  int uklupl = 0;
  int pengaduan = 0;
  int foto = 0;
  int video = 0;
  int bank = 0;
  int datas = 0;
  int warta = 0;
  int pengumuman = 0;
  int berita = 0;
  int program = 0;
  int akun = 0;
  int beranda = 0;
  late int index;
  int galeri = 0;

  @override
  void initState() {
    super.initState();
    // timer = Timer.periodic(Duration(seconds: 1), (Timer t) => notf());
    notf();
  }

  void _onNavBarTapped(index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  Future<Null> notf() async {
    final response = await api().notifUser();
    var data = response['data'][0];

    setState(() {
      sppl = int.parse(data['sppl']);
      amdal = int.parse(data['amdal']);
      uklupl = int.parse(data['uklupl']);
      pengaduan = int.parse(data['pengaduan']);
      datas = int.parse(data['data']);
      beranda = sppl + amdal + uklupl + pengaduan + datas;
      warta = int.parse(data['warta']);
      pengumuman = int.parse(data['pengumuman']);
      berita = warta + pengumuman;
      bank = int.parse(data['banksampah']);
      program = bank;
      foto = int.parse(data['foto']);
      video = int.parse(data['video']);
      galeri = foto + video;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final _listPage = <Widget>[
      // Beranda(amnot : amdal, spnot : sppl, uknot : uklupl, pengnot : pengaduan, datas : datas),
      // GaleriPage(foto: foto, video: video,),
      // BeritaPage(wartas: warta, pengumuman: pengumuman,),
      // MyHomePage(bank: bank,),
      // AkunPage(id: '',)
      ASDF(index: 1),
      ASDF(index: 2),
      ASDF(index: 3),
      ASDF(index: 4),
      AkunPage()
    ];

    final PageStorageBucket bucket = PageStorageBucket();

    final _bottomNavBar = CurvedNavigationBar(
      backgroundColor: ColorPalette.underlineTextField,
      animationCurve: Curves.fastOutSlowIn,
      height: 60,
      index: _selectedTabIndex,
      items: <Widget>[
        Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            MaterialButton(
              onPressed: () {
                setState(() {
                  _selectedTabIndex = 0;
                  menu1 = 1;
                  menu2 = 0;
                  menu3 = 0;
                  menu4 = 0;
                  menu5 = 0;
                });
              },
              padding: EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.home,
                    size: menu1 == 1 ? 35 : 20,
                  ),
                  menu1 == 1
                      ? Padding(
                          padding: EdgeInsets.all(0),
                        )
                      : AutoSizeText(
                          "Beranda",
                          maxFontSize: 12,
                        )
                ],
              ),
            ),
            beranda <= 0
                ? Padding(
                    padding: EdgeInsets.all(0),
                  )
                : Container(
                    width: 20,
                    height: 20,
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(2),
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 0.1,
                            offset: Offset(1.0, 3.0),
                            blurRadius: 2)
                      ],
                      border: Border.all(color: Colors.red, width: 3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
          ],
        ),
        Stack(alignment: Alignment.topLeft, children: <Widget>[
          MaterialButton(
            onPressed: () {
              setState(() {
                _selectedTabIndex = 1;
                menu1 = 0;
                menu2 = 1;
                menu3 = 0;
                menu4 = 0;
                menu5 = 0;
              });
            },
            padding: EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.image,
                  size: menu2 == 1 ? 35 : 20,
                ),
                menu2 == 1
                    ? Padding(
                        padding: EdgeInsets.all(0),
                      )
                    : AutoSizeText(
                        "Galeri",
                        maxFontSize: 12,
                      )
              ],
            ),
          ),
          galeri <= 0
              ? Padding(
                  padding: EdgeInsets.all(0),
                )
              : Container(
                  width: 20,
                  height: 20,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(2),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 0.1,
                          offset: Offset(1.0, 3.0),
                          blurRadius: 2)
                    ],
                    border: Border.all(color: Colors.red, width: 3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
        ]),
        Stack(alignment: Alignment.topLeft, children: <Widget>[
          MaterialButton(
            onPressed: () {
              setState(() {
                _selectedTabIndex = 2;
                menu1 = 0;
                menu2 = 0;
                menu3 = 1;
                menu4 = 0;
                menu5 = 0;
              });
            },
            padding: EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.subtitles,
                  size: menu3 == 1 ? 35 : 20,
                ),
                menu3 == 1
                    ? Padding(
                        padding: EdgeInsets.all(0),
                      )
                    : AutoSizeText(
                        "Berita",
                        maxFontSize: 12,
                      )
              ],
            ),
          ),
          berita <= 0
              ? Padding(
                  padding: EdgeInsets.all(0),
                )
              : Container(
                  width: 20,
                  height: 20,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(2),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 0.1,
                          offset: Offset(1.0, 3.0),
                          blurRadius: 2)
                    ],
                    border: Border.all(color: Colors.red, width: 3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
        ]),
        Stack(alignment: Alignment.topLeft, children: <Widget>[
          MaterialButton(
            onPressed: () {
              setState(() {
                _selectedTabIndex = 3;
                menu1 = 0;
                menu2 = 0;
                menu3 = 0;
                menu4 = 1;
                menu5 = 0;
              });
            },
            padding: EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.dashboard,
                  size: menu4 == 1 ? 35 : 20,
                ),
                menu4 == 1
                    ? Padding(
                        padding: EdgeInsets.all(0),
                      )
                    : AutoSizeText(
                        "Program",
                        maxFontSize: 12,
                      )
              ],
            ),
          ),
          program <= 0
              ? Padding(
                  padding: EdgeInsets.all(0),
                )
              : Container(
                  width: 20,
                  height: 20,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(2),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 0.1,
                          offset: Offset(1.0, 3.0),
                          blurRadius: 2)
                    ],
                    border: Border.all(color: Colors.red, width: 3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
        ]),
        Stack(alignment: Alignment.topLeft, children: <Widget>[
          MaterialButton(
            onPressed: () {
              setState(() {
                _selectedTabIndex = 4;
                menu1 = 0;
                menu2 = 0;
                menu3 = 0;
                menu4 = 0;
                menu5 = 1;
              });
            },
            padding: EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.person,
                  size: menu5 == 1 ? 35 : 20,
                ),
                menu5 == 1
                    ? Padding(
                        padding: EdgeInsets.all(0),
                      )
                    : AutoSizeText(
                        "Akun",
                        maxFontSize: 12,
                      )
              ],
            ),
          ),
          akun <= 0
              ? Padding(
                  padding: EdgeInsets.all(0),
                )
              : Container(
                  width: 20,
                  height: 20,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(2),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 0.1,
                          offset: Offset(1.0, 3.0),
                          blurRadius: 2)
                    ],
                    border: Border.all(color: Colors.red, width: 3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
        ]),
      ],
      onTap: _onNavBarTapped,
    );

    return WillPopScope(
        child: Scaffold(
          body: Center(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  child: PageStorage(
                    child: _listPage[_selectedTabIndex],
                    bucket: bucket,
                  ),
                ),
                Container(
                  height: 13,
                  decoration: BoxDecoration(
                      color: ColorPalette.underlineTextField,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7),
                          topRight: Radius.circular(7))),
                )
              ],
            ),
          ),
          bottomNavigationBar: _bottomNavBar,
        ),
        onWillPop: () async {
          bool keluar = false;
          await showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: Text("Anda akan keluar"),
                    content: Text("Anda yakin untuk keluar?"),
                    actions: <Widget>[
                      new MaterialButton(
                        child: new Text("Ya",
                            style: TextStyle(color: Colors.black38)),
                        onPressed: () => exit(0),
                      ),
                      new MaterialButton(
                        child: new Text("Tidak"),
                        onPressed: () {
                          Navigator.pop(context);
                          keluar = false;
                        },
                      ),
                    ],
                  ));
          return keluar;
        });
  }
}
