class Conseiller {
  String id;
  String name;
  String title;
  String picture;
  String document;

  Conseiller(
      {this.id, this.name, this.title, this.document, this.picture});

  factory Conseiller.fromMap(Map<String, dynamic> document) {
    return new Conseiller(
        id: document["objectId"],
        name: document["name"],
        document: document["document"],
        title: document["title"],
        picture: document["picture"]);
  }
}
