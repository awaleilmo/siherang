import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dlh/animasi/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:responsive_container/responsive_container.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';


class ArtikelPage extends StatefulWidget{
  final int id ;
  final int tipe;
  final String judul ;

  ArtikelPage({this.id, this.judul, this.tipe});
  @override
    _ArtikelPage createState() => _ArtikelPage();
  }
class _ArtikelPage extends State<ArtikelPage>{
  var nom;
  bool isLoading = false;
  List kintal;
  String Foto='';
  String Judul='';
  String Desk='';
  String wak ='';

  @override
  void initState(){
    super.initState();
    berita();
  }

  @override
  Future<void> berita() async {
    if (!isLoading) {
        setState(() {
          isLoading = true;
        });
      final response = await http.get(
          widget.tipe == 1 ? linknya.urlbase + "app/findartikel?id=" +
              widget.id.toString() : linknya.urlbase + "app/findpengumuman?id=" +
              widget.id.toString());
      var jsson = jsonDecode(response.body);
      var data = jsson['data'][0];
      setState(() {
        isLoading = false;
        Foto = data['foto'].toString();
        Judul = data['judul'];
        Desk = data['deskripsi'];
        nom = parse(Desk);
        var now = DateTime.parse(data['tanggal']);
        var format = DateFormat('dd - MMMM - yyyy');
        String has = format.format(now);
        wak = has;
      });
      print('berhasil');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed:() {Navigator.pop(context);},
        ),
        iconTheme: IconThemeData(color: ColorPalette.underlineTextField),
        title: ResponsiveContainer(widthPercent: 60,heightPercent: 4.5, child: AutoSizeText(widget.judul, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22), textAlign: TextAlign.center,),),
        backgroundColor: ColorPalette.underlineTextField,
      ),
      body:isLoading == true?_buildProgressIndicator(): RefreshIndicator(
        child: ResponsiveContainer(
            widthPercent: 100,
            heightPercent: 100,
            alignment: Alignment.center,
            margin: EdgeInsets.all(5),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[

                    ResponsiveContainer(
                      widthPercent: 100,
                      heightPercent: 30,
                      child: _foto(),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20),),
                    _judul(),
                    _icon(),
                    _padding(),
                    _desk()
              ],
            )
        ),
        onRefresh: berita,
        color: Colors.transparent,
      )
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

  _foto(){
    return widget.tipe == 1 ? FadeInImage.assetNetwork(
      image:'http://dlh-serangkota.com/upload/artikel/'+ Foto.toString(),
      placeholder: 'asset/img/loading.gif',
      fit: BoxFit.cover,
    ) : FadeInImage.assetNetwork(
    image:'http://dlh-serangkota.com/upload/pengumuman/'+ Foto.toString(),
    fit: BoxFit.cover,
    placeholder: 'asset/img/loading.gif',
    );
  }

  _judul(){
    return AutoSizeText(
      Judul.toString(),style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
  _padding(){
    return Padding(padding: EdgeInsets.only(top: 15),);
  }
 _icon(){
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: Row(
        children: <Widget>[
          Icon(Icons.person_pin),
          AutoSizeText('Admin DLH Kota Serang', style: TextStyle(fontSize: 11),),
          Padding(padding: EdgeInsets.only(left: 10, right: 10),),
          Icon(Icons.access_time),
          AutoSizeText(wak , style: TextStyle(fontSize: 11) )
        ],
      ),
    );
 }

 _desk(){
    return HtmlWidget(
      Desk,
      webView: true,
    );
 }

}