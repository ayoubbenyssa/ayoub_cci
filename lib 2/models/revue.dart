import 'package:cloud_firestore/cloud_firestore.dart';

class Revue {
  String objectId;
  String date;
  bool isselected = false;
  var url;
  String img;
  String title;
  var isLiked;
  var likesCount;
  var numbercommenttext;
  var type;
  var partner;
  var liked;
  var numberlikes;
  var author;

  Revue(
      {this.objectId, this.date, this.url, this.img, this.isLiked, this.title});

  factory Revue.fromMap(Map<String, dynamic> document) {
    return new Revue(
      objectId: document["objectId"],
      date: document["date"],
      isLiked: false,
      url: "https://www.cgem.ma/" + document["url"],
      title: document["title"],
      img: "https://www.cgem.ma/" + document["image"],
    );
  }
}
