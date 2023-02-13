import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:mycgem/chat/chatscreen.dart';
import 'package:mycgem/filter/connect_message.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/objectif.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/notifications/invite_view_user.dart';
import 'package:mycgem/services/connect.dart';
import 'package:mycgem/services/location_services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/block.dart';
import 'package:mycgem/swiper_new/distance_online_widget.dart';
import 'package:mycgem/widgets/alert_card.dart';
import 'package:mycgem/widgets/common.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

enum AppBarBehavior { normal, pinned, floating, snapping }

class Details_user extends StatefulWidget {
  Details_user(this.user, this.user_me, this.cse,
      this.list_partners, this.analytics, this.onLocaleChange,
      {this.reload});

  User user;
  //var block;
  User user_me;
  bool cse;
  var reload;
  var list_partners;
  var analytics;
  var onLocaleChange;

  @override
  _Details_userState createState() => _Details_userState();
}

class _Details_userState extends State<Details_user>
    with TickerProviderStateMixin {
  AnimationController _containerController;

  double _appBarHeight = 320.0;
  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;
  Animation<double> width;
  Animation<double> heigth;
  Distance distance = new Distance();
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  ParseServer parse_s = new ParseServer();

  bool click = true;
  var text = "Se connecter";

  var lat, lng;

  var currentLocation = <String, double>{};
  var location = new Location();

  getLocation() async {
    try {
      currentLocation = await Location_service.getLocation();

      lat = currentLocation["latitude"];
      lng = currentLocation["longitude"];

      if (lat == null)
        widget.user.dis = "-.- Km";
      else
        widget.user.dis = distance
                .as(
                    LengthUnit.Kilometer,
                    new LatLng(double.parse(widget.user.lat),
                        double.parse(widget.user.lng)),
                    new LatLng(lat, lng))
                .toString() +
            " " +
            LinkomTexts.of(context).km();
    } on PlatformException {
      print("noooooo");

      // showInSnackBar("Veuillez activer votre GPS");
    }
  }

  contact(my_id, his_id) async {
    setState(() {
      click = true;
    });

    var response = await parse_s.getparse(
        'connect?where={"\$or":[{"key_id":{"\$eq":"$my_id"}},{"key_id":{"\$eq":"$his_id"}} ]}');
    var count = response["results"].length;

    if (!this.mounted) return null;

    setState(() {
      widget.user.wait = true;
    });
    if (count == 2) {
      text = "Message";
    } else if (count == 0) {
      text = "Se connecter";
    } else {
      var key_id = response["results"][0]["key_id"];
      if (key_id == my_id && response["results"][0]["accepted"] == false) {
        text = "Confirmer";
      } else {
        text = "Demande envoyée";
      }
    }

    return text;
  }

  getOnlineUser() async {
    DocumentSnapshot a = await Firestore.instance
        .collection('users')
        .document(widget.user.auth_id)
        .get();

    if (!this.mounted) return;

    if(a.data != null){
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
  }

  /*


  connectedorno() async {
    setState(() {
      widget.user.cnt = "SE CONNECTER";
    });
    var id = widget.user.id;
    String my_id = widget.user_me.id;

    var response = await parse_s.getparse(
        'connect?where={"receive_req":"$my_id","send_requ":"$id","accepted":false}');
    if(!this.mounted) return;

    setState(() {
      widget.user.wait = true;
    });

    if (response["results"].length > 0) {
      setState(() {
        widget.user.cnt = "CONFIRMER";
      });
    } else {
      setState(() {
        widget.user.cnt = "SE CONNECTER ";
      });
    }
  }*/

  void initState() {
    widget.user.online = false;

    getOnlineUser();

    var id = widget.user.id.toString() + "_" + widget.user_me.id;
    String my_id = widget.user_me.id + "_" + widget.user.id;


    contact(id, my_id).then((val) {
      setState(() {
        widget.user.cnt = val;
      });
      print("jdijdiojiodjdiojd");
    });

    if (widget.cse == true) {
      getOnlineUser();

      widget.user.list_obj = [];
      widget.user.list = [];
      if (widget.user.objectif != null) {
        widget.user.list_obj = List<String>.from(widget.user.objectif);
      }

      if (widget.user.cmpetences != null) {
        for (var i in widget.user.cmpetences) {
          widget.user.list.add(i);
        }
      }

      getLocation();
    }

    _containerController = new AnimationController(
        duration: new Duration(milliseconds: 2000), vsync: this);
    super.initState();
    width = new Tween<double>(
      begin: 200.0,
      end: 220.0,
    ).animate(
      new CurvedAnimation(
        parent: _containerController,
        curve: Curves.ease,
      ),
    );
    heigth = new Tween<double>(
      begin: 200.0,
      end: 200.0,
    ).animate(
      new CurvedAnimation(
        parent: _containerController,
        curve: Curves.ease,
      ),
    );
    heigth.addListener(() {
      setState(() {
        if (heigth.isCompleted) {}
      });
    });
    _containerController.forward();
  }

  @override
  void dispose() {
    _containerController.dispose();
    super.dispose();
  }

  connect() async {
    setState(() {
      widget.user.activate = false;
    });

    await Connect.inser_request(widget.user_me.id, widget.user.id, false);
    //String token = await _firebaseMessaging.getToken();

    /*  await Firestore.instance.collection('user_notifications')
        .document(widget.images[_currentIndex].auth_id).setData({
      "notif":true
    });*/

    await Firestore.instance
        .collection('user_notifications')
        .document(widget.user.auth_id)
        .collection("Notifications")
        .add({
      "id_user": widget.user_me.auth_id,
      "other_user": widget.user.auth_id,
      "time": new DateTime.now().millisecondsSinceEpoch,
      "accept": false,
      "read": false,
      "type": "connect"
    });



    setState(() {
      widget.user.cnt = "Demande envoyée";
    });
  }

  show_connect() async {

    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) =>
                new SenderPage(widget.user, widget.user_me, connect)));
  }

  confirm() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new Invite_view(
          widget.user.auth_id,
          null,
          widget.user_me.auth_id,
          widget.user_me,
          true,
          false,
          null,
          null,
          widget.list_partners,
          widget.user,
          widget.reload,
          widget.analytics,
          widget.onLocaleChange);
    }));
  }

  gotochat() async {
    print("jdhdhdhdh");
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new ChatScreen(
        widget.user_me.auth_id,
        widget.user.auth_id,
        widget.list_partners,
        false,
        null,
        widget.analytics,
        widget.onLocaleChange,
        user: widget.user_me,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    Color loginGradientEnd = Fonts.col_app_fon;

    Widget lgn = Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: MaterialButton(
        elevation: 1,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.all(
            Radius.circular(8.0),
          )),
          color: widget.user.cnt == "Demande envoyée"
              ? Colors.grey
              : Fonts.col_app_fon,
          highlightColor: Colors.transparent,
          splashColor: !widget.user.wait ? Colors.grey[400] : loginGradientEnd,
          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
            child: Text(
              widget.user.cnt,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 14.0),
            ),
          ),
          onPressed: () {
            if (widget.user.activate != false && widget.user.wait != false) {
              print(widget.user.cnt);
              if (widget.user.cnt == "Se connecter")
                show_connect();
              else if (widget.user.cnt == "Confirmer")
                confirm();
              else if (widget.user.cnt == "Message")
                gotochat();
              else
                return null;
            }
          }),
    );

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

   /* block_user() async {
      if (widget.reload.toString() != "null") {
        widget.reload();
      }

      await Block.insert_block(widget.user_me.auth_id, widget.user.auth_id,
          widget.user_me.id, widget.user.id);
      await Block.insert_block(widget.user.auth_id, widget.user_me.auth_id,
          widget.user.id, widget.user_me.id);

      setState(() {
        widget.user.show = false;
      });
    }*/

    void showMenuSelection(String value) {
      if (value == "bloquer") {
       //  Alert.showAlert(context, block_user);
      }
    }

    Widget menusubscribe = widget.user.id == widget.user_me.id
        ? Container()
        : new Container(
            width: 40.0,
            height: 40.0,
            child: new PopupMenuButton<String>(
                padding: new EdgeInsets.all(2.0),
                icon: new Icon(
                  Icons.more_horiz,
                  color: Fonts.col_app,
                ),
              //  onSelected: showMenuSelection,
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      /* new PopupMenuItem<String>(
                  value: "Block",
                  child: new ListTile(
                      title: new Text(
                          isBlock ? "Unblock this user" : "Block this user")*/
                      new PopupMenuItem<String>(
                          value: "bloquer",
                          child: new ListTile(
                              title:
                                  new Text(LinkomTexts.of(context).block()))),
                    ]));

    Widget page = new Container(
      width: width.value,
      height: heigth.value,
      color: Colors.grey[50],
      child: new Card(
        margin: new EdgeInsets.all(0.0),
        color: Colors.transparent,
        child: new Container(
          alignment: Alignment.center,
          width: width.value,
          height: heigth.value,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.circular(10.0),
          ),
          child: new Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              new CustomScrollView(
                shrinkWrap: false,
                slivers: <Widget>[
                  new SliverAppBar(
                    elevation: 0.0,
                    forceElevated: true,
                    leading: new IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: new Icon(
                        Icons.arrow_back,
                        color: Colors.blue[300],
                        size: 30.0,
                      ),
                    ),
                    actions: <Widget>[menusubscribe],
                    expandedHeight: _appBarHeight,
                    pinned: _appBarBehavior == AppBarBehavior.pinned,
                    floating: _appBarBehavior == AppBarBehavior.floating ||
                        _appBarBehavior == AppBarBehavior.snapping,
                    snap: _appBarBehavior == AppBarBehavior.snapping,
                    flexibleSpace: new FlexibleSpaceBar(
                      title: new Text(""),
                      background: new Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          new Container(
                            width: width.value,
                            height: _appBarHeight,
                            child: new Container(
                                decoration: new BoxDecoration(
                                  color: Fonts.col_app.withOpacity(0.06),
                                ),
                                child: new Column(children: <Widget>[
                                  new Row(
                                    children: <Widget>[
                                      new Expanded(child: new Container()),
                                    ],
                                  ),
                                  new Container(
                                    height: 68.0,
                                  ),
                                  new GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FullScreenWrapper(
                                                imageProvider: NetworkImage(
                                                    widget.user.image),
                                              ),
                                            ));
                                      },
                                      child:
                                          /*new Hero(
                                        tag: widget.user.id,
                                        child: */
                                      new Container(
                                          decoration: new BoxDecoration(
                                            color: widget.user.verify.toString() != "1"
                                                ? Colors.grey[300]
                                                : widget.user.entreprise.situation == "Ajour"
                                                ? Fonts.col_app_green
                                                : Fonts.col_gr,
                                            shape: BoxShape.circle,
                                          ),
                                          padding: EdgeInsets.all(4),
                                          child:   new ClipOval(
                                              child: new Container(
                                        width: 70.0,
                                        height: 70.0,
                                        child: new FadingImage.network(
                                          widget.user.image,
                                          fit: BoxFit.cover,
                                        ),
                                      )))),
                                  new Container(
                                    height: 12.0,
                                  ),
                                  new Center(
                                      child: new Text(
                                   toBeginningOfSentenceCase(widget
                                                .user.firstname
                                                .toString()) +
                                            " " +
                                            widget.user.fullname
                                                .toString()
                                                .toUpperCase(),
                                    style: new TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w700),
                                  )),
                                  new Container(
                                    height: 4.0,
                                  ),
                                  new Container(
                                    padding: EdgeInsets.only(left: 8, right: 8),
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: new Container(
                                        width: 330.0,
                                        child: RichText(
                                            textAlign: TextAlign.center,
                                            text: new TextSpan(
                                              text: "",
                                              children: <TextSpan>[
                                                new TextSpan(
                                                  text: widget.user.fonction.name
                                                      .toString(),
                                                  style: new TextStyle(
                                                      color: Colors.grey[400],
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                new TextSpan(
                                                  text: " à " ,
                                                  style: new TextStyle(
                                                      color: Colors.grey[400],
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                new TextSpan(
                                                    text: widget.user.organisme,
                                                    style: new TextStyle(
                                                        color: Colors.blue[400],
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w600))
                                              ],
                                            ))),
                                  ),
                                  new Container(
                                    height: 8.0,
                                  ),
                                  new Container(
                                      padding:
                                          EdgeInsets.only(left: 8, right: 8),
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: new Text(
                                        widget.user.community.toString(),
                                        textAlign: TextAlign.center,
                                        style: new TextStyle(
                                            color: Colors.grey[200],
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.w400),
                                      )),
                                  widget.user.id == widget.user_me.id
                                      ? Container()
                                      : lgn,
                                  new Container(
                                    height: 12.0,
                                  ),
                                  Expanded(
                                    child: Container(),
                                  ),
                                ])),
                          ),
                        ],
                      ),
                    ),
                  ),
                  new SliverList(
                    delegate: new SliverChildListDelegate(<Widget>[
                      new Container(height: 8.0),
                      Distance_Online_Widget(widget.user),
                      new Container(height: 8.0),
                      new Container(
                          padding: EdgeInsets.all(16),
                          color: Fonts.col_cl,
                          child: new Text(LinkomTexts.of(context).compe(),
                              style: new TextStyle(
                                  color: Fonts.col_app,
                                  fontWeight: FontWeight.w600))),
                      new Container(height: 12.0),
                      widget.user.list != null && widget.user.list.isNotEmpty
                          ? new Center(
                              child: new Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  spacing: 4.0,
                                  runSpacing: 4.0,
                                  children: widget.user.list.map((String item) {
                                    return a(item);
                                  }).toList()))
                          : new Container(
                              padding:
                                  new EdgeInsets.only(top: 16.0, bottom: 24.0),
                              child: new Center(
                                child: new Text(
                                  "Aucun domaine d’expertise n'a été mentionné",
                                  style: new TextStyle(
                                      color: Colors.grey[500], fontSize: 16.0),
                                ),
                              )),
                      new Container(height: 12.0),
                      new Container(
                          padding: EdgeInsets.all(16),
                          color: Fonts.col_cl,
                          child: new Text(
                            LinkomTexts.of(context).objs(),
                            style: new TextStyle(
                                color: Fonts.col_app,
                                fontWeight: FontWeight.w600),
                          )),
                      new Container(
                        height: 12.0,
                      ),
                      widget.user.list_obj != null &&
                              widget.user.list_obj.isNotEmpty
                          ? new Center(
                              child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children:
                                      widget.user.list_obj.map((String item) {
                                    return new Container(
                                        padding: new EdgeInsets.all(8.0),
                                        margin:
                                            new EdgeInsets.only(bottom: 8.0),
                                        height: 36.0,
                                        //alignment: Alignment.center,
                                        decoration: new BoxDecoration(
                                          color: Colors.blue[50],
                                          borderRadius:
                                              new BorderRadius.circular(8.0),
                                        ),
                                        child: new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Icon(Icons.bookmark_border,
                                                color: Fonts.col_app),
                                            new Container(
                                              width: 4.0,
                                            ),
                                            new Text(
                                              item,
                                              style: new TextStyle(
                                                  color: Fonts.col_app_fon),
                                            )
                                          ],
                                        ));
                                  }).toList()))
                          : new Container(
                              padding:
                                  new EdgeInsets.only(top: 16.0, bottom: 24.0),
                              child: new Center(
                                child: new Text(
                                    "Aucun objectif n'a été mentionné",
                                    style: new TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 16.0)),
                              )),
                      new Container(
                        height: 12.0,
                      ),
                      widget.user.bio != "" &&
                              widget.user.bio.toString() != "null"
                          ? new Container(
                              padding: EdgeInsets.all(16),
                              color: Fonts.col_cl,
                              child: new Text(
                                "BIO:",
                                style: new TextStyle(
                                    color: Fonts.col_app,
                                    fontWeight: FontWeight.w600),
                              ))
                          : new Container(),
                      widget.user.bio != "" &&
                              widget.user.bio.toString() != "null"
                          ? new Container(
                              padding: new EdgeInsets.all(16.0),
                              width: 300.0,
                              child: new Text(widget.user.bio.toString()),
                            )
                          : new Container(),
                      new Container(height: 8.0),
                      new Container(
                        height: 14.0,
                      ),
                      widget.user.linkedin_link != "" &&
                              widget.user.linkedin_link.toString() != "null"
                          ? new Container(
                              padding: EdgeInsets.all(16),
                              color: Fonts.col_cl,
                              child: new Text(
                                "Profil Linkedin:",
                                style: new TextStyle(
                                    color: Fonts.col_app,
                                    fontWeight: FontWeight.w600),
                              ))
                          : new Container(),
                      new Container(height: 8.0),
                      widget.user.niveau != "" &&
                              widget.user.niveau.toString() != "null"
                          ? new Container(
                              height: 1.0,
                              width: 1000.0,
                              color: Colors.grey[300],
                            )
                          : new Container(),
                      new Container(
                        height: 8.0,
                      ),
                      widget.user.niveau.toString() != "null"
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                  Text("Niveau d'étude:",
                                      style: new TextStyle(
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.w600)),
                                  Container(width: 8),
                                  //jiji
                                ])
                          : Container(),
                      widget.user.niveau.toString() != "null"
                          ? Center(
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(widget.user.niveau.toString()),
                              ),
                            )
                          : Container(),
                      new Container(
                        height: 8.0,
                      ),
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

                                    print(widget.user.linkedin_link);

                                    Navigator.push(context,
                                        new MaterialPageRoute<String>(
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
                      widget.user.twitter_link != "" &&
                              widget.user.twitter_link.toString() != "null"
                          ? new Container(
                              padding: EdgeInsets.all(16),
                              color: Fonts.col_cl,
                              child: new Text(
                                "Profil Twitter:",
                                style: new TextStyle(color: Colors.grey[600]),
                              ))
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
                                    Navigator.push(context,
                                        new MaterialPageRoute<String>(
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
                    ]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    return new Theme(
      data: new ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.grey[50],
        platform: Theme.of(context).platform,
      ),
      child: page,
    );
  }

/*
*/
}

class FullScreenWrapper extends StatelessWidget {
  final ImageProvider imageProvider;
  final Widget loadingChild;
  final Color backgroundColor;
  final dynamic minScale;
  final dynamic maxScale;

  FullScreenWrapper(
      {this.imageProvider,
      this.loadingChild,
      this.backgroundColor,
      this.minScale,
      this.maxScale});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.black,
          actions: <Widget>[
            new IconButton(
                icon: new Icon(
                  Icons.close,
                  color: Fonts.col_app,
                  size: 26.0,
                ),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
        backgroundColor: Colors.black87,
        body: new Container(
            constraints: BoxConstraints.expand(
              height: MediaQuery.of(context).size.height,
            ),
            child: new PhotoView(
              imageProvider: imageProvider,
              loadingChild: loadingChild,
              //backgroundColor: backgroundColor,
              minScale: minScale,
              maxScale: maxScale,
            )));
  }
}
