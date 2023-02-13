import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mycgem/home/search_event_pub.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/sector.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/parc_events_stream/parc_events_stream.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/sector_services.dart';
import 'package:mycgem/widgets/fixdropdown.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommandesList extends StatefulWidget {
  CommandesList(this.lat, this.lng, this.user, this.list_partner,
      this.analytics, this.chng);

  var lat, lng;
  User user;
  List list_partner;
  var analytics;
  var chng;

  @override
  _ParcState createState() => _ParcState();
}

class _ParcState extends State<CommandesList>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  bool _menuShown = false;
  List<Sector> _list = [];

  getSectors() async {
    List<Sector> sect = await SectorsServices.get_list_sectors();
    setState(() {
      _list = sect;
    });
  }

  final _titrecontroller = new TextEditingController();

  bool loading = false;

  String selectedValue = "";

  @override
  initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    // getSectors();
    display_slides();
    getSectors();
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

  int count1 = 0;

  setSount1(c) {
    setState(() {
      count1 = c;
    });
  }

  Widget drop_down() => new Container(
      color: Fonts.col_app_shadow,
      width: 700.0,
      height: 60.0,
      child: Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.only(left: 16.0, right: 8.0),
          decoration: new BoxDecoration(
            color: Fonts.col_app_shadow,
            border: new Border.all(color: Fonts.col_app_shadow, width: 1.0),
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
                    style: TextStyle(color: Fonts.col_app),

                  ),

                );
              }).toList(),
              hint: new Text(
                selectedValue != "" ? selectedValue : "Secteur:",
                maxLines: 1,
                softWrap: true,
                style: new TextStyle(color: Fonts.col_app_fonn),
              ),
              onChanged: (Sector value) {
                setState(() {
                  selectedValue = value.name;
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
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Alert(
                      context: context,
                      title: LinkomTexts.of(context).search(),
                      content: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _titrecontroller,
                            decoration: InputDecoration(
                              icon: Image.asset(
                                "images/icons/opportunity.png",
                                color: Fonts.col_app,
                                width: MediaQuery.of(context).size.width * 0.08,
                              ),
                              hintMaxLines: 2,
                              labelText: LinkomTexts.of(context).search_opp(),
                            ),
                          ),
                        ],
                      ),
                      buttons: [
                        DialogButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(context, new MaterialPageRoute(
                                builder: (BuildContext context) {
                              return new SearchNewEvent(
                                _titrecontroller.text,
                                widget.user,
                                widget.list_partner,
                                widget.lat,
                                widget.lng,
                                "commande",
                                widget.chng,
                              );
                            }));
                          },
                          child: Text(
                            LinkomTexts.of(context).search(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        )
                      ]).show();
                },
                icon: CircleAvatar(
                  backgroundColor: Fonts.col_app_shadow,
                  // backgroundColor: const Color(0xffff374e),
                  child: Icon(
                    Icons.search,
                    color: Fonts.col_app_fon,
                  ),
                ))
          ],
          backgroundColor: Fonts.col_app_shadow,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Fonts.col_app_fonn),
          title: Text(
            count1 == 0
                ? "1 ère commande"
                : "1 ère commande" + '  (' + count1.toString() + ')',
            style: TextStyle(
                color: Fonts.col_app_fonn, fontWeight: FontWeight.w400),
          ),
        ),
        body: Stack(children: <Widget>[
          new Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                color: Fonts.col_app_shadow,
               // margin: EdgeInsets.all(6),

                  child:Row(children: <Widget>[
                    Container(width: 24,),
                    Text("Mon solde restant: 35 000 dhs TTC",style: TextStyle(fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xffff374e)
                    ))
                  ]
             ,)),
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
                          sector: selectedValue,
                          category: "commande",
                          video: false,
                          revue: false,
                          favorite: false,
                          boutique: false,
                        ))
            ],
          ),
        ]));
  }
}
