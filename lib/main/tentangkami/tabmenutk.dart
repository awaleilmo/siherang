import 'package:auto_size_text/auto_size_text.dart';
import 'package:dlh/animasi/animasi.dart';
import 'package:dlh/animasi/constant.dart';
import 'package:dlh/main/akun.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:responsive_container/responsive_container.dart';
import 'package:vertical_tabs/vertical_tabs.dart';

class MenuTk extends StatefulWidget {

  @override
  _MenuTk createState() => _MenuTk();
}

class _MenuTk extends State<MenuTk>  {

  int _counter = 0;
  String nmmenu='';
  InAppWebViewController webView;
  String kons = linknya.url + 'mobile/kadis';
  int pil = 0;
  bool hil = false;
  double progress = 0;
  ScrollController _scrollController = new ScrollController();

  void _incrementCounter() {
    setState(() {
      _counter++;

    });
  }

  @override
  Future<void> stru() async{
    webView.reload();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener((){
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent)
        _incrementCounter();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: ResponsiveContainer(widthPercent: 60,heightPercent: 4.5, child: Text('Tentang Kami', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22), textAlign: TextAlign.center,),),
            elevation: 0,
            backgroundColor: ColorPalette.underlineTextField,
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.orangeAccent,
              tabs: <Widget>[
                Tab(child: Text('Dasar Hukum')),
                Tab(child: Text('Visi & Misi')),
                Tab(child: Text('Sejarah')),
                Tab(child: Text('Struktur Bidang')),
                Tab(child: Text('Struktur Organisasi')),
              ],
            ),
          ),
          body: _menu(),
          backgroundColor: Colors.white,// This trailing comma makes auto-formatting nicer for build methods.
        ),
    );
  }
  _menu(){
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        ListView(children: <Widget>[
          HtmlWidget(
            '''
        
  <table border="0" cellpadding="0" style="width:100%; text-align:justify">
  <tbody>
  <tr>
    <td style="text-align:center">
      <h2>Dasar Hukum</h2>
    </td>
  </tr>
  <tr>
      <td >
      <p>Dinas Lingkungan Hidup (DLH) Kota Serang dibentuk berdasarkan Peraturan Walikota Serang Nomor 15 Tahun 2017 Tentang Perubahan Kedudukan, Susunan Organisasi, Tugas dan Fungsi serta Tata kerja Dinas Lingkungan Hidup (DLH)  Kota Serang Pasal 3 yang menyebutkan bahwa :</p>
    </td>
    </tr>
    <tr>
    <td >
    <p>Dinas Lingkungan Hidup melaksanakan urusan pemerintahan daerah dibidang lingkungan hidup sesuai dengan visi, misi dan program Walikota sebagaimana terjabarkan dalam Rencana Pembangunan Jangka Menengah Daerah.</p>
    </td>
    </tr>
    </tbody>
    </table>''',
            webView: true,
          ),
        ], padding: EdgeInsets.all(10)),
        ListView(children: <Widget>[
          HtmlWidget(
            '''
          <table border="0" cellpadding="0">
                <tr>
                  <td style="font-weight:bold; font-size: xx-large; text-align:center">
                  Visi
                  </td>
                </tr>
                <tr>
                    <td>
                        <p>"Terwujudnya Kota Peradaban yang Berdaya dan Berbudaya</p></td>

                </tr>
                <tr>
                    <td style="font-weight:bold; font-size: xx-large; text-align:center">Misi</td>
                </tr>
                <tr>
                    <td align="left">
                        Menguatkan Peradaban Berbasis Nilai-Nilai Kemanusiaan.<br><br>
                        Meningkatkan Sarana Prasarana Daerah yang Berwawasan Lingkungan.<br>
                        <p style="text-align: justify">Meningkatkan Perekonomian Daerah dan Pemberdayaan Masyarakat yang Berdaya Saing. </p><br>
                        <p>Meningkatkan Tata Kelola Pemerintahan yang Baik  .</p>
                        </td>

                </tr>
            </table>            
          ''',
            webView: true,
            unsupportedWebViewWorkaroundForIssue37: true,
          ),

        ], padding: EdgeInsets.all(10)),
        ListView(children: <Widget>[
          HtmlWidget(
            '''
          <h2 class="hero-heading wow fadeInDown animated animated" data-wow-duration="0.6s" style="text-align:center; visibility: visible; animation-duration: 0.6s;">SEJARAH</h2>
                <table border="0" cellpadding="10" class="hero-text wow bounceInUp animated animated" data-wow-duration="0.9s" data-wow-delay="0.2s" style="visibility: visible; animation-duration: 0.9s; animation-delay: 0.2s;">
                    
                    <tr>
                        <td align="left">
                        <p style="text-align: justify">Dengan diberlakukannya Undang-undang Nomor 22 Tahun 1999 tentang Pemerintahan Daerah dan Peraturan Pemerintah Nomor 25 Tahun 2000 tentang Kewenangan Pemerintah dan Kewenangan Provinsi sebagai Daerah Otonom.
                        Untuk melaksanakan kegiatan pembangunan pada bidang pelestarian  lingkungan hidup, berdasarkan Peraturan Daerah Nomor 10 Tahun 2008 tentang Susunan Organisasi  Lembaga Teknis Daerah Kota Serang yang kemudian diubah dengan Peraturan Daerah Kota Serang
                        Nomor 18 Tahun 2011 tentang Perubahan atas Peraturan Daerah Kota Serang Nomor 10 Tahun 2008 tentang Pembentukan dan Susunan Organisasi Lembaga Teknis Daerah Kota Serang.</p></td>
                    </tr>
                    <tr>
                        <td align="left">
                        <p style="text-align: justify">Pada Tahun 2004 , Undang-Undang Nomor 22 Tahun 1999 tentang Pemerintahan Daerah diganti dengan Undang-Undang Nomor 32 Tahun 2004 tentang Pemerintahan Daerah (Lembaran Negara Republik Indonesia Tahun 2004 Nomor 125,
                        Tambahan Lembaran Negara Republik Indonesia Nomor 4437) sebagaimana telah diubah dengan Undang-Undang Nomor 2 Tahun 2008 tentang tentang Perubahan Kedua Atas Undang-Undang Nomor 32 Tahun 2004 tentang Pemerintahan Daerah (Lembaran Negara Republik Indonesia Tahun 2008 Nomor 59,
                        Tambahan Lembaran Negara Republik Indonesia Nomor 4844) dan berdasarkan Peraturan Pemerintah Nomor 41 Tahun 2007 tentang  Organisasi Perangkat Daerah (Lembaran Negara Republik Indonesia Tahun 2007 Nomor 89, Tambahan Lembaran Negara Republik Indonesia Nomor 4741) . Pada Tahun 2011,
                        nomenklator Kantor Lingkungan Hidup Kota Serang diubah menjadi Badan Lingkungan Hidup Kota Serang berdasarkan Peraturan Daerah Nomor 18 Tahun 2011. Sedangkan Tupoksi diatur pada Peraturan Walikota Nomor 18 tahun 2011 tentang Perubahan atas Peraturan Walikota Nomor 38 Tahun 2008 tentang Tugas Pokok dan Fungsi Lembaga Teknis Daerah Kota Serang.</p></td>
                    </tr>
                </table>
          ''',
            webView: true,
          )
        ], padding: EdgeInsets.all(10)),
        RefreshIndicator(
          onRefresh: stru,
          child: Column(
            children: <Widget>[
              ResponsiveContainer(
                widthPercent: 100,
                heightPercent: 10,
                child:  ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    FlatButton(
                      padding: EdgeInsets.only(left: 5,right: 5),
                      onPressed: (){
                        webView.reload();
                        webView.loadUrl(linknya.url + 'mobile/kadis');
                      },
                      child: _btnmnu(nmmenu = 'Kepala Dinas'),
                    ),
                    FlatButton(
                      padding: EdgeInsets.only(left: 5,right: 5),
                      onPressed: (){
                        webView.reload();
                        webView.loadUrl(linknya.url + 'mobile/sekdis');
                      },
                      child:_btnmnu(nmmenu = 'Sekretaris'),
                    ),
                    FlatButton(
                      padding: EdgeInsets.only(left: 5,right: 5),
                      onPressed: (){
                        webView.reload();
                        webView.loadUrl(linknya.url + 'mobile/unpeg');
                      },
                      child:_btnmnu(nmmenu = 'Umum dan Kepegawaian'),
                    ),

                    FlatButton(
                      padding: EdgeInsets.only(left: 5,right: 5),
                      onPressed: (){
                        webView.reload();
                        webView.loadUrl(linknya.url + 'mobile/pep');
                      },
                      child:_btnmnu(nmmenu = 'PEP dan Keuangan'),
                    ),
//                    FlatButton(
//                      padding: EdgeInsets.only(left: 5,right: 5),
//                      onPressed: (){
//                        webView.reload();
//                        webView.loadUrl(linknya.url + 'mobile/ppklh');
//                      },
//                      child:_btnmnu(nmmenu = 'Bidang Pengendalian'),
//                    ),

//                    FlatButton(
//                      padding: EdgeInsets.only(left: 5,right: 5),
//                      onPressed: (){
//                        webView.reload();
//                        webView.loadUrl(linknya.url + 'mobile/uptlab');
//                      },
//                      child:_btnmnu(nmmenu = 'UPTD Laboratorium'),
//                    ),
//
//                    FlatButton(
//                      padding: EdgeInsets.only(left: 5,right: 5),
//                      onPressed: (){
//                        webView.reload();
//                        webView.loadUrl(linknya.url + 'mobile/uptperbekalan');
//                      },
//                      child:_btnmnu(nmmenu = 'UPTD Perlengkapan'),
//                    ),

                    FlatButton(
                      padding: EdgeInsets.only(left: 5,right: 5),
                      onPressed: (){
                        webView.reload();
                        webView.loadUrl(linknya.url + 'mobile/jabatan');
                      },
                      child:_btnmnu(nmmenu = 'Kelompok Jabatan Fungsional'),
                    ),
                  ],
                ),
              ),
              (progress != 1.0) ? LinearProgressIndicator(value: progress) : Padding(padding: EdgeInsets.all(0),),
             RefreshIndicator(
               onRefresh: stru,
               child:  Expanded(
                 child: ResponsiveContainer(
                   widthPercent: 100,
                   heightPercent: 70,
                   padding: EdgeInsets.only(left:15, right: 15, top: 15),
                   child:_kadis(),
                 ),
               ),
             )



            ],
          ),
        ),
        ListView(children: <Widget>[
          HtmlWidget(
            '''
          <h2 class="hero-heading wow fadeInDown animated animated" data-wow-duration="0.6s" style="text-align:center; visibility: visible; animation-duration: 0.6s;">STRUKTUR ORGANISASI</h2>
          <br>
          <br>
          <img src="https://dlh-serangkota.com/image-resources/dlh/strukdlh.png" style="margin-left:0">
          ''',
          )
        ], padding: EdgeInsets.all(10)),
      ],
    );
  }


  Widget _kadis(){
    return InAppWebView(
        initialUrl: kons,
        initialHeaders: {

        },
        initialOptions: {

        },
        onWebViewCreated: (InAppWebViewController controller) {
          webView = controller;
        },
        onLoadStart: (InAppWebViewController controller, String url) {
          print("started $kons");
          setState(() {
            this.kons = kons;
          });
        },
        onProgressChanged: (InAppWebViewController controller, int progress) {
          setState(() {
            this.progress = progress/100;
          });
        },
    );
  }

  _btnmnu(String s){
    return ResponsiveContainer(
      widthPercent: 40,
      heightPercent: 15,
      padding: EdgeInsets.only(top:10, bottom: 0),
      child: Container(
        padding: EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          //boxShadow:[ BoxShadow(color: Colors.grey, spreadRadius: 0.5,offset: Offset(3.0,4.0), blurRadius: 5)],
          border: Border.all(color: ColorPalette.underlineTextField, width: 1.5),
          borderRadius: BorderRadius.circular(50),
        ),
        child:Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          //Icon(ikon, color: ColorPalette.underlineTextField, size: 50,),
          AutoSizeText(nmmenu,minFontSize:11,style: TextStyle(color: ColorPalette.underlineTextField, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
        ],
        ),
      ),
    );
  }
}