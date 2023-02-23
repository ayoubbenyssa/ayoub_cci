import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycgem/communities/communities.dart';
import 'package:mycgem/communities/federations.dart';
import 'package:mycgem/filter/filter_by_region.dart';
import 'package:mycgem/home/entreprise_view.dart';
import 'package:mycgem/home/events.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/language_params/scope_model_wrapper.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/widgets/apebi_pre.dart';
import 'package:mycgem/widgets/app_appbar.dart';
import 'package:mycgem/widgets/chambre_conseil.dart';
import 'package:mycgem/widgets/formations.dart';
import 'package:mycgem/widgets/menu%20widgets/Foires_Salons.dart';
import 'package:mycgem/widgets/partners.dart';
import 'package:mycgem/widgets/services_pre.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:mycgem/youtube_videos/views/youtubeList.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mycgem/annonces/annonces_tabs.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/home/opportunite.dart';
import 'package:mycgem/models/offers.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/auth.dart';
import 'package:mycgem/services/routes.dart';
import 'package:mycgem/widgets/header_menu.dart';
import 'package:mycgem/home/publications.dart';
import 'package:mycgem/widgets/invite_friends.dart';
import 'package:mycgem/services/app_services.dart';

import 'menu widgets/Opportunités_affaires.dart';
import 'menu widgets/Partenariats_conventions.dart';
import 'menu widgets/Presentation.dart';
import 'menu widgets/telechargements.dart';

var API_KEY = "AIzaSyDCB1z3cOQuIaf9LxLI6adVYjsSJC5TpDU";

class Menu extends StatefulWidget {
  Menu(
      this.user,
      this.id,
      this.auth,
      this.onSignedIn,
      this.lat,
      this.lng,
      this.list_partner,
      this.analytics,
      this.gotocompanies,
      this.index,
      this.ctrl,
      this.onLocaleChange);

  var auth;
  var onSignedIn;
  User user;
  String id;
  var lat;
  var lng;
  List list_partner;
  var analytics;
  var gotocompanies;
  var func;
  int index = 0;
  var onLocaleChange;
  var ctrl;

  @override
  _MenuState createState() => new _MenuState();
}

class _MenuState extends State<Menu> {
  Auth auth = new Auth();
  var colo1 = Fonts.col_app_fonn;
  var colo2 = Fonts.col_app_fonn;
  ParseServer parse_s = new ParseServer();
  TextStyle stle = TextStyle(
      color: Fonts.col_ap_fonn, fontSize: 15.sp, fontWeight: FontWeight.w700);

  /*Future<User> getcurrentuser() async {
    FirebaseUser a = await FirebaseAuth.instance.currentUser();
    id = a.uid;
    DocumentSnapshot snap =
    await Firestore.instance.collection('users').document(a.uid).get();
    setState(() {
      widget.user = new User.fromDocument(snap);
    });
    return new User.fromDocument(snap);
  }*/

  /**
   *
   * Map
   */

  /**
   *
   *
   * Map code
   *
   *
   *
   */

  bool en = false;
  bool ar = false;

  Widget AR() => ScopedModelDescendant<AppModel1>(
      builder: (context, child, model) => InkWell(
          //elevation: 18.0,
          onTap: () {
            print("1234567");
            print(model.locale);
            if (model.locale == "en") {
              setState(() {
                ar = true;
                en = false;
              });
              model.changeDirection();
              widget.onLocaleChange(
                  Locale(model.locale, ""), model.textDirection);
            }
          },
          child: new Text(
            "العربية", //
            style: new TextStyle(
                color: ar == false ? Colors.grey[800] : Fonts.col_app,
                fontSize: 13.0),
          )));

  Widget EN() => ScopedModelDescendant<AppModel1>(
      builder: (context, child, model) => InkWell(
          //elevation: 18.0,
          onTap: () {
            if (model.locale == "ar") {
              setState(() {
                ar = false;
                en = true;
              });
              model.changeDirection();
              widget.onLocaleChange(
                  Locale(model.locale, ""), model.textDirection);
            }
          },
          child: new Text(
            "Français",
            style: new TextStyle(

                ///  fontFamily: "",
                color: en == false ? Colors.grey[800] : Fonts.col_app,
                fontSize: 13.0),
          )));

/*

Navigator.push(context,
            new MaterialPageRoute<String>(builder: (BuildContext context) {
              return new Cities();
            }));
 */

  String verify;

  getUser(id) async {
    var a = await parse_s
        .getparse('users?where={"objectId":"$id"}&include=fonction');
    if (!this.mounted) return;
    print(a);

    setState(() {
      verify = a["results"][0]["verify"].toString();
      print(verify);
    });
  }

  @override
  void initState() {
    //getcurrentuser();

    super.initState();

    getUser(widget.user.id);
    print("widget.lat  ${widget.lat}");
    print("widget.lng  ${widget.lng}");
  }

  tap(a) {
    if (a == "a") {
      Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) {
        return new Presentation();
      }));
    } else if (a == "form") {
      Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) {
        return new Formations();
      }));
    } else if (a == "Partners") {
      Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) {
        return new Partners();
      }));
    } else if (a == "cgf") {
      Navigator.push(context,
          new MaterialPageRoute<String>(builder: (BuildContext context) {
        return ChambreConseil(true);
      }));
    } else if (a == "b") {
      //ServicesPre
      Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: MyCgemBarApp(
              LinkomTexts.of(context).services(),
              actionswidget: Container(),
            ),
            body: new ServicesPre(
                widget.lat, widget.lng, widget.user, widget.onLocaleChange));
      }));
    } else if (a == "c") {
      Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) {
        return new CommunitiesCGEM(null, null, [], false, false, widget.lat,
            widget.lng, widget.onLocaleChange,
            user: widget.user);
      }));
    } else if (a == "Telechargements"){
      Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) {
            return new Telechargements();
          }));
    } else if (a == "Foires & Salons"){
      Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) {
            return new Foires_Salons();
          }));

    } else if (a == "Partenariats et conventions"){
      Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) {
            return new Partenariats_conventions();
          }));
    } else if (a == "Opportunités d'affaires"){
      Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) {
            return new Opportunites_affaires();
          }));
    } else if (a == "Présentation"){
      Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) {
            return new Presentations();
          }));
    }  else if (a == "e") {
      Navigator.push(
        context,
        new PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> _,
              Animation<double> __) {
            return RegionStream(widget.user, widget.lat, widget.lng, [], null,
                widget.onLocaleChange, false, true);
          },
        ),
      );
    } else {
      //FedCGEM

      Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) {
        return new FedCGEM(
          null,
          null,
          [],
          false,
          false,
          widget.lat,
          widget.lng,
          widget.onLocaleChange,
          user: widget.user,
        );
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    ///    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);

    Widget lang = new ListTile(
      dense: true,
      trailing: Container(
        width: MediaQuery.of(context).size.width * 0.25,
        child: Row(
          children: <Widget>[
            EN(),
            Container(
              width: 6,
            ),
            AR()
          ],
        ),
      ),
      leading: new Image.asset(
        "images/language.png",
        color: colo1,
        width: 30.0,
        height: 30.0,
      ),
      title: new Text(LinkomTexts.of(context).language()),
    );

    _showDialog1() async {
      return await showDialog(
          context: context,
          builder: (BuildContext context) => new AlertDialog(
              contentPadding: const EdgeInsets.all(16.0),
              content: Container(
                  height: 160,
                  child: Column(children: <Widget>[
                    Text(LinkomTexts.of(context).option()),
                  ]))));
    }

    Widget lst(img, text, tp, w, h) => ListTile(
          dense: true,
          //contentPadding: EdgeInsets.only(left: 68, right: 60),
          onTap: () {
            if (text == LinkomTexts.of(context).CGEM()) {
              tap("a");
            } else if (text == LinkomTexts.of(context).services()) {
              tap("b");
            } else if (text == LinkomTexts.of(context).comms()) {
              tap("c");
            } else if (text == "CGEM-Régions") {
              tap("e");
            } else if (text == "Groupe CGEM à la Chambre des Conseillers") {
              tap("cgf");
            } else if (text == "Formation") {
              tap("form");
            } else if (text == "Partenaires") {
              tap("Partners");
            }else if(text == "Telechargements"){
            tap("Telechargements");
            }else if(text == "Foires & Salons"){
              tap("Foires & Salons");
            } else if(text == "Partenariats et conventions"){
              tap("Partenariats et conventions");
            } else if(text == "Opportunités d'affaires"){
              tap("Opportunités d'affaires");
            } else if(text == "Présentation"){
              tap("Présentation");
            } else  {
              tap("d");
            }

          },
          /* leading: new Image.asset(
        img,
        color: colo1,
        width: w,
        height: h,
      ),*/
          title: new Text(text, style: stle),
        );

    Widget Publication = new ListTile(
      dense: true,
      onTap: () {
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) {
          return new Publications(
              widget.lat,
              widget.lng,
              widget.user,
              widget.list_partner,
              widget.auth,
              0,
              widget.analytics,
              widget.onLocaleChange);
        }));
      },
      title: new Text(LinkomTexts.of(context).actu(), style: stle),
    );

    Widget companies = new ListTile(
      dense: true,
      onTap: () {
        // Navigator.pop(context);
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) {
          return EntrepriseStream(widget.user, widget.lat, widget.lng, [], null,
              widget.onLocaleChange);
        }));

        /*widget.index = 1;
        widget.gotocompanies(1);

        new Timer(const Duration(milliseconds: 200), () {
          widget.ctrl.animateToPage(1,
              duration: const Duration(milliseconds: 300), curve: Curves.ease);
        });*/
      },
      /* leading: new Image.asset(
        "images/visit.png",
        color: colo1,
        width: 30.0,
        height: 30.0,
      ),*/
      title: new Text("Membres", style: stle),
    );
    Widget Agenda = new ListTile(
      dense: true,
      onTap: () {
        print("evenements");
        print("widget.lat  ${widget.lat}");
        print("widget.lng  ${widget.lng}");
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) {
          return new Events(
              widget.user.lat,
              widget.user.lng,
              widget.user,
              widget.list_partner,
              widget.auth,
              0,
              widget.analytics,
              widget.onLocaleChange);
        }));
      },
      title: new Text(LinkomTexts.of(context).agenda(), style: stle),
    );

    Widget opportunites = new ListTile(
      dense: true,
      onTap: () {
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) {
          return new Opportunite(widget.lat, widget.lng, widget.user,
              widget.list_partner, widget.analytics, widget.onLocaleChange);
        }));
      },
      title: new Text(LinkomTexts.of(context).oppo(), style: stle),
    );

    Widget video = new ListTile(
      dense: true,
      onTap: () {
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) {
          return new YoutubeBody(widget.user, widget.lat, widget.lng,
              widget.list_partner, widget.analytics, widget.onLocaleChange);
        }));
      },
      /*leading: new Image.asset(
        "images/youtu.png",
        //color: colo1,
        width: 29.0,
        height: 29.0,
        color: colo1,

      ),*/
      title: new Text("CGEM TV", style: stle),
    );

    make_user_offline() async {
      Map<String, dynamic> map = new Map<String, dynamic>();
      map["online"] = false;
      map["last_active"] = new DateTime.now().millisecondsSinceEpoch;
      Firestore.instance
          .collection('users')
          .document(widget.user.auth_id)
          .updateData(map);

      FirebaseDatabase.instance
          .reference()
          .child("status")
          .update({widget.user.auth_id: false});

      FirebaseDatabase.instance
          .reference()
          .child("status")
          .update({widget.user.auth_id: false});
    }

    Widget share = new ListTile(
      dense: true,
      onTap: () {
        //Invitrefriends
        // Routes.goto(context,"login");
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) {
          return new Invitrefriends();
        }));
      },
      /*leading: new Image.asset("images/ch.png",
          color: colo1, width: 25.0, height: 25.0),*/
      title: new Text(LinkomTexts.of(context).invite(), style: stle),
    );

    ParseServer parse_s = new ParseServer();

    Widget logout = new ListTile(
      dense: true,
      onTap: () async {
        Widgets.onLoading(context);
        await make_user_offline();
        await Firestore.instance
            .collection('user_notifications')
            .document(widget.user.auth_id)
            .updateData({"send": "no"});
        var js = {
          "token": "",
        };
        await parse_s.putparse("users/" + widget.user.id, js);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.clear();
        prefs.setString("Slides", "yess");
        prefs.setString("cov", "cov");
        prefs.setString("homes", "homes");
        prefs.setString("con", "con");
        prefs.setString("par", "par");
        prefs.setString("pub", "pub");
        prefs.setString("shop", "shop");

        await FirebaseAuth.instance.signOut();
        Navigator.of(context, rootNavigator: true).pop('dialog');

        Routes.go_login(context, widget.auth, widget.onSignedIn,
            widget.list_partner, widget.analytics, widget.onLocaleChange);
      },
      /* leading: new Icon(Icons.exit_to_app, color: colo1),*/
      title: new Text(LinkomTexts.of(context).logout(), style: stle),
    );

    return Container(
        color: Fonts.col_grey.withOpacity(0.16),
        child: new ListView(
          children: <Widget>[
            widget.id.toString() == ""
                ? new Container()
                : new HeaderMenuDrawer(
                    widget.user, widget.onLocaleChange, widget.lat, widget.lng),
            //reseau,
            // messages,
            // notif,
            // revue,

            Container(
                padding: EdgeInsets.only(left: 12, right: 12),
                margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(
                        MediaQuery.of(context).size.width > 600 ? 12 : 10),
                    left: 12,
                    right: 12),
                decoration: new BoxDecoration(
                    color: Colors.white,
                    // border: new Border.all(color: Colors.grey[100], width: 1.0),
                    borderRadius: new BorderRadius.circular(12.0)),
                child: Column(children: <Widget>[
                  ///WWWWQ cmnd,
                ])),


            Container(
                padding: EdgeInsets.only(left: 12, right: 12),
                margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(
                        MediaQuery.of(context).size.width > 600 ? 12 : 10),
                    left: 12,
                    right: 12),
                decoration: new BoxDecoration(
                    color: Colors.white,
                    border: new Border.all(color: Colors.grey[100], width: 1.0),
                    borderRadius: new BorderRadius.circular(12.0)),
                child: Column(children: <Widget>[
                  Container(child: Publication),
                  Container(
                    height: MediaQuery.of(context).size.width > 600 ? 16 : 0,
                  ),
                  Container(child: Agenda),
                  Container(
                    height: MediaQuery.of(context).size.width > 600 ? 16 : 0,
                  ),
                  //  Container(child: video),
                  Container(
                    height: MediaQuery.of(context).size.width > 600 ? 16 : 0,
                  ),
                ])),



            Container(
                padding: EdgeInsets.only(left: 12, right: 12),
                margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(
                        MediaQuery.of(context).size.width > 600 ? 12 : 10),
                    left: 12,
                    right: 12),
                decoration: new BoxDecoration(
                    color: Colors.white,
                    border: new Border.all(color: Colors.grey[100], width: 1.0),
                    borderRadius: new BorderRadius.circular(12.0)),
                child: Column(children: <Widget>[
                  companies,
                  Container(
                    height: MediaQuery.of(context).size.width > 600 ? 16 : 0,
                  ),

                  Container(child: opportunites),
                  Container(
                    height: MediaQuery.of(context).size.width > 600 ? 16 : 0,
                  ),
                  lst("images/morocco.png", LinkomTexts.of(context).CGEM(), tap,
                      25.0, 25.0),
                  lst("images/morocco.png", "Partenaires", tap, 25.0, 25.0),
                  lst("images/morocco.png", "Formation", tap, 25.0, 25.0),

                  lst("images/morocco.png", "Telechargements", tap, 25.0, 25.0),
                  lst("images/morocco.png", "Foires & Salons", tap, 25.0, 25.0),
                  lst("images/morocco.png", "Partenariats et conventions", tap, 25.0, 25.0),

                  lst("images/morocco.png", "Opportunités d'affaires", tap, 25.0, 25.0),
                  lst("images/morocco.png", "Présentation", tap, 25.0, 25.0),







                  //ss    prod,
                  //  Container(child: con),
                ])),

            /*
                Container(child: ann),
             */

            /*Container(
                padding: EdgeInsets.only(left: 12, right: 12),
                margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(
                        MediaQuery.of(context).size.width > 600 ? 12 : 10),
                    left: 12,
                    right: 12),
                decoration: new BoxDecoration(
                    color: Colors.white,
                    border: new Border.all(color: Colors.grey[100], width: 1.0),
                    borderRadius: new BorderRadius.circular(12.0)),
                child: Column(children: <Widget>[
                  // Container(child: parc),
                  lst("images/morocco.png", LinkomTexts.of(context).CGEM(), tap,
                      25.0, 25.0),
                  Container(
                      child: lst(
                          "images/area-with-pins.png",
                          "Groupe CGEM à la Chambre des Conseillers",
                          tap,
                          25.0,
                          25.0)),
                  Container(
                    height: MediaQuery.of(context).size.width > 600 ? 16 : 0,
                  ),

                  Container(
                      child: lst("images/area-with-pins.png", "CGEM-Régions",
                          tap, 25.0, 25.0)),
                  Container(
                    height: MediaQuery.of(context).size.width > 600 ? 16 : 0,
                  ),

                  Container(
                      child: lst("images/icons/fed.png",
                          LinkomTexts.of(context).fids(), tap, 25.0, 25.0)),
                  Container(
                    height: MediaQuery.of(context).size.width > 600 ? 16 : 0,
                  ),

                  Container(
                      child: lst("images/icons/team.png",
                          LinkomTexts.of(context).comms(), tap, 25.0, 25.0)),
                  Container(
                    height: MediaQuery.of(context).size.width > 600 ? 16 : 0,
                  ),

                  lst("images/icons/servic.png",
                      LinkomTexts.of(context).services(), tap, 25.0, 25.0),
                ])),
           */
            Container(
                padding: EdgeInsets.only(left: 12, right: 12),
                margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(
                        MediaQuery.of(context).size.width > 600 ? 12 : 10),
                    left: 12,
                    right: 12),
                decoration: new BoxDecoration(
                    color: Colors.white,
                    border: new Border.all(color: Colors.grey[100], width: 1.0),
                    borderRadius: new BorderRadius.circular(12.0)),
                child: Column(children: <Widget>[
                  share,
                  Container(
                    height: MediaQuery.of(context).size.width > 600 ? 16 : 0,
                  ),
                  logout
                ])),
            Container(
              height: 40,
            ),
          ],
        ));
  }
}
