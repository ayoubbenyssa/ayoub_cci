class Ville {
  String id;
  String name;
  var num;
  bool check = false;

  Ville(this.id, this.name, this.num);

  Ville.fromMap(Map<String, dynamic> map)
      : id = map["objectId"],
        name = map["ville"],
        check = false,
        num = map["num"];
}
