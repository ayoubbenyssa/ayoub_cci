import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mycgem/fils_actualit/wall_card.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/models/offers.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/posts_services.dart';
import 'package:mycgem/widgets/app_appbar.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CommissionNews extends StatefulWidget {
  CommissionNews( this.user,this.chng,this.comm_id,this.title);
  User user;
  var chng;
  String comm_id;
  String title;


  @override
  _FeederationsNewsState createState() => _FeederationsNewsState();
}

class _FeederationsNewsState extends State<CommissionNews> {
  List<Offers> list = new List<Offers>();
  ScrollController _hide_bar_mur = new ScrollController();

  var noPost = "";
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

  getLIst() async {
    all_list = [];
    list = [];

    var a = await PostsServices.get_pub_type_commissions(
      skip * 4,
      "commissions",
      widget.user,
      verify,
      widget.comm_id
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


  showwidgets(List<Offers> result) {
    //if (skip == 0) count = result.length ;

    for (Offers item in result) {
      count2++;

      listWidget.add( Wall_card(item, widget.user, [],
          0.0, 0.0, null, widget.chng));
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
    _hide_bar_mur.addListener(() {
      if (_hide_bar_mur.position.atEdge) {
        streampost(count2);
      }
    });
    //  await getUser(widget.user.id);
    streampost(skip);
  }

  @override
  void initState() {
    super.initState();
    getdata();

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
                    noPost,
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

      Widget listposts = new SliverList(
          delegate:
          new SliverChildListDelegate(new List<Widget>.from(listWidget)));

      Widget scrollview =
      new CustomScrollView(controller: _hide_bar_mur, slivers: [
        silverheader,
        // widget.silver == null ? new SliverToBoxAdapter() : widget.silver,
        isLoading ? loading : listposts,
        bottom,
      ]);

      return new RefreshIndicator(
          onRefresh: () => getrefresh(),
          child: scrollview,
          key: _refreshIndicatorKey);
    }





    return Scaffold(
        appBar:   MyCgemBarApp(
          widget.title,
          actionswidget: Container(),
        ),

        body: new Builder(builder: buildBody));

  }
}
