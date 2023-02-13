import 'package:flutter/material.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/parc_events_stream/parc_events_stream.dart';

class Participate extends StatefulWidget {
  Participate(this.user, this.idp, this.chng);

  User user;
  var idp;
  var chng;

  @override
  _ParticipateState createState() => _ParticipateState();
}

class _ParticipateState extends State<Participate> {
  int count1 = 0;
  int count2 = 0;

  setSount1(c) {
    setState(() {
      count1 = c;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(LinkomTexts.of(context).particip()+" (" + count1.toString() + ')')),
        body: new StreamParcPub(
          new Container(),
          null,
          null,
          widget.user,
          "1",
          [],
          null,
          setSount1,
          widget.chng,
          revue: false,
          idpost: widget.idp,
          video: false,
          favorite: false,
          boutique: false,
        ));
  }
}
