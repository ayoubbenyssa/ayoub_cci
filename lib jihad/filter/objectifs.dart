import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mycgem/filter/filter_by_objectifs.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/models/objectif.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/partners_list.dart';
import 'package:mycgem/widgets/app_appbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Objectifs_widget extends StatefulWidget {
  Objectifs_widget(this.user, this.lat, this.lng, this.list_partner,
      this.analytics, this.chng);

  User user;
  var lat, lng;
  List list_partner;
  var analytics;
  var chng;

  @override
  _AvailableTaimeState createState() => new _AvailableTaimeState();
}

class _AvailableTaimeState extends State<Objectifs_widget> {
  int postCount;
  bool loading = true;
  List<Objectif> obj = new List<Objectif>();
  String selected_obj = "";

  Future<List<Objectif>> getObjectifs() async {
    obj = await PartnersList.get_objectifs();

    /* for (int i = 0; i < 6; i++) {
      if (widget.user.objectif.contains(obj[i].name)) {
        obj[i].isselected = true;
      }
    }
    setState(() {
      postCount = obj.length;
      object_list = obj;
      loading = false;
    });*/
    setState(() {
      loading = false;
    });
    return obj;
  }

  ParseServer parse_s = new ParseServer();

  @override
  void initState() {
    getObjectifs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*  Widget btn_confirm = new Padding(
      padding: new EdgeInsets.symmetric(vertical: 0.0),
      child: new Material(
        borderRadius: new BorderRadius.circular(30.0),
        shadowColor: Colors.purple,
        elevation: 5.0,
        child: new MaterialButton(
          minWidth: 180.0,
          height: 30.0,
          onPressed: () {
            //  Navigator.pop(context,time_available);
          },
          color: Colors.purple,
          child:
              new Text('Confirmer', style: new TextStyle(color: Colors.white)),
        ),
      ),
    );*/

    row(title, List<Objectif> data, index) {
      return new Container(
          margin: new EdgeInsets.all(8.0),
          height: 45.0,
          child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new InkWell(
                  //highlightColor: Colors.red,
                  splashColor: Fonts.col_app,
                  onTap: () {
                    if (data[index].isselected == true) {
                      setState(() {
                        data[index].isselected = false;
                        selected_obj = "";
                        /* if (widget.user.list_obj.contains(data[index].name)) {
                          widget.user.list_obj.remove(data[index].name);
                          widget.user.objectif.remove(data[index].name);
                        }*/
                      });
                    } else
                      setState(() {
                        obj.forEach((element) {
                          setState(() {
                            element.isselected = false;
                          });
                        });
                        data[index].isselected = true;
                        selected_obj = data[index].name;
                        // objectif.add(data[index].name);
                      });
                  },
                  child: new Container(
                    margin: new EdgeInsets.only(left: 8.0, right: 16.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Container(
                          // height: 70.0,
                          //width: 70.0,
                          child: data[index].isselected
                              ? new Icon(
                                  Icons.check,
                                  color: Colors.white,
                                )
                              : new Container(
                                  width: 25.0,
                                  height: 25.0,
                                ),
                          decoration: new BoxDecoration(
                            color: data[index].isselected
                                ? Fonts.col_app
                                : Colors.transparent,
                            border: new Border.all(
                                width: 1.0,
                                color: data[index].isselected
                                    ? Fonts.col_app
                                    : Colors.grey),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(2.0)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                Container(
                  width: 12.0,
                ),
                new Text(title , style: TextStyle(
                    color: Fonts.col_ap_fonn,
                    fontWeight: FontWeight.w700,
                    height: 1.4,
                    fontSize: 15.5.sp)),
              ]));
    }

    return new WillPopScope(
        onWillPop: () {
          Navigator.pop(context);
        },
        child: new Scaffold(
            appBar:  MyCgemBarApp(
              "Centres d’intérêt",
              actionswidget:  Container(child: Ink(

                  decoration: const ShapeDecoration(
                    color: Fonts.col_app_fon,
                    shape: CircleBorder(),
                  ),
                  child: new IconButton(
                    padding: EdgeInsets.all(8),
                      icon: new Icon(
                        Icons.check,
                        size: 24,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        Navigator.push(context, new PageRouteBuilder(
                            pageBuilder: (BuildContext context,
                                Animation<double> _, Animation<double> __) {
                              return FilterByObjectifs(
                                  widget.user,
                                  widget.lat,
                                  widget.lng,
                                  [],
                                  null,
                                  widget.chng,
                                  selected_obj);
                            }));

                        /* if (tapped) {
                  }*/
                        // widget.user.list_obj = [];
                        // widget.user.objectif = [];

                        /*if (objectif != null) {
                        for (var i in objectif) {
                          widget.user.list_obj.add(i);
                          widget.user.objectif.add(i);
                        }
                      }

                      var js = {
                        "objectif": widget.user.list_obj,
                      };

                      await parse_s.putparse("users/" + widget.user.id, js);

                      Navigator.pop(context, widget.user);*/
                      })),padding: EdgeInsets.all(8),),
            ),


            body: loading
                ? new Center(
                    child: new RefreshProgressIndicator(),
                  )
                : new ListView(
                    children: obj.map((Objectif ob) {
                    return row(ob.name, obj, obj.indexOf(ob));
                  }).toList())));
  }
}
