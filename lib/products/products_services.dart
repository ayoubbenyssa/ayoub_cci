import 'dart:async';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:mycgem/home/conventions.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/parc_events_stream/parc_events_stream.dart';
import 'package:mycgem/products/filter.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/teeeeest.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductServices extends StatefulWidget {
  ProductServices(this.lat, this.lng, this.user, this.list_partner,
      this.analytics, this.chng);

  var lat, lng;
  User user;
  List list_partner;
  var chng;
  var analytics;

  @override
  _ParcState createState() => _ParcState();
}

class _ParcState extends State<ProductServices> with TickerProviderStateMixin {
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

  List<Tab> tabs = <Tab>[];

  TabController _tabController;

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

    tabs = [
      new Tab(
          text: count1 == 0
              ? LinkomTexts.of(context).tous()
              : LinkomTexts.of(context).tous() +
                  " (" +
                  count1.toString() +
                  ")"),
      new Tab(
          text: count2 == 0
              ? LinkomTexts.of(context).mone()
              : LinkomTexts.of(context).mone() +
                  " (" +
                  count2.toString() +
                  ")"),
      new Tab(
          text: count3 == 0
              ? LinkomTexts.of(context).suivi()
              : LinkomTexts.of(context).suivi() +
                  " (" +
                  count3.toString() +
                  ")")
    ];

    _tabController = new TabController(vsync: this, length: tabs.length);
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    Animation opacityAnimation =
        Tween(begin: 0.0, end: 1.0).animate(animationController);
    if (_menuShown)
      animationController.forward();
    else
      animationController.reverse();

   /* Widget tbs = new TabBar(
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
    );*/

    Widget servvices = Stack(children: <Widget>[
      DefaultTabController(
          initialIndex: 0,
          length: 3,
          child: Scaffold(
           /* appBar: AppBar(
              actions: <Widget>[
               /* IconButton(
                    key: _fabKey,
                    onPressed: () {
                      Navigator.of(context).push<void>(
                        FilterProdServ.route(
                            context, _fabKey, widget.user, widget.chng),
                      );
                    },
                    icon: CircleAvatar(
                      backgroundColor: const Color(0xffff374e),
                      child: Icon(
                        Icons.filter_list,
                        color: Colors.white,
                      ),
                    ))*/
              ],
              elevation: 1,
              iconTheme: IconThemeData(color: Fonts.col_app_fonn),
              backgroundColor: Fonts.col_app_shadow,
              bottom: tbs,
              title: Text(
                LinkomTexts.of(context).prodss(),
                style: TextStyle(
                    color: Fonts.col_app_fonn, fontWeight: FontWeight.w400),
              ),
            ),*/
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
                    category: "prod_service",
                    cat: "",
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
                    category: "prod_service",
                    cat: widget.user.entreprise.objectId,
                    favorite: false,
                    boutique: false,
                    revue: false,
                    video: false,
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
                      setSount3,
                      widget.chng,
                      category: "prod_service",
                      cat: widget.user.entreprise.objectId,
                      favorite: false,
                      boutique: false,
                      revue: false,
                      auth: null,
                      context: context,
                      suivis: true),
                ]),
          )),
      _menuShown == false
          ? Container()
          : Positioned(
              child: FadeTransition(
                opacity: opacityAnimation,
                child: ShapedWidget(
                    "Actualités et informations en continu selon vos centres d’intérêt",
                    onp,
                    120.0),
              ),
              right: 12.0,
              top: 86.0,
            ),
    ]);



    return   DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Fonts.col_app_shadow,
            /*bottom: TabBar(
               isScrollable: true,
              labelStyle: new TextStyle(color: Colors.blue),
              indicatorPadding: new EdgeInsets.all(0.0),
              tabs: [
                new Tab(
                    text: count1 == 0
                        ? "Marketplace"
                        : "Marketplace" +
                        " (" +
                        count1.toString() +
                        ")"),
                Tab(
                    text: count2 == 0
                        ? LinkomTexts.of(context).tarifs()
                        : LinkomTexts.of(context).tarifs() +
                        " (" +
                        count2.toString() +
                        ")"),
              ],
            ),*/
            title: Text(LinkomTexts.of(context).prodss()),
          ),
          body:
              servvices,
              /*new Conventions(
                  widget.lat,
                  widget.lng,
                  widget.user,
                  widget.list_partner,
                  widget.analytics,
                  "cgem",
                  widget.chng)            ],
          ),*/
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
