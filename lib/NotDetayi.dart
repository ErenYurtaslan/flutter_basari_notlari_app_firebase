import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basari_notlari_app_firebase/Notlar.dart';


import 'main.dart';

class NotDetay extends StatefulWidget {

  Notlar not;

  NotDetay({required this.not});

  @override
  State<NotDetay> createState() => _NotDetayState();
}

class _NotDetayState extends State<NotDetay> {

  var tfDersAdi = TextEditingController();
  var tfNot1 = TextEditingController();
  var tfNot2 = TextEditingController();

  var refNotlar = FirebaseDatabase.instance.ref().child("notlar");


  Future<void> sil(String not_id) async{
    refNotlar.child(not_id).remove();

    // ignore: use_build_context_synchronously
    Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa()));
  }

  Future<void> guncelle(String not_id, String ders_adi, num not1, num not2) async{
    var bilgi = HashMap<String, dynamic>();
    bilgi["ders_adi"]=ders_adi;
    bilgi["not1"]=not1;
    bilgi["not2"]=not2;

    refNotlar.child(not_id).update(bilgi);

    // ignore: use_build_context_synchronously
    Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa()));
  }



  @override
  void initState() {
    super.initState();

    var not = widget.not;
    tfDersAdi.text = not.ders_adi;
    tfNot1.text = not.not1.toString();
    tfNot2.text = not.not2.toString();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGrey4,
      appBar: AppBar(
        title:  Text("Not Detayı",style: TextStyle(color: Colors.indigo.shade800),),
        actions: [


          TextButton(
            onPressed: (){
              sil(widget.not.not_id);
            },
            child: Text("Sil",style: TextStyle(color: Colors.indigo.shade800),),),


          TextButton(
              onPressed: (){
                guncelle(widget.not.not_id, tfDersAdi.text, num.parse(tfNot1.text),  num.parse(tfNot2.text));
              },
              child: Text("Güncelle",style: TextStyle(color: Colors.indigo.shade800),))
        ],



      ),






      body:  Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 43.0, right: 43.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:  <Widget>[
              TextField(
                controller: tfDersAdi,
                decoration: InputDecoration(hintText: "Ders Adı"),
              ),
              TextField(
                controller: tfNot1,
                decoration: InputDecoration(hintText: "Vize"),
              ),
              TextField(
                controller: tfNot2,
                decoration: InputDecoration(hintText: "Final"),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
