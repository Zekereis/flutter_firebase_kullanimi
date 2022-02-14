import 'dart:collection';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_kullanimi/Kisiler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var refKisiler = FirebaseDatabase.instance.reference().child("kisiler_tablo");

  Future<void> kisiEkle() async{
    var bilgi = HashMap<String,dynamic>();
    bilgi["kisi_ad"] = "Reisoğlu";
    bilgi["kisi_yas"] = 10;
    refKisiler.push().set(bilgi);
  }
  Future<void> kisiSil() async{
    refKisiler.child("-MvoPqfsN7Z--ZQvpsmB").remove();
  }
  Future<void> kisiGuncelle() async{
    var guncelbilgi = HashMap<String,dynamic>();
    guncelbilgi["kisi_ad"] = "güncellenen zeker";
    guncelbilgi["kisi_yas"] = 22;
    refKisiler.child("-MvoQPaiMK--dMVBKEJa").update(guncelbilgi);
  }
  Future<void> tumKisiler() async{
    refKisiler.onValue.listen((event) {
      var gelenDegerler = event.snapshot.value;

      if(gelenDegerler != null){
        gelenDegerler.forEach((key,nesne){
          var gelenKisi = Kisiler.fromJson(nesne);
          print("************");
          print("Kişi key : $key");
          print("Kişi ad : ${gelenKisi.kisi_ad}");
          print("Kişi yaş : ${gelenKisi.kisi_yas}");

        });
      }
    });
  }
  Future<void> tumKisilerOnce() async{

    refKisiler.once().then((DataSnapshot snapshot) {

      var gelenDegerler = snapshot.value;

      if(gelenDegerler != null){
        gelenDegerler.forEach((key,nesne){
          var gelenKisi = Kisiler.fromJson(nesne);
          print("************");
          print("Kişi key : $key");
          print("Kişi ad : ${gelenKisi.kisi_ad}");
          print("Kişi yaş : ${gelenKisi.kisi_yas}");

        });
      }
    });
  }
  Future<void> esitlikArama() async{

    var sorgu = refKisiler.orderByChild("kisi_yas").equalTo(50);

    sorgu.onValue.listen((event) {
      var gelenDegerler = event.snapshot.value;

      if(gelenDegerler != null){
        gelenDegerler.forEach((key,nesne){
          var gelenKisi = Kisiler.fromJson(nesne);
          print("************");
          print("Kişi key : $key");
          print("Kişi ad : ${gelenKisi.kisi_ad}");
          print("Kişi yaş : ${gelenKisi.kisi_yas}");

        });
      }
    });
  }
  Future<void> limitliVeri() async{

    var sorgu = refKisiler.limitToFirst(2);

    sorgu.onValue.listen((event) {
      var gelenDegerler = event.snapshot.value;

      if(gelenDegerler != null){
        gelenDegerler.forEach((key,nesne){
          var gelenKisi = Kisiler.fromJson(nesne);
          print("************");
          print("Kişi key : $key");
          print("Kişi ad : ${gelenKisi.kisi_ad}");
          print("Kişi yaş : ${gelenKisi.kisi_yas}");

        });
      }
    });
  }
  Future<void> degerAraligi() async{

    var sorgu = refKisiler.orderByChild("kisi_yas").startAt(18).endAt(40);

    sorgu.onValue.listen((event) {
      var gelenDegerler = event.snapshot.value;

      if(gelenDegerler != null){
        gelenDegerler.forEach((key,nesne){
          var gelenKisi = Kisiler.fromJson(nesne);
          print("************");
          print("Kişi key : $key");
          print("Kişi ad : ${gelenKisi.kisi_ad}");
          print("Kişi yaş : ${gelenKisi.kisi_yas}");

        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    //kisiEkle();
    //kisiSil();
    //kisiGuncelle();
    //tumKisiler();
    //tumKisilerOnce();
    //esitlikArama();
    //limitliVeri();
    degerAraligi();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[


          ],
        ),
      ),

    );
  }
}
