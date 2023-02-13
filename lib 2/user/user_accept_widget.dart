import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/notifications/invite_view_user.dart';
import 'package:intl/intl.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/connect.dart';
import 'package:mycgem/widgets/bottom_menu.dart';

class UserAcceptWidget extends StatefulWidget {
  UserAcceptWidget(this.user, this.user_me, this.auth, this.sign,
      this.list_partners, this.load, this.analytics, this.chng);

  User user;
  var auth;
  var sign;
  var list_partners;
  User user_me;
  var load;
  var analytics;

  var chng;

  @override
  _UserSearchWidgetState createState() => _UserSearchWidgetState();
}

class _UserSearchWidgetState extends State<UserAcceptWidget> {
  String id_connect;
  String id_notification;

  String getKey() => widget.user_me.auth_id + "_" + widget.user.auth_id;

  String getKey1() => widget.user.auth_id + "_" + widget.user_me.auth_id;

  bool load = false;

  confirmer() async {
    setState(() {
      load = true;
    });

    QuerySnapshot res = await Firestore.instance
        .collection('user_notifications')
        .document(widget.user_me.auth_id)
        .collection("Notifications")
        .where("id_user", isEqualTo: widget.user.auth_id)
        .getDocuments();

    id_notification = res.documents[0].documentID;

    var response1 =
        await Connect.get_request_user(widget.user_me.id, widget.user.id);
    id_connect = response1[0].objectId;

    Firestore.instance
        .collection('user_notifications')
        .document(widget.user_me.auth_id)
        .collection("Notifications")
        .document(id_notification)
        .updateData({"accept": true});

    DatabaseReference gMessagesDbRef2 = FirebaseDatabase.instance
        .reference()
        .child("room_medz")
        .child(getKey());
    gMessagesDbRef2.set({
      "token": widget.user_me.token,
      "name": widget.user_me.firstname +
          " " +
          widget.user_me.fullname.toString().toUpperCase(),
      widget.user_me.auth_id: true,
      "lastmessage": "Aucun message",
      "key": getKey(),
      "me": false,
      "timestamp": ServerValue.timestamp /*new DateTime.now().toString()*/,
    });

    FirebaseDatabase.instance
        .reference()
        .child("room_medz")
        .child(getKey1())
        .set({
      "token": widget.user.token,
      widget.user.auth_id: true,
      "lastmessage": "Aucun message",
      "key": getKey1(),
      "me": false,
      "timestamp": ServerValue.timestamp /*new DateTime.now().toString()*/,
    });

    await Firestore.instance
        .collection('user_notifications')
        .document(widget.user_me.auth_id)
        .collection("Notifications")
        .document(id_notification)
        .delete();

    Firestore.instance
        .collection('user_notifications')
        .document(widget.user.auth_id)
        .collection("Notifications")
        .add({
      "id_user": widget.user_me.auth_id,
      "other_user": widget.user.auth_id,
      "time": new DateTime.now().millisecondsSinceEpoch,
      "read": false,
      "type": "accept"
    });
    await Connect.update_request(id_connect);
    await Connect.inser_request(widget.user_me.id, widget.user.id, true);

    /* Routes.goto_home(context, widget.auth, widget.sign, widget.user_me,
        widget.analytics, widget.observer, widget.list_partner);*/

    setState(() {
      load = false;
    });

    Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => new BottomNavigation(widget.auth,
                null, widget.user_me, [], false, widget.analytics, widget.chng,
                animate: true)));
  }

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      child: new Column(children: <Widget>[
        new Container(
          padding: new EdgeInsets.all(8.0),
          height: 60.0,
          child: new Row(
            children: <Widget>[
              new ClipOval(
                  child: new Container(
                      width: 40.0,
                      height: 40.0,
                      child: new Image.network(widget.user.image,
                          fit: BoxFit.cover))),
              new Container(width: 16.0),
              new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      height: 4.0,
                    ),
                    new Container(
                        width: 140.0,
                        child: new RichText(
                          text: new TextSpan(
                            text: "",
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              new TextSpan(
                                  text: toBeginningOfSentenceCase(
                                          widget.user.firstname) +
                                      "  " +
                                      widget.user.fullname.toUpperCase(),
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.0)),
                            ],
                          ),
                        )),
                    Container(
                        width: 140.0,
                        child: new Text(
                          widget.user.fonction.name + " à " + widget.user.organisme,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: new TextStyle(color: Colors.grey[800]),
                        ))
                  ]),
              new Expanded(child: new Container()),
              new RaisedButton(
                  padding: new EdgeInsets.all(0.0),
                  color: Fonts.col_app_fon,
                  child: load
                      ? CupertinoActivityIndicator()
                      : new Text(
                          "Confirmer".toUpperCase(),
                          style: new TextStyle(color: Colors.white),
                        ),
                  onPressed: () {
                    if (load == false) confirmer();
                    /* Navigator.push(context,
                        new MaterialPageRoute(builder: (BuildContext context) {
                      return new Invite_view(
                          widget.user.auth_id,
                          null,
                          widget.user_me.auth_id,
                          widget.user_me,
                          true,
                          false,
                          widget.auth,
                          widget.sign,
                          widget.list_partners,
                          widget.user,
                          widget.load,
                          widget.analytics,
                          widget.chng);
                    }));*/
                  })
            ],
          ),
        ),
        new Container(
          height: 1.0,
          // width: 1000.0,
          color: Colors.grey[300],
        )
      ]),
      onTap: () {
        /* Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) {
              return new Invite_view(posts[index].auth_id, posts[index].notif_id,id,widget.user_me,go,delete_not);
            }));*/
      },
    );
  }
}
