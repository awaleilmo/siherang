import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dlh/animasi/constant.dart';
import 'package:dlh/main/akun.dart';
import 'package:dlh/main/berita.dart';
import 'package:dlh/main/contoh.dart';
import 'package:dlh/main/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_container/responsive_container.dart';

class ASDF extends StatelessWidget {
  final int index;
  ASDF({this.index});
  @override
  Widget build(BuildContext context) {
    //Navigator.pop(context, SlideLeftRoute(page: CatalogHome()));

    return Container(
      child: Center(
          child: !(index == 0) ? Text("sip ${index}")
              :     InkWell(
              child: Text('logout'),
              onTap: () {

              }
          )
      ),);
  }
}

class HomePage extends StatefulWidget{
  @override
  _BottomNavPageState createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<HomePage>{
  int _selectedTabIndex = 0;
  int menu1 = 1;
  int menu2 = 0;
  int menu3 = 0;
  int menu4 = 0;

  void _onNavBarTapped(int index){
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context){

    final _listPage = <Widget>[
      Beranda(),
      BeritaPage(),
      MyHomePage(),
      AkunPage()
    ];


    final PageStorageBucket bucket = PageStorageBucket();

    final _bottomNavBar = CurvedNavigationBar(
      backgroundColor: ColorPalette.underlineTextField,
      animationCurve: Curves.fastOutSlowIn,
      height: 60,
      index: _selectedTabIndex,
      items: <Widget>[
        FlatButton(
          onPressed:  (){
            setState(() {
              _selectedTabIndex = 0;
              menu1 = 1;
              menu2 = 0;
              menu3 = 0;
              menu4 = 0;
            });
          },
          padding: EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.home,size: menu1 == 1 ? 35:20,),
              menu1 == 1 ? Padding(padding: EdgeInsets.all(0),):AutoSizeText("Beranda",maxFontSize: 12,)
            ],
          ),
        ),
        FlatButton(
          onPressed:  (){
            setState(() {
              _selectedTabIndex = 1;
              menu1 = 0;
              menu2 = 1;
              menu3 = 0;
              menu4 = 0;
            });
          },
          padding: EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.subtitles,size: menu2 == 1 ? 35:20,),
              menu2== 1 ? Padding(padding: EdgeInsets.all(0),):AutoSizeText("Berita",maxFontSize: 12,)
            ],
          ),
        ),
        FlatButton(
          onPressed:  (){
            setState(() {
              _selectedTabIndex = 2;
              menu1 = 0;
              menu2 = 0;
              menu3 = 1;
              menu4 = 0;
            });
          },
          padding: EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.dashboard,size: menu3 == 1 ? 35:20,),
              menu3 == 1 ? Padding(padding: EdgeInsets.all(0),):AutoSizeText("Program",maxFontSize: 12,)
            ],
          ),
        ),
        FlatButton(
          onPressed:  (){
            setState(() {
              _selectedTabIndex = 3;
              menu1 = 0;
              menu2 = 0;
              menu3 = 0;
              menu4 = 1;
            });
          },
          padding: EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.person,size: menu4 == 1 ? 35:20,),
              menu4 == 1 ? Padding(padding: EdgeInsets.all(0),):AutoSizeText("Akun",maxFontSize: 12,)
            ],
          ),
        ),
      ],
      onTap: _onNavBarTapped,
    );

    return WillPopScope(child: Scaffold(

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
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(7), topRight: Radius.circular(7))
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: _bottomNavBar,
    ),onWillPop: () async {
      bool keluar = false;
      await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Anda akan keluar"),
            content: Text("Anda yakin untuk keluar?"),
            actions: <Widget>[
              new FlatButton(
                child: new Text(
                    "Ya",
                    style: TextStyle(
                        color: Colors.black38
                    )
                ),
                onPressed: ()=> exit(0),
              ),
              new FlatButton(
                child: new Text("Tidak"),
                onPressed: () {
                  Navigator.pop(context);
                  keluar = false;
                },
              ),

            ],
          )
      );
      return keluar;
    });
  }
}