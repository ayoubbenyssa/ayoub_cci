import 'dart:async';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/parc_events_stream/parc_events_stream.dart';
import 'package:mycgem/products/filter.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/teeeeest.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupCommissions extends StatefulWidget {
  GroupCommissions(this.lat, this.lng, this.user, this.list_partner,
      this.analytics, this.id_commission, this.type_genre, this.chng);

  var lat, lng;
  User user;
  List list_partner;

  var analytics;
  String id_commission;
  var type_genre;

  var chng;

  @override
  _ParcState createState() => _ParcState();
}

class _ParcState extends State<GroupCommissions> with TickerProviderStateMixin {
  AnimationController animationController;
  bool _menuShown = false;
  final GlobalKey _fabKey = GlobalKey();

  int count1 = 0;
  int count2 = 0;
  int count3 = 0;

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

  List<Tab> tabs = <Tab>[

  ];

  TabController _tabController;

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
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
    tabs = [ new Tab(
        text: count1 == 0
            ? LinkomTexts.of(context).g_n()
            : LinkomTexts.of(context).g_n()+ "" + " (" + count1.toString() + ")"),
    new Tab(
        text: count2 == 0
            ? LinkomTexts.of(context).g_r()
            : LinkomTexts.of(context).g_r() + " (" + count2.toString() + ")"),];
    _tabController = new TabController(vsync: this, length: tabs.length);
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

    Widget tbs = new TabBar(
      onTap: (val){

      },
      isScrollable: true,
      unselectedLabelColor: Colors.grey[700],
      labelColor: Colors.white,
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

    return Stack(children: <Widget>[
      DefaultTabController(
          initialIndex: 0,
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              actions: <Widget>[],
              elevation: 1,
              iconTheme: IconThemeData(color: Fonts.col_app_fonn),
              backgroundColor: Fonts.col_app_shadow,
              bottom: tbs,
              title: Text(
                'Groupes',
                style: TextStyle(color: Fonts.col_app_fonn),
              ),
            ),
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
                    tpe_group: "national",
                    type_groupe: widget.id_commission,
                    genre: widget.type_genre,
                    favorite: false,
                    boutique: false,
                    revue: false,
                    auth: null,
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
                    genre: widget.type_genre,
                    tpe_group: "regional",
                    type_groupe: widget.id_commission,
                    favorite: false,
                    boutique: false,
                    revue: false,
                    video: false,
                    auth: null,
                    context: context,
                  ),
                ]),
          )),
    ]);
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
