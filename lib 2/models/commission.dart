import 'package:cloud_firestore/cloud_firestore.dart';

class Commission {
  String id;
  String name;
  String sectorName;

  var name_ar;
  var desc_ar;
  String img;
  String vice_chef;
  String vice_image;
  String chef_image;
  String address;
  String tel;
  String fax;
  String email;
  String chef_civilite;
  String vice_civilite;

  bool isselected = false;
  String objectId;
  bool check = false;
  var description;
  var docUrl;
  var chef;

  Commission({this.id,
    this.name,
    this.img,
    this.objectId,
    this.docUrl,
    this.description,
    this.chef,
    this.name_ar,
    this.desc_ar,
    this.chef_civilite,
    this.vice_civilite,
    this.chef_image,
    this.vice_chef,
    this.vice_image, this.address, this.email, this.fax, this.tel, this.sectorName});

  factory Commission.fromDoc(Map<String, dynamic> document) {
    return new Commission(
        objectId: document["objectId"],
        id: document["objectId"],
        sectorName: document["sectorName"],
        tel: document["tel"],
        fax: document["fax"],
        address: document["address"],
        email: document["email"],
        name: document["name"],
        name_ar: document["name_ar"],
        desc_ar: document["desc_ar"],
        chef_civilite : document["chef_civilite"],
        vice_civilite : document["vice_civilite"],
        img: document["picture"],
        description: document["description"],
        docUrl: document["docUrl"],
        vice_chef: document["vice_chef"],
        chef_image: document["chef_image"],
        vice_image: document["vice_image"],
        chef: document["chef"]);
  }
}
