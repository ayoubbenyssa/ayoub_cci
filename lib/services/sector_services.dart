

import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/models/category_shop.dart';
import 'package:mycgem/models/commission.dart';
import 'package:mycgem/models/conseiler.dart';
import 'package:mycgem/models/sector.dart';

class SectorsServices {

static   ParseServer parseFunctions = new ParseServer();



static get_list_conseillers() async {
  String url = 'groupe_conseillers?order=ordre';
  var sect = await parseFunctions.getparse(url);
  if (sect == "No Internet") return "No Internet";
  if (sect == "error") return "error";
  List res =  sect["results"];
  return res.map((var contactRaw) => new Conseiller.fromMap(contactRaw))
      .toList();
}

   static get_list_sectors() async {
    String url = 'sectors?order=name';
    var sect = await parseFunctions.getparse(url);
    if (sect == "No Internet") return "No Internet";
    if (sect == "error") return "error";
    List res =  sect["results"];
    return res.map((var contactRaw) => new Sector.fromMap(contactRaw))
        .toList();
  }


static get_list_sectors1() async {
  String url = 'sectors_convention?order=name';
  var sect = await parseFunctions.getparse(url);
  if (sect == "No Internet") return "No Internet";
  if (sect == "error") return "error";
  List res =  sect["results"];
  return res.map((var contactRaw) => new Sector.fromMap(contactRaw))
      .toList();
}


static get_list_com() async {
  String url = 'commissions?order=order';
  var sect = await parseFunctions.getparse(url);
  if (sect == "No") return "No";
  if (sect == "error") return "error";
  List res =  sect["results"];
  return res.map((var contactRaw) => new Commission.fromDoc(contactRaw))
      .toList();
}




static get_list_fed() async {
  String url = 'federations?order=nme';
  var sect = await parseFunctions.getparse(url);
  if (sect == "No") return "No";
  if (sect == "error") return "error";
  List res =  sect["results"];
  return res.map((var contactRaw) => new Commission.fromDoc(contactRaw))
      .toList();
}





static get_list_category() async {

  String url = 'categories_shop';
  var sect = await parseFunctions.getparse(url);
  if (sect == "No Internet") return "No Internet";
  if (sect == "error") return "error";
  List res =  sect["results"];
  return res.map((var contactRaw) => new CategoryShop.fromMap(contactRaw))
      .toList();
}


}