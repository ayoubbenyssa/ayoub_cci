import 'dart:async';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:mycgem/cards/like_partner_button.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/membre.dart';
import 'package:mycgem/models/partner.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/parc_events_stream/parc_events_stream.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/widgets/arc_clip.dart';
import 'package:mycgem/widgets/common.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

enum AppBarBehavior { normal, pinned, floating, snapping }

class PartnerCardDetails2 extends StatefulWidget {
  PartnerCardDetails2(this.partner, this.lat, this.lng, this.user, this.chng);

  Membre partner;
  User user;
  double lat;
  double lng;
  var chng;

  @override
  _ShopCardState createState() => _ShopCardState();
}

class _ShopCardState extends State<PartnerCardDetails2>
    with TickerProviderStateMixin {
  //For ùaking a call
  Future _launched;
  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;

  int count1 = 0;
  int count2 = 0;
  int count3 = 0;
  int count4 = 0;
  int count5 = 0;
  int count6 = 0;
  int count7 = 0;

  List<Tab> tabs = <Tab>[

  ];

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

  setSount4(c) {
    setState(() {
      count4 = c;
    });
  }

  setSount5(c) {
    setState(() {
      count5 = c;
    });
  }

  setSount6(c) {
    setState(() {
      count6 = c;
    });
  }

  setSount7(c) {
    setState(() {
      count7 = c;
    });
  }

  TabController _tabController;

  Future _launch(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget tbs() =>  new TabBar(
    indicatorSize: TabBarIndicatorSize.tab,
    tabs: tabs,
    isScrollable: true,

    indicatorColor: Fonts.col_app_green,
    indicatorWeight: 4,
    unselectedLabelColor: Fonts.col_grey,
    //isScrollable: false,

    labelColor: Fonts.col_app,
    labelStyle: new TextStyle(
        color: Fonts.col_app,
        fontWeight: FontWeight.w600,
        fontSize: 16),
    indicatorPadding: new EdgeInsets.all(0.0),
    controller: _tabController,
  );


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    tabs= [
      new Tab(
          text: count2 == 0
              ? LinkomTexts.of(context).members()
              : LinkomTexts.of(context).members() + " (" + count2.toString() + ")"),
      new Tab(text: LinkomTexts.of(context).details()),
      new Tab(
          text: count3 == 0
              ? LinkomTexts.of(context).publi()
              : LinkomTexts.of(context).publi() + " (" + count3.toString() + ")"),
      new Tab(
          text: count4 == 0
              ? LinkomTexts.of(context).agenda()
              : LinkomTexts.of(context).agenda() + " (" + count4.toString() + ")"),
      new Tab(
          text: count5 == 0
              ? LinkomTexts.of(context).oppo()
              : LinkomTexts.of(context).oppo() +
              " (" +
              count5.toString() +
              ")"),
      new Tab(
          text: count6 == 0
              ? LinkomTexts.of(context).prodss()
              : LinkomTexts.of(context).prodss() +
              " (" +
              count6.toString() +
              ")")];
    _tabController = new TabController(vsync: this, length: tabs.length);

  }
  @override
  Widget build(BuildContext context) {

    double _appBarHeight = MediaQuery.of(context).size.height * 0.26;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Fonts.col_app_shadow,
          elevation: 0.0,
        ),
        body:
        new Stack(alignment: AlignmentDirectional.bottomCenter, children: <
            Widget>[
          new CustomScrollView(shrinkWrap: false, slivers: <Widget>[
            new SliverAppBar(
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                elevation: 0,
                forceElevated: true,
                expandedHeight: _appBarHeight,
                pinned: _appBarBehavior == AppBarBehavior.pinned,
                floating: _appBarBehavior == AppBarBehavior.floating ||
                    _appBarBehavior == AppBarBehavior.snapping,
                snap: _appBarBehavior == AppBarBehavior.snapping,
                flexibleSpace: new FlexibleSpaceBar(
                    title: new Text(""),
                    background: ClipPath(
                        clipper: new ArcClipper2(),
                        child: Container(
                            decoration: new BoxDecoration(
                                gradient: new LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  // Add one stop for each color. Stops should increase from 0 to 1
                                  colors: Widgets.kitGradients11,
                                )),
                            child: new Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,

                                children: <Widget>[
                                  Center(
                                    child: new ClipOval(
                                        child: new Container(
                                            width: 70.0,
                                            height: 70.0,
                                            child: new Image.network(
                                              widget.partner.logo,
                                              fit: BoxFit.cover,
                                            ))),
                                  ),
                                  Container(
                                    height: 12,
                                  ),
                                  Center(
                                    child: Text(
                                      widget.partner.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          fontSize: ScreenUtil()
                                              .setSp(20)),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil()
                                              .setSp(12)),
                                    ),
                                  ),

                                ]))))),
            new SliverToBoxAdapter(
                child: Container(padding: EdgeInsets.all(2), child: tbs())),
            new SliverToBoxAdapter(
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [
                        new StreamParcPub(
                          new Container(),
                          widget.lat,
                          widget.lng,
                          widget.user,
                          "1",
                          null,
                          null,
                          setSount1,
                          widget.chng,
                          member: widget.partner.objectId,
                          favorite: false,
                          boutique: false,
                          revue: false,
                          video: false,
                          auth: null,
                          context: context,
                        ),
                        Container(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Description:",
                                style: TextStyle(color: Fonts.col_app),
                              ),
                              Container(
                                height: 4,
                              ),
                              new Text(widget.partner.description),
                              Container(
                                height: 12,
                              ),
                              /*  Text(
                                    LinkomTexts.of(context).sector()+ ":",
                                    style: TextStyle(color: Fonts.col_app),
                                  ),
                                  Container(
                                    height: 4,
                                  ),
                                  new Text(widget.partner.se),*/
                              Container(
                                height: 12,
                              ),
                              Text(
                                "Adresse:",
                                style: TextStyle(color: Fonts.col_app),
                              ),
                              Container(
                                height: 4,
                              ),
                              new Text(widget.partner.address.toString() =="null"?"":widget.partner.address)
                            ],
                          ),
                        ),

                        new StreamParcPub(
                          new Container(),
                          widget.lat,
                          widget.lng,
                          widget.user,
                          "0",
                          null,
                          null,
                          setSount2,
                          widget.chng,
                          category: "news",
                          cat: widget.partner.objectId,
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
                          "1",
                          null,
                          null,
                          setSount4,
                          widget.chng,
                          category: "event",
                          cat: widget.partner.objectId,
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
                          "1",
                          null,
                          null,
                          setSount5,
                          widget.chng,
                          sector: "",
                          category: "opportunite",
                          cat: widget.partner.objectId,
                          revue: false,
                          video: false,
                          favorite: false,
                          boutique: false,
                        ),
                        new StreamParcPub(
                          new Container(),
                          widget.lat,
                          widget.lng,
                          widget.user,
                          "0",
                          null,
                          null,
                          setSount6,
                          widget.chng,
                          category: "prod_service",
                          cat: widget.partner.objectId,
                          favorite: false,
                          boutique: false,
                          revue: false,
                          video: false,
                          auth: null,
                          context: context,
                        )
                      ])),
            )
          ])
        ])) /*Scaffold(
      appBar: new AppBar(),
      body: new ListView(
        children: <Widget>[
          new Container(
              color: Colors.grey[200],
              height: 300.0,
              child: new Swiper(
                autoplay: false,
                loop: false,
                itemBuilder: (BuildContext context, int index) {
                  return new Container(
                      color: Colors.grey[200],
                      child: new FadingImage.network(
                        widget.partner.logo.toString()
                            /*"http://via.placeholder.com/350x150"*/,
                        fit: BoxFit.cover,
                      ));
                },
                itemCount: 1,
                //pagination: new SwiperPagination(),
               // control: new SwiperControl(),
              )),
          new Container(height: 12.0),
          new Container(
            padding: new EdgeInsets.only(left: 2.0, right: 2.0),
            child:
              HtmlWidget(
              widget.partner.name.toString().replaceAll(RegExp(r'(\\n)+'), ''),
                config: new Config(
                  baseUrl: Uri.parse('/'),
                  onLinkTap: (String url) {

                  },
                ),
              )
          ),
          new Container(
            padding: new EdgeInsets.only(left: 2.0, right: 2.0),
            child:
              HtmlWidget(
              widget.partner.description.toString().replaceAll(RegExp(r'(\\n)+'), ''),
      config: new Config(
        baseUrl: Uri.parse('/'),
        onLinkTap: (String url) {

        },
      ),
    )
          ),
          new Container(
            padding: new EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new GestureDetector(
                  onTap: () {
                    /* var lat = shop.latLng.toString().split(";")[0];
                    var lng = shop.latLng.toString().split(";")[1];
                    _launched = _launch('https://www.google.com/maps/@$lat,$lng,16z');
*/
                  },
                  child: new Icon(
                    Icons.location_on,
                    color: Colors.grey[600],
                  ),
                ),
                new Container(
                  width: 4.0,
                ),
                new Text(
                  widget.partner.address,
                  style: new TextStyle(color: Colors.grey[600]),
                )
              ],
            ),
          ),
        ],
      ),
    )*/
    ;
  }
}
