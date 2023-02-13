

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Chat{

  String idUser="";
  String audio ="";
  String messageText ;
  var lat;
  var lng;


  var imageUrl;
  var timestamp;



  Chat({
    this.idUser,
    this.audio,
    this.messageText,
    this.lat,
    this.lng,
    this.imageUrl,
    this.timestamp,
  });

  factory Chat.fromDocument(DataSnapshot document) {
    return new Chat(
        idUser: document.value["idUser"],
        audio: document.value["audio"],
        messageText: document.value["messageText"],
        lat: document.value["latLng"].toString() != "null" ?document.value["latLng"].toString().split(";")[0]:0.0,
        lng: document.value["latLng"].toString() != "null"? document.value["latLng"].toString().split(";")[1]:0.0,
        imageUrl: document.value['imageUrl'],
        timestamp: document.value["timestamp"],

    );
  }

  /*factory Chat.fromDoc(DocumentSnapshot document) {
    return new Chat(
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



  factory Chat.fromMap(var document,String key) {
    return new Chat(
       // id: key,
        name: document["name"],
        distance: document["distance"],


        description: document['description'],
        picture: document["pictures"].toString() == "null" ?"images/un.png":document["pictures"][0],
        check: false

    );
  }
*/
}