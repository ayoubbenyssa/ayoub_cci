import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mycgem/cards/details_parc.dart';
import 'package:mycgem/cards/opp_card.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/language_params/scope_model_wrapper.dart';
import 'package:mycgem/models/offers.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/widgets/app_appbar.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:timeago/timeago.dart' as ta;
import 'package:mycgem/models/user.dart';
import 'package:mycgem/notifications/invite_view_user.dart';
import 'package:intl/intl.dart';

class Listusers extends StatefulWidget {
  Listusers(this.user_me, this.auth, this.sign, this.list_partner, this.load,
      this.analytics, this.chng);

  User user_me;
  var sign;
  var auth;
  var list_partner;
  var load;
  var analytics;
  var chng;

  @override
  _PostsBycategoryState createState() => new _PostsBycategoryState();
}

class _PostsBycategoryState extends State<Listusers> {
  int postCount;

  FirebaseUser me;
  ParseServer parse_s = new ParseServer();
  bool loading = true;
  List<User> posts = null;
  String id;

  getid() async {
    var a = await FirebaseAuth.instance.currentUser();
    if (!mounted) return;
    setState(() {
      id = a.uid;
    });
  }

  @override
  void initState() {
    getid();
    super.initState();
    getPosts();
  }

  getPosts() async {
    var a = await FirebaseAuth.instance.currentUser();
    if (!mounted) return;

    setState(() {
      id = a.uid;
    });
    var snap = await Firestore.instance
        .collection('user_notifications')
        .document(id)
        .collection("Notifications")
        .orderBy('time', descending: true)
        .getDocuments();
    if (!mounted) return;

    setState(() {
      loading = false;
      posts = [];
    });

    if (snap.documents.length == 0) {
      setState(() {
        posts = [];
        loading = false;
      });
    }

    for (var doc in snap.documents) {
      //posts.add(new User.fromDoc(doc));
      String id_other;

      id_other = doc.data["id_user"];

      var response = await parse_s.getparse('users?where={"id1":"$id_other"}&include=commissions&include=membre_user.federation&include=membre_user.region&include=fonction');
      if (!this.mounted) return;

      User user = new User.fromMap(response["results"][0]);
      user.accept = doc.data["accept"];
      user.notif_time = doc.data["time"];
      user.read = doc.data["read"];
      user.notif_id = doc.documentID;
      user.type_req = doc.data["type"];
      user.message = doc.data.containsKey("message") ? doc.data["message"] : "";
      user.id_publication = doc.data.containsKey("id_publication")
          ? doc.data["id_publication"]
          : "";

      setState(() {
        postCount = snap.documents.length;
        posts.add(user);
      });
    }
  }

  int i;

  delete_not() {
    setState(() {
      posts.removeAt(i - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyCgemBarApp(
          LinkomTexts.of(context).not(),
          actionswidget: Container(),
        ),
        body: loading
            ? Widgets.load()
            : posts.isEmpty
                ? new Center(
                    child: new Text(LinkomTexts.of(context).no_not()),
                  )
                : new ListView(
                    children: new List.generate(posts.length, (int index) {
                    //print(snapshot.data[index]);

                    return posts[index].accept == true
                        ? new Container()
                        : new InkWell(
                            child: new Column(children: <Widget>[
                              //  if(posts[index].type_req == "accept" || posts[index].type_req == "connect")
                              new Container(
                                color: posts[index].read == false
                                    ? Colors.blue[50]
                                    : Colors.white,
                                padding: new EdgeInsets.all(8.0),
                                height: 60.0,
                                child: new Row(
                                  children: <Widget>[
                                    new ClipOval(
                                        child: new Container(
                                            padding: EdgeInsets.all(
                                                (posts[index].type_req ==
                                                            "connect" ||
                                                        posts[index].type_req ==
                                                            "accept")
                                                    ? 0
                                                    : 6),
                                            color:
                                                Fonts.col_app.withOpacity(0.1),
                                            width: 40.0,
                                            height: 40.0,
                                            child: (posts[index].type_req ==
                                                        "connect" ||
                                                    posts[index].type_req ==
                                                        "accept")
                                                ? new Image.network(
                                                    posts[index].image,
                                                    fit: BoxFit.cover)
                                                : Image.asset("assets/images/logo.png"))),
                                    new Container(width: 10.0),
                                    new Container(
                                        width: (posts[index].type_req ==
                                                    "connect" ||
                                                posts[index].type_req ==
                                                    "accept")
                                            ? 180.0
                                            : 220,
                                        child: new RichText(
                                          text: new TextSpan(
                                            text: "",
                                            style:
                                                TextStyle(color: Colors.black),
                                            children: <TextSpan>[
                                              new TextSpan(
                                                  text: (posts[index]
                                                                  .type_req ==
                                                              "connect" ||
                                                          posts[index]
                                                                  .type_req ==
                                                              "accept")
                                                      ? (toBeginningOfSentenceCase(
                                                              posts[index]
                                                                  .firstname
                                                                  .toString()) +
                                                          " " +
                                                          posts[index]
                                                              .fullname
                                                              .toString()
                                                              .toUpperCase())
                                                      : "",
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13.0)),
                                              new TextSpan(
                                                  text: posts[index].type_req ==
                                                          "connect"
                                                      ? " " +
                                                          LinkomTexts.of(
                                                                  context)
                                                              .sendi()
                                                      : posts[index].type_req ==
                                                              "accept"
                                                          ? " " +
                                                              LinkomTexts.of(
                                                                      context)
                                                                  .accepta()
                                                          : (posts[index].type_req ==
                                                                      "publication" ||
                                                                  posts[index]
                                                                          .type_req ==
                                                                      "opportunite")
                                                              ? posts[index]
                                                                  .message
                                                              : "",
                                                  style: new TextStyle(
                                                      fontSize: 13.0)),
                                            ],
                                          ),
                                        )),
                                    new Expanded(child: new Container()),
                                    ScopedModelDescendant<AppModel1>(
                                        builder: (context, child, model) =>
                                            new Text(
                                              ta.format(
                                                  new DateTime
                                                          .fromMillisecondsSinceEpoch(
                                                      posts[index].notif_time),
                                                  locale: model.locale == "ar"
                                                      ? "ar"
                                                      : "fr"),
                                              style: new TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 11.0),
                                            ))
                                  ],
                                ),
                              ),
                              new Container(
                                height: 1.0,
                                width: 1000.0,
                                color: Colors.grey[300],
                              )
                            ]),
                            onTap: () async {
                              // UserConn(this.id, this.id_notification,this.my_id /*,this.image,this.name*/)
                              i = index;

                              setState(() {
                                posts[index].read = true;

                              });
                              Firestore.instance
                                  .collection('user_notifications')
                                  .document(widget.user_me.auth_id)
                                  .collection("Notifications")
                                  .document( posts[index].notif_id )
                                  .updateData({"read": true});

                              if (posts[index].type_req == "connect" ||
                                  posts[index].type_req == "accept") {
                                bool go = true;
                                if (posts[index].type_req == "connect") {
                                  go = true;
                                } else if (posts[index].type_req == "accept") {
                                  go = false;
                                }

                                Navigator.push(context, new MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return new Invite_view(
                                      posts[index].auth_id,
                                      posts[index].notif_id,
                                      id,
                                      widget.user_me,
                                      go,
                                      delete_not,
                                      widget.auth,
                                      widget.sign,
                                      widget.list_partner,
                                      posts[index],
                                      widget.load,
                                      widget.analytics,
                                      widget.chng);
                                }));
                              } else if (posts[index].type_req ==
                                      "publication" ||
                                  posts[index].type_req == "opportunite") {
                                String idpost = posts[index].id_publication;

                                var a = await parse_s.getparse(
                                    'offers?where={"objectId": "$idpost"}&include=author&include=membre');
                                Offers off = Offers.fromMap(a['results'][0]);

                                if (posts[index].type_req == "opportunite") {
                                  Navigator.push(context, new MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return new OppCard(off, widget.user_me, 0.0,
                                        0.0, context, true, widget.chng);
                                  }));
                                } else {
                                  Navigator.push(context, new MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return new DetailsParc(
                                        off,
                                        widget.user_me,
                                        off.type,
                                        [],
                                        null,
                                        widget.analytics,
                                        widget.chng,
                                        0.0,
                                        0.0);
                                  }));
                                }
                              }
                            },
                          );
                  })));
  }
}
