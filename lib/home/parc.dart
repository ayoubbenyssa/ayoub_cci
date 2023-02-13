import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/parc_events_stream/parc_events_stream.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/teeeeest.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Parc extends StatefulWidget {
  Parc(this.lat, this.lng, this.user, this.list_partner, this.auth,
      this.analytics, this.chng);

  var lat, lng;
  User user;
  List list_partner;
  var auth;
  var chng;
  var analytics;

  @override
  _ParcState createState() => _ParcState();
}

class _ParcState extends State<Parc> with SingleTickerProviderStateMixin {
  AnimationController animationController;
  bool _menuShown = false;

  display_slides() async {
    //Restez informés sur  tout ce qui se passe au sein de votre communauté à travers l’actualité et les événements.
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString("par") != "par") {
      new Timer(new Duration(seconds: 1), () {
        setState(() {
          _menuShown = true;
        });

        prefs.setString("par", "par");
      });
    }
  }

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

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    // TODO: implement initState
    super.initState();
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

    return Stack(
      children: <Widget>[
        DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.black),
                elevation: 1,
                backgroundColor: Colors.white,

                bottom: TabBar(
                  // isScrollable: true,
                  labelStyle: new TextStyle(color: Colors.blue),
                  indicatorPadding: new EdgeInsets.all(0.0),
                  tabs: [
                    new Tab(
                        text: count1 == 0
                            ? LinkomTexts.of(context).event()
                            : LinkomTexts.of(context).event() +
                                " (" +
                                count1.toString() +
                                ")"),
                    Tab(
                        text: count2 == 0
                            ? LinkomTexts.of(context).actu()
                            : LinkomTexts.of(context).actu() +
                                " (" +
                                count2.toString() +
                                ")"),
                  ],
                ),
                title: Text('Votre parc'),
              ),
              body: TabBarView(
                children: [
                  new StreamParcPub(
                    new Container(),
                    widget.lat,
                    widget.lng,
                    widget.user,
                    "1",
                    widget.list_partner,
                    widget.analytics,
                    setSount1,
                    widget.chng,
                    category: "event",
                    cat: "Parc",
                    favorite: false,
                    boutique: false,
                    revue: false,
                    video: false,
                    auth: widget.auth,
                  ),
                  new StreamParcPub(
                    new Container(),
                    widget.lat,
                    widget.lng,
                    widget.user,
                    "0",
                    widget.list_partner,
                    widget.analytics,
                    setSount2,
                    widget.chng,
                    category: "news",
                    cat: "Parc",
                    favorite: false,
                    auth: widget.auth,
                    boutique: false,
                  )
                ],
              ),
            )),
        _menuShown == false
            ? Container()
            : Positioned(
                child: FadeTransition(
                  opacity: opacityAnimation,
                  child: ShapedWidget(
                      "Restez informés sur  tout ce qui se passe au sein de votre communauté à travers l’actualité et les événements..",
                      onp,
                      140.0),
                ),
                right: 12.0,
                top: 86.0,
              ),
      ],
    );
  }
}
