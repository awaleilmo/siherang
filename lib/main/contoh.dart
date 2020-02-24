import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dlh/animasi/animasi.dart';
import 'package:dlh/animasi/constant.dart';
import 'package:dlh/main/akun.dart';
import 'package:dlh/main/berita.dart';
import 'package:dlh/main/Link.dart';
import 'package:dlh/main/contoh.dart';
import 'package:dlh/main/informasi_data/infodata.dart';
import 'package:dlh/main/tentangkami/tabmenutk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_container/responsive_container.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;

import 'artikelpage.dart';
class MyHomePage extends StatefulWidget{
  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage>{
  bool loading=false;
  String Judul = '';
  String nmmenu ='';
  String img = '' ;
  List total = new List();
  var ikon;
  var tujuan;
  @override
  void initState() {
    super.initState();
    kaon();
  }

  @override
  Future<void> kaon() async {
    setState(() {
      loading=true;
    });
    final response = await http.get(linknya.urlbase + "app/pengumuman?page=1" );
    var jsson = jsonDecode(response.body);
    var data = jsson['data']['data'];
    print('program');
    setState(() {
      loading = false;
      total.addAll(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: Padding(padding: EdgeInsets.only(left: 0),),
        iconTheme: IconThemeData(color: ColorPalette.underlineTextField),
        title: ResponsiveContainer(widthPercent: 60,heightPercent: 4.5, child: Text('Program', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22), textAlign: TextAlign.center,),),
        backgroundColor: ColorPalette.underlineTextField,
      ),
      body:loading == true ? _buildProgressIndicator():  RefreshIndicator(
        child: ResponsiveContainer(
          widthPercent: 100,
          heightPercent: 100,
          child: ListView(
            children: <Widget>[
              _body()
            ],
          ),
        ),
        onRefresh: kaon,
      ),
    );


  }

  _body(){
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 10),),
        _slider(),
        _tentang()
      ],
    );
  }

  _padding(){
    return Padding(
      padding: EdgeInsets.only(top: 25),
    );
  }

  _tentang(){
    return ResponsiveContainer(
      widthPercent: 100,
      heightPercent: 50,
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: ()async{
                  Navigator.push(context, SlideRightRoute(page: LinkPage(ur: linknya.url + 'mobile/adwiyata', tit: 'Adiwiyata',)));
                },
                padding: EdgeInsets.all(0),
                child: _menu(img="asset/icon/adiwiyata.png",nmmenu='Adiwiyata'),
              ),
              FlatButton(
                onPressed: ()async{
                  Navigator.push(context, SlideRightRoute(page: LinkPage(ur: linknya.url + 'mobile/banksampah', tit: 'Bank Sampah',)));
                },
                padding: EdgeInsets.all(0),
                child: _menu(img="asset/icon/banksampah.png",nmmenu='Bank Sampah'),
              ),
              FlatButton(
                onPressed: ()async{
                  Navigator.push(context, SlideRightRoute(page: LinkPage(ur: linknya.url + 'mobile/pengawasan', tit: 'Pengawasan',)));
                },
                padding: EdgeInsets.all(0),
                child: _menu(img="asset/icon/pengawasan.png",nmmenu='Pengawasan'),
              )
            ],
          ),
          _padding(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: ()async{
                  Navigator.push(context, SlideRightRoute(page: LinkPage(ur: linknya.url + 'mobile/persampahan', tit: 'Persampahan',)));
                },
                padding: EdgeInsets.all(0),
                child: _menu(img="asset/icon/persampahan.png",nmmenu='Persampahan'),
              ),
              FlatButton(
                onPressed: ()async{
                  Navigator.push(context, SlideRightRoute(page: LinkPage(ur: linknya.url + 'mobile/tps3r', tit: 'TPS3R',)));
                },
                padding: EdgeInsets.all(0),
                child: _menu(img="asset/icon/tps3r.png",nmmenu='TPS 3R'),
              ),

            ],
          ),
          _padding(),

        ],
      ),
    );
  }

  _menu(String img, String s){
    return ResponsiveContainer(
      widthPercent: 29,
      heightPercent: 15,
      padding: EdgeInsets.all(3),
      child: Container(
        padding: EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow:[ BoxShadow(color: Colors.grey, spreadRadius: 0.5,offset: Offset(3.0,4.0), blurRadius: 5)],
          border: Border.all(color: ColorPalette.underlineTextField, width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
        child:Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Image.asset(
            img,
            fit: BoxFit.cover,
            scale: 9.0,
          ),
          Padding(
            padding: EdgeInsets.only(top:5),
          ),
          Text(nmmenu,style: TextStyle(color: ColorPalette.underlineTextField, fontSize: 12, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
        ],
        ),
      ),
    );
  }
  _slider(){
    return CarouselSlider.builder(
      itemCount: 4,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 3),
      autoPlayAnimationDuration: Duration(milliseconds: 800),
      aspectRatio: 16/9,
      viewportFraction: 0.8,
      enlargeCenterPage: true,
      itemBuilder: (BuildContext context, int itemIndex) =>
          InkWell(
            onTap: () {
              Navigator.push(context, SlideRightRoute(page: ArtikelPage(
                  id: total[itemIndex]['id'],
                  judul: Judul = 'Pengumuman',
                  tipe: 0)));
              print('ok');
            },
            child: ResponsiveContainer(
                widthPercent: 78,
                heightPercent: 5,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: ColorPalette.underlineTextField,
                          border: Border.all(color: ColorPalette.underlineTextField, width: 3),
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage('http://dlh-serangkota.com/upload/pengumuman'
                                  '/' + total[itemIndex]['foto']),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                          color: ColorPalette.underlineTextField
                      ),
                      child: AutoSizeText(total[itemIndex]['judul'], textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                    )
                  ],
                )
            ),
          ),
    );
  }
  _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: loading == true ? 1.0:0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

}