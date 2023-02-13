import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/parc_events_stream/parc_events_stream.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/widgets/app_appbar.dart';

class CommissionsStream extends StatefulWidget {
  CommissionsStream(this.user, this.lat, this.lng, this.list_partner,
      this.analytics, this.chng, this.display_scaffold);

  User user;
  var lat, lng;
  List list_partner;
  var analytics;
  var chng;
  bool display_scaffold;

  @override
  _UsersStreamState createState() => _UsersStreamState();
}

class _UsersStreamState extends State<CommissionsStream> {
  int count1 = 0;

  setSount1(c) {
    setState(() {
      count1 = c;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget page = Container(
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
          user_stream: "commission",
          revue: false,
          favorite: false,
          boutique: false,
          display_photo: widget.display_scaffold
        ));

    return widget.display_scaffold == false
        ? page
        : Scaffold(
            appBar: MyCgemBarApp(
              "Commissions permanentes",
              actionswidget: Container(),
            ),
            body: page);
  }
}
