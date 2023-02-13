import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

//import 'package:flutter_nativeads/flutter_nativeads.dart';
import 'package:latlong/latlong.dart';
import 'package:mycgem/cards/annonce_card.dart';
import 'package:mycgem/cards/commande_card.dart';
import 'package:mycgem/cards/commission_card.dart';
import 'package:mycgem/cards/opp_card.dart';
import 'package:mycgem/cards/region_card_filter.dart';
import 'package:mycgem/cards/revue_press.dart';
import 'package:mycgem/cards/search_group_widget.dart';
import 'package:mycgem/cards/sonagecard.dart';
import 'package:mycgem/cards/user_item_card.dart';
import 'package:mycgem/cards/video_card.dart';
import 'package:mycgem/cards/promotion_card.dart';
import 'package:mycgem/cards/pub_parc_card.dart';
import 'package:mycgem/entreprise/entreprise_card.dart';
import 'package:mycgem/entreprise/entreprise_card_search.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/commission.dart';
import 'package:mycgem/models/conversation_g.dart';
import 'package:mycgem/models/favorite.dart';
import 'package:mycgem/models/membre.dart';
import 'package:mycgem/models/offers.dart';
import 'package:mycgem/models/partner.dart';
import 'package:mycgem/models/region.dart';
import 'package:mycgem/models/revue.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/models/video.dart';
import 'package:mycgem/parc_events_stream/stream_parc_events_func.dart';
import 'package:mycgem/search/search_user_widget.dart';
import 'package:mycgem/services/Fonts.dart';

import 'package:mycgem/widgets/widgets.dart';
import 'package:mycgem/youtube_videos/views/youtube_card.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StreamParcPub extends StatefulWidget {
  StreamParcPub(this.widgetheader, this.lat, this.lng, this.user, this.tpe,
      this.list_partner, this.analytics, this.count_posts, this.chng,
      {this.widgetfooter,
        this.auth,
        this.category,
        this.filter,
        this.sector,
        this.suivis,
        this.display_photo = false,
        this.likepost,
        this.searchText,
        this.commission,
        this.show_post = false,
        this.federation,
        this.region,
        this.reg,
        this.video,
        this.idp,
        this.member,
        this.partner_id,
        this.boutique,
        this.type,
        this.type_promo,
        this.chat,
        this.idpost,
        this.sector_promo,
        this.user_stream,
        this.search_posts,
        this.search_type,
        this.search_entreprise,
        this.bool_sector,
        this.dep,
        this.dest,
        this.gender,
        this.type_groupe,
        this.tpe_group,
        this.genre,
        this.obj,
        this.profile,
        this.func,
        this.entreprise,
        this.da,
        this.user_id_cov,
        this.search,
        this.cat,
        this.revue,
        this.favorite,
        this.funct_users,
        this.bl_search,
        this.context,
        Key key})
      : super(key: key);
  bool bool_sector;
  final Widget widgetheader;
  final Widget widgetfooter;
  var count_posts;
  var lat;
  var genre;
  var gender;
  bool display_photo;
  Region region;
  bool show_post;

  var chng;
  var type_groupe;
  var tpe_group;
  var filter;
  var lng;
  var sector_promo;
  var chat;
  var auth;
  bool revue = false;
  var idpost;
  var suivis;
  Commission commission;
  Commission federation;
  String type_promo;
  var profile;
  var search_entreprise;
  var user_stream;
  String tpe;
  List list_partner;
  var searchText;
  var funct_users;
  String obj;
  User user;
  String member;
  var sector;
  bool video = false;
  List<String> entreprise;
  String partner_id;
  var idp;
  bool reg;

  var bl_search;
  var likepost;

  var search_posts;
  var search_type;
  final String type;
  var dep;
  var dest;
  var da;
  var cat;
  String user_id_cov;
  bool boutique = false;
  bool favorite = false;
  var context;
  final String category;
  var analytics;
  var search = "";
  var func;

//  final User current;

  @override
  _StreamPostsState createState() => new _StreamPostsState();
}

class _StreamPostsState extends State<StreamParcPub> {
  ScrollController scrollController = new ScrollController();

  StreamPostsFunctions streamPosts = new StreamPostsFunctions();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  SliverPersistentHeaderDelegate delegate;
  List listWidget = new List();
  bool isLoading = true;
  var skip = 0;
  var count = 0;
  var count2 = 0;
  var noPost = "";
  ParseServer parseFunctions = new ParseServer();

  //String verify;

  //calculate distance
  Distance distance = new Distance();

  /* getUser(id) async {
    var a = await parseFunctions
        .getparse('users?where={"objectId":"$id"}');
    if (!this.mounted) return;
    print(a);

    setState(() {
      verify = a["results"][0]["verify"].toString();
      print(verify);
    });
  }*/

  getdata() async {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        /* if (widget.category == "opportunite" && verify != "1") {
        } else if (count2 < count) */
        streampost(count2);
      }
    });

    //if(widget.type_promo == "cgem")
    // await getUser(widget.user.id);
    streampost(skip);
  }

  getrefresh() {
    streampost(0);
    Completer<Null> completer = new Completer<Null>();
    new Timer(new Duration(seconds: 3), () {
      completer.complete();
    });
    return completer.future;
  }

  var result;
  var load = false;

  streampost(skipp) async {
    if (skipp == 0) listWidget = new List();

    /*

     var genre;
  var type_groupe;
  var tpe_group;
     */
    var a = await streamPosts.fetchposts(widget.user, "",
        obj: widget.obj,
        gender: widget.gender,
        commission: widget.commission,
        federation: widget.federation,
        search_type: widget.search_type,
        search_entreprise: widget.search_entreprise,
        user_stream: widget.user_stream,
        region: widget.region,
        filter: widget.filter,
        lat: widget.lat,
        lng: widget.lng,
        genre: widget.genre,
        type_groupe: widget.type_groupe,
        tpe_group: widget.tpe_group,
        partner_id: widget.partner_id,
        idp: widget.idp,
        sector_promo: widget.sector_promo,
        type_promo: widget.type_promo,
        likepost: widget.likepost,
        revue: widget.revue,
        video: widget.video,
        category: widget.category,
        cat: widget.cat,
        suivis: widget.suivis,
        type: widget.type,
        skip: skipp,
        search: widget.search,
        sector: widget.sector,
        entreprise: widget.entreprise,
        dep: widget.dep,
        dest: widget.dest,
        da: widget.da,
        boutique: widget.boutique,
        idpost: widget.idpost,
        favorite: widget.favorite,
        member: widget.member,
        search_posts: widget.search_posts,
        user_cov_id: widget.user_id_cov);

    if (!this.mounted) return;

    setState(() {
      result = a;
    });

    try {
      setState(() => isLoading = false);
    } catch (e) {
      e.toString();
    }

    print("----------------<<<<<<------------------------");
    print(result);

    if (result == "nointernet" || result == "error")
    errorrequest(result);
    else if (result == "empty" || result == "nomoreresults")
      noPosts(result);
    else
      showwidgets(result);
  }

  list_func() {
    for (int i = 0; i < result["results"].length; i++) {
      setState(() {
        print(result["results"][i].check);
        result["results"][i].check = false;
        //listWidget.removeAt(i);
        // listWidget.insert(i, new Entreprise_card(result["results"][i],func: list_func,),);
      });
    }
    setState(() {
      load = true;
    });

    new Timer(const Duration(milliseconds: 300), () {
      try {
        setState(() => load = false);
      } catch (e) {
        e.toString();
      }
    });
  }

  add_wid() {
    return listWidget.add(Container(
        padding: EdgeInsets.all(8),
        child: new RaisedButton(
          color: Colors.grey[200],
          onPressed: () async {
            return await showDialog(
                context: context,
                builder: (BuildContext context) => new AlertDialog(
                    contentPadding: const EdgeInsets.all(16.0),
                    content: Container(
                        height: 160,
                        child: Column(children: <Widget>[
                          Text(LinkomTexts.of(context).option()),
                        ]))));
          },
          child: Text(
            "Voir autres opportunités",
            style: TextStyle(color: Fonts.col_app),
          ),
        )));
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
        setState(() => noPost = LinkomTexts.of(context).aucun());
    } catch (e) {
      e.toString();
    }
  }


  showwidgets(result) {

    print("****************************************************************");
    print(result["count"]);

    widget.count_posts(result["count"]);

    if (skip == 0) count = result["count"];

    if (result["results"].length != 0) {
      for (var post in result["results"]) {
        count2++;

        //UserSearchWidget(widget.user_me,user,widget.list, widget.analytics)

        if (widget.revue == true) {
          Revue postdata;
          postdata = post;

          print(postdata);

          listWidget.add(new RevueCard(widget.user, postdata));

          setState(() => skip += 20);
        } else if (widget.user_stream.toString() != "null" &&
            widget.user_stream.toString() == "users") {

          print("----------------------------");
          print(widget.user_stream);
          print(widget.filter);
          print("----------------------------");

          if (widget.filter == "region") {
            Membre postdata;
            postdata = post;
            listWidget.add(Entreprise_card_search(
                postdata, widget.user, widget.lat, widget.lng, widget.chng));
            setState(() => skip += 20);
          }

          else     if (widget.filter == "federations") {
            Membre postdata;
            postdata = post;
            print(postdata.name);
            listWidget.add(Entreprise_card_search(
                postdata, widget.user, widget.lat, widget.lng, widget.chng));
            setState(() => skip += 20);
          }

          else {
            User postdata;
            postdata = post;
            if (widget.filter == "proche") {
              if (postdata.lat == "")
                postdata.dis = "-.- Km";
              else if (postdata.lat == "0" || postdata.lat.toString() == "null")
                postdata.dis = "-.- Km";
              else {
                if (postdata.lat.toString() != "null" && postdata.lat != "") {
                  postdata.dis = distance
                      .as(
                      LengthUnit.Kilometer,
                      new LatLng(double.parse(postdata.lat),
                          double.parse(postdata.lng)),
                      new LatLng(widget.lat, widget.lng))
                      .toString() +
                      " Km(s)";
                } else {
                  postdata.dis = "-.- Kms";
                }
              }
            }

            listWidget.add(UserItemWidget(
                widget.user,
                postdata,
                widget.list_partner,
                widget.analytics,
                widget.chng,
                widget.filter));

            setState(() => skip += 20);
          }
        } else if (widget.user_stream.toString() != "null" &&
            widget.user_stream.toString() == "entreprise") {
          Membre postdata;
          postdata = post;

          listWidget.add(Entreprise_card_search(
              postdata, widget.user, widget.lat, widget.lng, widget.chng));

          setState(() => skip += 20);
        } else if (widget.user_stream.toString() != "null" &&
            widget.user_stream.toString() == "region") {
          Region postdata;
          postdata = post;

          listWidget.add(Region_card_filter(postdata, widget.user, widget.lat,
              widget.lng, widget.chng, widget.reg, widget.show_post));

          setState(() => skip += 20);
        } else if (widget.user_stream.toString() != "null" &&
            widget.user_stream.toString() == "commission" ||
            widget.user_stream.toString() == "federation") {
          Commission postdata;
          postdata = post;

          print("-----dkdkdkdkdk");
          print(widget.filter);

          listWidget.add(Commission_card_search(
              postdata,
              widget.user,
              widget.lat,
              widget.lng,
              widget.chng,
              widget.display_photo,
              widget.bool_sector,
              type: widget.user_stream.toString()));

          setState(() => skip += 20);
        } else if (widget.type == "sondage") {
          Offers postdata;
          postdata = post;

          listWidget.add(SondageCard(
            widget.user,
            postdata,
            [],
            widget.chng,
          ));

          setState(() => skip += 20);
        } else if (widget.video != false && widget.video != null) {
          YT_API postdata;
          postdata = post;

          listWidget.add(YoutubeCard(widget.user, postdata, widget.chng));

          setState(() => skip += 20);
        } else if (widget.likepost != null && widget.likepost != "") {
          User postdata;
          postdata = post;

          listWidget.add(UserSearchWidget(widget.user, postdata,
              widget.list_partner, widget.analytics, widget.chng));
        } else if (widget.search != "" && widget.search != null) {
          User postdata;
          postdata = post;

          if (widget.bl_search == "true") {
            print("yeessss");
            listWidget.add(UserSearchWidgetGroup(widget.user, postdata,
                widget.list_partner, widget.analytics, widget.chat,
                funct_users: widget.funct_users));
          } else {
            print("nooo");
            listWidget.add(UserItemWidget(widget.user, postdata,
                widget.list_partner, widget.analytics, widget.chng, ""));
          }

          setState(() => skip += 20);
        }

        if (widget.search_entreprise != "" &&
            widget.search_entreprise != null) {
          Membre postdata;
          postdata = post;

          listWidget.add(Entreprise_card_search(
              postdata, widget.user, widget.lat, widget.lng, widget.chng));

          setState(() => skip += 20);
        } else if (widget.member != "" && widget.member.toString() != "null") {
          User postdata;
          postdata = post;
          listWidget.add(UserItemWidget(
              widget.user, postdata, widget.lat, widget.lng, widget.chng, ""));
          setState(() => skip += 20);
        } else if (widget.search_posts.toString() != "null") {
          Offers postdata;
          postdata = post;

          print(
              '----------------------------------------------------------------------------------');

          if (widget.search_type == "opportunite") {
            listWidget.add(new OppCard(
              postdata,
              widget.user,
              widget.lng,
              widget.lat,
              context,
              false,
              widget.chng,
            ));
            setState(() => skip += 20);
          } else {
            listWidget.add(new ParcPubCard(
              postdata,
              widget.user,
              widget.tpe,
              widget.list_partner,
              widget.auth,
              widget.analytics,
              widget.context,
              widget.lat,
              widget.lng,
              widget.chng,
            ));
          }
          setState(() => skip += 20);
        } else if (widget.category != "" &&
            widget.category != null &&
            widget.category == "opportunite") {
          Offers postdata;
          postdata = post;
          parseFunctions.putparse(
              "offers/" + postdata.objectId, {"views": postdata.views + 1});
          listWidget.add(new OppCard(
            postdata,
            widget.user,
            widget.lng,
            widget.lat,
            context,
            false,
            widget.chng,
          ));
          setState(() => skip += 20);
          break;
        } else if (widget.category == "promotion") {
          Offers postdata;
          postdata = post;

          listWidget.add(new PromotionsCard(
              postdata, widget.user, false, true, widget.chng,
              verify: ""));
          setState(() => skip += 20);
        } else if (widget.category != "" &&
            widget.category != null &&
            widget.category.toString() == "prod_service") {
          Offers postdata;
          postdata = post;
          listWidget.add(new ParcPubCard(
            postdata,
            widget.user,
            widget.tpe,
            widget.list_partner,
            widget.auth,
            widget.analytics,
            widget.context,
            widget.lat,
            widget.lng,
            widget.chng,
          ));
          setState(() => skip += 20);
        } else if (widget.category != "" &&
            widget.category != null &&
            widget.cat.toString() != "null" &&
            widget.cat != "") {
          Offers postdata;
          postdata = post;

          if (postdata.latLng.isNotEmpty &&
              postdata.latLng.toString() != "null") {
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
          listWidget.add(new ParcPubCard(
            postdata,
            widget.user,
            widget.tpe,
            widget.list_partner,
            widget.auth,
            widget.analytics,
            widget.context,
            widget.lat,
            widget.lng,
            widget.chng,
          ));
          setState(() => skip += 20);
        } else if (widget.idpost != null && widget.idpost != "") {
          User postdata;
          postdata = post;

          listWidget.add(UserSearchWidget(
            widget.user,
            postdata,
            null,
            null,
            widget.chng,
          ));
          setState(() => skip += 20);
        } else if (widget.entreprise.toString() != "" &&
            widget.entreprise.toString() != "null") {
          Membre postdata;
          postdata = post;

          listWidget.add(new Entreprise_card(
              post, widget.searchText, list_func, widget.func));
          setState(() => skip += 30);
        } else if (widget.category != "" &&
            widget.category != null &&
            widget.category == "commande") {
          Offers postdata;
          postdata = post;
          parseFunctions.putparse(
              "offers/" + postdata.objectId, {"views": postdata.views + 1});
          listWidget.add(new CommCard(
            postdata,
            widget.user,
            widget.lng,
            widget.lat,
            context,
            false,
            widget.chng,
          ));
          setState(() => skip += 20);
        } else if (widget.category != "" && widget.category != null) {
          print("if 1");
          Offers postdata;
          postdata = post;
          parseFunctions.putparse(
              "offers/" + postdata.objectId, {"views": postdata.views + 1});

          if (postdata.latLng.isNotEmpty &&
              postdata.latLng.toString() != "null") {
            print("if 2");

            if (postdata.latLng.split(";")[0].toString() == 'null' ||
                postdata.latLng.split(";")[0] == "")
              postdata.dis = "-.- Km";
            else
              print("if 3");
            print("widget.lat  ${widget.lat}");
            print("widget.lng  ${widget.lng}");


            postdata.dis = distance
                  .as(
                  LengthUnit.Kilometer,
                  new LatLng(
                      double.parse(postdata.latLng.split(";")[0]),
                      double.parse(postdata.latLng.split(";")[1])),
                  new LatLng(double.parse(widget.lat), double.parse(widget.lng)))
                  .toString() +
                  " Km(s)";
          } else {
            postdata.dis = "-.- Km";
          }

          /* if (result["results"].indexOf(post) % 1 == 0) {
            listWidget.add(AppInstalledAd());
          }*/

          listWidget.add(new ParcPubCard(
            postdata,
            widget.user,
            widget.tpe,
            widget.list_partner,
            widget.auth,
            widget.analytics,
            widget.context,
            double.parse(widget.lat),
            double.parse(widget.lng),
            widget.chng,
          ));
          setState(() => skip += 20);
        } else if (widget.type != "" &&
            widget.type != null &&
            widget.type != "sondage") {
          Offers postdata;
          postdata = post;

          parseFunctions.putparse(
              "offers/" + postdata.objectId, {"views": postdata.views + 1});

          listWidget.add(new AnnonceCard(
            postdata,
            widget.user,
            null,
            null,
            widget.analytics,
            null,
            widget.list_partner,
            widget.chng,
          ));
          setState(() => skip += 20);
        }
      }

      /*if (widget.category == "opportunite" && verify != "1") {
        add_wid();
      } else if (widget.category == "Annonces" && verify != "1") {
        add_wid();
      }*/

      /*if (count2 >= count) {
        noPosts("nomoreresults");
      } else {}*/
    }
  }

  @override
  initState() {
    super.initState();
    getdata();

    // setupNativeAd();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildBody(BuildContext context) {
      Widget loading = new SliverToBoxAdapter(
          child: Padding(
              padding: EdgeInsets.only(top: 32), child: Widgets.load()));
      Widget bottom = new SliverToBoxAdapter(
          child: new Center(
              child: new Container(
                  padding: const EdgeInsets.only(
                      top: 86.0, left: 16.0, right: 16.0, bottom: 16.0),
                  child: new Text(
                    noPost,
                    style: TextStyle(
                        color: Fonts.col_ap_fonn,
                        fontSize: 15.5.sp,
                        fontWeight: FontWeight.w700),
                  ))));

      Widget silverheader = new SliverToBoxAdapter(child: widget.widgetheader);

      Widget listposts = widget.revue || widget.boutique || widget.favorite
          ? new SliverGrid.count(
          crossAxisCount: widget.revue ? 2 : 2,
          childAspectRatio: widget.revue ? 0.7 : 0.90,
          //mainAxisSpacing: 4.0,
          //crossAxisSpacing: 4.0,
          children: new List<Widget>.from(listWidget))
          : new SliverList(
          delegate: new SliverChildListDelegate(
              new List<Widget>.from(listWidget)));

      Widget scrollview =
      new CustomScrollView(controller: scrollController, slivers: [
        silverheader,
        // widget.silver == null ? new SliverToBoxAdapter() : widget.silver,
        load
            ? new SliverToBoxAdapter(
            child: Padding(
                padding: EdgeInsets.only(top: 32), child: Container()))
            : isLoading
            ? widget.boutique || widget.favorite || widget.revue
            ? Container()
            : loading
            : listposts,
        bottom
      ]);
      return new RefreshIndicator(
          onRefresh: () => getrefresh(),
          child: scrollview,
          key: _refreshIndicatorKey);
    }

    return Container(
        child: widget.profile == "profile"
            ? ListView(
          // physics: NeverScrollableScrollPhysics(),

          children: new List<Widget>.from(noPost == "Aucun post trouvé"
              ? [
            Center(
                child: Text(
                  LinkomTexts.of(context).aucun(),
                  style: TextStyle(color: Colors.grey[600]),
                ))
          ]
              : listWidget),
        )
            : widget.user_id_cov.toString() != "null" &&
            widget.user_id_cov != ""
            ? new SliverList(
            delegate: new SliverChildListDelegate(
                new List<Widget>.from(listWidget)))
            : new Builder(builder: buildBody));
  }
}
