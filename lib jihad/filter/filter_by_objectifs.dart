import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/parc_events_stream/parc_events_stream.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/widgets/app_appbar.dart';

class FilterByObjectifs extends StatefulWidget {
  FilterByObjectifs(this.user, this.lat, this.lng, this.list_partner, this.analytics,
      this.chng,this.obj);
  User user;
  var lat, lng;
  List list_partner;
  var analytics;
  var chng;
  String obj;

  @override
  _UsersStreamState createState() => _UsersStreamState();
}

class _UsersStreamState extends State<FilterByObjectifs> {
  int count1 = 0;

  setSount1(c) {
    setState(() {
      count1 = c;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar:  MyCgemBarApp(widget.obj,
          actionswidget: Container(),),
        body: Container(
            color: Fonts.col_grey.withOpacity(0.16),
            child: new StreamParcPub(
              new Container(),
              widget.lat,
              widget.lng,
              widget.user,
              "1",
              widget.list_partner,
              widget.analytics,
              setSount1,
              widget.chng,
              obj: widget.obj,
              user_stream: "users",
              filter: "objectifs",
              revue: false,
              favorite: false,
              boutique: false,
            )));
  }
}
