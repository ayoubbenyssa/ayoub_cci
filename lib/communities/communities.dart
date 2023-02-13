import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mycgem/communities/communitiy_widget.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/commission.dart';
import 'package:mycgem/models/community.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/sector_services.dart';
import 'package:mycgem/widgets/app_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommunitiesCGEM extends StatefulWidget {
  CommunitiesCGEM(this.auth, this.sign, this.list_partner, this.show, this.view,
      this.lat, this.lng, this.chng,
      {this.user});

  var auth;
  var sign;

  List list_partner;
  bool show;
  User user;
  bool view = false;
  var chng;
  var lat;
  var lng;

  @override
  _State createState() => new _State();
}

class _State extends State<CommunitiesCGEM> {
  DatabaseReference data;

  List<Commission> com = new List<Commission>();
  Community co = new Community();
  bool loading = true;

  //final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String id = "";
  List<Commission> list = [];

  getId() async {
    FirebaseUser a = await FirebaseAuth.instance.currentUser();
    if (!mounted) return;
    setState(() {
      id = a.uid;
    });
  }

  getcom() async {
    if (!this.mounted) return;

    List<Commission> coms = await SectorsServices.get_list_com();

    if (!this.mounted) return;

    setState(() {
      com = coms;
      loading = false;
    });

    if (widget.user.toString() != "null") {


      for (Commission i in coms) {
        if (widget.user.commissions_list.contains(i.objectId)) {
          i.check = true;
          list.add(i);
        }
      }
    }
  }

  @override
  initState() {
    super.initState();
    getcom();
    getId();
  }

  al() {
    setState(() {
      loading = true;
    });
  }

  ParseServer parseFunctions = new ParseServer();

  enter() async {
    List lst = [];
    List lst2 = [];
    for (Commission i in list) {
      lst.add({
        "__type": "Pointer",
        "className": "commissions",
        "objectId": i.objectId
      });

      lst2.add(i.objectId);
    }

    var js = {
      "commissions": {"__op": "AddUnique", "objects": lst},
      "commissions_list": lst2
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String my_id = prefs.getString("id");

    if (widget.user.toString() != "null") {
      widget.user.commissions_list = lst2;
    }
    print(id);
    parseFunctions.putparse("users/" + my_id, js);

    if (widget.show == false) {
      Navigator.pop(context, list);

      /* Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (BuildContext context) =>
                //new HomePage(widget.auth,widget.sign)
                new SubmitNameOrganisme(/*com,*/ null, null, []),
          ));*/
    } else {
      Navigator.pop(context, list);
    }
    print(lst);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listWidget = new List<Widget>();
    //_showAlert();

    Widget refreshprogress = new Center(
        child: new Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: new RefreshProgressIndicator()));

    Widget page;

    if (loading) {
      listWidget.add(refreshprogress);
      page = new ListView(children: listWidget);
    } else {
      if (com == null || com.isEmpty) {
        al();

      } else {
        //page = new ListView(children: loadPosts());
        page = new ListView(
            primary: false,
            padding: const EdgeInsets.all(1.5),
            children: com.map((var item) {
              return new Communitywidget(item, widget.auth, widget.sign, id,
                  widget.user, widget.show, list, widget.view, widget.chng);
            }).toList());


      }
    }

    return new WillPopScope(
        onWillPop: () {
          if (widget.user.toString() != "null") {
            List<Commission> lst = [];
            for (var i in widget.user.commissions) {
              lst.add(i);
            }
            Navigator.pop(context, lst);
          } else
            exit(0);
        },
        child: new Scaffold(
            backgroundColor: Colors.grey[200],
            //key: _scaffoldKey,
            appBar:  MyCgemBarApp(
                LinkomTexts.of(context).comms(),
              actionswidget: Container(),
            ),

            body: new Padding(
              padding: new EdgeInsets.only(top: 0.0),
              child: page,
            )));
  }
}
