import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/teeeeest.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mycgem/annonces/add_annonces.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/parc_events_stream/parc_events_stream.dart';

class AnnoncesTabs extends StatefulWidget {
  AnnoncesTabs(this.user, this.auth, this.sign, this.lat, this.lng,
      this.list_partner, this.index, this.analytics, this.chng);

  User user;
  var auth;
  var sign;
  var lat;
  var lng;
  int index;
  var analytics;
  var chng;

  List list_partner;

  @override
  _AnnoncesTabsState createState() => _AnnoncesTabsState();
}

class _AnnoncesTabsState extends State<AnnoncesTabs>
    with TickerProviderStateMixin {
  AnimationController animationController;
  bool _menuShown = false;

  int count1 = 0;
  int count2 = 0;

  setSount1(c) {
    setState(() {
      count1 = c;
    });
  }

  setSount2(c) {
    setState(() {
      count2 = c;
    });
  }

  display_slides() async {
    //Restez informés sur  tout ce qui se passe au sein de votre communauté à travers l’actualité et les événements.
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString("an") != "an") {
      new Timer(new Duration(seconds: 1), () {
        setState(() {
          _menuShown = true;
        });

        prefs.setString("an", "an");
      });
    }
  }

  ParseServer parseFunctions = new ParseServer();
  String verify = "1";

  getUser(id) async {
    var a = await parseFunctions.getparse('users?where={"objectId":"$id"}&include=fonction');
    if (!this.mounted) return;
    print(a);

    setState(() {
      verify = a["results"][0]["verify"].toString();
      print(verify);
    });
  }

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    // TODO: implement initState
    super.initState();
    getUser(widget.user.id);

    display_slides();
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

    return DefaultTabController(
        initialIndex: widget.index,
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Fonts.col_app_fonn),
            /* bottom: TabBar(
              isScrollable: true,
              indicatorColor: Fonts.col_app,
              unselectedLabelColor: Colors.grey,
              labelColor: Fonts.col_app,
              labelStyle: new TextStyle(color: Fonts.col_app),
              indicatorPadding: new EdgeInsets.all(0.0),
              tabs: [
              //  new Tab(text:count1==0?"Offres d'emploi": "Offres d'emploi"+ " (" +count1.toString()+")"),
                Tab(text:count2 ==0? "Annonces":"Annonces"+" ("+count2.toString()+")"),
              ],
            ),*/
            title: Text(
              count2 == 0
                  ? LinkomTexts.of(context).ann()
                  : LinkomTexts.of(context).ann() + " (" + count2.toString() + ")",
              style: TextStyle(color: Fonts.col_app_fonn),
            ),
          ),
          body: Stack(
            children: <Widget>[
              TabBarView(
                children: [
                  /* new StreamParcPub(
                    new Container(),
                    widget.lat,
                    widget.lng,
                    widget.user,
                    "1",
                    widget.list_partner,
                    widget.analytics,
                    setSount1,
                    type: "Mission_raja",
                    favorite: false,
                    revue: false,
                    boutique: false,
                  ),*/
                  verify != "1"
                      ? Container(
                          padding: EdgeInsets.all(24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.asset("images/al.png"),
                              Container(
                                height: 16,
                              ),
                              Text(
                                LinkomTexts.of(context).option(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ))
                      : new StreamParcPub(
                          new Container(),
                          widget.lat,
                          widget.lng,
                          widget.user,
                          "1",
                          widget.list_partner,
                          widget.analytics,
                          setSount2,
                          widget.chng,
                          type: "Annonces",
                          favorite: false,
                          revue: false,
                          boutique: false,
                        )
                ],
              ),
              _menuShown == false
                  ? Container()
                  : Positioned(
                      child: FadeTransition(
                        opacity: opacityAnimation,
                        child: ShapedWidget(
                            "Vous avez besoin  d’information ? De vendre un bien, un service ou de solliciter l’aide d’un expert ? Publiez gratuitement votre annonce ici. Elle sera vue par tous les membres de la communauté, qui pourront vous répondre.",
                            onp,
                            160.0),
                      ),
                      right: 12.0,
                      top: 86.0,
                    ),
            ],
          ),
          /*  floatingActionButton: UnicornDialer(
              backgroundColor: Colors.black54,
              parentButtonBackground: Fonts.col_app,
              orientation: UnicornOrientation.VERTICAL,
              parentButton: Icon(Icons.add),
              childButtons: childButtons),*/
        ));
  }
}
