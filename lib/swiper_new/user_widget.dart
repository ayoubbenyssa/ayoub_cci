import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:latlong/latlong.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/app_services.dart';
import 'package:mycgem/services/block.dart';
import 'package:mycgem/swiper_new/distance_online_widget.dart';
import 'package:mycgem/user/details_user.dart';
import 'package:mycgem/widgets/alert_card.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycgem/widgets/common.dart';

class UserWidget extends StatefulWidget {
  UserWidget(this.user, this.id, this.lat, this.lng, this.controller,
      this.my_id, this.user_me, this.list, this.analytics, this.onLocaleChange);

  String id;
  User user;
  var lat;
  var lng;
  var controller;
  var my_id = "";
  User user_me;
  var list;
  int ind = 0;
  var analytics;
  var onLocaleChange;

  @override
  _UserWidgetState createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget>
    with SingleTickerProviderStateMixin {
  String nogps = "";
  var lat, lng;
  Distance distance = new Distance();
  bool toggle_se = false;
  TabController _tabController;

  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  ParseServer parse_s = new ParseServer();

  List<Widget> tabs() => <Widget>[
        widget.user.bio == null
            ? Container()
            : new Tab(
                icon: SvgPicture.asset(
                "images/icons/ap.svg",
                height: 30.0,
                color: widget.user.ind == 0 ? Fonts.col_app : Colors.grey,
              )),
        widget.user.cmpetences.isEmpty
            ? Container()
            : new Tab(
                icon: SvgPicture.asset(
                "images/icons/skills.svg",
                height: 30.0,
                color: widget.user.ind == 1 ? Fonts.col_app : Colors.grey,
              )),
        widget.user.list_obj.isEmpty
            ? Container()
            : new Tab(
                icon: SvgPicture.asset(
                "images/icons/goal.svg",
                height: 30.0,
                color: widget.user.ind == 2 ? Fonts.col_app : Colors.grey,
              )),
        widget.user.linkedin_link == null &&
                widget.user.instargram_link == null &&
                widget.user.twitter_link == null
            ? Container()
            : new Tab(
                icon: SvgPicture.asset(
                "images/icons/social.svg",
                height: 30.0,
                color: widget.user.ind == 3 ? Fonts.col_app : Colors.grey,
              )),
      ];

  update_connect() {}

  toggle_connect() async {
    if (toggle_se == true)
      setState(() {
        toggle_se = false;
      });
    else
      setState(() {
        toggle_se = true;
      });
  }

  getOnlineUser() async {
    DocumentSnapshot a = await Firestore.instance
        .collection('users')
        .document(widget.user.auth_id)
        .get();

    if (!this.mounted) return;

    if (a.data["offline"].toString() == "offline") {
      setState(() {
        widget.user.online = false;
        widget.user.offline = "offline";
      });
    } else if (a.data["online"].toString() == "null") {
      setState(() {
        widget.user.online = false;
      });
    } else
      setState(() {
        widget.user.online = a.data["online"];
        widget.user.last_active = a.data["last_active"];
      });
  }

  int i = 0;

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: tabs().length);
    if (widget.user.bio == null && widget.user.cmpetences.length > 0) {
      setState(() {
        _tabController.animateTo(1);
        widget.user.ind = 1;
      });
    } else if (widget.user.cmpetences.length == 0 &&
        widget.user.list_obj.length > 0) {
      setState(() {
        _tabController.animateTo(2);
        widget.user.ind = 2;
      });
    } else if (widget.user.list_obj.length == 0 &&
        widget.user.linkedin_link != null) {
      setState(() {
        _tabController.animateTo(3);
        widget.user.ind = 3;
      });
    }

    widget.user.online = false;
    try {
      getOnlineUser();
    } catch (e) {}

    if (widget.user.bio.toString() == "null") {
      setState(() {
        //  tabs.removeAt(0);
      });
    }

    /*setState(() {
      widget.user.dis =  (distance(new LatLng(widget.lat, widget.lng),
          new LatLng(double.parse(widget.user.lat), double.parse(widget.user.lng)))
          .toDouble() /
          1000)
          .toStringAsFixed(2) +
          " Km";
    });


   print(widget.user.dis);
*/

    /* try {
        setState(() {
          widget.user.tt = ta.format(
              new DateTime.fromMillisecondsSinceEpoch(widget.user.last_active),
            );
        });
      } catch (e) {}
    */

    widget.user.list = [];
    widget.user.list_obj = [];

    if (widget.user.objectif != null) {
      for (var i in widget.user.objectif) {
        widget.user.list_obj.add(i);
      }
    }

    if (widget.user.cmpetences != null) {
      for (var i in widget.user.cmpetences) {
        widget.user.list.add(i);
      }
    }

    super.initState();
  }

/*

 */

  block_user() async {
    await Block.insert_block(widget.user_me.auth_id, widget.user.auth_id,
        widget.user_me.id, widget.user.id);
    await Block.insert_block(widget.user.auth_id, widget.user_me.auth_id,
        widget.user.auth_id, widget.user_me..id);

    setState(() {
      widget.user.show = false;
    });
   /// widget.controller.next(animation: true);


  }

  setv(val) {
    setState(() {
      widget.user.ind = val;
    });
  }

  @override
  Widget build(BuildContext context) {

    void showMenuSelection(String value) {
      if (value == "bloquer") {
        String res = Alert.showAlert(context, block_user);
      }
    }

    Widget view4 = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        widget.user.linkedin_link != "" &&
                widget.user.linkedin_link.toString() != "null"
            ? new Center(
                child: new IconButton(
                    iconSize: 66.0,
                    icon: new Image.asset(
                      "images/linkedin.png",
                      width: 54.0,
                      height: 54.0,
                    ),
                    onPressed: () {
                      // final flutterWebviewPlugin = new FlutterWebviewPlugin();

                      Navigator.push(context, new MaterialPageRoute<String>(
                          builder: (BuildContext context) {
                        return new WebviewScaffold(
                          url: widget.user.linkedin_link,
                          appBar: new AppBar(
                            title: new Text(""),
                          ),
                        );
                      }));

                      //flutterWebviewPlugin.launch(widget.user.linkedin_link , hidden: true);
                    }))
            : new Container(),
        new Container(height: 8.0),
        widget.user.instargram_link != "" &&
                widget.user.instargram_link.toString() != "null"
            ? new Center(
                child: new IconButton(
                    iconSize: 66.0,
                    icon: new Image.asset(
                      "images/instagram.png",
                      width: 54.0,
                      height: 54.0,
                    ),
                    onPressed: () {
                      // final flutterWebviewPlugin = new FlutterWebviewPlugin();
                      // flutterWebviewPlugin.launch(widget.user.instargram_link);
                      Navigator.push(context, new MaterialPageRoute<String>(
                          builder: (BuildContext context) {
                        return new WebviewScaffold(
                          url: widget.user.instargram_link,
                          appBar: new AppBar(
                            title: new Text(""),
                          ),
                        );
                      }));
                    }))
            : new Container(),
        new Container(height: 8.0),
        widget.user.twitter_link != "" &&
                widget.user.twitter_link.toString() != "null"
            ? new Center(
                child: new IconButton(
                    iconSize: 66.0,
                    icon: new Image.asset(
                      "images/twitter.png",
                      width: 54.0,
                      height: 54.0,
                    ),
                    onPressed: () {
                      // final flutterWebviewPlugin = new FlutterWebviewPlugin();
                      /*flutterWebviewPlugin.launch(widget.user.twitter_link);*/
                      Navigator.push(context, new MaterialPageRoute<String>(
                          builder: (BuildContext context) {
                        return new WebviewScaffold(
                          url: widget.user.twitter_link,
                          appBar: new AppBar(
                            title: new Text(""),
                          ),
                        );
                      }));

                      //flutterWebviewPlugin.launch(widget.user.linkedin_link , hidden: true);
                    }))
            : new Container()
      ],
    );

    Widget view1 = Column(
      children: <Widget>[
        new Container(
          height: 8.0,
        ),
        widget.user.bio != "" && widget.user.bio.toString() != "null"
            ? new Center(
                child: new Text(
                "BIO:",
                style: new TextStyle(color: Colors.grey[600]),
              ))
            : new Container(),
        Container(
          height: 8.0,
        ),
        widget.user.bio != "" && widget.user.bio.toString() != "null"
            ? new Container(
                padding: new EdgeInsets.only(left: 4.0, right: 4.0),
                width: 300.0,
                child: new Text(widget.user.bio.toString()),
              )
            : new Container(),
        new Container(height: 8.0),
        widget.user.linkedin_link != "" &&
                widget.user.linkedin_link.toString() != "null"
            ? new Container(
                height: 1.0,
                width: 1000.0,
                color: Colors.grey[300],
              )
            : new Container(),
        new Container(
          height: 14.0,
        ),
        widget.user.linkedin_link != "" &&
                widget.user.linkedin_link.toString() != "null"
            ? new Center(
                child: new Text(
                "Profil Linkedin:",
                style: new TextStyle(color: Colors.grey[600]),
              ))
            : new Container(),
        new Container(height: 8.0),
      ],
    );

    Widget view2 = Column(
      children: <Widget>[
        Container(
          height: 4,
        ),
        new Center(
            child: new Text(LinkomTexts.of(context).compe(),
                style: new TextStyle(
                    color: Colors.grey[800], fontWeight: FontWeight.w600))),
        new Container(height: 4.0),
        widget.user.list != null && widget.user.list.isNotEmpty
            ? new Center(
                child: new Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: widget.user.list.map((String item) {
                      return a(item);
                    }).toList()))
            : new Container(
                padding: new EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: new Center(
                  child: new Text(
                    "Aucun Domaine d’expertise n'a été mentionné",
                    style:
                        new TextStyle(color: Colors.grey[500], fontSize: 16.0),
                  ),
                ))
      ],
    );

    /*


     */

    Widget view3 = Column(
      children: <Widget>[
        Container(
          height: 10,
        ),
        new Center(
            child: new Text(
          LinkomTexts.of(context).objs(),
          style: new TextStyle(
              color: Colors.grey[800], fontWeight: FontWeight.w600),
        )),
        new Container(
          height: 12.0,
        ),
        widget.user.list_obj != null && widget.user.list_obj.isNotEmpty
            ? new Expanded(
                child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: widget.user.list_obj.map((String item) {
                      return new Container(
                          padding: new EdgeInsets.all(8.0),
                          margin: new EdgeInsets.only(bottom: 8.0),
                          height: 36.0,
                          //alignment: Alignment.center,
                          decoration: new BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: new BorderRadius.circular(8.0),
                          ),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Icon(Icons.bookmark_border,
                                  color: Fonts.col_app),
                              new Container(
                                width: 4.0,
                              ),
                              new Text(
                                item,
                                style: new TextStyle(color: Fonts.col_app_fon),
                              )
                            ],
                          ));
                    }).toList()))
            : new Container(
                padding: new EdgeInsets.only(top: 16.0, bottom: 24.0),
                child: new Center(
                  child: new Text("Aucun objectif n'a été mentionné",
                      style: new TextStyle(
                          color: Colors.grey[500], fontSize: 16.0)),
                ))
      ],
    );

    Widget menusubscribe = new Container(
        width: 40.0,
        height: 40.0,
        child: new PopupMenuButton<String>(
            padding: new EdgeInsets.all(2.0),
            icon: new Icon(
              Icons.more_vert,
              size: 32,
              color: Colors.white,
            ),
            onSelected: showMenuSelection,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  /* new PopupMenuItem<String>(
                  value: "Block",
                  child: new ListTile(
                      title: new Text(
                          isBlock ? "Unblock this user" : "Block this user")*/
                  new PopupMenuItem<String>(
                      value: "bloquer",
                      child: new ListTile(
                          title: new Text(LinkomTexts.of(context).block()))),
                ]));

    Widget header = Container(
        width: MediaQuery.of(context).size.width,
        child: Card(
          margin: EdgeInsets.all(0),
          color: Fonts.col_app_green,
          child: Container(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 4.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Center(
                          child: new Text(
                            AppServices.capitalizeFirstofEach(
                            widget.user.firstname?.toLowerCase()) +
                                " " +
                                widget.user.fullname?.toUpperCase(),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(15),
                            fontWeight: FontWeight.w800),
                      )),
                      new Container(
                        height: 2.0,
                      ),
                      new Container(
                          width: MediaQuery.of(context).size.width * 0.82,
                          child: new Text(
                            widget.user.fonction.name.toString() == ""
                                ? ""
                                : widget.user.anne_exp.toString() != "null" &&
                                        widget.user.anne_exp.toString() != ""
                                    ? widget.user.fonction.name.toString() +
                                        " à " +
                                        widget.user.organisme +
                                        " (" +
                                        widget.user.anne_exp +
                                        " ans)"
                                    : widget.user.fonction.name.toString() +
                                        " à " +
                                        widget.user.organisme,
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: new TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(15),
                                fontWeight: FontWeight.w500),
                          )),
                      new Container(
                        height: 4.0,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  menusubscribe
                ],
              )),
        ));

    return widget.user.show == false
        ? new Container()
        : InkWell(
            child: new Material(
              color: Colors.white,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.all(
                Radius.circular(12.0),
              )),
              elevation: 3.0,
              shadowColor: Colors.grey[800],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  header,
                  Stack(children: <Widget>[
                    Container(
                      color: Fonts.col_cl,
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: MediaQuery.of(context).size.width,
                      child: FadingImage.network(
                        widget.user.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ]),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: Distance_Online_Widget(widget.user)),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      color: Fonts.col_cl,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          widget.user.respons.toString() == "null"
                              ? Container()
                              : new Container(
                                  padding: EdgeInsets.only(right: 12),
                                  height: 50,
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                          "images/da.png",
                                          width: 40,
                                          height: 40,
                                        ),
                                        Container(
                                          width: 12,
                                        ),
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: new Text(
                                                widget.user.respons
                                                            .toString() ==
                                                        "null"
                                                    ? ""
                                                    : widget.user
                                                            .respons["name"]
                                                            .toString() +
                                                        "  ",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                //textAlign: TextAlign.center,
                                                style: new TextStyle(
                                                    color: Fonts.col_app,
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.w500)))
                                      ])),
                          widget.user.respons.toString() == "null"
                              ? Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    widget.user.bio.toString() == "null"
                                        ? ""
                                        : widget.user.bio.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Fonts.col_app_fonn),
                                  ),
                                )
                              : Container(),
                          Expanded(
                            child: Container(),
                          ),
                          RaisedButton(
                            padding: EdgeInsets.all(4),

                            color: Colors.white,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.all(
                              Radius.circular(8.0),
                            )),
                            splashColor: Colors.grey,
                            elevation: 1,
                            onPressed: () {
                              Navigator.of(context).push(new PageRouteBuilder(
                                pageBuilder: (_, __, ___) => new Details_user(
                                    widget.user,
                                    widget.user_me,
                                    true,
                                    widget.list,
                                    widget.analytics,
                                    widget.onLocaleChange),
                              ));
                            },
                            child: Text(
                              LinkomTexts.of(context).details(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Fonts.col_app_green,
                                  fontSize: ScreenUtil().setSp(16)),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.of(context).push(new PageRouteBuilder(
                pageBuilder: (_, __, ___) => new Details_user(
                    widget.user,
                    widget.user_me,
                    true,
                    widget.list,
                    widget.analytics,
                    widget.onLocaleChange),
              ));
            },
          );
  }

  Widget a(text) => new Container(
        padding: new EdgeInsets.all(6.0),
        //  width: 150.0,
        //alignment: Alignment.center,
        decoration: new BoxDecoration(
          border: new Border.all(color: Colors.blue, width: 1.0),
          color: Colors.transparent,
          borderRadius: new BorderRadius.circular(8.0),
        ),
        child: new Text(
          "#" + text,
          style: new TextStyle(color: Colors.blue),
        ),
      );
}
