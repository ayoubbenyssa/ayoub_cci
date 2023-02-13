import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/parc_events_stream/parc_events_stream.dart';
import 'package:mycgem/services/Fonts.dart';

class FilterByOld extends StatefulWidget {
  FilterByOld(this.user, this.lat, this.lng, this.list_partner, this.analytics,
      this.chng);
  User user;
  var lat, lng;
  List list_partner;
  var analytics;
  var chng;

  @override
  _UsersStreamState createState() => _UsersStreamState();
}

class _UsersStreamState extends State<FilterByOld> {
  int count1 = 0;

  setSount1(c) {
    setState(() {
      count1 = c;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 1,
          title: Text(
            "Trier par anciens utilisateurs",
            style: Fonts.st(ScreenUtil().setSp(16)),
          ),
        ),
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
              user_stream: "users",
              filter: "old",
              revue: false,
              favorite: false,
              boutique: false,
            )));
  }
}
