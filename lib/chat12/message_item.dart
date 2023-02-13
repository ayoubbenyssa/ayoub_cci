import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:mycgem/chat12/chatscreen.dart';
import 'package:mycgem/language_params/scope_model_wrapper.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:timeago/timeago.dart' as ta;
import 'package:mycgem/chat/chatscreen.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/models/user.dart';

class MessageItem extends StatefulWidget {
  MessageItem(this.snapshot, this.id, this.searchText, this.reload, this.me,
      this.list_partners, this.auth, this.analytics,this.chng,
      {Key key})
      : super(key: key);
  DataSnapshot snapshot;
  String id;
  String searchText;
  var reload;
  User me;
  var list_partners;
  var auth;
  var analytics;
  var chng;


  @override
  _MessageItemState createState() => new _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  String name = "", idOther = "";
  String titre = "";
  DatabaseReference gMessagesDbRef3;

  TextStyle style = new TextStyle(
    fontSize: 10.5,
    color: Colors.grey,
  );

  ParseServer parse_s = new ParseServer();

  String photoURL = "";
  var sp;
  String idLast = "";

  bool vu = false;
  bool vumoi = false;
  User userme;
  User user_other = new User();

  /*getOnlineUser() async {

    DocumentSnapshot a = await Firestore.instance
        .collection('users')
        .document(user_other.auth_id)
        .get();
    if (!this.mounted) return;

    if (a.data["online"].toString() == "true") {

      setState(() {
        user_other.online = true;
      });
    } else
      setState(() {
        user_other.online = false ;
      });

  }*/

  /* Future<User> GetUserInfo(id) async {
    // DocumentSnapshot snap =
    //  await Firestore.instance.collection('users').document(id).get();
    //return new User.fromDoc(snap)
    var response = await parse_s.getparse('users?where={"id":"$id"}');
    user_other = new User.fromMap(response["results"][0]);
    //  user_other.online = false;
   // getOnlineUser();
    return new User.fromMap(response["results"][0]);
  }*/

  /*



 List<String> likes;

LiveChat.fromMap(Map<String, dynamic> data) {
  likes = data['likes'].cast<String>();
}




  */

  List<Map<String, double>> getListOfMaps() {
    return widget.snapshot.value["ids"]
        .cast<Map<String, dynamic>>()
        .map((trace) => trace.cast<String, dynamic>())
        .toList();
  }

  @override
  initState() {
    super.initState();

    // var reversed = Map.fromEntries(aa.entries.map((e) => MapEntry(e.value, e.key)));

    //print(reversed.entries);

//      print(kv.value);

    //list_ids_users.add(kv.value);
    //print(list_ids_users);

    /*
    new Map<String, dynamic>.from(
     */

    /*  for( var i = 0;i<3;i++)
      {

        print(  new Map<String, dynamic>.from(widget.snapshot.value["ids"][i]));
      }*/
    // widget.snapshot
    /*  widget.snapshot.value['ids'].cast<Map<String,dynamic>>() .forEach((val)=> print(val));


   // for(var i = 0;i<)

    print(widget.snapshot.value["ids"]);


print(getListOfMaps()


    for(var i =0 ;i< widget.snapshot.value["ids"].length;i++)
      {

        print(widget.snapshot.value["ids"][0]);
      }*/

    // print(widget.snapshot.value["ids"]);

    /*getUser(widget.id).then((user) {
      try {
        setState(() {
         userme = user;
        });
      } catch (e) {}
    });*/
  }

  @override
  Widget build(BuildContext context) {
    Widget namew() {
      return new Text(widget.snapshot.value['groupName'].toString(),
          style: new TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 15.0,
          ));
    }

    Widget titrew() {
      return Container(
          width: 140.0,
          child: new Text(widget.snapshot.value['messageText'].toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: new TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.w500,
                fontSize: 12.0,
              )));
    }

    return (!name.toLowerCase().contains(widget.searchText.toLowerCase()) &&
            widget.searchText.isNotEmpty)
        ? new Container()
        : new Container(
            //color: Colors.grey[50],
            color: Colors.grey[50],
            child: new FlatButton(
                // padding: new EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0,bottom: 8.0),
                onPressed: () {
                  Navigator.push(
                    context,
                    new PageRouteBuilder(
                      pageBuilder: (BuildContext context, Animation<double> _,
                          Animation<double> __) {
                        return new ChatScreen1(
                            widget.id,
                            idOther,
                            widget.list_partners,
                            false,
                            widget.auth,
                            //List des ids des utilisateurs
                            new Map<String, dynamic>.from(
                                    widget.snapshot.value["ids_o"])
                                .keys
                                .toList(),
                            widget.snapshot.value["groupName"],
                            widget.snapshot.key,
                            widget.analytics,
                            widget.chng,
                            user: widget.me,
                            reload: widget.reload,
                            chat: widget.snapshot);
                      },
                    ),
                  );
                },
                child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(height: 8.0),
                      new Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new ClipOval(
                              child: new Container(
                                  width: 56.0,
                                  height: 56.0,
                                  child: new Image.network(
                                    widget.snapshot.value['logo'].toString(),
                                    fit: BoxFit.cover,
                                  ))),
                          new Container(width: 4.0),
                          new Container(width: 8.0),
                          new Container(
                            //padding: new EdgeInsets.all(4.0),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Container(
                                    // padding: new EdgeInsets.only(bottom: 2.0),
                                    child: namew()),
                                new Container(height: 2.0),
                                titrew(),
                                new Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.42,
                                          padding: new EdgeInsets.only(
                                              top: 2.0), //error
                                          child: new Text(
                                            widget.snapshot.value['last_person']
                                                    .toString() +
                                                ": " +
                                                widget.snapshot
                                                    .value['lastMessage']
                                                    .toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.blueGrey[500],
                                                fontSize: 11.0),
                                          )),
                                      new Container(width: 8.0),
                                    ]),
                              ],
                            ),
                          ),
                          new Expanded(child: new Container()),
                          new Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              new Row(children: <Widget>[
                                /* new Icon(Icons.access_time,
                            size: 12.0, color: Colors.grey[500]),*/
                                new Container(width: 2.0),
                                ScopedModelDescendant<AppModel1>(
                                    builder: (context, child, model) => new Text(
                                        ta.format(
                                            new DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                widget.snapshot
                                                    .value['timestamp']),
                                            locale: model.locale == "ar"
                                                ? "ar"
                                                : "fr"),
                                        style: new TextStyle(
                                            color: Colors.grey,
                                            fontSize: 11.0))),
                              ]),
                              new Container(
                                height: 16.0,
                              ),
                            ],
                          )
                        ],
                      ),
                      new Container(
                        height: 8.0,
                      ),
                      new Container(
                          height: 0.5, width: 900.0, color: Colors.grey[400])
                    ])));
  }
}
