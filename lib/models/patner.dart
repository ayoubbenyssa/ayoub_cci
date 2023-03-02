
class Partnr {
  //String id;
  String name = "";
  String date;
  String country = "";


  Partnr({this.date, this.name, this.country});
  Partnr.fromMap(Map<String, dynamic> map)
      : date = "${map['createdAt']}",
        name = "${map['rs']}",
        country = "${map['pays']}";
}
