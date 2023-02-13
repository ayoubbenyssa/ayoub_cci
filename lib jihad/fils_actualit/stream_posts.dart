import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong/latlong.dart';
import 'package:mycgem/accueil/gallery_widget.dart';
import 'package:mycgem/accueil/videos_list.dart';
import 'package:mycgem/cards/opp_card.dart';
import 'package:mycgem/cards/pub_parc_card.dart';
import 'package:mycgem/cards/sonagecard.dart';
import 'package:mycgem/communities/communities.dart';
import 'package:mycgem/communities/federations.dart';
import 'package:mycgem/fils_actualit/wall_card.dart';
import 'package:mycgem/filter/federation.dart';
import 'package:mycgem/filter/filter_by_commission.dart';
import 'package:mycgem/filter/filter_by_region.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/checked.dart';
import 'package:mycgem/models/commission.dart';
import 'package:mycgem/models/offers.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/posts_services.dart';
import 'package:mycgem/widgets/allhome.dart';
import 'package:mycgem/widgets/chambre_conseil.dart';
import 'package:mycgem/widgets/custom_widgets/buttons_appbar.dart';
import 'package:mycgem/widgets/fixdropdown.dart';
import 'package:mycgem/widgets/groups_commission.dart';
import 'package:mycgem/widgets/services_pre.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class StreamPots extends StatefulWidget {
  StreamPots(this.user, this.lat, this.lng, this.list_partners, this.analytics,
      this._isVisible1, this._hide_bar_mur, this.chng);

  User user;
  var lat;
  var lng;
  var list_partners;
  var analytics;
  var _isVisible1;
  var _hide_bar_mur;
  var chng;

  @override
  _StreamPotsState createState() => _StreamPotsState();
}

class _StreamPotsState extends State<StreamPots> with TickerProviderStateMixin {
  List<Offers> list = new List<Offers>();
  ScrollController _hideButtonController1 = new ScrollController();
  TabController _controller;
  String verify;

  TabController _tabController;
  bool isPlaying = false;

  var noPost = "";
  bool story = false;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  SliverPersistentHeaderDelegate delegate;
  List listWidget = new List();
  bool isLoading = true;
  int skip = 0;

  //var count = 0;
  var count2 = 0;
  int indx = 0;

  List _list = [];

  String selectedValue = "news";
  String selected_type = "news";

  strt() {
    setState(() {
      story = true;
    });
    new Timer(const Duration(seconds: 1), () {
      try {
        setState(() => story = false);
      } catch (e) {
        e.toString();
      }
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    //  if (_controllerv != null) _controllerv.pause();
  }

  Reload() {
    setState(() => isLoading = true);
    skip = 0;
    if (selected_type == "center") {
      setState(() {
        isLoading = false;
      });
    }
    streampost(0);
  }

  Future<List<Offers>> getLIst() async {
    list = [];

    if (selected_type == "center")
      setState(() {
        list = [];
      });
    else {
      var a = await PostsServices.get_pub_type(
          skip, selected_type, widget.user, verify);
      list = a["results"];
    }

    ///count = list.length;

    if (this.mounted)
      setState(() {
        isLoading = false;
      });

    return list;
  }

  errorrequest(text) {
    var errorWithYourRequest = "Error";
    if (text == "nointernet")
      errorWithYourRequest =
          "S'il vous plait vérifier votre connexion internet!";
    Scaffold.of(context).showSnackBar(new SnackBar(
      duration: new Duration(seconds: 5),
      content: new Text(errorWithYourRequest,
          style: new TextStyle(color: Colors.red[900])),
      action: new SnackBarAction(
          label: "try again",
          onPressed: () {
            streampost(skip);
          }),
    ));
  }

  Distance distance = new Distance();

  eventcard(Offers postdata) {
    if (postdata.latLng.isNotEmpty && postdata.latLng.toString() != "null") {
      print(4444);
      print(postdata.latLng);

      if (postdata.latLng.split(";")[0] != null &&
          postdata.latLng.split(";")[1] != null) {
        postdata.dis = "-.- " + "Kms";
      } else
        postdata.dis = distance
                .as(
                    LengthUnit.Kilometer,
                    new LatLng(double.parse(postdata.latLng.split(";")[0]),
                        double.parse(postdata.latLng.split(";")[1])),
                    new LatLng(widget.lat, widget.lng))
                .toString() +
            " " +
            "Kms";
    } else {
      postdata.dis = "-.- " + "Kms";
    }
    return Container(
        child: new ParcPubCard(postdata, widget.user, true, [], null,
            widget.analytics, context, widget.lat, widget.lng, widget.chng));
  }

  streampost(skipp) async {
    if (skipp == 0) listWidget = new List();
    List<Offers> result = await getLIst();

    if (!this.mounted) return;

    setState(() => isLoading = false);

    if (result == "nointernet" || result == "error")
      errorrequest(result);
    else if (result == "empty" || result == "nomoreresults")
      noPosts(result);
    else
      showwidgets(result);
  }

  getdata() async {
    _hideButtonController1.addListener(() {
      if (_hideButtonController1.position.atEdge) {
//  if (count2 < count)
        streampost(count2);
      }
    });
    streampost(skip);
  }

  /* initializeRemoteConfig() async {
    RemoteConfigService _remoteConfigService;
    _remoteConfigService = await RemoteConfigService.getInstance();
    await _remoteConfigService.initialize();
    print(_remoteConfigService.getUrl.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("############# api_url 12");
    print(_remoteConfigService.getUrl);
    prefs.setString('api_url', _remoteConfigService.getUrl);
    // prefs.setString('api_url', "http://umpo.ml/api");
    // http://umpo.ml/api
  }*/
  ParseServer parseFunctions = new ParseServer();

  getUser(id) async {
    var a = await parseFunctions
        .getparse('users?where={"objectId":"$id"}&include=fonction');
    if (!this.mounted) return;
    setState(() {
      verify = a["results"][0]["verify"].toString();
    });
  }

  @override
  void initState() {
    super.initState();

    print("%%%%%%%%%%%%%%%%%%");
    // initializeRemoteConfig();
    print("%%%%%%%%%%%%%%%%%%");

// Optional: enter your test device ids here
    /*  _controller.setTestDeviceIds([
      "ca-app-pub-3542535357117024/6214301788",
      ""
    ]);*/

    _list = [
      {"name": "Accueil", "type": "all"},
      {"name": "Actualités", "type": "news"},
      {"name": "Agenda / Événement", "type": "event"},
      {
        "name": "Opportunités d'affaires",
        "type": "opportunite",
        "isSelected": false
      },
    //  {"name": "Offres Stage / Emploi", "type": "Offres Stages/Emplois_emi"},
      {"name": "Photothèque", "type": "gellery"},
      {"name": "Vidéothèque", "type": "videotheque"},
  //    {"name": "Objets perdus", "type": "Objets perdus_emi"},
     // {"name": "Sondages", "type": "sondage"}
    ];
    _controller = TabController(length: _list.length, vsync: this);

//VideoRca
    getdata();
  }

  @override
  void dispose() {
    super.dispose();
  }

  noPosts(type) {
    try {
      if (type == "nomoreresults")
        setState(() => noPost = "Il n y a aucun autre résultat");
      else
        setState(() => noPost = "Aucun post trouvé");
    } catch (e) {
      e.toString();
    }
  }

  getrefresh() {
    skip = 0;

    streampost(0);
    Completer<Null> completer = new Completer<Null>();
    new Timer(new Duration(seconds: 1), () {
      completer.complete();
    });
    return completer.future;
  }

  ld(i) {
    /* if (_list[i]["type"] == "tous") {
      setState(() {
        selectedValue = "Type de publication";
        selected_type = "";
      });
      //com = value;
      Reload();
    } */
    setState(() {
      selectedValue = _list[i]["name"];
      selected_type = _list[i]["type"];
    });
    //com = value;
    Reload();
  }

  st(i) {
    setState(() {
      indx = i;
    });
    ld(i);
  }

  st3(i) {
    st(i);
    _controller.animateTo(i);
  }

  showwidgets(List<Offers> result) {
    for (Offers item in result) {
      count2++;

      print('--------------------------------------');
      print(item.type);

      listWidget.add(Column(children: [
        /* item.type == "videotheque"
            ? YtbeVideo(item.link_id, 190.w, 120.h))
            : */
        item.type == "sondage"
            ? SondageCard(widget.user, item, list, widget.chng)
            : item.type == "event"
                ? /**/
                eventcard(item)
                : Wall_card(item, widget.user, widget.list_partners, widget.lat,
                    widget.lng, widget.analytics, widget.chng),
        /*  (result.indexOf(item) % 10 == 0 /*&& result.indexOf(item) != 0*/)
            ? Container(
                height: 170,
                child: Card(
                    elevation: 1,
                    child: NativeAdmob(
                      adUnitID: AppServices.admobNativeAdIdAndroid,
                      loading: Center(child: CircularProgressIndicator()),
                      error: Text(""),
                      controller: _controller,
                      type: NativeAdmobType.full,
                      options: NativeAdmobOptions(
                        ratingColor: Colors.green,
                        // Others ...
                      ),
                    )))
            : Container(),*/
      ]));
    }

    setState(() => skip += 30);
  }

  @override
  Widget build(BuildContext context) {
    Widget buildBody(BuildContext context) {
      Widget loading = new SliverToBoxAdapter(
          child: new Center(
              child: Padding(
                  padding: EdgeInsets.only(top: 24), child: Widgets.load())));

      Widget header_widget = SliverToBoxAdapter();

      Widget bottom = new SliverToBoxAdapter(
          child: new Center(
              child: new Container(
                  padding: const EdgeInsets.only(
                      top: 85.0, left: 16.0, right: 16.0, bottom: 16.0),
                  child: new Text(noPost))));
      Widget silverheader = new SliverToBoxAdapter(child: Container());

      Widget listposts = new SliverList(
          delegate:
              new SliverChildListDelegate(new List<Widget>.from(listWidget)));

      Widget scrollview =
          new CustomScrollView(controller: _hideButtonController1, slivers: [
        silverheader,
        header_widget,

        // widget.silver == null ? new SliverToBoxAdapter() : widget.silver,
        isLoading ? loading : listposts,
        bottom,
      ]);
      return new RefreshIndicator(
          onRefresh: () => getrefresh(),
          child: scrollview,
          key: _refreshIndicatorKey);
    }

    Widget tbs = Container(
            height: 40.0.h,
            child: ButtonsTabBar(
              backgroundColor: Fonts.col_gr,
              radius: 42.r,
              contentPadding: EdgeInsets.all(6.w),
              borderWidth: 1.0,
              controller: _controller,
              borderColor: Fonts.col_app,
              unselectedBorderColor: Fonts.col_app_fon,
              unselectedBackgroundColor: Colors.white,
              unselectedLabelStyle:
                  TextStyle(color: Fonts.col_app_fon, fontSize: 12.sp),
              labelStyle: TextStyle(
                  fontSize: 12.0.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              onPressed: st,
              tabs: _list.map((a) => new Tab(text: a["name"])).toList(),
            )) /*TabBar(
      onTap: (i) {
        st(i);

        ld(i);
      },
      isScrollable: true,
      indicatorColor: Fonts.col_gr,
      indicatorWeight: 4,
      unselectedLabelColor: Fonts.col_grey,
      labelColor: Colors.black,
      labelStyle: new TextStyle(
          color: Colors.black,
          fontFamily: "Helvetica",
          fontWeight: FontWeight.w600,
          fontSize: 16),
      indicatorPadding: new EdgeInsets.all(0.0),
      tabs: _list
          .map((dynamic a) => isLoading && _list.indexOf(a) != indx
              ? Container(
                  child: new Card(
                      child: Container(
                    padding: EdgeInsets.all(4),
                    margin: new EdgeInsets.only(bottom: 7.0, top: 8.0),
                    color: Colors.grey[100],
                    height: 10.0,
                    width: 70.0,
                  )),
                )
              : new Tab(text: a["name"]))
          .toList(),
    )*/
        ;

    return DefaultTabController(
            initialIndex: 0,
            length: _list.length,
            child: Column(children: <Widget>[
              /* Container(
                  decoration: new BoxDecoration(
                      color: Fonts.col_app_green,
                      image: new DecorationImage(
                          fit: BoxFit.cover,
                          colorFilter: new ColorFilter.mode(
                              Fonts.col_app_green.withOpacity(0.25), BlendMode.dstATop),
                          image: new AssetImage("images/bck1.png"))),
                  child: StoriesWidget(
                widget.user,
                rounded: true,
              )),*/
              // drop_down(),

              Container(height: 12.h),
              Container(
                  //  height: MediaQuery.of(context).size.height * 0.08,
                  child: isLoading
                      ? IgnorePointer(
                          child: tbs,
                        )
                      : tbs),

              Expanded(
                  child: indx == 5
                      ? VideosList()
                      : indx == 4
                          ? GalleryWidget()
                          : indx == 0
                              ? AllHome(
                                  widget.user, widget.lat, widget.lng, st3)
                              : Container(
                                  color: Fonts.col_cl,
                                  child: new Builder(builder: buildBody)))
            ])) /*Scaffold(
        //backgroundColor: Colors.blue[100],
        appBar: AppBar(),
        body: list.isEmpty
            ? Center(child: RefreshProgressIndicator())
            : Container(
               // color: Colors.blue[50],
                child: ListView(
                    padding: EdgeInsets.all(0),
                    children: list.map((Offers item) {
                      return item.type == "cov"
                          ? Cov_Card(
                              item,
                              widget.user,
                              null,
                              null,
                              widget.list_partners,
                              lat: widget.lat,
                              lng: widget.lng,
                            )
                          : Wall_card(item, widget.user, widget.list_partners);
                    }).toList())))*/
        ;
  }

/*
class _StreamPotsState extends State<StreamPots> {
  List<Offers> list = new List<Offers>();

  var noPost = "";
  String selectedValue = "Actualités";

  List<Offers> all_list = new List<Offers>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  SliverPersistentHeaderDelegate delegate;
  List listWidget = new List();
  bool isLoading = true;
  int skip = 0;
  var count2 = 0;
  ParseServer parseFunctions = new ParseServer();
  String verify;
  String select_result = "";

  var j = 0;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    selected_type = "news";
    selectedValue = LinkomTexts.of(context).actu();
    _list = [
      {
        "name": LinkomTexts.of(context).actu(),
        "type": "news",
        "isSelected": true
      },
      {
        "name": LinkomTexts.of(context).agenda(),
        "type": "event",
        "isSelected": false
      },
      {
        "name": "Opportunités d'affaires",
        "type": "opportunite",
        "isSelected": false
      },
      {"name": "Activités régions", "type": "maregion", "isSelected": false},
      {
        "name": "Activités fédérations",
        "type": "federations",
        "isSelected": false
      },
      {
        "name": "Activités commissions",
        "type": "commissions",
        "isSelected": false
      },
      {
        "name": "Groupe parlementaire",
        "type": "parlement",
        "isSelected": false
      },
      {"name": "Services aux membres", "type": "membres", "isSelected": false}
    ];

    /**
        if (widget.user.commissions.length == 0)
        _list.remove(_list
        .where((element) => element["type"] == "commissions")
        .elementAt(0));
        if (widget.user.entreprise.region.toString() == "null")
        _list.remove(
        _list.where((element) => element["type"] == "maregion").elementAt(0));
        if (widget.user.entreprise.federation.toString() == "null")
        _list.remove(_list
        .where((element) => element["type"] == "federations")
        .elementAt(0));
     */
  }

  getLIst() async {
    all_list = [];
    list = [];

    var a = await PostsServices.get_pub_type(
      skip * 4,
      selected_type,
      widget.user,
      verify,
      selected: selectedValue,
    );

    return a;
  }

  errorrequest(text) {
    var errorWithYourRequest = "Error";
    if (text == "nointernet")
      errorWithYourRequest = "Vérifier votre connexion internet!";
    Scaffold.of(context).showSnackBar(new SnackBar(
      duration: new Duration(seconds: 5),
      content: new Text(errorWithYourRequest,
          style: new TextStyle(color: Colors.red[900])),
      action: new SnackBarAction(
          label: "try again",
          onPressed: () {
            streampost(skip);
          }),
    ));
  }

  Distance distance = new Distance();
  String selected_type = "";

  eventcard(Offers postdata) {
    if (postdata.latLng.isNotEmpty && postdata.latLng.toString() != "null") {
      if (postdata.latLng.split(";")[0].toString() == "null" ||
          postdata.latLng.split(";")[0] == "") {
        postdata.dis = "-.- Km";
      } else
        postdata.dis = distance
                .as(
                    LengthUnit.Kilometer,
                    new LatLng(double.parse(postdata.latLng.split(";")[0]),
                        double.parse(postdata.latLng.split(";")[1])),
                    new LatLng(widget.lat, widget.lng))
                .toString() +
            " Km(s)";
    } else {
      postdata.dis = "-.- Km";
    }
    return Container(
        child: new ParcPubCard(postdata, widget.user, true, [], null,
            widget.analytics, context, widget.lat, widget.lng, widget.chng));
  }

  showwidgets(List<Offers> result) {
    //if (skip == 0) count = result.length ;

    for (Offers item in result) {
      count2++;

      listWidget.add(item.type == "sondage"
          ? SondageCard(widget.user, item, list, widget.chng)
          : item.type == "event"
              ? eventcard(item)
              : item.type == "opportunite"
                  ? new OppCard(item, widget.user, widget.lng, widget.lat,
                      context, false, widget.chng)
                  : Wall_card(item, widget.user, widget.list_partners,
                      widget.lat, widget.lng, widget.analytics, widget.chng));
    }

    setState(() => skip += 5);
  }

  streampost(skipp) async {
    setState(() => noPost = "");

    if (skipp == 0) listWidget = new List();
    var result = await getLIst();

    if (!this.mounted) return;

    try {
      setState(() => isLoading = false);
    } catch (e) {
      e.toString();
    }

    if (result == "nointernet" || result == "error")
      errorrequest(result);
    else if (result == "empty" || result == "nomoreresults")
      noPosts(result);
    else
      showwidgets(result["results"]);
  }

  getdata() async {
    widget._hide_bar_mur.addListener(() {
      if (widget._hide_bar_mur.position.atEdge) {
        streampost(count2);
      }
    });
    await getUser(widget.user.id);
    streampost(skip);
  }

  getUser(id) async {
    var a = await parseFunctions
        .getparse('users?where={"objectId":"$id"}&include=fonction');
    if (!this.mounted) return;
    setState(() {
      verify = a["results"][0]["verify"].toString();
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300)).then((value) async {
      getdata();
    });
  }

  noPosts(type) {
    try {
      if (type == "nomoreresults")
        setState(() => noPost = "");
      else
        setState(() => noPost = "Aucun résultat trouvé !");
    } catch (e) {
      e.toString();
    }
  }

  getrefresh() {
    skip = 0;

    streampost(0);
    Completer<Null> completer = new Completer<Null>();
    new Timer(new Duration(seconds: 3), () {
      completer.complete();
    });
    return completer.future;
  }

  Reload() {
    skip = 0;

    if (selected_type != "commissions" &&
        selected_type != "federations" &&
        selected_type != 'parlement' &&
        selected_type != 'membres' &&
        selected_type != "maregion") {
      {
        setState(() {
          isLoading = true;
        });
        streampost(0);
      }
    }
  }

  List _list = [];

  filter_no() {
    setState(() {
      selectedValue = LinkomTexts.of(context).tous();
      select_result = "";
    });
    Reload();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildBody(BuildContext context) {
      Widget loading = new SliverToBoxAdapter(
          child: new Center(
              child: Padding(
                  padding: EdgeInsets.only(top: 32), child: Widgets.load())));

      Widget bottom = new SliverToBoxAdapter(
          child: new Center(
              child: new Container(
                  padding: const EdgeInsets.only(
                      top: 85.0, left: 16.0, right: 16.0, bottom: 16.0),
                  child: new Text(
                    (noPost == "Aucun résultat trouvé !" &&
                            selected_type == "opportunite")
                        ? "Aucune opportunité d’affaires trouvée !"
                        : noPost,
                    style: TextStyle(
                        color: Fonts.col_ap_fonn,
                        fontSize: 15.5.sp,
                        fontWeight: FontWeight.w700),
                  ))));

      Widget silverheader = new SliverToBoxAdapter(
          child: Stack(
        children: <Widget>[
          Positioned(
            child: Container(),
          )
        ],
      ));

      Widget listposts = (widget.user.verify.toString() != "1" &&
              selectedValue == "Opportunités d'affaires")
          ? SliverToBoxAdapter(
              child: Container(
                  padding: EdgeInsets.only(top: 60, left: 12, right: 12),
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: RichText(
                          textAlign: TextAlign.left,
                          text: new TextSpan(
                            text: "",
                            children: <TextSpan>[
                              new TextSpan(
                                text:
                                    "Vous n'avez actuellement pas accès aux opportunités d'affaires. Pour plus d'informations, contactez-nous à : ",
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 15),
                              ),
                              new TextSpan(
                                  text: //(dans une entreprise déjà inscrite au niveau de la plateforme)
                                      "adherents@cgem.ma",
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      final Uri _emailLaunchUri = Uri(
                                        scheme: 'mailto',
                                        path: 'adherents@cgem.ma',
                                      );

// ...

                                      launch(_emailLaunchUri.toString());
                                    },
                                  style: new TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500))
                            ],
                          )))),
            )
          : (widget.user.entreprise.situation != "Ajour" &&
                  selectedValue == "Opportunités d'affaires")
              ? SliverToBoxAdapter(
                  child: Container(
                      padding: EdgeInsets.only(top: 60, left: 12, right: 12),
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: RichText(
                              textAlign: TextAlign.left,
                              text: new TextSpan(
                                text: "",
                                children: <TextSpan>[
                                  new TextSpan(
                                    text:
                                        "Vous n'avez actuellement pas accès aux opportunités d'affaires. Pour plus d'informations, contactez-nous à : ",
                                    style: TextStyle(
                                        color: Colors.grey[600], fontSize: 15),
                                  ),
                                  new TextSpan(
                                      text: //(dans une entreprise déjà inscrite au niveau de la plateforme)
                                          "adherents@cgem.ma",
                                      recognizer: new TapGestureRecognizer()
                                        ..onTap = () {
                                          final Uri _emailLaunchUri = Uri(
                                            scheme: 'mailto',
                                            path: 'adherents@cgem.ma',
                                          );

// ...

                                          launch(_emailLaunchUri.toString());
                                        },
                                      style: new TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.blue,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500))
                                ],
                              )))),
                )
              : new SliverList(
                  delegate: new SliverChildListDelegate(
                      new List<Widget>.from(listWidget)));

      Widget scrollview =
          new CustomScrollView(controller: widget._hide_bar_mur, slivers: [
        silverheader,
        isLoading ? loading : listposts,
        bottom,
      ]);

      return new RefreshIndicator(
          onRefresh: () => getrefresh(),
          child: scrollview,
          key: _refreshIndicatorKey);
    }

    onPressed(var value) {
      setState(() {
        var last_element = _list
            .where((element) => element["name"] == selectedValue)
            .elementAt(0);
        last_element["isSelected"] = false;
        value["isSelected"] = true;
      });

      setState(() {
        selectedValue = value["name"];
        selected_type = value["type"];
        Reload();
      });
    }

    horizontal_list() {
      return Container(
        height: MediaQuery.of(context).size.height * 0.08,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: (_list
              .map((e) => Column(
                    children: [
                      FlatButton(
                        child: Text(
                          e["name"].toUpperCase(),
                          style: TextStyle(
                              fontSize: 12.5.sp,
                              fontFamily: 'coffee',
                              fontWeight: FontWeight.w700),
                        ),
                        onPressed: () => onPressed(e),
                        textColor:
                            e["isSelected"] ? Fonts.col_app : Fonts.col_ap_fonn,
                      ),
                      Container(
                        height: 0,
                      ),
                      Container(
                        width: 60,
                        height: e["isSelected"] ? 5 : 0,
                        color:
                            e["isSelected"] ? Fonts.col_gr : Fonts.col_ap_fonn,
                      )
                    ],
                  ))
              .toList()),
        ),
      );
    }

    cases_widgets() {
      switch (selected_type) {
        case 'maregion':
          return Padding(
              padding: EdgeInsets.only(left: 8.w, top: 8.h, right: 8.0.w),
              child: RegionStream(widget.user, widget.lat, widget.lng, [], null,
                  widget.chng, true, false));
        case 'commissions':
          return Padding(
              padding: EdgeInsets.only(left: 6.w, top: 8.h, right: 6.0.w),
              child: CommissionsStream(widget.user, widget.lat, widget.lng, [],
                  null, widget.chng, false));
        case 'federations':
          return Padding(
              padding: EdgeInsets.only(left: 6.w, top: 8.h, right: 6.0.w),
              child: FederationsStream(widget.user, widget.lat, widget.lng, [],
                  null, widget.chng, false, false));
        case 'parlement':
          return ChambreConseil(false);
        case 'membres':
          return new ServicesPre(
              widget.lat, widget.lng, widget.user, widget.chng);
        default:
          return new Builder(builder: buildBody);
      }
    }

    /**
     *      Expanded(
        child: indx == 6
        ? VideosList()
        : indx == 5
        ? GalleryWidget()
        : indx == 0
        ? AllHome(
        widget.user, widget.lat, widget.lng, st3)
        : Container(
        color: Fonts.col_cl,
        child: new Builder(builder: buildBody)))
    return Container(
      child: Column(
        children: <Widget>[horizontal_list(), Expanded(child: cases_widgets())],
      ),
      color: Fonts.col_grey.withOpacity(0.16),
    );
  }
}
*/*/
}
