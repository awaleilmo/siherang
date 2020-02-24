import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dlh/animasi/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_container/responsive_container.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPeng extends StatefulWidget{
  int idnya;
  DetailPeng({this.idnya});
  @override
  _detail createState() => _detail();
}

class _detail extends State<DetailPeng>{
  List total = new List();
  double lokasiLat = -6.112387777530127;
  double lokasiLng = 106.141655479581237;
  bool mar = false;
  bool loading = false;
  var tempat = TextEditingController();
  var nama = TextEditingController();
  var alamat = TextEditingController();
  var nohp = TextEditingController();
  var alamatkejadian = TextEditingController();
  var jenis = TextEditingController();
  var namakegiatan = TextEditingController();
  var waktu = TextEditingController();
  var uraian = TextEditingController();
  var dampak = TextEditingController();
  var penyelesaian = TextEditingController();
  var instansi1 = TextEditingController();
  var instansi2 = TextEditingController();
  var instansi3 = TextEditingController();
  var tanggal1 = TextEditingController();
  var tanggal2 = TextEditingController();
  var tanggal3 = TextEditingController();
  var _image;
  var lk;
  String lok;
  var lks = TextEditingController();
  String lokasi = '';
  final formatwaktu = DateFormat("HH:mm");
  final formattanggal = DateFormat("dd-MM-yyyy");

  @override
  void initState(){
    super.initState();
    loading = true;
    kaon();
  }

  @override
  Future<void> kaon() async {
    final response = await http.get(linknya.urlbase + "app/detailpengaduan?id=" + widget.idnya.toString());
    var jsson = jsonDecode(response.body);
    var datat = jsson['data'];
    print(datat);
    setState((){
      tempat.text = datat['tempat'];
      nama.text = datat['nama'];
      alamat.text = datat['alamat'];
      nohp.text = datat['notelp'];
      alamatkejadian.text = datat['alamatkejadian'];
      jenis.text = datat['jeniskegiatan'];
      namakegiatan.text = datat['namakegiatan'];
      waktu.text = datat['waktu'];
      uraian.text = datat['uraiankejadian'];
      dampak.text = datat['dampak'];
      penyelesaian.text = datat['penyelesaian'];
      lk  = datat['lokasi'].split(',');
      lok  = datat['lokasi'];
      lokasiLat = double.parse(lk[0]);
      lokasiLng = double.parse(lk[1]);
      _image = datat['foto'];
      loading = false;
    });
    print(_image.toString());
    setState(() {
      var nm  = datat['namainstansi'].split(',');
      var tg  = datat['tgl'].split(',');
      if(nm[0] != null || nm[1] != null || nm[2] != null) {
        instansi1.text = nm[0];
        tanggal1.text = tg[0];
        instansi2.text = nm[1];
        tanggal2.text = tg[1];
        instansi3.text = nm[2];
        tanggal3.text = tg[2];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: ResponsiveContainer(widthPercent: 60,heightPercent: 4.5, child: Text('Pengaduan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22), textAlign: TextAlign.center,),),
        backgroundColor: ColorPalette.underlineTextField,
      ),
      body: Center(
        child:loading == true ? _buildProgressIndicator(): ResponsiveContainer(
          widthPercent: 100,
          heightPercent: 100,
          margin: EdgeInsets.only(left: 10,right: 10),
          child: ListView(
            children: <Widget>[
              _padding(),
              TextFormField(
                controller: tempat,
                readOnly: true,
                decoration: new InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorPalette.underlineTextField,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                      width: 2.5,
                    ),
                  ),
                  labelText:  'Tempat',
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),
                  hintStyle: TextStyle(
                      color: ColorPalette.hintColor
                  ),

                ),
                style: TextStyle(color: Colors.black54),
                autofocus: false,
              ),
              _padding(),
              Container(
                alignment: Alignment.centerLeft,
                child: AutoSizeText('A. Identitas Pengadu',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.left,),
              ),
              _padding(),
              TextFormField(
                controller: nama,
                readOnly: true,
                decoration: new InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorPalette.underlineTextField,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                      width: 2.5,
                    ),
                  ),
                  labelText:  'Nama',
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),
                  hintStyle: TextStyle(
                      color: ColorPalette.hintColor
                  ),

                ),
                style: TextStyle(color: Colors.black54),
                autofocus: false,
              ),
              _padding(),
              TextFormField(
                controller: alamat,
                readOnly: true,
                decoration: new InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorPalette.underlineTextField,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                      width: 2.5,
                    ),
                  ),
                  labelText:  'Alamat',
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),
                  hintStyle: TextStyle(
                      color: ColorPalette.hintColor
                  ),

                ),
                style: TextStyle(color: Colors.black54),
                autofocus: false,
              ),
              _padding(),
              TextFormField(
                controller: nohp,
                readOnly: true,
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorPalette.underlineTextField,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                      width: 2.5,
                    ),
                  ),
                  labelText:  'No Telp',
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),
                  hintStyle: TextStyle(
                      color: ColorPalette.hintColor
                  ),

                ),
                style: TextStyle(color: Colors.black54),
                autofocus: false,
              ),
              _padding(),
              Container(
                alignment: Alignment.centerLeft,
                child: AutoSizeText('B. Lokasi Kejadian',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.left,),
              ),
              _padding(),
              TextFormField(
                controller: alamatkejadian,
                readOnly: true,
                decoration: new InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorPalette.underlineTextField,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                      width: 2.5,
                    ),
                  ),
                  labelText:  'Alamat Kejadian',
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),
                  hintStyle: TextStyle(
                      color: ColorPalette.hintColor
                  ),

                ),
                style: TextStyle(color: Colors.black54),
                autofocus: false,
              ),
              _padding(),
              Container(
                alignment: Alignment.centerLeft,
                child: AutoSizeText('C. Dugaan Sumber atau Penyebab',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.left,),
              ),
              _padding(),
              TextFormField(
                controller: jenis,
                readOnly: true,
                decoration: new InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorPalette.underlineTextField,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                      width: 2.5,
                    ),
                  ),
                  labelText:  'Jenis Kegiatan( Jika diketahui )',
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),
                  hintStyle: TextStyle(
                      color: ColorPalette.hintColor
                  ),

                ),
                style: TextStyle(color: Colors.black54),
                autofocus: false,
              ),
              _padding(),
              TextFormField(
                controller: namakegiatan,
                readOnly: true,
                decoration: new InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorPalette.underlineTextField,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                      width: 2.5,
                    ),
                  ),
                  labelText:  'Nama Kegiatan dan atau Usaha( Jika diketahui )',
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),
                  hintStyle: TextStyle(
                      color: ColorPalette.hintColor
                  ),

                ),
                style: TextStyle(color: Colors.black54),
                autofocus: false,
              ),
              _padding(),
              Container(
                alignment: Alignment.centerLeft,
                child: AutoSizeText('D. Waktu dan Uraian Kejadian',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.left,),
              ),
              _padding(),
              Container(
                alignment: Alignment.centerLeft,
                child: AutoSizeText('Waktu diketahuinya pencemaran dan atau perusakan lingkungan dan/atau perusakan hutan:',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16), textAlign: TextAlign.left,),
              ),
              _padding(),
              DateTimeField(
                controller: waktu,
                readOnly: true,
                format: formatwaktu,
                decoration: new InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorPalette.underlineTextField,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                      width: 2.5,
                    ),
                  ),
                  //labelText:  'Jam:Menit',
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),
                  hintStyle: TextStyle(
                      color: ColorPalette.hintColor
                  ),

                ),
                style: TextStyle(color: Colors.black54),
                autofocus: false,
                onShowPicker: (context, currentValue) async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                  );
                  return DateTimeField.convert(time);
                },
              ),
              _padding(),
              Container(
                alignment: Alignment.centerLeft,
                child: AutoSizeText('Uraian Kejadian',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16), textAlign: TextAlign.left,),
              ),
              _padding(),
              TextFormField(
                controller: uraian,
                readOnly: true,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: new InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorPalette.underlineTextField,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                      width: 2.5,
                    ),
                  ),
                  labelText:  '',
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),
                  hintStyle: TextStyle(
                      color: ColorPalette.hintColor
                  ),

                ),
                style: TextStyle(color: Colors.black54),
                autofocus: false,
              ),
              _padding(),
              Container(
                alignment: Alignment.centerLeft,
                child: AutoSizeText('Dampak yang dirasakan akibat pencemaran dan atau perusakan lingkungan dan/atau perusakan hutan:',style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16), textAlign: TextAlign.left,),
              ),
              _padding(),
              TextFormField(
                controller: dampak,
                readOnly: true,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: new InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorPalette.underlineTextField,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                      width: 2.5,
                    ),
                  ),
                  labelText:  '',
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),
                  hintStyle: TextStyle(
                      color: ColorPalette.hintColor
                  ),

                ),
                style: TextStyle(color: Colors.black54),
                autofocus: false,
              ),
              _padding(),
              Container(
                alignment: Alignment.centerLeft,
                child: AutoSizeText('E. Penyelesaian yang Diinginkan',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.left,),
              ),
              _padding(),
              TextFormField(
                controller: penyelesaian,
                readOnly: true,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: new InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorPalette.underlineTextField,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                      width: 2.5,
                    ),
                  ),
                  labelText:  '',
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),
                  hintStyle: TextStyle(
                      color: ColorPalette.hintColor
                  ),

                ),
                style: TextStyle(color: Colors.black54),
                autofocus: false,
              ),
              _padding(),
              Container(
                alignment: Alignment.centerLeft,
                child: AutoSizeText('F. Pernah Menyampaikan Pengaduan',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.left,),
              ),
              _padding(),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: ColorPalette.underlineTextField
                    )
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        ResponsiveContainer(
                          heightPercent: 5,
                          widthPercent: 45,
                          child: AutoSizeText('Nama Instansi'),
                        ),
                        ResponsiveContainer(
                          heightPercent: 5,
                          widthPercent: 45,
                          child: AutoSizeText('Tanggal'),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        ResponsiveContainer(
                          heightPercent: 6,
                          widthPercent: 45,
                          padding: EdgeInsets.only(right: 5),
                          child: TextFormField(
                            controller: instansi1,
                            readOnly: true,
                            decoration: new InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorPalette.underlineTextField,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.orange,
                                  width: 2.5,
                                ),
                              ),
                              labelText:  '',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold
                              ),
                              hintStyle: TextStyle(
                                  color: ColorPalette.hintColor
                              ),

                            ),
                            style: TextStyle(color: Colors.black54),
                            autofocus: false,
                          ),
                        ),
                        ResponsiveContainer(
                          heightPercent: 6,
                          widthPercent: 45,
                          child: DateTimeField(
                            format: formattanggal,
                            controller: tanggal1,
                            readOnly: true,
                            decoration: new InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorPalette.underlineTextField,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.orange,
                                  width: 2.5,
                                ),
                              ),
                              labelText:  '',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold
                              ),
                              hintStyle: TextStyle(
                                  color: ColorPalette.hintColor
                              ),

                            ),
                            onShowPicker: (context, currentValue) {
                              return showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1900),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(2100));
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 5),),
                    Row(
                      children: <Widget>[
                        ResponsiveContainer(
                          heightPercent: 6,
                          widthPercent: 45,
                          padding: EdgeInsets.only(right: 5),
                          child: TextFormField(
                            controller: instansi2,
                            readOnly: true,
                            decoration: new InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorPalette.underlineTextField,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.orange,
                                  width: 2.5,
                                ),
                              ),
                              labelText:  '',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold
                              ),
                              hintStyle: TextStyle(
                                  color: ColorPalette.hintColor
                              ),

                            ),
                            style: TextStyle(color: Colors.black54),
                            autofocus: false,
                          ),
                        ),
                        ResponsiveContainer(
                          heightPercent: 6,
                          widthPercent: 45,
                          child: DateTimeField(
                            controller: tanggal2,
                            format: formattanggal,
                            readOnly: true,
                            decoration: new InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorPalette.underlineTextField,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.orange,
                                  width: 2.5,
                                ),
                              ),
                              labelText:  '',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold
                              ),
                              hintStyle: TextStyle(
                                  color: ColorPalette.hintColor
                              ),

                            ),
                            onShowPicker: (context, currentValue) {
                              return showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1900),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(2100));
                            },
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 5),),
                    Row(
                      children: <Widget>[
                        ResponsiveContainer(
                          heightPercent: 6,
                          widthPercent: 45,
                          padding: EdgeInsets.only(right: 5),
                          child: TextFormField(
                            controller: instansi3,
                            readOnly: true,
                            decoration: new InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorPalette.underlineTextField,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.orange,
                                  width: 2.5,
                                ),
                              ),
                              labelText:  '',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold
                              ),
                              hintStyle: TextStyle(
                                  color: ColorPalette.hintColor
                              ),

                            ),
                            style: TextStyle(color: Colors.black54),
                            autofocus: false,
                          ),
                        ),
                        ResponsiveContainer(
                          heightPercent: 6,
                          widthPercent: 45,
                          child: DateTimeField(
                            controller: tanggal3,
                            readOnly: true,
                            format: formattanggal,
                            decoration: new InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorPalette.underlineTextField,
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.orange,
                                  width: 2.5,
                                ),
                              ),
                              labelText:  '',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold
                              ),
                              hintStyle: TextStyle(
                                  color: ColorPalette.hintColor
                              ),

                            ),
                            onShowPicker: (context, currentValue) {
                              return showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1900),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(2100));
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _padding(),
              Container(
                alignment: Alignment.centerLeft,
                child: AutoSizeText('G. Lokasi Dan Upload Foto',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.left,),
              ),
              _padding(),
              ResponsiveContainer(
                widthPercent: 100,
                heightPercent: 35,
                alignment: Alignment.topLeft,
                child: Container(
                  alignment: Alignment.center,
                  decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(5),
                  ),
                  child: FadeInImage.assetNetwork(
                    image:linknya.url + '/upload/pengaduan/' + _image.toString(),
                    placeholder: 'asset/img/loading.gif',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              _padding(),
              Container(
                width: 200,
                height: 400,
                child: FlutterMap(
                  options: MapOptions(
                      center: LatLng(lokasiLat, lokasiLng),
                      zoom: 15.0,
                  ),
                  layers: [
                    TileLayerOptions(
                        urlTemplate:'https://{s}.google.com/vt/lyrs=m@221097413,traffic&x={x}&y={y}&z={z}',
                        subdomains: ['mt0', 'mt1', 'mt2','mt3']),
                    MarkerLayerOptions(
                        markers: [_marker()]
                    ),
                  ],
                ),
              ),
              _padding(),
            ],
          ),
        ),
      ),
    );
  }

  _padding(){
    return Padding(
      padding: EdgeInsets.only(top: 15),
    );
  }

  _marker(){
    return new Marker(
      width: 80.0,
      height: 80.0,
      point: new LatLng(lokasiLat, lokasiLng),
      builder: (context) => new FlatButton(
        onPressed: (){
          _launchURL();
        },
          child:  Icon(
            Icons.location_on,color: Colors.red, size: 50.0,)
      ),
    );
  }

  _launchURL() async {
    var url = 'https://www.google.com/maps/dir/?api=1&destination=' + lok;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: loading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

}