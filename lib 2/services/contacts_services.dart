import 'dart:convert';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/models/membre.dart';
import 'package:mycgem/models/objectif.dart';
import 'package:mycgem/models/partner.dart';
import 'package:mycgem/models/pro.dart';
import 'package:mycgem/models/region.dart';
import 'package:mycgem/models/resp.dart';
import 'package:mycgem/models/shop.dart';
import 'package:mycgem/models/ville.dart';

class Contacts_services {
  static ParseServer parse_s = new ParseServer();

  /*static get_list_contacts_by_id_membre(String id_membre) async {
    //,"sponsored":1
    String url = 'contacts?where={"id_membre":"$id_membre"}&order=-createdAt';
    var getres = await parse_s.getparse(url);
    if (getres == "No") return "No";
    if (getres == "error") return "error";
    List res = getres["results"];

    return res
        .map((var contactRaw) => new Contact.fromMap(contactRaw))
        .toList();

  }*/

}