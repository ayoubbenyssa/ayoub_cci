class Formation_model {
  //String id;
  String obj = "";
  String date_formation ;
  String telephone ;
  bool payant ;
  String lieu ;
  String fichier ;
  String updateAt ;
  String title ;
  String createAt ;
  String email ;
  String description ;
  Formation_model({this.obj, this.date_formation, this.telephone,this.payant,this.lieu,this.fichier,this.updateAt,this.title,this.createAt,this.email,this.description});
  Formation_model.fromMap(Map<String, dynamic> map)
      :
        obj = "${map['objectId']}",
        date_formation = "${map['date_formation']}",
        telephone = "${map['telephone']}",
        payant = "${map['payante']}" == "true" ? true : false,
        lieu = "${map['lieu']}",
        fichier = "${map['createdAt']}",
        updateAt = "${map['updatedAt']}",
        title = "${map['titre']}",
        createAt = "${map['createdAt']}",
        email = "${map['email']}",
        description = "${map['description']}";
}