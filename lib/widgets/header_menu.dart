import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/app_services.dart';
import 'package:mycgem/user/myprofile.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:intl/intl.dart';

class HeaderMenuDrawer extends StatefulWidget {
  HeaderMenuDrawer(this.user, this.chng, this.lat, this.lng, {Key key})
      : super(key: key);
  User user;
  var chng;
  var lat;
  var lng;

  @override
  _HeaderMenuState createState() => new _HeaderMenuState();
}

class _HeaderMenuState extends State<HeaderMenuDrawer> {
  // RoutesFunctions routesFunctions = new RoutesFunctions();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);

    Widget avatar(image) => GestureDetector(
        onTap: () {
          print("ddd");

          Navigator.push(context, new PageRouteBuilder(pageBuilder:
              (BuildContext context, Animation<double> _,
                  Animation<double> __) {
            return Scaffold(
                appBar: AppBar(
                  title: Text(
                    AppServices.capitalizeFirstofEach(
                            widget.user.firstname?.toLowerCase()) +
                        " " +
                        widget.user.fullname?.toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                body: new MyProfile(widget.user, false, true, widget.lat,
                    widget.lng, [], null, widget.chng));
          }));
        },
        child: new Container(
            width: ScreenUtil().setWidth(55),
            height: ScreenUtil().setWidth(55),
            child: new Center(
                child: new ClipOval(
                    child: image == null
                        ? new Image.asset("assets/images/logo.png",
                        width: ScreenUtil().setWidth(55),
                        height: ScreenUtil().setWidth(55), fit: BoxFit.cover)
                        : new Image.network(image,
                        width: ScreenUtil().setWidth(55),
                        height: ScreenUtil().setWidth(55), fit: BoxFit.cover)))));

    Widget head() =>
        /* new StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('users')
            .document(widget.user.id)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData)
            return new Container(
                alignment: FractionalOffset.center,
                child: new CircularProgressIndicator());

          widget.user = new User.fromDoc(snapshot.data);
*/
        new Container(
            // padding: new EdgeInsets.only(left: 16.0),
            child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              // new Container(height: 8.0),
              widget.user == null ? new Container() : avatar(widget.user.image),
              new Container(height: 8.0),
              new Text(
                  AppServices.capitalizeFirstofEach(
                          widget.user.firstname?.toLowerCase()) +
                      " " +
                      widget.user.fullname.toUpperCase(),
                  style: new TextStyle(
                      fontSize: ScreenUtil().setSp(14),

                      // color: Fonts.color_app_fonc,
                      fontWeight: FontWeight.w700)),
              new Container(height: 8.0),
              new Text(widget.user.email.toString(),
                  style:
                      new TextStyle(fontSize: ScreenUtil().setSp(14)
                          // color: Fonts.color_app_fonc,
                          ))
            ]));

    return new GestureDetector(
        onTap: () =>
            null /* Routes.goto(context,"profile", id: widget.user.id),*/,
        // Routes.gotoparams2("profile", context, widget.user,widget.user.id),
        child: new Container(

            //decoration: Widgets.back,
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              Container(
                height: 16,
              ),
              head(),
              new Container(
                height: 16.0,
              ),
            ])));
  }
}
