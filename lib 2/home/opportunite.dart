import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mycgem/home/search_event_pub.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/parc_events_stream/parc_events_stream.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/widgets/app_appbar.dart';
import 'package:mycgem/widgets/fixdropdown.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class Opportunite extends StatefulWidget {
  Opportunite(this.lat, this.lng, this.user, this.list_partner, this.analytics,
      this.chng);

  var lat, lng;
  User user;
  List list_partner;
  var analytics;
  var chng;

  @override
  _ParcState createState() => _ParcState();
}

class _ParcState extends State<Opportunite>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  bool _menuShown = false;

  List<String> _list = [
    /// "Appel d'offres",
    ///"Consultation",
    "Appel à manifestation d'intérêt",

    /// "Recherche collaboration",
    "Proposition de produits / Services",
    // "proposition de service",
    //"Autre"
  ];
  final _titrecontroller = new TextEditingController();

  bool loading = false;

  String selectedValue = "";

  @override
  initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    // getSectors();
    display_slides();
  }

  Reload() {
    setState(() {
      loading = true;
    });
    new Timer(const Duration(seconds: 1), () {
      try {
        setState(() => loading = false);
      } catch (e) {
        e.toString();
      }
    });
  }

  int count1 = 0;

  setSount1(c) {
    setState(() {
      count1 = c;
    });
  }

  Widget drop_down() => new Container(
      color: Colors.white,
      width: 700.0,
      height: 60.0,
      child: Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.only(left: 16.0, right: 8.0),
          decoration: new BoxDecoration(
            color: Colors.white,
            border: new Border.all(color: Fonts.col_app_shadow, width: 1.0),
            borderRadius: new BorderRadius.circular(2.0),
          ),
          child: new FixDropDown(
              iconSize: 32.0,
              isDense: false,
              items: _list.map((String value) {
                return new FixDropdownMenuItem(
                  value: value,
                  child: new Text(
                    value.toString(),
                    maxLines: 2,
                    softWrap: true,
                    style: TextStyle(color: Fonts.col_app_fonn),
                  ),
                );
              }).toList(),
              hint: new Text(
                selectedValue != ""
                    ? selectedValue
                    : LinkomTexts.of(context).type_opp(),
                maxLines: 1,
                softWrap: true,
                style: new TextStyle(color: Fonts.col_app_fonn),
              ),
              onChanged: (String value) {
                setState(() {
                  selectedValue = value;
                  Reload();
                });
              })));

  display_slides() async {
    //Restez informés sur  tout ce qui se passe au sein de votre communauté à travers l’actualité et les événements.
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString("con") != "con") {
      new Timer(new Duration(seconds: 1), () {
        setState(() {
          _menuShown = true;
        });

        prefs.setString("con", "con");
      });
    }
  }

  onp() {
    setState(() {
      _menuShown = false;
    });
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
      appBar: MyCgemBarApp(LinkomTexts.of(context).oppo(),
          actionswidget: widget.user.verify.toString() == "1"
              ? IconButton(
              onPressed: () {
                Alert(
                    context: context,
                    title: LinkomTexts.of(context).search(),
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _titrecontroller,
                          decoration: InputDecoration(
                            icon: Image.asset(
                              "images/icons/opportunity.png",
                              color: Fonts.col_app,
                              width:
                              MediaQuery.of(context).size.width * 0.08,
                            ),
                            hintMaxLines: 2,
                            labelText: LinkomTexts.of(context).search_opp(),
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
                                  "opportunite",
                                  widget.chng,
                                );
                              }));
                        },
                        child: Text(
                          LinkomTexts.of(context).search(),
                          style:
                          TextStyle(color: Colors.white, fontSize: 20),
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
              : Container()),
      /*AppBar(
          actions: <Widget>[

          ],
          backgroundColor: Fonts.col_app_shadow,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Fonts.col_app_fonn),
          title: Text(
            count1 == 0
                ? LinkomTexts.of(context).oppo()
                : LinkomTexts.of(context).oppo() +
                '  (' +
                count1.toString() +
                ')',
            style: TextStyle(
                color: Fonts.col_app_fonn, fontWeight: FontWeight.w400),
          ),
        ),*/
      body:
      /*widget.user.verify.toString() != "1"
            ? Container(
                child: Container(
                    padding: EdgeInsets.only(top: 60, left: 12, right: 12),
                    child: Text(
                      "Vous devez être membre de la CGEM pour accéder à cette rubrique",
                      textAlign: TextAlign.center,
                      style:  TextStyle(
                          color: Fonts.col_ap_fonn,
                          fontSize: 15.5.sp,
                          fontWeight: FontWeight.w700),
                    )),
              )
            : widget.user.entreprise.situation != "Ajour"
                ? Container(
                    child: Container(
                        padding: EdgeInsets.only(top: 60, left: 12, right: 12),
                        child: Text(
                          "Les opportunités d'affaires sont accessibles aux membres à jour de leurs cotisations. Pour plus d'informations, contactez-nous à adherents@cgem.ma",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              height: 1.4,
                              color: Fonts.col_ap_fonn),
                        )),
                  )
                : */
      (widget.user.verify.toString() != "1" )
          ?  Container(
          padding: EdgeInsets.only(top: 60, left: 12, right: 12),
          child:Container(
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
                  )))
      )
          : widget.user.entreprise.situation != "Ajour"
          ?  Container(
          padding:
          EdgeInsets.only(top: 60, left: 12, right: 12),
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
                  ))))

          : new Column(
        children: <Widget>[
          drop_down(),
          new Expanded(
              child: loading
                  ? Widgets.load()
                  : new StreamParcPub(
                new Container(),
                widget.lat,
                widget.lng,
                widget.user,
                "1",
                widget.list_partner,
                widget.analytics,
                setSount1,
                widget.chng,
                sector: selectedValue,
                category: "opportunite",
                video: false,
                revue: false,
                favorite: false,
                boutique: false,
              ))
        ],
      ),
    );
  }
}
