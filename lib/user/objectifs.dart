import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/models/objectif.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/partners_list.dart';

class Objectifs_widget extends StatefulWidget {
  Objectifs_widget(this.user);

  User user;

  var id;

  @override
  _AvailableTaimeState createState() => new _AvailableTaimeState();
}

class _AvailableTaimeState extends State<Objectifs_widget> {
  int postCount;
  bool loading = true;
  List<String> objectif = new List<String>();
  List<Objectif> obj = new List<Objectif>();



  ParseServer parse_s = new ParseServer();

  Future<List<Objectif>> getObjectifs() async {
    obj = await PartnersList.get_objectifs();

    for (int i = 0; i < obj.length; i++) {
      if (widget.user.objectif.contains(obj[i].name)) {
        obj[i].isselected = true;
      }
    }
    setState(() {
      postCount = obj.length;
      // object_list = obj;
      loading = false;
    });

    return List<Objectif>.from(obj).reversed.toList();
  }


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
                    /*  setState(() {
                     // data.forEach((element) => element.isselected = false);
                      data[index].isselected = true;
                      objectif.add(data[index].name);

                    });*/

                    if (data[index].isselected == true) {
                      setState(() {
                        data[index].isselected = false;
                        objectif.remove(data[index].name);
                        if (widget.user.list_obj.contains(data[index].name)) {
                          widget.user.list_obj.remove(data[index].name);
                          widget.user.objectif.remove(data[index].name);
                        }
                      });
                    } else
                      setState(() {
                        data[index].isselected = true;
                        objectif.add(data[index].name);
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
                Container(width:8.0,),
               /// Image.network(data[index].img,width: 25.0,height: 25.0,),
                Container(width:12.0,),
                new Text(title),
              ]));
    }

    return new WillPopScope(
        onWillPop: () {
          Navigator.pop(context, widget.user);
        },
        child: new Scaffold(

            appBar: AppBar(
              backgroundColor: Color.fromRGBO(247, 247, 247, 100),
              elevation: 0.0,
              iconTheme: IconThemeData(color: Color(0xff272C6E)),
              actions: <Widget>[
                new IconButton(
                    icon: new Icon(Icons.check),
                    onPressed: () async {
                      /* if (tapped) {
                  }*/
                      // widget.user.list_obj = [];
                      // widget.user.objectif = [];

                      if (objectif != null) {
                        for (var i in objectif) {
                          widget.user.list_obj.add(i);
                          widget.user.objectif.add(i);
                        }
                      }

                      var js = {
                        "objectif": widget.user.list_obj,
                      };

                      await parse_s.putparse("users/" + widget.user.id, js);

                      Navigator.pop(context, widget.user);
                    })
              ],
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Centres d’intérêts", style: TextStyle(color: Color(0xff272C6E),fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "louis george cafe"),),
                  Container(
                    margin: EdgeInsets.only(right: 10,),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(9)),

                    ),
                    child: Center(
                      child: Image.asset("images/logo.png"),
                    ),
                  ),
                ],
              ),
            ),

            body: loading
                ? new Center(
              child: new RefreshProgressIndicator(),
            )
                : new ListView(
                children: List<Objectif>.from(obj).map((Objectif ob) {
                  return row(
                      ob.name, obj, List<Objectif>.from(obj).indexOf(ob));
                }).toList())));
  }
}
