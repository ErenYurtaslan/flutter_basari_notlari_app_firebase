import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basari_notlari_app_firebase/NotDetayi.dart';
import 'package:flutter_basari_notlari_app_firebase/NotKaydi.dart';
import 'package:flutter_basari_notlari_app_firebase/Notlar.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});



  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  var refNotlar = FirebaseDatabase.instance.ref().child("notlar");

  Future<bool> closeApp() async{
    exit(0);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: CupertinoColors.systemGrey4,



      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            closeApp();
          }, icon: const Icon(Icons.arrow_back_ios, color: CupertinoColors.systemGrey4,),),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Notlar Uygulaması", style: TextStyle(color: Colors.indigo.shade800, fontSize: 16),),
            StreamBuilder<DatabaseEvent>(
              stream: refNotlar.onValue,
              builder: (context, event){
                if(event.hasData){
                  var notlarListesi =<Notlar>[];
                  var gelenDeger = event.data!.snapshot.value as dynamic;
                  if(gelenDeger != null){
                    gelenDeger.forEach((key, nesne){
                      var gelenNot = Notlar.fromJson(key, nesne);
                      notlarListesi.add(gelenNot);
                    });
                  }

                  double ortalama = 0.0;

                  if(notlarListesi.isNotEmpty){
                    double toplam = 0.0;

                    for(var n in notlarListesi){
                      toplam = toplam + (n.not1+n.not2)/2;
                    }

                    ortalama = toplam/notlarListesi.length;

                  }

                  return  Text("Ortalama : $ortalama", style: TextStyle(color: Colors.indigo.shade800, fontSize: 14),);


                }else{
                  return  Text("Ortalama : null", style: TextStyle(color: Colors.indigo.shade800, fontSize: 14),);

                }
              },
            ),
          ],
        ),
      ),






      body: WillPopScope(
        onWillPop: closeApp,
        child: StreamBuilder<DatabaseEvent>(
            stream: refNotlar.onValue,
            builder: (context, event){
              if(event.hasData){
                var notlarListesi =<Notlar>[];
                var gelenDeger = event.data!.snapshot.value as dynamic;
                if(gelenDeger != null){
                  gelenDeger.forEach((key, nesne){
                    var gelenNot = Notlar.fromJson(key, nesne);
                    notlarListesi.add(gelenNot);
                  });
                }
                return ListView.builder(
                    itemCount: notlarListesi.length,
                    itemBuilder: (context, index){
                      var not = notlarListesi[index];

                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NotDetay(not: not,)));
                        },
                        child: Card(
                          color: Colors.cyanAccent,
                          child: SizedBox(
                            height: 55,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(not.ders_adi, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo.shade800),),
                                Text(not.not1.toString(), style: TextStyle(fontWeight: FontWeight.normal, color: Colors.indigo.shade800),),
                                Text(not.not2.toString(), style: TextStyle(fontWeight: FontWeight.normal, color: Colors.indigo.shade800),),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                );
              }else{
                return const Center();
              }
            }
        ),
      ),


      floatingActionButton:  FloatingActionButton(
        backgroundColor: Colors.indigo.shade700,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  const NotKayit()));
        },
        tooltip: 'Not Ekle',
        child: const Icon(Icons.add, color: CupertinoColors.systemGrey4,),
      ),


    );
  }
}
