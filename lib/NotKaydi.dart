import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basari_notlari_app_firebase/main.dart';



class NotKayit extends StatefulWidget {
  const NotKayit({Key? key}) : super(key: key);

  @override
  State<NotKayit> createState() => _NotKayitState();
}

class _NotKayitState extends State<NotKayit> {

  var tfDersAdi = TextEditingController();
  var tfNot1 = TextEditingController();
  var tfNot2 = TextEditingController();

  var refNotlar = FirebaseDatabase.instance.ref().child("notlar");


  Future<void> kayit(String ders_adi, num not1, num not2) async{
    var bilgi = HashMap<String, dynamic>();
    bilgi["not_id"]="";
    bilgi["ders_adi"]=ders_adi;
    bilgi["not1"]=not1;
    bilgi["not2"]=not2;

    refNotlar.push().set(bilgi);

    // ignore: use_build_context_synchronously
    Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa()));
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGrey4,
      appBar: AppBar(
        title: Text("Not Kayıt",style: TextStyle(color: Colors.indigo.shade800),),
      ),
      body: Center(
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

      floatingActionButton:  FloatingActionButton.extended(
        onPressed: (){
          kayit(tfDersAdi.text, num.parse(tfNot1.text),  num.parse(tfNot2.text));
        },
        tooltip: 'Not Kayıt',
        icon: const Icon(Icons.save, color: CupertinoColors.systemGrey4,),
        label: Text("Kaydet",style: TextStyle(color: Colors.indigo.shade800),),
      ),
    );
  }
}
