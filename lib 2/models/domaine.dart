
class Domaine{

  String id;
  String name;
  bool isselected = false;



  Domaine({
    this.id,
    this.isselected, this.name

  });



  factory Domaine.fromDoc(Map<String,dynamic> document) {
    return new Domaine(
      //id: document.documentID,
      name: document["name"],
      id: document["id"],
      isselected: false




    );
  }

}