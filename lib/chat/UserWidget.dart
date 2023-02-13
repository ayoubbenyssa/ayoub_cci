import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:mycgem/chat/message_data.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/block.dart';
import 'package:mycgem/services/location_services.dart';
import 'package:mycgem/user/details_user.dart';

class UserWidget extends StatelessWidget {
  UserWidget(this.user, this.user_o, this.user_m, this.reload, this.list,
      this.analytics, this.chng);

  Message user;
  User user_o;
  User user_m;
  var reload;
  var list;
  var analytics;
  var chng;

  Distance distance = new Distance();
  var currentLocation = <String, double>{};
  var location = new Location();
  var lat, lng;

  getLOcation() async {
    currentLocation = await Location_service.getLocation();

    lat = currentLocation["latitude"];
    lng = currentLocation["longitude"];

    user_o.dis = distance
            .as(
                LengthUnit.Kilometer,
                new LatLng(double.parse(user_o.lat), double.parse(user_o.lng)),
                new LatLng(lat, lng))
            .toString() +
        " Km(s)";
  }

  // RoutesFunctions routesFunctions = new RoutesFunctions();

  @override
  Widget build(BuildContext context) {
    block_user() async {
      await Block.insert_block(
          user_m.auth_id, user_o.auth_id, user_m, user_o.id);
      await Block.insert_block(
          user_o.auth_id, user_m.auth_id, user_o.id, user_m.id);
    }

    Widget avatar = new GestureDetector(
        onTap: () async {
          await getLOcation();

          Navigator.push(context,
              new MaterialPageRoute(builder: (BuildContext context) {
            return new Details_user(
                user_o, user_m, true, list, analytics, chng,
                reload: reload);
          }));

          /*routesFunctions.gotoparams2("profile", context,user,user.objectId)*/
        },
        child: new ClipOval(
            child: new Container(
                width: 40.0,
                height: 40.0,
                child: new Image.network(user.avatar, fit: BoxFit.cover))));

    Widget header =
        new Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      avatar,
      new Container(width: 8.0),
      new GestureDetector(
          onTap: () =>
              null /* routesFunctions.gotoparams2("profile", context, user, user.objectId)*/,
          child: new Text(
            user.name,
            style: new TextStyle(color: Colors.grey[700], fontSize: 16.0),
          ))
    ]);

    return header;
  }
}
