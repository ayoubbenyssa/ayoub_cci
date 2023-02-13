class Serv {
  String id;
  String name;
  String desc;
  String name_ar;
  String desc_ar;
  String lien;
  String img;

  Serv(this.id, this.name, this.desc, this.lien);

  Serv.fromMap(Map<String, dynamic> map)
      : id = map["objectId"],
        desc = map["description"],
        desc_ar = map["desc_ar"],
        img = map["img"],
        lien = map["lien"],
        name_ar = map["name_ar"],
        name = map["name"];
}
