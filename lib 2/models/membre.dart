import 'package:intl/intl.dart';
import 'package:mycgem/models/commission.dart';
import 'package:mycgem/models/region.dart';
import 'package:mycgem/models/sector.dart';
import 'package:mycgem/models/ville.dart';

class Membre {
  var objectId;
  String nadh;
  String ice;
  String tel;
  String pays;

  var status;
  String phone;

  ///pointer de type statuts

  List<Sector> sectors = [];
  Region region; //Pointer
  String situation;
  String activities;
  Ville ville;

  String fonction;
  var address = "";
  var createdDate = "";
  var description = "";
  var email = "";
  var name = "";
  var logo = "";
  String im;

  Commission federation;
  List<String> tels = [];
  List<String> emails = [];
  List<String> fax = [];
  int active = 1;

  bool liked = false;
  var numberlikes;
  bool wait = false;
  var cnt = "";
  bool begin = true;
  bool check = false;

  Membre({
    this.objectId,
    this.nadh,
    this.ice,
    this.fonction,
    this.status,
    this.tel,
    this.ville,
    this.sectors,
    this.region,
    this.pays,
    this.situation,
    this.tels,
    this.emails,
    this.fax,
    this.address,
    this.createdDate,
    this.federation,
    this.phone = "",
    this.activities,
    this.description,
    this.name,
    this.logo,
    this.email,
  });

  Membre.fromMap(Map<String, dynamic> document)
      : objectId = document["objectId"].toString(),
        fonction = document["lib_f"].toString(),
        pays = document["pays"].toString(),
        activities = document["activities"].toString() == "null"
            ? ""
            : document["activities"].toString(),
        ice = document["ice"].toString(),
        status = document["status"].toString(),
        tel = document["tel"],
       /* sectors = document["sectors"].toString() == "null"
            ? []
            : List<Sector>.from(
            document["sectors"].map((val) => Sector.fromMap(val)).toList()),*/
        ville = document["ville"].toString()=='null'?null: Ville.fromMap(document["ville"]),
        region = document["region"].toString() == "null"
            ? null
            : new Region.fromMap(document["region"]),
        situation = document["situation"].toString(),


        address = document["address"].toString(),

        createdDate = document["createdDate"].toString(),
        federation = document["federation"].toString() == "null"
            ? null
            : new Commission.fromDoc(document["federation"]),
        description = document["description"].toString(),
        name = document["rs"].toString(),
        im = document["logo"],
        logo =  document["imageUrl"].toString();
}
/*
class Contact {
  var objectId;
  List<String> emails = [];
  var name = "";
  var nom = "";
  var prenom = "";
  String fonction;
  String email;
  Membre membre;
  bool new_membre;

  /// Pointer

  var logo = "";

  String organisme;
  var object_id; //for user non verifié

  Contact(
      {this.objectId,
      this.object_id,
      this.name,
      this.nom,
      this.new_membre,
      this.prenom,
      this.emails,
      this.fonction,
      this.membre,
      this.organisme,
      this.email});

  Contact.fromMap(Map<String, dynamic> document)
      : objectId = document["objectId"].toString(),
        name = document["name"],
        nom = document["nom"],
        fonction = document["fonction"].toString() == "null"
            ? ""
            : document["fonction"]["name"],
        prenom = document["prenom"],
        membre = document["membre"] == null
            ? null
            : Membre.fromMap(document["membre"]),
        emails = document["emails"].toString() == '[""]'
            ? []
            : List<String>.from(document["emails"]);
}
*/

