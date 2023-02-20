import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dlh/animasi/animasi.dart';
import 'package:dlh/animasi/constant.dart';
import 'package:dlh/main/artikelpage.dart';
import 'package:dlh/main/galeri/video.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GaleriPage extends StatefulWidget {
  final int foto;
  final int video;

  GaleriPage({required this.foto, required this.video});

  @override
  _GaleriPage createState() => _GaleriPage();
}

class _GaleriPage extends State<GaleriPage>
    with SingleTickerProviderStateMixin {
  int _counter = 1;
  late Timer timer;
  int _counterpe = 1;
  List total = [];
  List Peng = [];
  int wartas = 0;
  int pengumuman = 0;

  String Judul = '';
  ScrollController _scrollController = new ScrollController();
  ScrollController _scroll2Controller = new ScrollController();
  bool _loadingMore = false;
  late TabController knt;

  @override
  Future<void> _incrementCounter() async {
    setState(() {
      _counter++;
      _loadingMore = true;
    });
    var url = Uri.https(linknya.urlbase , "app/foto?page=" + _counter.toString());
    final response = await http
        .get(url);
    var jsson = jsonDecode(response.body);
    var data = jsson['data']['data'];
    setState(() {
      _loadingMore = false;
      Peng.addAll(data);
    });
  }

  @override
  Future<void> _incrementpe() async {
    setState(() {
      _counterpe++;
      _loadingMore = true;
    });
    var url =Uri.https(linknya.urlbase , "app/video?page=" + _counterpe.toString());
    final response = await http
        .get(url);
    var jsson = jsonDecode(response.body);
    var data = jsson['data']['data'];

    setState(() {
      _loadingMore = false;
      total.addAll(data);
    });
  }

  @override
  Future<void> warta() async {
    if (!_loadingMore) {
      setState(() {
        _loadingMore = true;
      });
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString('id') ?? '';
      var url1 = Uri.https(linknya.urlbase , "app/foto?page=" + _counter.toString());
      final response = await http
          .get(url1);
      var jsson = jsonDecode(response.body);
      var data = jsson['data']['data'];
      var url2 = Uri.https(linknya.urlbase , "app/video?page=" + _counterpe.toString());
      final response1 = await http
          .get(url2);
      var jsson1 = jsonDecode(response1.body);
      var data1 = jsson1['data']['data'];

      setState(() {
        _loadingMore = false;
        Peng.addAll(data);
        total.addAll(data1);
      });
    }
  }

  @override
  Future<Null> _refreshberita() async {
    if (!_loadingMore) {
      setState(() {
        _loadingMore = true;
        _counter = 1;
      });
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString('id') ?? '';
      String userToken = prefs.getString('token') ?? '';
      var url = Uri.https(linknya.urlbase , "app/foto?page=" + _counter.toString());
      final response = await http
          .get(url);
      var jsson = jsonDecode(response.body);
      var data = jsson['data']['data'];
      print(_counter);
      setState(() {
        _loadingMore = false;
        Peng = data;
      });
    }
  }

  @override
  Future<Null> _refreshpengumuman() async {
    if (!_loadingMore) {
      setState(() {
        _loadingMore = true;
        _counterpe = 1;
      });
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString('id') ?? '';
      String userToken = prefs.getString('token') ?? '';
      var url = Uri.https(linknya.urlbase , "app/video?page=" + _counterpe.toString());
      final response1 = await http
          .get(url);
      var jsson1 = jsonDecode(response1.body);
      var data1 = jsson1['data']['data'];
      print(_counter);
      setState(() {
        _loadingMore = false;
        total = data1;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    warta();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) _incrementCounter();
    });
    _scroll2Controller.addListener(() {
      if (_scroll2Controller.position.pixels ==
          _scroll2Controller.position.maxScrollExtent) _incrementpe();
    });
    knt = TabController(vsync: this, length: 2);
    timer = Timer.periodic(
        Duration(seconds: 1),
        (Timer t) => setState(() {
              wartas = widget.foto;
              pengumuman = widget.video;
            }));
  }

  @override
  Future<Null> notifikasi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('id') ?? '';
    var url = Uri.https(linknya.urlbase , "app/clearnotif?userId=" + userId + "&menu=4");
    await http
        .get(url);
  }

  @override
  Future<Null> notifikasi2() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('id') ?? '';
    var url = Uri.https(linknya.urlbase , "app/clearnotif?userId=" + userId + "&menu=5");
    await http
        .get(url);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 0),
        ),
        iconTheme: IconThemeData(color: ColorPalette.underlineTextField),
        title: Container(
          width: MediaQuery.of(context).size.width * 0.60,
          height: MediaQuery.of(context).size.height * 0.045,
          child: Text(
            'Galeri',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: ColorPalette.underlineTextField,
        bottom: _tabBar(),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.100,
        height: MediaQuery.of(context).size.height * 0.100,
        child: TabBarView(
          controller: knt,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            RefreshIndicator(
              child: _list(),
              onRefresh: _refreshberita,
            ),
            RefreshIndicator(
              child: _list2(),
              onRefresh: _refreshpengumuman,
            ),
          ],
        ),
      ),
    );
  }

  _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: _loadingMore ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  _tabBar() {
    return TabBar(
      controller: knt,
      tabs: <Widget>[
        Tab(
            child: Stack(
          alignment: Alignment.topRight,
          children: <Widget>[
            AutoSizeText(
              'Foto   ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            wartas <= 0
                ? Padding(
                    padding: EdgeInsets.all(0),
                  )
                : Container(
                    width: 10,
                    height: 10,
                    padding: EdgeInsets.all(0),
                    margin: EdgeInsets.only(left: 10),
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
                  )
          ],
        )),
        Tab(
          child: Stack(alignment: Alignment.topRight, children: <Widget>[
            AutoSizeText(
              'Video   ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white),
            ),
            pengumuman <= 0
                ? Padding(
                    padding: EdgeInsets.all(0),
                  )
                : Container(
                    width: 10,
                    height: 10,
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
                  )
          ]),
        ),
      ],
    );
  }

  _list() {
    return ListView.builder(
      itemCount: Peng == null ? 2 : Peng.length + 1,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        if (index == Peng.length) {
          notifikasi();
          return _buildProgressIndicator();
        } else {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  SlideRightRoute(
                      page: ArtikelPage(
                          id: Peng[index]['id'],
                          judul: Judul = 'Foto',
                          tipe: 1)));
              print('ok');
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width * 0.90,
              height: MediaQuery.of(context).size.height * 0.34,
              child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: ColorPalette.underlineTextField,
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  verticalDirection: VerticalDirection.up,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.90,
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.circular(5),
                                image: new DecorationImage(
                                    image: NetworkImage(
                                        '${linknya.url}upload/galeri/foto/' +
                                            Peng[index]['file'],
                                        scale: 1.0),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.90,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: SizedBox(
                            child: AutoSizeText(
                              Peng[index]['judul'],
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
      controller: _scrollController,
    );
  }

  _list2() {
    return ListView.builder(
      itemCount: total == null ? 1 : total.length + 1,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        if (index == total.length) {
          notifikasi2();
          return _buildProgressIndicator();
        } else {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  SlideRightRoute(
                      page: VideoPage(
                    ur: total[index]['id'],
                    tit: total[index]['judul'],
                  )));
              print('ok');
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 20),
              width: MediaQuery.of(context).size.width * 0.90,
              height: MediaQuery.of(context).size.height * 0.34,
              child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: ColorPalette.underlineTextField,
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  verticalDirection: VerticalDirection.up,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.90,
                          height: MediaQuery.of(context).size.height * 0.25,
                          alignment: Alignment.topLeft,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.circular(5),
                                image: new DecorationImage(
                                    image: NetworkImage(
                                        'http://img.youtube.com/vi/' +
                                            total[index]['link'] +
                                            '/mqdefault.jpg',
                                        scale: 1.0),
                                    fit: BoxFit.cover)),
                            child: Icon(
                              Icons.play_circle_filled,
                              size: 100,
                              color: ColorPalette.underlineTextField,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.90,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: SizedBox(
                            child: AutoSizeText(
                              total[index]['judul'],
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
      controller: _scroll2Controller,
    );
  }
}
