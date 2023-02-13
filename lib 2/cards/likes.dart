import 'package:flutter/material.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/parc_events_stream/parc_events_stream.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/widgets/app_appbar.dart';


class LikeList extends StatefulWidget {
  LikeList(this.lat,this.lng,this.user_me,this.onLocaleChange, this.like_id);
  var onLocaleChange;
  var lat;
  var lng;
  User user_me;
  var like_id;


  @override
  _LikeListState createState() => _LikeListState();
}

class _LikeListState extends State<LikeList> {

  int count1 = 0;

  setSount1(c) {
    setState(() {
      count1 = c;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: MyCgemBarApp("J'aime ",
      actionswidget: Container(),
      ),
      body: new StreamParcPub(
        new Container(),
        widget.lat,
        widget.lng,
        widget.user_me,
        "0",
        [],
        null,
        setSount1,
        widget.onLocaleChange,
        favorite: false,
        boutique: false,
        revue: false,
        likepost: widget.like_id,
      ),
    );
  }
}
