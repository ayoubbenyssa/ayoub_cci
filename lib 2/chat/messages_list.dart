import 'dart:async';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mycgem/models/user.dart';
import 'message_data.dart';
import 'message_item.dart';

class MessagesList extends StatefulWidget {
  MessagesList(
      this.user,
      this.iduser,
      this._searchText,
      this._scrollViewController,
      this.listp,
      this.Rel,
      this.auth,
      this.analytics,
      this.chng,
      {Key key})
      : super(key: key);
  String iduser;
  ScrollController _scrollViewController;
  String _searchText;
  User user;
  var listp;
  var Rel;
  var auth;
  var analytics;
  var chng;


  @override
  _MessagesListState createState() => new _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  List<Message> list = new List<Message>();
  Timer _time;
  var data;
  int i = 0;

  var loading = false;

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

  @override
  initState() {
    super.initState();

    widget.Rel();

    /*_time = new Timer.periodic(const Duration(minutes: 1), (Timer it) {
      setState(() {});
    });*/

    /*data = FirebaseDatabase.instance
        .reference()
        .child("room");*/

    data = FirebaseDatabase.instance
        .reference()
        .child("room_medz")
        .orderByChild(widget.iduser)
        .equalTo(true);
    data.keepSynced(true);
    data.onValue.forEach((val) {
      try {
        setState(() {
          i = 1;
          if (val.snapshot.value == null) i = 2;
        });
      } catch (e) {}
    });

    FirebaseDatabase.instance.setPersistenceEnabled(true);
    // data.keepSynced(true);
  }

  /*@override
  dispose() {
    _time.cancel();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    Widget loadingScreen() {
      final ThemeData theme = Theme.of(context);
      return new Container(
          child: new Center(
              child: new Text("Loading...", style: theme.textTheme.display1)));
    }

    Widget emptyScreen() {
      final ThemeData theme = Theme.of(context);
      return new Container(
          child: new Center(
              child: new Text("No Messages", style: theme.textTheme.display1)));
    }

    Widget nomessagesfound = new Container(
        padding: new EdgeInsets.only(top: 24.0),
        child: new Center(child: new Text("Aucun message trouv??")));

    Widget listmessages = new FirebaseAnimatedList(
        controller: widget._scrollViewController,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        defaultChild: Center(
          child: new RefreshProgressIndicator(),
        ),
        padding: new EdgeInsets.all(4.0),
        query: data,
        sort: (a, b) => b.value['timestamp'].compareTo(a.value['timestamp']),
        itemBuilder:
            (_, DataSnapshot snap, Animation<double> animation, int a) {
          return new MessageItem(
            snap,
            widget.iduser,
            widget._searchText,
            Reload,
            widget.user,
            widget.listp,
            widget.auth,
            widget.analytics,
            widget.chng,
          );
        },
        duration: new Duration(milliseconds: 1000));

    return i == 2 ? nomessagesfound : !loading ? listmessages : new Container();
  }
}
