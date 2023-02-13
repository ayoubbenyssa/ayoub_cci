import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycgem/filter/federation.dart';
import 'package:mycgem/filter/filter_by_region.dart';
import 'package:mycgem/filter/filter_gender.dart';
import 'package:mycgem/filter/filter_relation.dart';
import 'package:mycgem/filter/filterbylocalion.dart';
import 'package:mycgem/filter/objectifs.dart';
import 'package:mycgem/home/entreprise_view.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/widgets/search_widget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'filter_by_commission.dart';

class FilterPage extends StatefulWidget {
  FilterPage(this.user, this.chng, this.lat, this.lng);

  User user;
  var chng;
  var lat;
  var lng;

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String text = "";

  bool val1 = true;
  bool val2 = false;
  bool val = true;
  String type = "Monsieur";

  alert() {
    Alert(
        context: context,
        title: "",
        content: Column(
          children: <Widget>[
            Container(height: 12),
            Container(
              height: 16,
            ),
            Choicess(val1, val2, func),
            Container(
              height: 16,
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              print("jdjdjjdjdjjdjdjdj");
              Navigator.pop(context);

              int i = 0;
              if (type == "Monsieur") {
                i = 1;
              } else {
//
                i = 2;
              }

              Navigator.push(
                context,
                new PageRouteBuilder(
                  pageBuilder: (BuildContext context, Animation<double> _,
                      Animation<double> __) {
                    return FilterByGender(widget.user, widget.lat, widget.lng,
                        [], null, widget.chng, i);
                  },
                ),
              );

              /* setState(() {
                      text.text = "";
                    });*/
            },
            child: Text(
              "Filtrer",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  tap(String text) {
    var res;
    switch (text) {
      case "Près de vous":
        res = UsersStream(
            widget.user, widget.lat, widget.lng, [], null, widget.chng);
        break;

     /* case "Nouveaux utilisateurs":
        res = FilterByNew(
            widget.user, widget.lat, widget.lng, [], null, widget.chng);
        break;
      case "Anciens utilisateurs":
        res = FilterByOld(
            widget.user, widget.lat, widget.lng, [], null, widget.chng);
        break;*/

      /*case "Dernière connexion":
        res = FilterByLastCnx(
            widget.user, widget.lat, widget.lng, [], null, widget.chng);
        break;*/
      case "Membres":
        res = EntrepriseStream(
            widget.user, widget.lat, widget.lng, [], null, widget.chng);
        break;
      case "Secteurs":
        res = FederationsStream(
            widget.user, widget.lat, widget.lng, [], null, widget.chng, true,true);
        break;
      case "Commissions permanentes":
        res = CommissionsStream(
            widget.user, widget.lat, widget.lng, [], null, widget.chng, true);
        break;

      case "Régions":
        res = RegionStream(
            widget.user, widget.lat, widget.lng, [], null, widget.chng,true,true);
        break;
      case "Centres d’intérêt":
        res = Objectifs_widget(
            widget.user, widget.lat, widget.lng, [], null, widget.chng);
        break;
      case "Relations":
        res = FilterByRelation(
            widget.user, widget.lat, widget.lng, [], null, widget.chng);
        break;
    }

    if (text == "Genre") {
      alert();
    } else
      Navigator.push(
        context,
        new PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> _,
              Animation<double> __) {
            return res;
          },
        ),
      );
  }

  func(a) {
    setState(() {
      type = a;
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget divid = Container(
      margin: EdgeInsets.only(top: 12, bottom: 12),
      width: MediaQuery.of(context).size.width,
      height: 1,
      color: Fonts.col_grey.withOpacity(0.4),
    );

    TextStyle st = TextStyle(
        color: Fonts.col_ap_fonn,
        fontSize: 15.sp,
        fontWeight: FontWeight.w700);

    Widget roww(String text) => InkWell(
        onTap: () {
          tap(text);
        },
        child: Row(
          children: [
            Text(text, style: st),
            Expanded(
              child: Container(),
            ),
            Image.asset(
              "images/arrr.png",
              color: Fonts.col_grey.withOpacity(0.77),
              width: ScreenUtil().setWidth(16),
              height: ScreenUtil().setWidth(16),
            ),
            Container(
              width: 16,
            )
          ],
        ));

    return Container(
      padding: EdgeInsets.only(left: 16, top: 12),
      child: ListView(
        children: [
          ///SearchWidget(widget.user, [], widget.lat != null ? widget.lat : 0.0,
           ///   widget.lng != null ? widget.lng : 0.0, null, null, widget.chng),
          Container(
            height: 16,
          ),
         /* Text(
            "TRIER PAR:",
            style: TextStyle(
                fontSize: ScreenUtil().setSp(18),
                color: Fonts.col_app,
                fontWeight: FontWeight.w800),
          ),*/



          Text(
            "FILTRER PAR :",
            style: TextStyle(
                fontSize: ScreenUtil().setSp(18),
                color: Fonts.col_app,
                fontWeight: FontWeight.w800),
          ),
          divid,
          roww("Près de vous"),
          divid,

          //  roww("Relations"),
          // divid,
          roww("Membres"),
          divid,
          roww("Régions"),
          divid,

          roww("Secteurs"),
          divid,
         // roww("Commissions permanentes"),
         // divid,

          roww("Centres d’intérêt"),
          divid,
          // roww("Compétence"),
          //divid,
          //roww("Genre"),
          //divid,
        ],
      ),
    );
  }
}

class Choicess extends StatefulWidget {
  Choicess(this.val1, this.val2, this.func);

  bool val1 = true;
  bool val2 = false;
  var func;

  @override
  _ChoicesState createState() => _ChoicesState();
}

class _ChoicesState extends State<Choicess> {
  @override
  Widget build(BuildContext context) {
    return new Container(
        child: Column(
            //backgroundColor: Colors.grey[100],
            children: [
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                "Monsieur",
                style: TextStyle(fontSize: 14),
              ),
              new Checkbox(
                value: widget.val1,
                onChanged: (bool value) {
                  setState(() {
                    widget.val1 = value;
                    widget.val2 = !value;
                    widget.func("Monsieur");
                  });
                },
              ),
              new Container(width: 16.0),
              new Text(
                "Madame",
                style: TextStyle(fontSize: 14),
              ),
              new Checkbox(
                value: widget.val2,
                onChanged: (bool value) {
                  setState(() {
                    widget.val2 = value;
                    widget.val1 = !value;
                    widget.func("Madame");
                  });
                },
              )
            ],
          ),
        ]));
    ;
  }
}
