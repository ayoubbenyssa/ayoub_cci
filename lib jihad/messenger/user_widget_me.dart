import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:mycgem/cards/sonagecard.dart';
import 'package:mycgem/chat/list_images.dart';
import 'package:mycgem/language_params/scope_model_wrapper.dart';
import 'package:mycgem/messenger/post_widget.dart';
import 'package:mycgem/messenger/sondage_card.dart';
import 'package:mycgem/models/chatmessage.dart';
import 'package:mycgem/models/offers.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/audioapp.dart';
import 'package:mycgem/user/edit_my_profile.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class UserWidgetMessage extends StatefulWidget {
  UserWidgetMessage(this.msg, this.myid, this.chng);

  /*

     (widget.snapshot.value['file']
                                                      .toString() !=
                                                  "null" &&
                                              widget.snapshot.value['file']
                                                      .toString() !=
                                                  "")
                                          ? InkWell(
                                              child: Container(
                                                color: Colors.grey[50],
                                                padding: EdgeInsets.all(4.0),
                                                child: Row(
                                                  children: <Widget>[
                                                    Image.asset(
                                                      "images/document.png",
                                                      width: 30.0,
                                                      height: 30.0,
                                                      color: Fonts.col_app_fonn,
                                                    ),
                                                    Container(
                                                      width: 8,
                                                    ),
                                                    Container(
                                                      width: 224.0,
                                                      child: Text(
                                                          widget.snapshot
                                                              .value['docname']
                                                              .toString()
                                                              .toString(),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: new TextStyle(
                                                            color: Colors
                                                                .blue[600],
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 12.0,
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              onTap: () {

                                                if (Platform.isIOS)
                                                  Navigator.push(context,
                                                      new MaterialPageRoute<String>(
                                                          builder: (BuildContext context) {
                                                            return new WebviewScaffold(
                                                              url: widget
                                                                  .snapshot.value['file'],
                                                              appBar: new AppBar(
                                                                title: new Text(""),
                                                              ),
                                                            );
                                                          }));
                                                else
                                                launch(widget
                                                    .snapshot.value['file']
                                                    .toString());



                                              },
                                            )
                                          : Container(),
   */
//, this.animation
  ChatMessage msg;
  String myid;

  var chng;

  //String otherid;

  // Animation animation;

  @override
  _UserWidgetMessageState createState() => _UserWidgetMessageState();
}

class _UserWidgetMessageState extends State<UserWidgetMessage> {
  Future _launch(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  gotomap(lat, lng) {
    _launch('https://www.google.com/maps/@$lat,$lng,16z');
  }

  @override
  Widget build(BuildContext context) {
    avatar() {
      return new ClipOval(
          child: new Container(
            width: 40.0,
            height: 40.0,
            child: new Image.network(
              widget.msg.user_owner.image,
              fit: BoxFit.fill,
            ),
          ));
    }

    return new GestureDetector(
        onLongPress: () {
          try {} catch (e) {}
          //   displaybottomsheet(widget.snapshot.value);
        },
        child:
        /*new SizeTransition(
            sizeFactor: new CurvedAnimation(
              parent: widget.animation,
              curve: Curves.elasticOut,
            ),
            axisAlignment: 0.0,
            child:*/
        new Column(children: <Widget>[
          new Container(
              padding: new EdgeInsets.only(left: 8.0, right: 8.0),
              child: new Row(
                  mainAxisAlignment: (widget.msg.id_send != widget.myid
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.end),
                  children: <Widget>[
                    widget.msg.id_send != widget.myid
                        ? new Container(
                      //  padding: new EdgeInsets.only(bottom: 16.0),
                        child: avatar())
                        : new Container(),
                    widget.msg.id_send != widget.myid
                        ? new Image.asset(
                      "images/left.png",
                      color: Colors.grey[200],
                      width: 15.0,
                      height: 20.0,
                    )
                        : new Container(),
                    new Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          //new Container(height: 16.0,),

                          new Container(
                              decoration: new BoxDecoration(
                                gradient: new LinearGradient(
                                    colors: [
                                      // const Color(0xFF3366FF),
                                      widget.msg.post_type.toString() != "null"
                                          ? Colors.grey[200]
                                          : widget.msg.id_send == widget.myid
                                          ? Colors.blue[400]
                                          : Colors.grey[300],
                                      widget.msg.post_type.toString() != "null"
                                          ? Colors.grey[200]
                                          : widget.msg.id_send == widget.myid
                                          ? Colors.blue[500]
                                          : Colors.grey[50],
                                    ],
                                    begin: const FractionalOffset(0.0, 0.0),
                                    end: const FractionalOffset(0.0, 1.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.mirror),
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.blue[50],
                                    offset: new Offset(0.0, 0.0),
                                    blurRadius: 4.0,
                                  ),
                                ],
                                border: new Border.all(
                                    color: widget.msg.id_send != widget.myid
                                        ? Colors.transparent
                                        : Colors.transparent,
                                    width: 1.0),
                                borderRadius: new BorderRadius.only(
                                    topRight:
                                    /*widget.snapshot.value["idUser"] == widget.msg2.idUser?  const Radius.circular(8.0)
                                  :*/
                                    const Radius.circular(12.0),
                                    bottomRight: const Radius.circular(12.0),
                                    bottomLeft: const Radius.circular(12.0),
                                    topLeft: const Radius.circular(12.0)),
                                color: widget.msg.id_send != widget.myid
                                    ? Colors.blue[400]
                                    : Colors.grey[50],
                              ),
                              margin: new EdgeInsets.only(
                                top: 24.0,
                              ),
                              padding: new EdgeInsets.only(
                                  bottom:
                                  widget.msg.post_type.toString() != "null"
                                      ? 0.0
                                      : 12.0,
                                  left:
                                  widget.msg.post_type.toString() != "null"
                                      ? 0.0
                                      : 8.0,
                                  right: 8.0,
                                  top: 0.0),
                              child: new Column(
                                crossAxisAlignment:
                                (widget.msg.id_send != widget.myid
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.end),
                                children: <Widget>[
                                  (widget.msg.audio.toString() != "null" &&
                                      widget.msg.audio.toString() != "")
                                      ? AudioApp(widget.msg.audio)
                                      : Container(),
                                  (widget.msg.lat.toString() != "null" &&
                                      widget.msg.lat != "")
                                      ? new InkWell(
                                    child: Row(
                                      children: <Widget>[
                                        new Image.asset(
                                          "images/location.png",
                                          width: 18.0,
                                          height: 18.0,
                                          color: Colors.blue[700],
                                        ),
                                        Container(
                                          width: 2.0,
                                        ),
                                        Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.56,
                                            padding:
                                            EdgeInsets.only(top: 4.0),
                                            child: Text("Ma position: " +
                                                widget.msg.lat
                                                    .toString() +
                                                ";" +
                                                widget.msg.lng
                                                    .toString()))
                                      ],
                                    ),
                                    onTap: () {
                                      gotomap(
                                          widget.msg.lat, widget.msg.lng);
                                    },
                                  )
                                      : Container(),
                                  widget.msg.post_title.toString() != "null" &&
                                      widget.msg.post_title != ""
                                      ? PostWidget(
                                      Offers(
                                          createdAt: widget.msg.createdAt,
                                          author1: widget.msg.user_owner,
                                          author: widget.msg.user_owner,
                                          title: widget.msg.post_title,
                                          description: widget.msg.post_desc,
                                          createdDate: widget.msg.createdAt,
                                          pic: widget.msg.post_pic,
                                          type: widget.msg.post_type),
                                      widget.msg.user_owner,
                                      widget.chng)
                                      : Container(),
                                  widget.msg.type.toString() == "sondage"
                                      ? SondageCardGroup(
                                      widget.msg.user_owner,
                                      Offers(
                                          objectId: widget.msg.objectId,
                                          author1: widget.msg.user_owner,
                                          title: widget.msg.post_title1,
                                          create: widget.msg.createdAt,
                                          pic: widget.msg.post_pic,
                                          type: widget.msg.post_type,
                                          options: widget.msg.options),
                                      [],
                                      widget.chng)
                                      : Container(),
                                  /*
                                  SondageCard(widget.user, item, list, widget.chng)
                                   */


                                  (
                                      widget.msg.doc_name == null &&
                                      widget.msg.image.toString() !=
                                          "null" &&
                                      widget.msg.image.toString() != "[]")
                                      ? Container(
                                    height: 140,
                                    width: MediaQuery.of(context)
                                        .size
                                        .width *
                                        widget.msg.image.length *
                                        0.24 >
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .width *
                                            0.7
                                        ? MediaQuery.of(context)
                                        .size
                                        .width *
                                        0.6
                                        : MediaQuery.of(context)
                                        .size
                                        .width *
                                        widget.msg.image.length *
                                        0.24,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: widget.msg.image
                                          .map<Widget>((var st) =>
                                          InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder:
                                                          (context) =>
                                                          FullScreenWrapper(
                                                            imageProvider:
                                                            NetworkImage(st.toString()),
                                                          ),
                                                    ));
                                              },
                                              child: new Container(
                                                  padding:
                                                  new EdgeInsets
                                                      .all(2.0),
                                                  width: 90,
                                                  height: 120,
                                                  child: new Material(
                                                      borderRadius:
                                                      new BorderRadius
                                                          .circular(
                                                          22.0),
                                                      shadowColor:
                                                      Colors
                                                          .white,
                                                      elevation: 3.0,
                                                      child: Image
                                                          .network(
                                                        st,
                                                        width: 90,
                                                        height: 120,
                                                        fit: BoxFit
                                                            .cover,
                                                      )))))
                                          .toList(),
                                    ),
                                  )
                                      : Container(),
                                  (widget.msg.doc_url.toString() != "null" &&
                                      widget.msg.doc_url.toString() != "")
                                      ? InkWell(
                                    child: Container(
                                      color: Colors.grey[50],
                                      padding: EdgeInsets.all(4.0),
                                      child: Row(
                                        children: <Widget>[
                                          Image.asset(
                                            "images/document.png",
                                            width: 30.0,
                                            height: 30.0,
                                            color: Fonts.col_app_fonn,
                                          ),
                                          Container(
                                            width: 8,
                                          ),
                                          Container(
                                            width: 224.0,
                                            child: Text(
                                                widget.msg.doc_name
                                                    .toString(),
                                                maxLines: 2,
                                                overflow:
                                                TextOverflow.ellipsis,
                                                style: new TextStyle(
                                                  color: Colors.blue[600],
                                                  fontWeight:
                                                  FontWeight.w500,
                                                  fontSize: 12.0,
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      if (Platform.isIOS)
                                        Navigator.push(context,
                                            new MaterialPageRoute<String>(
                                                builder: (BuildContext
                                                context) {
                                                  return new WebviewScaffold(
                                                    url: widget.msg.doc_url,
                                                    appBar: new AppBar(
                                                      title: new Text(""),
                                                    ),
                                                  );
                                                }));
                                      else
                                        launch(widget.msg.doc_url);
                                    },
                                  )
                                      : Container(),
                                  (widget.msg.text == "" &&
                                      widget.msg.image.toString() !=
                                          "null" &&
                                      widget.msg.image.toString() != "" &&
                                      widget.msg.image.length > 2)
                                      ? RaisedButton(
                                    color: Colors.grey[200],
                                    child: Text(
                                      "Voir tous",
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (BuildContext
                                              context) =>
                                              new ImageList(
                                                  widget.msg.image)));
                                    },
                                  )
                                      : Container(),
                                  widget.msg.text == ""
                                      ? Container()
                                      : widget.msg.text.toString() == "null"
                                      ? Container()
                                      : new Container(
                                      margin: const EdgeInsets.only(
                                          top: 5.0),
                                      child: new Container(
                                          width: 160.0,
                                          child: new Text(
                                            widget.msg.text
                                                .toString() ==
                                                "null"
                                                ? ""
                                                : widget.msg.text
                                                .toString(),
                                            overflow:
                                            TextOverflow.ellipsis,
                                            maxLines: 140,
                                            style: new TextStyle(
                                              // fontWeight: FontWeight.w600,
                                              fontSize: 15.0,
                                              color: (widget.msg
                                                  .id_send !=
                                                  widget.myid
                                                  ? Colors.black
                                                  : Colors.grey[50]),
                                            ),
                                          ))),
                                ],
                              )),
                          new Container(height: 4.0),

                          /*
                           ScopedModelDescendant<AppModel1>(
    builder: (context, child, model) => new Text(
                                  timeago.format(
                                      new DateTime.fromMillisecondsSinceEpoch(
                                          widget.snapshot.value['timestamp']),locale: model.locale == "ar"
                                      ? "ar"
                                      : "fr"),
                           */
                          ScopedModelDescendant<AppModel1>(
                              builder: (context, child, model) => new Text(
                                  timeago.format(widget.msg.timestamp,
                                      locale:
                                      model.locale == "ar" ? "ar" : "fr"),
                                  style: (widget.msg.id_send != widget.myid
                                      ? new TextStyle(
                                      fontSize: 10.0,
                                      color: Colors.grey[600])
                                      : new TextStyle(
                                      fontSize: 10.0,
                                      color: Colors.grey[600])))),
                        ]),
                    widget.msg.id_send == widget.myid
                        ? new Image.asset(
                      "images/right.png",
                      color: widget.msg.post_type.toString() != "null"
                          ? Colors.grey[200]
                          : Fonts.col_app,
                      width: 16.0,
                      height: 20.0,
                    )
                        : new Container(),
                  ])),
        ]));
  }
}
