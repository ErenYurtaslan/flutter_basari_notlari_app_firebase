class Notlar{
  String not_id;
  String ders_adi;
  num not1;
  num not2;

  Notlar(this.not_id, this.ders_adi, this.not1, this.not2);

  factory Notlar.fromJson(String key, Map<dynamic,dynamic> json){
    return Notlar(key, json["ders_adi"] as String, json["not1"] as num, json["not2"] as num );
  }
}