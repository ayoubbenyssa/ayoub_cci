import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mycgem/communities/communitiy_widget.dart';
import 'package:mycgem/communities/fedwidget.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/commission.dart';
import 'package:mycgem/models/community.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/sector_services.dart';
import 'package:mycgem/widgets/app_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FedCGEM extends StatefulWidget {
  FedCGEM(this.auth, this.sign, this.list_partner, this.show, this.view,
      this.lat, this.lng, this.chng,
      {this.user});

  var auth;
  var sign;
  List list_partner;
  bool show;
  User user;
  bool view = false;

  var lat;
  var lng;
  var chng;

  @override
  _State createState() => new _State();
}

class _State extends State<FedCGEM> {
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

    List<Commission> coms = await SectorsServices.get_list_fed();

    if (!this.mounted) return;

    setState(() {
      com = coms;
      loading = false;
    });

    if (widget.user.toString() != "null") {

      for (Commission i in coms) {
        print(i.objectId);
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

    /* new Future.delayed(Duration.zero, () {
      showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                content: new Container(
                    height: 220.0,
                    child: new Column(
                      children: <Widget>[
                        new Text(
                            "Nous vous remercions de votre inscription. Vous pouvez maintenant choisir votre communauté. Vous êtes autorisés à faire partie d’une seule communauté. "
                                "Une vérification de votre position GPS est exigée pour valider votre appartenance à la communauté choisie.")
                      ],
                    )),
                actions: <Widget>[
                  new FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: new Text('OK')),
                ],
              ));
    });*/

    // com.add(new Community.fromDocument(val.snapshot));

    /*try {
        setState(() {
          i = 1;
          if (val.snapshot.value == null) i = 2;
        });
      } catch (e) {}*/
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
        //page = new NoGps(getLocation);
        /*new RaisedButton(child: new Text("Réessayer"),onPressed: (){
          getLocation();
        },);*/
      } else {
        //page = new ListView(children: loadPosts());
        page = new ListView(
            primary: false,
            padding: const EdgeInsets.all(0.5),
            children: com.map((var item) {
              return new Fedwidget(item, widget.auth, widget.sign, id,
                  widget.user, widget.show, list, widget.view, widget.chng);
            }).toList());
        /*new Center(child: new RaisedButton(child: new Text("Réessayer"),onPressed: (){
          al();
          getLocation();
        },),);*/

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
            appBar:   MyCgemBarApp(
              LinkomTexts.of(context).fids(),
              actionswidget: Container(),
            ),

            body: new Padding(
              padding: new EdgeInsets.only(top: 0.0),
              child: page,
            )));
  }
}
