
import 'package:mycgem/models/commission.dart';
import 'package:mycgem/models/fonction.dart';
import 'package:mycgem/models/membre.dart';

class User {
  var val_notif_opp;
  var notif_user;
  Fonction fonction;

  User(
      {this.fullname,
        this.id,
        this.image,
        this.val_notif_opp,
        this.val_notif_pub,
        this.notif_user,
        this.civilite,
        this.email,
        this.respons,
        this.fonction,
        this.mm,
        this.bio,
        this.fed,
        this.verify_code,
        this.timestamp,
        this.phone,
        this.prenom,
        this.type_profil,
        this.firstname,
        this.item,
        this.updatedAt,
        // this.titre,
        this.organisme,
        this.sexe,
        this.age,
        this.des,
        this.objectif,
        this.cmpetences,
        this.block_list,
        this.org_type,
        this.org_id,
        this.emails,
        this.connect_list,
        this.auth_id,
        this.lat,
        this.token,
        this.entreprise,
        this.createdAt,
        this.lng,
        this.online,
        this.type_membre,
        this.location,
        this.ent,
        this.community,
        this.last_active,
        this.linkedin_link,
        this.communitykey,
        this.instargram_link,
        this.twitter_link,
        this.received_list,
        this.new_membre,
        this.active,
        this.commissions_list,
        this.commissions,
        this.verify,
        this.rl,
        this.raja,
        this.anne_exp,
        this.active_loc,
        this.niveau});

  var updatedAt;

  bool new_membre;
  var val_notif_pub;

  String id = "";
  String niveau;
  String phone = "";
  String civilite;
  List<dynamic> commissions_list;
  List<dynamic> commissions;
  List<dynamic> fed;
  var respons;
  bool rl;
  List<String> emails = [];

  bool raja;
  var active_loc;
  String org_type;
  String org_id;
  var mm = false;
  String password = "";
  String prenom = "";
  String fullname = "";
  String email = "";
  String image = "";
  String bio = "";
  String firstname;
  String linkedin_link;
  String instargram_link;
  String twitter_link;
  bool read;
  var notif_time;
  int ind = 0;
  Membre entreprise;
  var createdAt;
  String notif_id;
  bool accept;
  var type_req;
  var id_publication;
  var message;
  var type_profil;
  String type_membre;
  var token = "";
  var confirm;
  var item;

  // String titre = "";
  String organisme = "";
  String sexe;
  var age;
  String anne_exp;
  List<String> cmpetences;
  var objectif;
  String community;
  List<String> list = new List<String>();
  List<String> list_obj = new List<String>();
  var location;
  var lat;
  var online = false;
  var lng;
  String offline = "";
  int last_active = 1;
  String dis;
  var tt = "";
  var active;
  var auth_id;
  bool show = true;
  bool block = true;
  var block_list;
  var connect_list;
  var received_list;
  var communitykey;
  String id_other;
  bool activate = true;
  bool wait = false;
  bool begin = true;
  var cnt = "";
  var ent;
  var verify;
  var des;
  var verify_code;

  var medz;
  var timestamp;

  static Map<dynamic, dynamic> toMap(User user) => {
    "id1": user.auth_id,
    "token": user.token,
    "objectId": user.id,
    "createdAt": user.createdAt,
    'anne_exp': user.anne_exp,
    "last_active": user.last_active,
    "communityName": user.community,
    "communityKey": user.communitykey,
    //'titre': user.titre,
    "lat": double.parse(user.lat),
    "lng": double.parse(user.lng),
    "phone": user.phone,
    "active": int.parse(user.active),
    "location": user.location,
    "linkedin_link": user.linkedin_link,
    "instagram_link": user.instargram_link,
    "twitter_link": user.twitter_link,
    "organisme": user.organisme,
    "familyname": user.fullname,
    "objectif": user.objectif,
    "firstname": user.firstname,
    "age": user.age,
    "email": user.email,
    'sexe': user.sexe,
    "competences": user.cmpetences,
    "bio": user.bio,
    "photoUrl": user.image
  };

  factory User.fromMap(var document) {
    return new User(
        auth_id: document["id1"],
        verify_code: document["verify_code"],

        updatedAt: document["updatedAt"],
        org_type: document["org_type"],
        org_id: document["org_id"],
        civilite: document["civility"],
        rl: document["rl"],
        val_notif_pub: document["val_notif_pub"] != "off" ? true : false,
        notif_user: document["notif_user"] != "off" ? true : false,
        val_notif_opp: document["val_notif_opp"] != "off" ? true : false,

        type_membre: document["type_membre"],
        token: document["token"],
        respons: document["respons"],

        commissions_list: document["commissions_list"].toString() == "null"
        ? []
            : document["commissions_list"],
        commissions: document["commissions"].toString() == "null"
        ? []
            : document["commissions"]
        .map((val) => Commission.fromDoc(val))
        .toList(),
    fed: document["fed"].toString() == "null"
    ? []
        : document["fed"].map((val) => Commission.fromDoc(val)).toList(),
    verify: document["verify"],
    id: document["objectId"],
    type_profil: document["type_profil"],
    createdAt: document["createdAt"],
    active_loc: document["active_loc"],
    anne_exp: document['anne_exp'],
    entreprise: document["membre_user"].toString() == "null"
    ? null
        : new Membre.fromMap(document["membre_user"]),
    ent: document["ent"],
    niveau: document["niveau"],
    raja: document["raja"],
    des: document["des"],
    community:
    document["communityName"] == null ? "" : document["communityName"],
    communitykey:
    document["communityKey"] == null ? "" : document["communityKey"],
    fonction: document['fonction'].toString() == "null"
    ? Fonction(name: document["titre"] == null?"":document["titre"], id: "")
        : Fonction.fromDoc(document['fonction']),
    lat: document["lat"].toString() == "null"
    ? ""
        : document["lat"].toString(),
    lng: document["lng"].toString() == "null"
    ? ""
        : document["lng"].toString(),
    phone: document['phone'].toString() == "null" ? "" : document['phone'],
    active: document["active"] == null ? 0 : document["active"],
    location:
    document["location"].toString() == "null" ? "" : document["location"],
    linkedin_link:
    document['linkedin_link'] == "null" ? "" : document['linkedin_link'],
    instargram_link: document['instagram_link'] == "null"
    ? ""
        : document['instagram_link'],
    twitter_link:
    document['twitter_link'] == "null" ? "" : document['twitter_link'],

    organisme: document['organisme'].toString() == "null"
    ? ""
        : document['organisme'],
    fullname: document['familyname'],
    firstname: document['firstname'],
    objectif:
    document["objectif"].toString() == "null" ? [] : document["objectif"],
    age: document["age"].toString() == "null"
    ? ""
        : document["age"].toString(),
    email: document['email'],
    sexe: document['sexe'].toString() == "null" ? "" : document['sexe'],
    //online: document["online"],
    cmpetences: document["competences"].toString() == "null"
    ? List<String>.from([])
        : List<String>.from(document["competences"]),

    bio: document['bio'],

    image:
    document['photoUrl'].toString() == "null" ? "" : document['photoUrl'],
    );
    }

/*  factory User.fromDoc(var document) {
    return new User(
      id: document.documentID,
      verify: document["verify"],

      community:
      document["communityName"] == null ? "" : document["communityName"],
      titre: document['titre'],
      lat: document["lat"],
      lng: document["lng"],
      phone: document['phone'],
      active: document["active"],
      location: document["location"],
      linkedin_link: document['linkedin_link'],
      organisme: document['organisme'],
      fullname: document['familyname'],
      firstname: document['firstname'],
      objectif: document["objectif"],
      //  date_naissance: document["date_naissance"],
      email: document['email'],
      sexe: document['sexe'],
      image: document['photoUrl'],
      item: new DecorationImage(
        image: new NetworkImage(document['photoUrl']),
        fit: BoxFit.cover,
      ),
    );
  }

  factory User.fromDocument(DocumentSnapshot document) {
    return new User(
        community: document["communityName"],
        email: document['email'],
        titre: document['titre'],
        sexe: document['sexe'],
        objectif: document["objectif"],
        cmpetences: document["competences"],
        //date_naissance: document["date_naissance"],
        organisme: document['organisme'],
        anne_exp: document['anne_exp'],
        timestamp: document["timestamp"],
        fullname: document['familyname'],
        firstname: document['firstname'],
        phone: document['phone'],
        image: document['photoUrl'],
        emails: document["emails"].toString() == '[""]'
            ? []
            : List<String>.from(document["emails"]),
        id: document.documentID,
        bio: document['bio'],
        item: new DecorationImage(
          image: new NetworkImage(document['photoUrl']),
          fit: BoxFit.cover,
        ));
  }*/
}
