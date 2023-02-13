import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:mycgem/home/connect_accept_widget.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/app_services.dart';
import 'package:mycgem/services/block.dart';
import 'package:mycgem/services/location_services.dart';
import 'package:mycgem/user/details_user.dart';
import 'package:intl/intl.dart';

class UserSearchWidget extends StatefulWidget {
  UserSearchWidget(
      this.user_me, this.user, this.list, this.analytics, this.chng);

  User user;
  User user_me;
  var list;
  var chng;
  var analytics;

  @override
  _UserSearchWidgetState createState() => _UserSearchWidgetState();
}

class _UserSearchWidgetState extends State<UserSearchWidget> {
  block_user() async {
    await Block.insert_block(widget.user_me.auth_id, widget.user.auth_id,
        widget.user_me, widget.user.id);
    await Block.insert_block(widget.user.auth_id, widget.user_me.auth_id,
        widget.user.id, widget.user_me.id);
  }

  Distance distance = new Distance();
  var currentLocation = <String, double>{};
  var location = new Location();
  var lat, lng;

  getLOcation() async {
    currentLocation = await Location_service.getLocation();

    if (currentLocation == null) {
      setState(() {
        widget.user.dis = "-.- Km";
      });
    } else {
      lat = currentLocation["latitude"];
      lng = currentLocation["longitude"];

      if (widget.user.lat == "")
        widget.user.dis = "-.- Km";
      else
        widget.user.dis = distance
                .as(
                    LengthUnit.Kilometer,
                    new LatLng(double.parse(widget.user.lat),
                        double.parse(widget.user.lng)),
                    new LatLng(lat, lng))
                .toString() +
            " Km(s)";
    }
  }

  go() async {
   // await getLOcation();

    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new Details_user(widget.user, widget.user_me, true, widget.list,
          widget.analytics, widget.chng);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      child: new Column(children: <Widget>[
        new Container(
          padding: new EdgeInsets.all(8.0),
          height: 80.0,
          width: MediaQuery.of(context).size.width,
          child: new Material(
              elevation: 4.0,
              borderRadius: new BorderRadius.circular(8.0),
              child: new Row(
                children: <Widget>[
                  Container(
                    width: 8,
                  ),
                  new ClipOval(
                      child: new Container(
                          // padding: EdgeInsets.all(8),
                          width: 50.0,
                          height: 50.0,
                          child: new Image.network(widget.user.image,
                              fit: BoxFit.cover))),
                  new Container(width: 12.0),
                  new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: new Text(
                                AppServices.capitalizeFirstofEach(widget
                                        .user.firstname.toLowerCase()) +
                                    " " +
                                    widget.user.fullname?.toUpperCase(),
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.0))),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: new Text(
                                widget.user.fonction.name +
                                    " à " +
                                    widget.user.organisme,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: new TextStyle(color: Colors.grey[800])))
                      ]),
                  new Expanded(child: new Container()),
                  widget.user.id == widget.user_me.id
                      ? Container()
                      : ConnectAcceptWidget(
                          widget.user, widget.user_me, widget.chng),
                  Container(
                    width: 8,
                  )
                ],
              )),
        ),
      ]),
      onTap: () {
        go();
        /* Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) {
              return new Invite_view(posts[index].auth_id, posts[index].notif_id,id,widget.user_me,go,delete_not);
            }));*/
      },
    );
  }
}
