import 'dart:convert';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/models/domaine.dart';
import 'package:mycgem/models/fonction.dart';
import 'package:mycgem/models/membre.dart';
import 'package:mycgem/models/objectif.dart';
import 'package:mycgem/models/partner.dart';
import 'package:mycgem/models/pro.dart';
import 'package:mycgem/models/region.dart';
import 'package:mycgem/models/resp.dart';
import 'package:mycgem/models/shop.dart';
import 'package:mycgem/models/ville.dart';

class PartnersList {
  static ParseServer parse_s = new ParseServer();

  static get_list_partners() async {
    //,"sponsored":1
    String url = 'partners?where={"active":1}&order=-createdAt';
    var getc = await parse_s.getparse(url);
    if (getc == "No") return "No";
    if (getc == "error") return "error";
    List res = getc["results"];

    return res
        .map((var contactRaw) => new Membre.fromMap(contactRaw))
        .toList();
  }


  /*static get_list_partnerssss() async {
    //,"sponsored":1
    String url = 'partners?order=createdAt&limit=300&skip=500';
    var getc = await parse_s.getparse(url);
    if (getc == "No") return "No";
    if (getc == "error") return "error";
    List res = getc["results"];

    return res
        .map((var contactRaw) => new Partner.fromMap(contactRaw))
        .toList();
  }*/

  static get_list_entreprise(skip) async {
    //,"sponsored":1
    String url =
        'partners?where={"active":1,"type":"entreprise","imageUrl":{"\$ne":"https://res.cloudinary.com/dgxctjlpx/image/upload/v1565012657/placeholder_2_seeta8.png"}}&order=-createdAt&limit=24&skip=$skip';

    var getcity = await parse_s.getparse(url);
    if (getcity == "No") return "No";
    if (getcity == "error") return "error";
    List res = getcity["results"];

    return res
        .map((var contactRaw) => new Membre.fromMap(contactRaw))
        .toList();
  }



  static get_list_fonctions() async {
    String url =
        'Fonction?order=createdAt';
    var res1 = await parse_s.getparse(url);
    if (res1 == "No") return "No";
    if (res1 == "error") return "error";
    List res = res1["results"];

    print(res);

    return res
        .map((var contactRaw) => new Fonction.fromDoc(contactRaw))
        .toList();
  }



  static get_list_entreprise12(skip) async {
    //,"sponsored":1
    String url =
        'membres?order=nme&limit=7000';///where={"active":1}&
    var getcity = await parse_s.getparse(url);
    if (getcity == "No") return "No";
    if (getcity == "error") return "error";
    List res = getcity["results"];

    print(res);

    return res
        .map((var contactRaw) => new Membre.fromMap(contactRaw))
        .toList();
  }


  static get_list_entreprise1(skip) async {
    //,"sponsored":1
    String url =
        'membres?where={"active":1}&order=nme&limit=30400&skip=$skip&include=ville&include=sectors';
    var getcity = await parse_s.getparse(url);
    if (getcity == "No") return "No";
    if (getcity == "error") return "error";
    List res = getcity["results"];

    print(res);

    return res
        .map((var contactRaw) => new Membre.fromMap(contactRaw))
        .toList();
  }

  static get_list_resp(skip) async {
    //,"sponsored":1
    String url = 'responsabilities?order=-createdAt&limit=3400';
    var getcity = await parse_s.getparse(url);
    if (getcity == "No") return "No";
    if (getcity == "error") return "error";
    List res = getcity["results"];

    return res.map((var contactRaw) => new Resp.fromDoc(contactRaw)).toList();
  }

  static get_list_regions() async {
    //,"sponsored":1
    String url = 'regions?order=region&limit=3400';
    var getcity = await parse_s.getparse(url);
    if (getcity == "No") return "No";
    if (getcity == "error") return "error";
    List res = getcity["results"];

    return res.map((var contactRaw) => new Region.fromMap(contactRaw)).toList();
  }

  static get_list_ss_regions() async {
    //,"sponsored":1
    String url = 'region13?order=-createdAt&limit=3400';
    var getcity = await parse_s.getparse(url);
    if (getcity == "No") return "No";
    if (getcity == "error") return "error";
    List res = getcity["results"];

    return res
        .map((var contactRaw) => new SSRegion.fromMap(contactRaw))
        .toList();
  }


  static get_list_ville_all() async {
    //,"sponsored":1
    print(num);
    String url =
        'ville?order=slug&limit=3400';
    var getcity = await parse_s.getparse(url);
    if (getcity == "No") return "No";
    if (getcity == "error") return "error";
    List res = getcity["results"];

    print(res);
    return res.map((var contactRaw) => new Ville.fromMap(contactRaw)).toList();
  }


  static get_list_ville(num) async {
    //,"sponsored":1
    print(num);
    String url =
        'ville?where={"region_id":{"\$inQuery":{"where":{"objectId":"$num"},"className":"region"}}}&order=-createdAt&limit=3400';
    var getcity = await parse_s.getparse(url);
    if (getcity == "No") return "No";
    if (getcity == "error") return "error";
    List res = getcity["results"];

    print(res);
    return res.map((var contactRaw) => new Ville.fromMap(contactRaw)).toList();
  }

  static get_domains() async {
    String url = 'Domaines_expertise';
    var getcity = await parse_s.getparse(url);

    if (getcity == "No Internet") return "No Internet";
    if (getcity == "error") return "error";
    List res = getcity["results"];
    return res
        .map((var contactRaw) => new Domaine.fromDoc(contactRaw))
        .toList();
  }

  static get_objectifs() async {
    String url = 'objectifs2';
    var getcity = await parse_s.getparse(url);

    if (getcity == "No Internet") return "No Internet";
    if (getcity == "error") return "error";
    List res = getcity["results"];
    return res
        .map((var contactRaw) => new Objectif.fromDoc(contactRaw))
        .toList();
  }

  static get_type() async {
    String url = 'type_pro1';
    var getcity = await parse_s.getparse(url);
    print(getcity);
    if (getcity == "No") return "No";
    if (getcity == "error") return "error";
    List res = getcity["results"];
    return res.map((var contactRaw) => new Pro.fromDoc(contactRaw)).toList();
  }

  static get_list_shop(id, objectId) async {
    String url = "";
    if (id.toString() == "null") {
      url = 'offers?where={"partnerKey":"$objectId","type":"shop"}';
    } else {
      url =
          'offers?where= {"\$or":[{"partnerKey":{"\$eq":"$id"}},{"partnerKey":{"\$eq":"$objectId"}}],"type":"shop"}';
    }
    var getcity = await parse_s.getparse(url);
    if (getcity == "No Internet") return "No Internet";
    if (getcity == "error") return "error";
    List res = getcity["results"];
    return res.map((var contactRaw) => new Shop.fromMap(contactRaw)).toList();
  }

  static getShp_details(id, objectId) async {
    String url =
        'shops?where= {"\$or":[{"partnerKey":{"\$eq":"$id"}},{"partnerKey":{"\$eq":"$objectId"}}]}';
    var getcity = await parse_s.getparse(url);
    if (getcity == "No Internet") return "No Internet";
    if (getcity == "error") return "error";
    var res = getcity["results"][0];
    return new Shop.fromMap(res);
  }
}
