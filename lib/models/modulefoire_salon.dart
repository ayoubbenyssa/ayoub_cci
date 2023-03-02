class ModuleFoire_salon{
 String objectId ;
 String telephone ;
 String liblle ;
 String pays ;
 String lieu ;
 String updatedAt ;
 String date_debut ;
 List secteur_economique ;
 String organisateur ;
 List images ;
 String date_fin ;
 String website ;
 String createAt ;
 String email ;
 String fax ;

 ModuleFoire_salon({
   this.objectId ,
   this.telephone,
   this.liblle,
   this.pays ,
   this.lieu,
   this.updatedAt,
   this.date_debut,
   this.secteur_economique,
   this.organisateur,
   this.images,
   this.date_fin,
   this.website,
   this.createAt ,
   this.email,
   this.fax,
});
 ModuleFoire_salon.fromMap(Map<String, dynamic> document) :

     //id: document.documentID,
     objectId = document["objectId"],
     telephone = document["telephone"],
     liblle = document["liblle"],
     pays = document["pays"],
     lieu = document["lieu"],
     updatedAt = document["updatedAt"],
     date_debut = document["date_debut"],
     secteur_economique = document["secteur_economique"],
     organisateur = document["organisateur"],
     images = document["images"],
     date_fin = document["date_fin"],
     website = document["website"],
     createAt = document["createAt"],
     email = document["email"];

}