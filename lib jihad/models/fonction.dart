class Fonction {
  String id;
  String name;
  bool check = false;

  Fonction({this.id, this.name, this.check});

  factory Fonction.fromDoc(Map<String, dynamic> document) {

    print("jjdjdjdj");
    print(document);
    return new Fonction(
        id: document["objectId"], name: document["name"], check: false);
  }
}
