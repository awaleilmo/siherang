

import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:dlh/animasi/animasi.dart';
import 'package:dlh/animasi/constant.dart';
import 'package:dlh/main/pengaduan/showpeng.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:responsive_container/responsive_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PengaduanMaps extends StatefulWidget{

  @override
  _PengaduanMaps createState() => _PengaduanMaps();

}

class _PengaduanMaps extends State<PengaduanMaps>{

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
  File _image;
  var lks = TextEditingController();
  String lokasi = '';
  final formatwaktu = DateFormat("HH:mm");
  final formattanggal = DateFormat("dd-MM-yyyy");

  void _test(lokasiLat,lokasiLng){
    var lat = lokasiLat;
    var lng = lokasiLng;
    setState(() {
      mar = true;
      lokasiLat = lat;
      lokasiLng = lng;
      lokasi = lat.toString() + ' , ' + lng.toString();
      lks.text = lokasi;
    });
    print(lks.text);
  }

  String status = '';
  String base64Image;
  String errMessage = 'Error Uploading Image';

  chooseImage() async {
    var image =  await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
    _image = image;
    });
    //print(_image);
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload() {
    setStatus('Uploading Image...');
    if (null == _image) {
      setStatus(errMessage);
      return;
    }
    String fileName = _image.path.split('/').last;
//    upload(fileName);
  }

  @override
  upload() async {
    setState((){
      loading = true;
    });
    base64Image = base64Encode(_image.readAsBytesSync());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('id');
    print('ok');
    Dio dio = new Dio();
    FormData data = FormData.fromMap({
      'userId': userId,
      'tempat': tempat.text,
      'nama': nama.text,
      'alamat': alamat.text,
      'nohp': nohp.text,
      'alamatkejadian': alamatkejadian.text,
      'jeniskegiatan': jenis.text,
      'namakegiatan': namakegiatan.text,
      'waktu': waktu.text,
      'uraiankejadian': uraian.text,
      'dampak': dampak.text,
      'penyelesaian': penyelesaian.text,
      'namainstansi': instansi1.text,
      'namainstansi2': instansi2.text,
      'namainstansi3': instansi3.text,
      'tglpengaduan': tanggal1.text,
      'tglpengaduan2': tanggal2.text,
      'tglpengaduan3': tanggal3.text,
      'lokasi': lks.text,
      "foto": await MultipartFile.fromFile(_image.path),
    });
    dio.post(linknya.urlbase +"app/pengaduan", data: data);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: ResponsiveContainer(widthPercent: 60,heightPercent: 4.5, child: Text('Pengaduan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22), textAlign: TextAlign.center,),),
        backgroundColor: ColorPalette.underlineTextField,
      ),
      body:loading == true ? _buildProgressIndicator() : ResponsiveContainer(
        widthPercent: 100,
        heightPercent: 100,
        child: Container(
          padding: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: ListView(
            children: <Widget>[
              _padding(),
              TextFormField(
                controller: tempat,
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
                      color: Colors.grey,
                      fontSize: 18,
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
                      color: Colors.grey,
                      fontSize: 18,
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
                      color: Colors.grey,
                      fontSize: 18,
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
                      color: Colors.grey,
                      fontSize: 18,
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
                      color: Colors.grey,
                      fontSize: 18,
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
                      color: Colors.grey,
                      fontSize: 18,
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
                      color: Colors.grey,
                      fontSize: 18,
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
                      color: Colors.grey,
                      fontSize: 18,
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
                      color: Colors.grey,
                      fontSize: 18,
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
                      color: Colors.grey,
                      fontSize: 18,
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
                      color: Colors.grey,
                      fontSize: 18,
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
                                  color: Colors.grey,
                                  fontSize: 18,
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
                                  color: Colors.grey,
                                  fontSize: 18,
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
                                  color: Colors.grey,
                                  fontSize: 18,
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
                                  color: Colors.grey,
                                  fontSize: 18,
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
                                  color: Colors.grey,
                                  fontSize: 18,
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
                                  color: Colors.grey,
                                  fontSize: 18,
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
              _image == null
                  ? Text('No image selected.')
                  : Image.file(_image),
              OutlineButton(
                onPressed: chooseImage,
                child: Text('Browse'),
              ),
              _padding(),
              Container(
                width: 200,
                height: 400,
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(lokasiLat, lokasiLng),
                    zoom: 12.0,
                    onTap: (LatLng){
                      _test(lokasiLat = LatLng.latitude, lokasiLng = LatLng.longitude);
                    }
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
              FlatButton(
                onPressed: (){
                  upload();
                  Navigator.pushReplacement(context, SlideLeftRoute(page: PengPage()));
                },
                color: ColorPalette.underlineTextField,
                child: AutoSizeText('Kirim',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              ),
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
    return mar == false ? new Marker() :new Marker(
      width: 80.0,
      height: 80.0,
      point: new LatLng(lokasiLat, lokasiLng),
      builder: (context) => new Container(
          child:  Icon(
                Icons.my_location,color: Colors.red, size: 20.0,)
      ),
    );
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