import 'package:flutter/material.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/language_params/scope_model_wrapper.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:timeago/timeago.dart' as ta;

class Distance_Online_Widget extends StatelessWidget {
  Distance_Online_Widget(this.user);

  User user;

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding:
          new EdgeInsets.only(bottom: 4.0, left: 16.0, right: 16.0, top: 4.0),
      alignment: Alignment.center,
      decoration: new BoxDecoration(
        color: Colors.white,
        /*border: new Border(
                            bottom: new BorderSide(
                                color: Colors.black12))*/
      ),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Icon(
                Icons.map,
                color: Fonts.col_app,
                size: 20.0,
              ),
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  user.active_loc == 0
                      ? LinkomTexts.of(context).inactive()
                      : user.dis,
                  style: TextStyle(fontSize: 12.0),
                ),
              )
            ],
          ),
          new Row(
            children: <Widget>[
              user.offline == "offline"
                  ? Container()
                  : user.last_active.toString() == "null"
                      ? Container()
                      : user.last_active.toString() == "0"
                          ? new CircleAvatar(
                              backgroundColor: Colors.blue, radius: 8.0)
                          : new Icon(
                              Icons.access_time,
                              color: Fonts.col_app,
                              size: 20.0,
                            ),

              /*


                                widget.user.last_active.toString() !=
                                                      "null" &&
                                                  widget.user.last_active.toString() !=
                                                      "" &&   widget.user.last_active.toString() !=
                                              "0"
                                              ? ta.format(new DateTime.fromMillisecondsSinceEpoch(
                                                          widget.user
                                                              .last_active)) ==
                                                      "il y a 49 ans"
                                                  ? ""
                                                  : ta.format(new DateTime
                                                          .fromMillisecondsSinceEpoch(
                                                      widget.user.last_active))
                                              : ""
                               */

              ScopedModelDescendant<AppModel1>(
                  builder: (context, child, model) => new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Text(
                            user.offline == "offline"
                                ? "Hors ligne"
                                : user.last_active.toString() == "null"
                                    ? ""
                                    : user.last_active.toString() == "0"
                                        ? "en ligne"
                                        : ta.format(
                                            new DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                user.last_active),
                                            locale: model.locale == "ar"
                                                ? "ar"
                                                : "fr"),
                            style: TextStyle(fontSize: 12.0)),
                      ))
            ],
          )
        ],
      ),
    );
  }
}
