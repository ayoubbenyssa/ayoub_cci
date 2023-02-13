import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/sector.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/parc_events_stream/parc_events_stream.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/sector_services.dart';
import 'package:mycgem/teeeeest.dart';
import 'package:mycgem/widgets/fixdropdown.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Conventions extends StatefulWidget {
  Conventions(this.lat, this.lng, this.user, this.list_partner, this.analytics,
      this.type_promo, this.chng);

  var lat, lng;
  User user;
  List list_partner;
  var analytics;
  var type_promo;
  var chng;

  @override
  _ParcState createState() => _ParcState();
}

class _ParcState extends State<Conventions>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  bool _menuShown = false;

  List<Sector> _list = [];
  bool loading = false;

  String selectedValue = "";
  String selectedValue_id = "";

  getSectors() async {
    List<Sector> sect = await SectorsServices.get_list_sectors1();
    setState(() {
      _list = sect;
    });
  }

  int count1 = 0;

  setSount1(c) {
    setState(() {
      count1 = c;
    });
  }

  @override
  initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    getSectors();
    display_slides();
  }

  Reload() {
    setState(() {
      loading = true;
    });
    new Timer(const Duration(seconds: 1), () {
      try {
        setState(() => loading = false);
      } catch (e) {
        e.toString();
      }
    });
  }

  Widget drop_down() => new Container(
      color: Colors.white,
      width: 700.0,
      height: 60.0,
      child: Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.only(left: 16.0, right: 8.0),
          decoration: new BoxDecoration(
            color: Fonts.col_app_shadow,
            border: new Border.all(color: Fonts.col_app_fonn, width: 1.0),
            borderRadius: new BorderRadius.circular(2.0),
          ),
          child: new FixDropDown(
              iconSize: 32.0,
              isDense: false,
              items: _list.map((Sector value) {
                return new FixDropdownMenuItem(
                  value: value,
                  child: new Text(
                    value.name.toString(),
                    maxLines: 2,
                    softWrap: true,
                  ),
                );
              }).toList(),
              hint: new Text(
                selectedValue.toString() != ""
                    ? selectedValue.toString()
                    : LinkomTexts.of(context).sector(),
                maxLines: 1,
                softWrap: true,
                style: new TextStyle(color: Fonts.col_app_fonn),
              ),
              onChanged: (Sector value) {
                setState(() {
                  selectedValue = value.name;
                  selectedValue_id= value.id;
                  Reload();
                });
              })));

  display_slides() async {
    //Restez informés sur  tout ce qui se passe au sein de votre communauté à travers l’actualité et les événements.
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString("con") != "con") {
      new Timer(new Duration(seconds: 1), () {
        setState(() {
          _menuShown = true;
        });

        prefs.setString("con", "con");
      });
    }
  }

  onp() {
    setState(() {
      _menuShown = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Animation opacityAnimation =
        Tween(begin: 0.0, end: 1.0).animate(animationController);
    if (_menuShown)
      animationController.forward();
    else
      animationController.reverse();

    return Scaffold(
       /* appBar: AppBar(
          iconTheme: IconThemeData(color: Fonts.col_app_fonn),
          backgroundColor: Fonts.col_app_shadow,
          elevation: 0.0,
          title: Text(
            widget.type_promo == "cgem"
                ?  LinkomTexts.of(context).tarifs()+' (' + count1.toString() + ")"
                : LinkomTexts.of(context).ava(),
            style: TextStyle(color: Fonts.col_app_fonn),
          ),
        ),*/
        body: Stack(children: <Widget>[
          new Column(
            children: <Widget>[
              drop_down(),
              new Expanded(
                  child: loading
                      ? Widgets.load()
                      : new StreamParcPub(
                          new Container(),
                          widget.lat,
                          widget.lng,
                          widget.user,
                          "1",
                          widget.list_partner,
                          widget.analytics,
                          setSount1,
                          widget.chng,
                          sector_promo: selectedValue_id,
                          category: "promotion",
                          type_promo: widget.type_promo,
                          revue: false,
                          favorite: false,
                          boutique: false,
                        ))
            ],
          ),
        /*  _menuShown == false
              ? Container()
              : Positioned(
                  child: FadeTransition(
                    opacity: opacityAnimation,
                    child: ShapedWidget(
                        "Plusieurs  conventions pour bénéficier de réductions valables sur toute l’année. Présentez votre badge sur l’application au "
                        "près du magasin conventionné pour profiter des meilleurs tarifs.",
                        onp,
                        168.0),
                  ),
                  right: 12.0,
                  top: 86.0,
                ),*/
        ]));
  }
}
