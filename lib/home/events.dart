import 'dart:async';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:mycgem/home/search_event_pub.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/parc_events_stream/parc_events_stream.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/teeeeest.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Events extends StatefulWidget {
  Events(this.lat, this.lng, this.user, this.list_partner, this.auth,
      this.index, this.analytics, this.chng);

  var lat, lng;
  User user;
  List list_partner;
  var auth;
  var index;
  var analytics;
  var chng;

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> with TickerProviderStateMixin {
  AnimationController animationController;
  bool _menuShown = false;
  final _titrecontroller = new TextEditingController();
  List<Tab> tabs = <Tab>[];
  TabController _tabController;
  int count1 = 0;
  int count2 = 0;
  int count3 = 0;
  SearchBar searchBar;

  _EventsState() {
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

  Widget tbs() => new TabBar(
        isScrollable: true,
        unselectedLabelColor: Colors.grey[700],
        labelColor: Colors.white,
        labelStyle: TextStyle(fontSize: 14.5.sp),
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: new BubbleTabIndicator(
          indicatorHeight: 24.0,
          indicatorRadius: 4.0,
          indicatorColor: Fonts.col_app,
          tabBarIndicatorSize: TabBarIndicatorSize.tab,
        ),
        tabs: tabs,
        controller: _tabController,
      );

  void onSubmitted(String value) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new SearchNewEvent(
        value,
        widget.user,
        [],
        widget.lat,
        widget.lng,
        "event",
        widget.chng,
      );
    }));
  }

  Widget default_appbar(context) => AppBar(
        actions: <Widget>[
          searchBar.getSearchAction(context),
        ],
        iconTheme: IconThemeData(color: Fonts.col_app_fon),
        elevation: 1,
        backgroundColor: Colors.white,

        title: Text(
          LinkomTexts.of(context).agenda(),
          style: TextStyle(
              color: Fonts.col_app_fon,
              fontSize: 15.5.sp,
              fontWeight: FontWeight.w700),
        ),
      );

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

    return Scaffold(
          appBar: searchBar.build(context),
          body: /*widget.user.verify.toString() != "1"
              ? Container(
                  child: Container(
                      padding: EdgeInsets.only(top: 60, left: 12, right: 12),
                      child: Text(
                        "Vous devez être membre de la CGEM pour accéder à cette rubrique",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Fonts.col_ap_fonn,
                            fontSize: 15.5.sp,
                            fontWeight: FontWeight.w700),
                      )),
                )
              : widget.user.entreprise.situation != "Ajour"
                  ? Container(
                      child: Container(
                          padding:
                              EdgeInsets.only(top: 60, left: 12, right: 12),
                          child: Text(
                            "Vous devez régulariser votre situation pour accéder à cette rubrique",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15.5.sp,
                                height: 1.4,
                                color: Fonts.col_ap_fonn),
                          )),
                    )
                  : */
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
                        cat: "",
                        favorite: false,
                        revue: false,
                        video: false,
                        boutique: false,
                        auth: widget.auth,
                        context: context,
                      )
        );
  }
}
