import 'dart:async';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:mycgem/home/search_event_pub.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/parc_events_stream/parc_events_stream.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Publications extends StatefulWidget {
  Publications(this.lat, this.lng, this.user, this.list_partner, this.auth,
      this.index, this.analytics, this.chng);

  var lat, lng;
  User user;
  List list_partner;
  var auth;
  var index;
  var analytics;
  var chng;

  @override
  _ParcState createState() => _ParcState();
}

class _ParcState extends State<Publications> with TickerProviderStateMixin {
  AnimationController animationController;
  bool _menuShown = false;
  SearchBar searchBar;


  TabController _tabController;
  int count1 = 0;
  int count2 = 0;
  int count3 = 0;
  final _titrecontroller = new TextEditingController();


  void onSubmitted(String value) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new SearchNewEvent(
        value,
        widget.user,
        [],
        widget.lat,
        widget.lng,
        "news",
        widget.chng,
      );
    }));
  }

  Widget default_appbar(context) => AppBar(
        actions: <Widget>[
          searchBar.getSearchAction(context),

          /**
           * IconButton(
              onPressed: () {
              /*
              SearchNewEvent(this.text,this.user_me,this.list,this.lat,this.lng,this.type)
              */

              Alert(
              context: context,
              title: LinkomTexts.of(context).search(),
              content: Column(
              children: <Widget>[
              TextFormField(
              controller: _titrecontroller,
              decoration: InputDecoration(
              icon: Image.asset(
              "images/pp.png",
              color: Fonts.col_app,
              width: MediaQuery.of(context).size.width *
              0.08,
              ),
              hintMaxLines: 2,
              labelText: 'Rechercher un post',
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
              "news",
              widget.chng,
              );
              }));
              },
              child: Text(
              LinkomTexts.of(context).search(),
              style: TextStyle(
              color: Colors.white, fontSize: 20),
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
           */
        ],
        elevation: 1,
        iconTheme: IconThemeData(color: Fonts.col_app_fon),
        backgroundColor: Colors.white,

        title: Text(
          LinkomTexts.of(context).publi(),
          style: TextStyle(
              color: Fonts.col_app_fon,
              fontSize: 15.5.sp,
              fontWeight: FontWeight.w700),
        ),
      );

  _ParcState() {
    searchBar = new SearchBar(
        inBar: false,
        hintText: "Rechercher",
        buildDefaultAppBar: default_appbar,
        setState: setState,
        onSubmitted: onSubmitted);
  }

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

  setSount3(c) {
    setState(() {
      count3 = c;
    });
  }

  display_slides() async {
    //Restez informés sur  tout ce qui se passe au sein de votre communauté à travers l’actualité et les événements.
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString("pub") != "pub") {
      new Timer(new Duration(seconds: 1), () {
        setState(() {
          _menuShown = true;
        });

        prefs.setString("pub", "pub");
      });
    }
  }

  @override
  void initState() {
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
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
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
        length: 3,
        child: Scaffold(
          appBar: searchBar.build(context),
          body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                new StreamParcPub(
                  new Container(),
                  widget.lat,
                  widget.lng,
                  widget.user,
                  "0",
                  widget.list_partner,
                  widget.analytics,
                  setSount1,
                  widget.chng,
                  category: "news",
                  cat: "",
                  favorite: false,
                  boutique: false,
                  revue: false,
                  auth: widget.auth,
                  context: context,
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
                  revue: false,
                  cat: widget.user.entreprise.objectId,
                  favorite: false,
                  boutique: false,
                  auth: widget.auth,
                  context: context,
                ),
                new StreamParcPub(
                    new Container(),
                    widget.lat,
                    widget.lng,
                    widget.user,
                    "0",
                    widget.list_partner,
                    widget.analytics,
                    setSount3,
                    widget.chng,
                    category: "news",
                    cat: widget.user.entreprise.objectId,
                    favorite: false,
                    boutique: false,
                    revue: false,
                    auth: widget.auth,
                    context: context,
                    suivis: true),
              ]),
        ));
  }
}

/*

    new StreamParcPub(
              new Container(),
              widget.lat,
              widget.lng,
              widget.user,
              "1",
              widget.list_partner,
              widget.analytics,
              category: "event",
              cat: "Général",
              favorite: false,
              boutique: false,
              auth: widget.auth,
              context: context,
            ),
 */
