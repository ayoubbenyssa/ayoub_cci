import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/login/login.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/routes.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActiveWidget extends StatefulWidget {
  ActiveWidget(this.user, this.chng);

  User user;
  var chng;


  // List list_partner;
  //var analytics;
  //var func;


  @override
  _InactiveWidgetState createState() => new _InactiveWidgetState();
}

class _InactiveWidgetState extends State<ActiveWidget> {
  bool loading = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  submit() {
    setState(() {
      loading = true;
    });
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  void initState() {
    super.initState();
  }

  ParseServer parse_s = new ParseServer();


  activate_compte() async {
    Widgets.onLoading(context);
    await Firestore.instance
        .collection('user_notifications')
        .document(widget.user.auth_id)
        .updateData({"send": "no"});

    String id = widget.user.id;
    var query =
        '"author":{"\$inQuery":{"where":{"objectId":"$id"},"className":"users"}}';
    var url = "offers?where={$query}";

    var res = await parse_s.getparse(url);

    for (var i in res["results"]) {
      parse_s.putparse("offers/"+i["objectId"], {"active":1});
    }

    var js = {"token": "", "active": 1, "des": false};

    await parse_s.putparse("users/" + widget.user.id, js);

    final status = await OneSignal.shared.getDeviceState();
     String token = status?.userId;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await parse_s.getparse('users?where={"objectId":"$id"}&include=commissions&include=membre_user.federation&include=membre_user.region&include=fonction');
    widget.user = new User.fromMap(response["results"][0]);

    prefs.setString("user", json.encode(response["results"][0]));

    prefs.setString("id", widget.user.id);

    await Firestore.instance
        .collection('user_notifications')
        .document(widget.user.auth_id)
        .setData({
      "send": "yes",
      "my_token": token,
      "name": widget.user.firstname + "  " + widget.user.fullname,
      "image": widget.user.image
    });

    Navigator.of(context, rootNavigator: true).pop('dialog');


    Routes.goto_home(context, null, null, widget.user,
        [], true, null, widget.chng);

  }

  @override
  Widget build(BuildContext context) {
    var style = new TextStyle(
        color: const Color(0xffeff2f7),
        fontSize: 20.0,
        fontWeight: FontWeight.w500);

    var style2 = new TextStyle(
        color: Colors.grey[700], fontSize: 20.0, fontWeight: FontWeight.w500);

    Widget ess = new Padding(
        padding: new EdgeInsets.only(left: 36.0, right: 36.0, top: 36.0),
        child: new Material(
            elevation: 4.0,
            shadowColor: Colors.grey[700],
            borderRadius: new BorderRadius.circular(8.0),
            color: Fonts.col_app,
            child: new MaterialButton(
                onPressed: () {
                  //  widget.func();
                  //nearDistance();

                  activate_compte();


                },
                child: new Text(LinkomTexts.of(context).activate(), style: style))));


    return new Scaffold(
        key: _scaffoldKey,
        body: new Container(
          decoration: new BoxDecoration(
              color: Colors.grey[300],
              image: new DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Colors.grey.withOpacity(0.2), BlendMode.dstATop),
                  image: new AssetImage("images/bac.jpg"))),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // new Container(height:8.0),
              new Center(
                  child: new Image.asset(
                    "images/logo.png",
                    width: 100.0,
                    height: 100.0,
                  )),
              Container(height: 48.0,),
              new Padding(
                  padding: EdgeInsets.all(12.0),
                  child: new Text(
                   LinkomTexts.of(context).disa()+ " ?",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        color: Colors.grey[700], height: 1.2, fontSize: 18.0),
                  )),
              new Container(height: 50.0),
              !loading ? new Container() : Widgets.load(),
              new Center(child: ess),

              //  new Center(child: ess),
            ],
          ),
        ));
  }
}
//Revenir en arrière
