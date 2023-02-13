import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/parc_events_stream/parc_events_stream.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:flutter/services.dart';
import 'package:mycgem/widgets/app_appbar.dart';

class UsersStream extends StatefulWidget {
  UsersStream(this.user, this.lat, this.lng, this.list_partner, this.analytics,
      this.chng);

  User user;
  var lat, lng;
  List list_partner;
  var analytics;
  var chng;

  @override
  _UsersStreamState createState() => _UsersStreamState();
}

class _UsersStreamState extends State<UsersStream> {
  int count1 = 0;
  ParseServer parse_s = new ParseServer();
  Position _currentPosition;
  String text_location = "";
  bool service_gps = false;

  bool show_button = false;

  setSount1(c) {
    setState(() {
      count1 = c;
    });
  }

  var dialogOpen;
  bool show = false;

  // this also checks for location permission.
  Future<void> _initCurrentLocation() async {
    Position currentPosition;
    try {
      /* currentPosition = await Geolocator()
    .getCurrentPosition();*/

      Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low)
          .then((Position position) {
        currentPosition = position;

        setState(() => currentPosition = position);
        setState(() {
          widget.lat = currentPosition.latitude;
          widget.lng = currentPosition.longitude;
          print(widget.lat);
          print(widget.lng);

          show_button = false;
        });

        var js = {
          "location": {
            "__type": "GeoPoint",
            "latitude": currentPosition.latitude,
            "longitude": currentPosition.longitude
          },
          "lat": currentPosition.latitude,
          "lng": currentPosition.longitude,
        };

        parse_s.putparse("users/" + widget.user.id, js);
        /*int timestamp = new DateTime.now().millisecondsSinceEpoch;
        parse_s.putparse("users/" + widget.user.id,
            {"disponible": true, "dispo_date": "$timestamp"});*/
        setState(() {
          show = false;
        });
        //  d("position = $currentPosition");
      });
    } on PlatformException catch (e) {
      print("ojoouoipip");
      print(e.message);
      currentPosition = null;
    }

    if (!mounted) return;

    setState(() => _currentPosition = currentPosition);
  }

  Future _checkGeolocationPermission() async {
    bool service = await Geolocator().isLocationServiceEnabled();
    print("-----------------------------------------------------");
    print(service);

    if (service == false) {
      setState(() {
        service_gps = false;

        text_location =
            "Pour identifier des membres prés de vous, veuillez autoriser l’accès à votre GPS";
      });


    } else {
      setState(() {
        service_gps = true;
      });

      var geolocationStatus =
          await Geolocator().checkGeolocationPermissionStatus();

      print("-kdkkdkd");
      print(geolocationStatus);
      if (geolocationStatus == GeolocationStatus.denied  ||geolocationStatus ==  GeolocationStatus.unknown) {
        setState(() {
          show_button = true;
        });

      } else if (geolocationStatus == GeolocationStatus.disabled) {
        await PermissionHandler().requestPermissions([
          PermissionGroup.locationAlways,
          PermissionGroup.locationWhenInUse
        ]);
      } else if (geolocationStatus == GeolocationStatus.granted) {
        _initCurrentLocation();
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _checkGeolocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyCgemBarApp("Près de vous", actionswidget: Container()),
        body: service_gps == false
            ?  Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.all(12),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Autorisez l'accès aux services de localisation pour cette application à l'aide des paramètres de l'appareil.",
                    style: TextStyle(
                        color: Fonts.col_app_fon,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ],
              ))
            : show_button == true
                ?   Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.all(12),
            child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Container(


                            child: Text(
                          "Acceptez les permissions de localisation pour "
                          "cette application.",
                          style: TextStyle(
                              color: Fonts.col_app_fon,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        )),
                        Container(
                          height: 16,
                        ),
                        RaisedButton(
                          color:  Fonts.col_app_fon,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.all(
                                Radius.circular(8.0),
                              )),
                          splashColor: Colors.grey,
                          elevation: 2,
                          child: Text(
                            "CONFIRMER",
                            style: TextStyle(
                                fontSize: 16, color:Colors.white),
                          ),
                          onPressed: () async{
                            await PermissionHandler().requestPermissions([
                              PermissionGroup.locationAlways,
                              PermissionGroup.locationWhenInUse
                            ]);
                            Geolocator().isLocationServiceEnabled();
                           _initCurrentLocation();
                          },
                        )
                      ]))
                : Container(
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
                      filter: "proche",
                      revue: false,
                      favorite: false,
                      boutique: false,
                    )));
  }
}
