import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:mycgem/home/connect_accept_widget.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/app_services.dart';
import 'package:mycgem/services/block.dart';
import 'package:mycgem/services/location_services.dart';
import 'package:mycgem/user/details_user.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserItemWidget extends StatefulWidget {
  UserItemWidget(
      this.user_me, this.user, this.list, this.analytics, this.chng, this.type);

  User user;
  User user_me;
  var list;
  var chng;
  var analytics;
  var type;
  double lat;
  double lng;

  @override
  _UserSearchWidgetState createState() => _UserSearchWidgetState();
}

class _UserSearchWidgetState extends State<UserItemWidget> {
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
      print(widget.user.dis);
      print(widget.user.lat);
      print(widget.user.lng);
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
  void initState() {
    // TODO: implement initState
    super.initState();

    print(widget.user.dis);
  }

  @override
  Widget build(BuildContext context) {
    return widget.user_me.id == widget.user.id
        ? Container()
        : new InkWell(
            child: new Column(children: <Widget>[
              new Container(
                padding: new EdgeInsets.all(4.0),
                width: MediaQuery.of(context).size.width,
                child: new Material(
                    elevation: 0.0,
                    borderRadius: new BorderRadius.circular(8.0),
                    child: new Row(
                      children: <Widget>[
                        Container(
                          width: 8,
                        ),
                        new Container(
                            decoration: new BoxDecoration(
                              color: widget.user.verify.toString() != "1"
                                  ? Colors.grey[300]
                                  : widget.user.entreprise?.situation == "Ajour"
                                      ? Fonts.col_app_green
                                      : Fonts.col_gr, // border color
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.all(4),
                            child: new ClipOval(
                                child: new Container(
                                    // padding: EdgeInsets.all(8),
                                    width: 50.0,
                                    height: 50.0,
                                    child: new Image.network(widget.user.image,
                                        fit: BoxFit.cover)))),
                        new Container(width: 12.0),
                        new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 10,
                              ),
                              new Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.66,
                                  child: new Text(
                                      AppServices.capitalizeFirstofEach(widget
                                              .user.firstname
                                              .toString()
                                              .toLowerCase()) +
                                          " " +
                                          widget.user.fullname
                                              .toString()
                                              .toUpperCase(),
                                      style: new TextStyle(
                                          color: Fonts.col_ap_fonn,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15.5.sp))),
                              Container(
                                height: 4,
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.66,
                                  child: new Text(
                                      AppServices.capitalizeFirstofEach(widget
                                          .user.fonction.name
                                          ?.toString()),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: new TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 14.5))),
                              Container(
                                height: 4,
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.66,
                                  child: new Text(widget.user.organisme,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: new TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 13.5))),
                              Container(
                                height: 4,
                              ),
                              widget.type != "new" && widget.type != "old"
                                  ? Container()
                                  : new Text(
                                      "Membre depuis: " +
                                          new DateFormat('yyyy-MM-dd').format(
                                              DateTime.parse(
                                                  widget.user.createdAt)),
                                      style: new TextStyle(
                                          color: Fonts.col_grey,
                                          //  fontWeight: FontWeight.bold,
                                          fontSize: 12.0),
                                    ),
                              widget.type == "proche"
                                  ? Text(widget.user.dis.toString(),
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey[500],
                                      ))
                                  : Container(),
                              Container(
                                height: 8,
                              ),
                            ]),
                        new Expanded(child: new Container()),
                        Container(
                          width: 10,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Colors.grey[400],
                        ),
                        Container(
                          width: 10,
                        ),
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
