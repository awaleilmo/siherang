import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dlh/animasi/animasi.dart';
import 'package:dlh/animasi/constant.dart';
import 'package:dlh/main/akun.dart';
import 'package:dlh/main/berita.dart';
import 'package:dlh/main/Link.dart';
import 'package:dlh/main/contoh.dart';
import 'package:dlh/main/dokling/amdal.dart';
import 'package:dlh/main/dokling/sppl.dart';
import 'package:dlh/main/dokling/ukl.dart';
import 'package:dlh/main/informasi_data/infodata.dart';
import 'package:dlh/main/pengaduan/pengaduan.dart';
import 'package:dlh/main/pengaduan/showpeng.dart';
import 'package:dlh/main/sipal/sipal.dart';
import 'package:dlh/main/tentangkami/tabmenutk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_container/responsive_container.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'artikelpage.dart';
class Beranda extends StatefulWidget{
    final int amnot;
    final int spnot;
    final int uknot;
    final int pengnot;
    final int datas;
    Beranda({this.amnot, this.spnot, this.uknot, this.pengnot, this.datas});
    _Beranda createState() => _Beranda();
}

class _Beranda extends State<Beranda>{
  Timer timer;
  bool loading=false;
  String Judul = '';
  String nmmenu ='';
  String img = '';
  int notif = 0;
  List total = new List();
  List fikasi = new List();
  int sppl = 0;
  int amdal = 0;
  int uklupl = 0;
  int datas = 0;
  int pengaduan = 0;
  var ikon;
  var tujuan;

  @override
  void initState() {
    super.initState();
     //timer = Timer.periodic(Duration(seconds: 1), (Timer t) => notf());
    kaon();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) =>
    setState(() {
      sppl = widget.spnot;
      amdal = widget.amnot;
      uklupl = widget.uknot;
      pengaduan = widget.pengnot;
      datas = widget.datas;
    }));

  }

  @override
  void dispose() {
    dispose();

    kaon();

    //notf();

  }

  @override
  Future<void> kaon() async {
      setState(() {
        loading=true;
      });
      final response = await http.get(linknya.urlbase + "app/artikel?page=1" );
      var jsson = jsonDecode(response.body);
      var data = jsson['data']['data'];
      print('home');
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
        title: ResponsiveContainer(widthPercent: 60,heightPercent: 4.5, child: Text('Beranda', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22), textAlign: TextAlign.center,),),
        backgroundColor: ColorPalette.underlineTextField,
      ),
      body:loading == true ? _buildProgressIndicator(): RefreshIndicator(
        child:  ResponsiveContainer(
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
      padding: EdgeInsets.only(top: 20),
    );
  }

  _tentang(){
    return ResponsiveContainer(
      widthPercent: 100,
      heightPercent: 100,
      padding: EdgeInsets.only(top:20,left: 20,right: 20),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: ()async{
                  Navigator.push(context, SlideRightRoute(page: MenuTk()));
                },
                padding: EdgeInsets.all(0),
                child: _menu(img= 'asset/icon/tentangkami.png',nmmenu='Tentang Kami',notif=0),
              ),
              FlatButton(
                onPressed: ()async{
                  Navigator.push(context, SlideRightRoute(page: LinkPage(ur: 'https://dlh-serangkota.com/mobile/cilowong', tit: 'Cilowong',)));
                },
                padding: EdgeInsets.all(0),
                child: _menu(img= 'asset/icon/cilowong.png',nmmenu='TPAS Cilowong',notif=0),
              ),
              FlatButton(
                onPressed: ()async{
                  Navigator.push(context, SlideRightRoute(page: InfoData()));
                },
                padding: EdgeInsets.all(0),
                child: _menu(img= 'asset/icon/informasidata.png',nmmenu='Informasi Data',notif=datas),
              )
            ],
          ),
          _padding(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: ()async{
                  Navigator.push(context, SlideRightRoute(page: SpplPage(ur: 'https://dlh-serangkota.com/mobile/sppl', tit: 'SPPL')));
                },
                padding: EdgeInsets.all(0),
                child: _menu(img= 'asset/icon/sppl.png',nmmenu='SPPL',notif= sppl),
              ),
              FlatButton(
                onPressed: ()async{
                  Navigator.push(context, SlideRightRoute(page: uklPage(ur: 'https://dlh-serangkota.com/mobile/uklupl', tit: 'UKL UPL',)));
                },
                padding: EdgeInsets.all(0),
                child: _menu(img= 'asset/icon/uklupl.png',nmmenu='UKL UPL',notif=uklupl),
              ),
              FlatButton(
                onPressed: ()async{
                  Navigator.push(context, SlideRightRoute(page: amdalPage(ur: 'https://dlh-serangkota.com/mobile/amdal', tit: 'AMDAL',)));
                },
                padding: EdgeInsets.all(0),
                child: _menu(img= 'asset/icon/amdal.png',nmmenu='AMDAL',notif=amdal),
              )
            ],
          ),
          _padding(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: ()async{
                  Navigator.push(context, SlideRightRoute(page: PengPage()));
                },
                padding: EdgeInsets.all(0),
                child: _menu(img= 'asset/icon/pengaduan.png',nmmenu='Pengaduan',notif=pengaduan),
              ),
              FlatButton(
                onPressed: ()async{
                  Navigator.push(context, SlideRightRoute(page: sipalPage()));
                },
                padding: EdgeInsets.all(0),
                child: _menu(img= 'asset/icon/sipal.png',nmmenu='Limbah',notif=0),
              ),
              FlatButton(
                onPressed: ()async{
                  Navigator.push(context, SlideRightRoute(page: LinkPage(ur: 'https://dlh-serangkota.com/mobile/uptlab', tit: 'UPTD Laboratorium',)));
                },
                padding: EdgeInsets.all(0),
                child: _menu(img= 'asset/icon/uptlab.png',nmmenu='UPTD Laboratorium',notif=0),
              ),
            ],
          ),
          _padding(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: ()async{
                  Navigator.push(context, SlideRightRoute(page: LinkPage(ur: 'https://dlh-serangkota.com/mobile/uptperbekalan', tit: 'UPTD Perlengkapan',)));
                },
                padding: EdgeInsets.all(0),
                child: _menu(img= 'asset/icon/perlengkapan.png',nmmenu='UPTD Perlengkapan',notif=0),
              ),
              FlatButton(
                onPressed: ()async{
                  Navigator.push(context, SlideRightRoute(page: LinkPage(ur: 'https://dlh-serangkota.com/mobile/pplh', tit: 'Bidang Penataan',)));
                },
                padding: EdgeInsets.all(0),
                child: _menu(img= 'asset/icon/bidpenataan.png',nmmenu='Bidang Penataan',notif=0),
              ),
              FlatButton(
                onPressed: ()async{
                  Navigator.push(context, SlideRightRoute(page: LinkPage(ur: 'https://dlh-serangkota.com/mobile/pslb', tit: 'Bidang Pengelolaan',)));
                },
                padding: EdgeInsets.all(0),
                child: _menu(img= 'asset/icon/bidpengelolaan.png',nmmenu='Bidang Pengelolaan',notif=0),
              ),
            ],
          ),
          _padding(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: ()async{
                  Navigator.push(context, SlideRightRoute(page: LinkPage(ur: 'https://dlh-serangkota.com/mobile/ppklh', tit: 'Bidang Pengendalian',)));
                },
                padding: EdgeInsets.all(0),
                child: _menu(img= 'asset/icon/bidpengendalian.png',nmmenu='Bidang Pengendalian',notif=0),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _menu(String img,String s, int not){
    return ResponsiveContainer(
      widthPercent: 29,
      heightPercent: 15,
      padding: EdgeInsets.only(left: 5,right: 5),
      child: Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(2),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow:[ BoxShadow(color: Colors.grey, spreadRadius: 0.5,offset: Offset(3.0,4.0), blurRadius: 5)],
              border: Border.all(color: ColorPalette.underlineTextField, width: 3),
              borderRadius: BorderRadius.circular(10),
            ),
            child:Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
//            Icon(ikon, color: ColorPalette.underlineTextField, size: 50,),
              Image.asset(
                img,
                fit: BoxFit.cover,
                scale: 9.0,
              ),
              Padding(
                padding: EdgeInsets.only(top:5),
              ),
              AutoSizeText(nmmenu,maxFontSize:12, minFontSize: 11,style: TextStyle(color: ColorPalette.underlineTextField, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),

            ],
            ),
          ),
          not == 0 ? Padding(padding: EdgeInsets.all(0),) : Container(
            width: 20,
            height: 20,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(2),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              color: Colors.red,
              boxShadow:[ BoxShadow(color: Colors.grey, spreadRadius: 0.1,offset: Offset(1.0,3.0), blurRadius: 2)],
              border: Border.all(color: Colors.red, width: 3),
              borderRadius: BorderRadius.circular(10),
            ),

          ),
        ],
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
                  judul: Judul = 'Pojok Warta LH',
                  tipe: 1)));
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
                              image: NetworkImage('http://dlh-serangkota.com/upload/artikel/' +
                                  total[itemIndex]['foto']),
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