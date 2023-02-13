class Resp {
  String id;
  String name;
  String img;
  bool check = false;

  Resp({this.id, this.name, this.img, this.check});

  factory Resp.fromDoc(Map<String, dynamic> document) {
    return new Resp(
        id: document["objectId"],
        name: document["name"],
        img: document["picture"],
        check: false);
  }
}
