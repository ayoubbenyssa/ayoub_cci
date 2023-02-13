import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String objectId;
  String release_date;
  String num_views;
  bool isselected = false;
  var link;
  var img;
  String title;
  var isLiked;
  var likesCount;
  var numbercommenttext;
  var type;
  var partner;
  var liked;
  var numberlikes;
  var author;

  Video(
      {this.objectId,
      this.release_date,
      this.num_views,
      this.link,
      this.img,
        this.isLiked,
      this.title});

  factory Video.fromMap(Map<String, dynamic> document) {
    return new Video(
      objectId: document["objectId"],
      release_date: document["release_date"],
      num_views: document["num_views"],
      isLiked: false,
      link: "https://www.youtube.com"+document["link"],
      title: document["title"],
      img: document["img"],
    );
  }
}
