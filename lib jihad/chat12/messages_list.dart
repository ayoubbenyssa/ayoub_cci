import 'dart:async';

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'message_data.dart';
import 'message_item.dart';

class MessagesList1 extends StatefulWidget {
  MessagesList1(
      this.user,
      this.iduser,
      this._searchText,
      this._scrollViewController,
      this.listp,
      this.Rel,
      this.auth,
      this.analytics,this.chng,
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

class _MessagesListState extends State<MessagesList1> {
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

  DatabaseReference gMessagesDbRef_inv;

  insert() {
    gMessagesDbRef_inv =
        FirebaseDatabase.instance.reference().child("room_medz_group");

    gMessagesDbRef_inv.push().set({
      'ids': {
        'bAg0gjSSNxXxBQumaS2txBlNdjP2': true,
        'YZcIJBCe2eQIgwtKcwaMUpGgvxw1': true,
        'mRTUftXkTIP6vMXvbOPrqP9pScW2': true,
        '7wfE5MGNCpYRJI0C32NHjQG165H3': true,
        widget.user.auth_id: true
      },
      'timestamp': ServerValue.timestamp,
      'messageText': "Hello this group is for ...",
      'lastMessage': "Hello this group is for ...",
      'logo':
          "https://res.cloudinary.com/dgxctjlpx/image/upload/v1555421909/87bbfe335196a834e772300c6abcdfd6--logo-s-team-logo_1_nreunk.jpg",
      'groupName': 'My First Group',
      'last_person': 'Ahmed',
      'idUser': widget.user.auth_id,
    });
  }

  @override
  initState() {
    super.initState();

    //insert();

    widget.Rel();

    /*_time = new Timer.periodic(const Duration(minutes: 1), (Timer it) {
      setState(() {});
    });*/

    /*data = FirebaseDatabase.instance
        .reference()
        .child("room");*/

    data = FirebaseDatabase.instance
        .reference()
        .child("room_medz_group")
        .orderByChild("ids/" + widget.iduser)
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
        child: new Center(child: new Text(LinkomTexts.of(context).no_mess())));

    Widget listmessages = new FirebaseAnimatedList(
        controller: widget._scrollViewController,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        defaultChild: Center(
          child: RefreshProgressIndicator(),
        ),
        padding: new EdgeInsets.all(4.0),
        query: data,
        sort: (a, b) => b.value['timestamp'].compareTo(a.value['timestamp']),
        itemBuilder:
            (_, DataSnapshot snap, Animation<double> animation, int a) {
          return new MessageItem(snap, widget.iduser, widget._searchText,
              Reload, widget.user, widget.listp, widget.auth, widget.analytics, widget.chng);
        },
        duration: new Duration(milliseconds: 1000));

    return i == 2 ? nomessagesfound : !loading ? listmessages : new Container();
  }
}
