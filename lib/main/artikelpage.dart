import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dlh/animasi/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

class ArtikelPage extends StatefulWidget {
  final int id;

  final int tipe;
  final String judul;

  ArtikelPage({required this.id, required this.judul, required this.tipe});

  @override
  _ArtikelPage createState() => _ArtikelPage();
}

class _ArtikelPage extends State<ArtikelPage> {
  var nom;
  bool isLoading = false;
  late List kintal;
  String Foto = '';
  String Judul = '';
  String Desk = '';
  String wak = '';

  @override
  void initState() {
    super.initState();
    berita();
  }

  @override
  Future<void> berita() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      var url = widget.tipe == 1
          ? Uri.https(
              linknya.urlbase, "app/findartikel?id=" + widget.id.toString())
          : Uri.https(linknya.urlbase +
              "app/findpengumuman?id=" +
              widget.id.toString());
      final response = await http.get(url);
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
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          iconTheme: IconThemeData(color: ColorPalette.underlineTextField),
          title: Container(
            width: MediaQuery.of(context).size.width * 0.60,
            height: MediaQuery.of(context).size.height * 0.045,
            child: AutoSizeText(
              widget.judul,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              textAlign: TextAlign.center,
            ),
          ),
          backgroundColor: ColorPalette.underlineTextField,
        ),
        body: isLoading == true
            ? _buildProgressIndicator()
            : RefreshIndicator(
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.100,
                    height: MediaQuery.of(context).size.height * 0.100,
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(5),
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.100,
                          height: MediaQuery.of(context).size.height * 0.30,
                          child: _foto(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                        ),
                        _judul(),
                        _icon(),
                        _padding(),
                        _desk()
                      ],
                    )),
                onRefresh: berita,
                color: Colors.transparent,
              ));
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

  _foto() {
    return widget.tipe == 1
        ? FadeInImage.assetNetwork(
            image: '${linknya.url}upload/artikel/' + Foto.toString(),
            placeholder: 'asset/img/loading.gif',
            fit: BoxFit.cover,
          )
        : FadeInImage.assetNetwork(
            image: '${linknya.url}upload/pengumuman/' + Foto.toString(),
            fit: BoxFit.cover,
            placeholder: 'asset/img/loading.gif',
          );
  }

  _judul() {
    return AutoSizeText(
      Judul.toString(),
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  _padding() {
    return Padding(
      padding: EdgeInsets.only(top: 15),
    );
  }

  _icon() {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: Row(
        children: <Widget>[
          Icon(Icons.person_pin),
          AutoSizeText(
            'Admin DLH Kota Serang',
            style: TextStyle(fontSize: 11),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
          ),
          Icon(Icons.access_time),
          AutoSizeText(wak, style: TextStyle(fontSize: 11))
        ],
      ),
    );
  }

  _desk() {
    return Html(
      data: Desk,
    );
  }
}
