import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong/latlong.dart';
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
import 'package:mycgem/widgets/chambre_conseil.dart';
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
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.9,
                child: RichText(
                    textAlign: TextAlign
                        .left,
                    text: new TextSpan(
                      text:
                      "",
                      children: <
                          TextSpan>[
                        new TextSpan(
                          text: "Vous n'avez actuellement pas accès aux opportunités d'affaires. Pour plus d'informations, contactez-nous à : ",
                          style: TextStyle(
                              color: Colors
                                  .grey[600],
                              fontSize: 15),
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

                                launch(
                                    _emailLaunchUri
                                        .toString());
                              },
                            style: new TextStyle(
                                decoration: TextDecoration
                                    .underline,
                                color: Colors
                                    .blue,
                                fontSize: 16.0,
                                fontWeight: FontWeight
                                    .w500))
                      ],
                    )))),
      )
          : (widget.user.entreprise.situation != "Ajour" &&
          selectedValue == "Opportunités d'affaires")
          ? SliverToBoxAdapter(
        child: Container(
            padding: EdgeInsets.only(top: 60, left: 12, right: 12),
            child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.9,
                child: RichText(
                    textAlign: TextAlign
                        .left,
                    text: new TextSpan(
                      text:
                      "",
                      children: <
                          TextSpan>[
                        new TextSpan(
                          text: "Vous n'avez actuellement pas accès aux opportunités d'affaires. Pour plus d'informations, contactez-nous à : ",
                          style: TextStyle(
                              color: Colors
                                  .grey[600],
                              fontSize: 15),
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

                                launch(
                                    _emailLaunchUri
                                        .toString());
                              },
                            style: new TextStyle(
                                decoration: TextDecoration
                                    .underline,
                                color: Colors
                                    .blue,
                                fontSize: 16.0,
                                fontWeight: FontWeight
                                    .w500))
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

    return Container(
      child: Column(
        children: <Widget>[horizontal_list(), Expanded(child: cases_widgets())],
      ),
      color: Fonts.col_grey.withOpacity(0.16),
    );
  }
}
