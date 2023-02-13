

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Community{

  String id="";
  String name ="";
  var lat;
  var lng;
  String description="";
  var picture;
  double other_distance ;
  var distance;
  bool check = false;



  Community({
    this.id,
    this.name,
    this.lat,
    this.lng,
    this.description,
    this.picture,
    this.distance,this.check
});

  factory Community.fromDocument(DataSnapshot document) {
    return new Community(
      id: document.key,
      name: document.value["name"],
      distance: document.value["distance"],

      lat:document.value["latLng"].toString().split(";")[0],
      lng: document.value["latLng"].toString().split(";")[1],
      description: document.value['descriptions'],
      picture: document.value["pictures"].toString() == "null" ?"images/un.png":document.value["pictures"][0],
      check: false

    );
  }

  factory Community.fromDoc(DocumentSnapshot document) {
    return new Community(
      id: document.documentID,
      name: document["name"],
      distance: document["distance"],
      lat:document["latLng"].toString().split(";")[0],
      lng: document["latLng"].toString().split(";")[1],
      description: document['descriptions'],
      picture: document["pictures"].toString() == "null" ?"images/un.png":document["pictures"][0],
      check: false

    );
  }



  factory Community.fromMap(var document,String key) {
    return new Community(
       id: key,
      name: document["name"],
      distance: document["distance"],


      description: document['description'],
      picture: document["pictures"].toString() == "null" ?"images/un.png":document["pictures"][0],
      check: false

    );
  }

}