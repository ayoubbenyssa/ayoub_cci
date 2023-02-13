import 'package:flutter/material.dart';
import 'package:mycgem/cards/shop_item.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/shop.dart';
import 'package:mycgem/services/partners_list.dart';
import 'package:mycgem/widgets/widgets.dart';

class ShopLIst extends StatefulWidget {
  ShopLIst(this.id, this.objectId,this.lat,this.lng);

  String id;
  String objectId;
  var lat;var  lng;


  @override
  _UserListsResultsState createState() => _UserListsResultsState();
}

class _UserListsResultsState extends State<ShopLIst> {
  List<Shop> btq = new List<Shop>();
  bool loading = true;
  int count = 0;

  @override
  void initState() {
    super.initState();

    PartnersList.get_list_shop(widget.id, widget.objectId).then((val) {
      setState(() {
        loading = false;
        btq = val;

        count = btq.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
        appBar: new AppBar(
          title: new Text("Nos boutiques"),
        ),
        body: loading == true
            ? Widgets.load()
            : count == 0
            ? new Center(child: new Text(LinkomTexts.of(context).aucun()))
            : new ListView(
          children: btq.map((Shop shop) {
            return ShopItem(shop,widget.lat,widget.lng);
          }).toList(),
        ));
  }
}
