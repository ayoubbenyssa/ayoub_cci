import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mycgem/login/entreprise_form.dart';
import 'package:mycgem/login/entreprise_user.dart';
import 'package:mycgem/login/submit_name_organisme.dart';
import 'package:mycgem/models/fonction.dart';
import 'package:mycgem/user/edit_my_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mycgem/func/parsefunc.dart';

class RegisterService {
  static ParseServer parse_s = new ParseServer();

  static onLoading(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => new Dialog(
              child: new Container(
                padding: new EdgeInsets.all(16.0),
                width: 60.0,
                color: Colors.blue[200],
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    new CircularProgressIndicator(),
                    new Container(height: 8.0),
                    new Text(
                      "En cours ...",
                      style: new TextStyle(color: Colors.blue[600]),
                    ),
                  ],
                ),
              ),
            ));

    // Navigator.pop(context); //pop dialog
    //  _handleSubmitted();
  }

  static insert_user(String name, String familyname, email, context, id, photo,
      titre, organisme, auth, sign, list_partners, analytics, chng,
      {accessToken,
      idToken,
      password,
      phone,
      profession,
      region,
      lat,
      lng,
      addr,
      type_user,
      membre_new,
      city,
      verify,
      contact_id,
      resp,
      id_ent,
      Fonction fonction,
      zone,
      verify_code}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> map = new Map<String, dynamic>();
    map["id1"] = id;
    map["idblock"] = id;
    map["val_notif_pub"] = "on";
    map["notif_user"] = "on";
    map["val_notif_opp"] = "on";

    map["raja"] = true;
    map["active_loc"] = 0;
    map["membre_user"] = {
      "__type": "Pointer",
      "className": "membres",
      "objectId": id_ent
    };
    map["verify"] = contact_id == "" ? 0 : 1;
    map["firstname"] = name;
    map["competences"] = [];
    map["objectif"] = [];
    map["month"] = new DateTime.now().month;
    map["year"] = new DateTime.now().year;
    map["age"] = "";
    map["familyname"] = familyname;
    map["verify_code"] = verify_code;

    map["titre"] = titre;
    map["organisme"] = organisme;
    map["photoUrl"] = photo;
    if (accessToken != null) map["accessToken"] = accessToken;
    if (idToken != null) map["idToken"] = idToken;
    map["timestamp"] = new DateTime.now().millisecondsSinceEpoch;
    map["email"] = email;
    if (phone != null) map["phone"] = phone;
    map["active"] = 0;
    Map<String, dynamic> map1 = new Map<String, dynamic>();
    map["online"] = true;
    map["last_active"] = 0;
    map["fonction"] = fonction;
    await Firestore.instance.collection('users').document(id).setData(map1);
    if (contact_id == "") {
      var val = await parse_s.postparse("users", map);

      prefs.setString("id", val["objectId"]);
      print("yessssssssss");

      print(val["objectId"]);
    } else {
      var val = await parse_s.putparse("users/" + contact_id, map);

      print("yessssssssss");
      prefs.setString("id", contact_id);
      print(contact_id);
    }

    if (contact_id == "") {
      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
            builder: (BuildContext context) =>
                //new HomePage(widget.auth,widget.sign)
                new EditMyProfile(null, null, [], chng, membre_new),
          ));
    } else {
      Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) {
        return new EntrepriseForm(contact_id, "entreprise", chng, id_ent);
      }));
    }

    /* Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
            builder: (BuildContext context) =>
                new EditMyProfile(auth, sign, list_partners,chng),
          ));*/
    //else

    /* Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
            builder: (BuildContext context) =>
                new EditMyProfile(auth, sign, list_partners,null,analytics),
          ));*/
    //Navigator.pop(context);

    //return ref.documentID;
  }
}
