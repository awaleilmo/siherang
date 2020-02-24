import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dlh/animasi/animasi.dart';
import 'package:dlh/animasi/constant.dart';
import 'package:dlh/main/artikelpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_container/responsive_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BeritaPage extends StatefulWidget{
  @override
  _BeritaPage createState() => _BeritaPage();
}

class _BeritaPage extends State<BeritaPage> with SingleTickerProviderStateMixin{
  int _counter = 1;
  int _counterpe = 1;
  List total = new List();
  List Peng = new List();
  String Judul='';
  ScrollController _scrollController = new ScrollController();
  ScrollController _scroll2Controller = new ScrollController();
  bool _loadingMore = false;
  TabController knt;

  @override
  Future<void> _incrementCounter() async {
    setState(() {
      _counter++;
      _loadingMore = true;
    });
    final response = await http.get(linknya.urlbase + "app/artikel?page=" + _counter.toString());
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
    final response = await http.get(linknya.urlbase + "app/pengumuman?page=" + _counterpe.toString());
    var jsson = jsonDecode(response.body);
    var data = jsson['data']['data'];
    print('pengumuman');
    setState(() {
      _loadingMore = false;
      total.addAll(data);
    });
  }

  @override
  Future<void> warta() async {
   if(!_loadingMore){
     setState(() {
       _loadingMore = true;
     });
     final SharedPreferences prefs = await SharedPreferences.getInstance();
     String userId = prefs.getString('id');
     String userToken = prefs.getString('token');
     final response = await http.get(linknya.urlbase + "app/artikel?page=" + _counter.toString());
     var jsson = jsonDecode(response.body);
     var data = jsson['data']['data'];
     final response1 = await http.get(linknya.urlbase + "app/pengumuman?page=" + _counterpe.toString());
     var jsson1 = jsonDecode(response1.body);
     var data1 = jsson1['data']['data'];
     print(_counter);
     setState(() {
       _loadingMore = false;
       Peng.addAll(data);
       total.addAll(data1);
     });
   }
  }

  @override
  Future<Null> _refreshberita() async {
    if(!_loadingMore){
      setState(() {
        _loadingMore = true;
        _counter = 1;
      });
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString('id');
      String userToken = prefs.getString('token');
      final response = await http.get(linknya.urlbase + "app/artikel?page=" + _counter.toString());
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
  Future<Null> _refreshpengumuman () async {
    if(!_loadingMore){
      setState(() {
        _loadingMore = true;
        _counterpe = 1;
      });
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString('id');
      String userToken = prefs.getString('token');
      final response1 = await http.get(linknya.urlbase + "app/pengumuman?page=" + _counterpe.toString());
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
    _scrollController.addListener((){
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent)
        _incrementCounter();
    });
    _scroll2Controller.addListener((){
      if(_scroll2Controller.position.pixels == _scroll2Controller.position.maxScrollExtent)
        _incrementpe();
    });
    knt = TabController(vsync: this, length: 2);
  }

 @override
 void dispose(){
    super.dispose();
 }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
          appBar: AppBar(
            leading: Padding(padding: EdgeInsets.only(left: 0),),
            iconTheme: IconThemeData(color: ColorPalette.underlineTextField),
            title: ResponsiveContainer(widthPercent: 60,heightPercent: 4.5, child: Text('Berita', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22), textAlign: TextAlign.center,),),
            backgroundColor: ColorPalette.underlineTextField,
            bottom:_tabBar(),
          ),
          body:  ResponsiveContainer(
              margin: EdgeInsets.all(10),
              widthPercent: 100,
              heightPercent: 100,
              child: TabBarView(
                controller: knt,
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
      )
    ;
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

  _tabBar(){
    return TabBar(
      controller: knt,
      tabs: <Widget>[
        Tab ( child: AutoSizeText('Pojok Warta LH',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),), ),
        Tab ( child: AutoSizeText('Pengumuman',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),), ),
      ],
    );
  }

  _list(){
    return ListView.builder(
        itemCount: Peng == null ? 2: Peng.length + 1 ,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index)
    {
      if (index == Peng.length) {
        return _buildProgressIndicator();
      }else{
            return InkWell(
              onTap: () {
                Navigator.push(context, SlideRightRoute(page: ArtikelPage(
                    id: Peng[index]['id'],
                    judul: Judul = 'Pojok Warta LH',
                    tipe: 1)));
                print('ok');
              },
              child:  ResponsiveContainer(
                margin: EdgeInsets.only(bottom: 20),
                widthPercent: 90,
                heightPercent: 15,
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: ColorPalette.underlineTextField,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    verticalDirection: VerticalDirection.up,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          ResponsiveContainer(
                            widthPercent: 50, heightPercent: 5, child: SizedBox(

                            child: AutoSizeText(
                              Peng[index]['judul'], maxLines: 2,),),),
                          ResponsiveContainer(widthPercent: 50,
                            heightPercent: 5,
                            alignment: Alignment.bottomLeft,
                            child: SizedBox(
                              child: AutoSizeText(
                                DateFormat('dd - MMMM - yyyy').format(
                                    DateTime.parse(Peng[index]['tanggal'])),
                                maxLines: 2, style: TextStyle(fontSize: 10),),
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(left: 5),),
                      ResponsiveContainer(
                        widthPercent: 35,
                        heightPercent: 100,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(5),
                            image: new DecorationImage(
                              image: NetworkImage('http://dlh-serangkota.com/upload/artikel/' + Peng[index]['foto'], scale: 1.0),
                              fit: BoxFit.cover
                            )
                          ),
                        ),
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

  _list2(){
    return ListView.builder(
      itemCount: total == null? 1:total.length + 1 ,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
      if (index == total.length) {
        return _buildProgressIndicator();
      }else {
        return InkWell(
          onTap: () {
            Navigator.push(context, SlideRightRoute(page: ArtikelPage(
                id: total[index]['id'],
                judul: Judul = 'Pengumuman',
                tipe: 0)));
            print('ok');
          },
          child: ResponsiveContainer(
            margin: EdgeInsets.only(bottom: 20),
            widthPercent: 90,
            heightPercent: 15,
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: ColorPalette.underlineTextField,
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                verticalDirection: VerticalDirection.up,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ResponsiveContainer(
                        widthPercent: 50, heightPercent: 5, child: SizedBox(

                        child: AutoSizeText(
                          total[index]['judul'], maxLines: 2,),),),
                      ResponsiveContainer(widthPercent: 50,
                        heightPercent: 5,
                        alignment: Alignment.bottomLeft,
                        child: SizedBox(
                          child: AutoSizeText(
                            DateFormat('dd - MMMM - yyyy').format(
                                DateTime.parse(total[index]['tanggal'])),
                            maxLines: 2, style: TextStyle(fontSize: 10),),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(left: 5),),
                  ResponsiveContainer(
                    widthPercent: 35,
                    heightPercent: 100,
                    alignment: Alignment.topLeft,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(5),
                          image: new DecorationImage(
                              image: NetworkImage(linknya.url + '/upload/pengumuman/' + total[index]['foto'], scale: 1.0),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
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