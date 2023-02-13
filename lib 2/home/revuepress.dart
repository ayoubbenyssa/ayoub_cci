import 'package:flutter/material.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/parc_events_stream/parc_events_stream.dart';
import 'package:mycgem/services/Fonts.dart';



class RevuePress extends StatefulWidget {
  RevuePress(this.user, this.lat, this.lng,
      this.list_partner, this.analytics, this.chng);
  User user;
  var lat,lng;
  List list_partner;
  var analytics;
  var chng;





  @override
  _BiblioVideosState createState() => _BiblioVideosState();
}

class _BiblioVideosState extends State<RevuePress> {


  int count1 = 0;

  setSount1(c) {
    setState(() {
      count1 = c;
    });
  }




  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(  backgroundColor: Fonts.col_app_shadow,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Fonts.col_app_fonn),
        title: Text(
          count1 == 0
              ? 'Revue de presse'
              : 'Revue de presse' + ' (' + count1.toString()+')',
          style: TextStyle(color: Fonts.col_app_fonn,fontSize: 14.0),
        ),
      ),
      body:    new StreamParcPub(
        new Container(),
        widget.lat,
        widget.lng,
        widget.user,
        "1",
        widget.list_partner,
        widget.analytics,
        setSount1,
        widget.chng,

        revue:true,
        favorite: false,
        boutique: false,
      ),
    );
  }
}
