import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycgem/chat/audio.dart';
import 'package:mycgem/chat/list_images.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/chat.dart';
import 'package:mycgem/models/user.dart';

import 'package:meta/meta.dart';
import 'package:mycgem/user/myprofile.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:mycgem/services/Fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'message_data.dart';



/*

 posts.firstWhere((r) => r.id == m.id);
 */

class ChatMessage1 extends StatefulWidget {
  final Chat snapshot;
  final Animation animation;
  final List<User> list_users;
  final User user_me;


  ChatMessage1(
      {@required this.snapshot,
      this.animation,this.list_users,this.user_me});

  @override
  _ChatMessageState createState() => new _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage1> {
  //RoutesFunctions routesFunctions = new RoutesFunctions();
  //PostFunctions postFunctions = new PostFunctions();

  bool iscolor = false;
 // User us ;

  @override
  initState() {
    super.initState();


    print(widget.snapshot.idUser );
    print(widget.list_users);



    setState(() {
  //   us =  widget.list_users.firstWhere((val)=>widget.snapshot.idUser == val.auth_id);
    });
  }



  Widget photoUrl() {
    Widget avatar;

      avatar = new ClipOval(
          child: new Container(
        width: 40.0,
        height: 40.0,
        child: new Image.network(
          widget.list_users.firstWhere((val)=>widget.snapshot.idUser == val.auth_id).image,
          fit: BoxFit.cover,
        ),
      ));
    return avatar;
  }

  Future _launch(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }




  gotomap(lat,lng) {

    _launch('https://www.google.com/maps/@$lat,$lng,16z');
  }


  /*avatar() {
    return widget.snapshot.idUser == null
        ? SizedBox(
            width: 60.0,
            height: 60.0,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: CircleAvatar(
                backgroundColor: Colors.grey[100],
                radius: 25.0,
              ),
            ))
        : new ClipOval(
            child: new Container(
            width: 40.0,
            height: 40.0,
            child: new Image.network(
             widget,
              fit: BoxFit.fill,
            ),
          ));
  }*/

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        onLongPress: () {
          try {
            setState(() {
              iscolor = true;
            });
          } catch (e) {}

        },
        child: new SizeTransition(
            sizeFactor: new CurvedAnimation(
              parent: widget.animation,
              curve: Curves.elasticOut,
            ),
            axisAlignment: 0.0,
            child: new Column(children: <Widget>[
              new Container(
                  padding: new EdgeInsets.only(left: 8.0, right: 8.0),
                  // color: iscolor == false ? Colors.transparent : Colors.white,
                  //margin: new EdgeInsets.symmetric(vertical: 3.0),
                  child: new Row(
                      /* crossAxisAlignment:
                          (widget.snapshot.value["idUser"] == widget.msg2.idUser
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.end),*/
                      mainAxisAlignment:
                          (widget.snapshot.idUser != widget.user_me.auth_id
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.end),
                      children: <Widget>[
                        widget.snapshot.idUser != widget.user_me.auth_id
                            ? new Container(
                              //  padding: new EdgeInsets.only(bottom: 16.0),
                                child: photoUrl())
                            : new Container(),
                        widget.snapshot.idUser != widget.user_me.auth_id
                            ? new Image.asset(
                                "images/left.png",
                                color: Fonts.col_app,
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
                                    border: new Border.all(
                                        color:
                                        widget.user_me.auth_id == widget.list_users.firstWhere((val)=>widget.snapshot.idUser == val.auth_id).auth_id
                                                ? Colors.transparent
                                                : Colors.transparent,
                                        width: 1.0),
                                    borderRadius: new BorderRadius.only(
                                        topRight:
                                            /*widget.snapshot.value["idUser"] == widget.msg2.idUser?  const Radius.circular(8.0)
                                  :*/
                                            const Radius.circular(6.0),
                                        bottomRight: const Radius.circular(6.0),
                                        bottomLeft: const Radius.circular(6.0),
                                        topLeft:
                                            /*widget.snapshot.value["idUser"] != widget.msg2.idUser?  const Radius.circular(8.0)
                                     :*/
                                            const Radius.circular(6.0)),

                                    /* boxShadow: [
                                new BoxShadow(
                                  color: Colors.grey[400],
                                  offset: new Offset(0.0, 0.0),
                                  blurRadius: 4.0,
                                ),
                              ],*/
                                    color: widget.user_me.auth_id != widget.list_users.firstWhere((val)=>widget.snapshot.idUser == val.auth_id).auth_id
                                        ? Fonts.col_app
                                        : Colors.grey[50],
                                  ),
                                  margin: const EdgeInsets.only(
                                    top: 24.0,
                                  ),
                                  padding: const EdgeInsets.only(
                                      bottom: 12.0,
                                      left: 8.0,
                                      right: 8.0,
                                      top: 0.0),
                                  child: new Column(
                                    crossAxisAlignment:
                                        ( widget.user_me.auth_id  == widget.list_users.firstWhere((val)=>widget.snapshot.idUser == val.auth_id).auth_id
                                            ? CrossAxisAlignment.end
                                            : CrossAxisAlignment.end),
                                    children: <Widget>[

                                      (
                                          widget.snapshot.audio
                                              .toString() !=
                                              "null" &&
                                          widget.snapshot.audio
                                              .toString() !=
                                              "")?AudioApp( widget.snapshot.audio):Container(),

                                      (widget.snapshot.lat
                                                      .toString() !=
                                                  "null" &&
                                          widget.snapshot.lat
                                              .toString() !=
                                              "0.0"
                                              )
                                          ? new InkWell(
                                              child: Row(
                                                children: <Widget>[
                                                  new Image.asset(
                                                    "images/location.png",
                                                    width: 18.0,
                                                    height: 18.0,
                                                    color: Fonts.col_app_fon,
                                                  ),
                                                  Container(width: 2.0,),
                                                 Container(
                                                   width: MediaQuery.of(context).size.width*0.56,
                                                   padding: EdgeInsets.only(top: 4.0),
                                                   child: Text("Ma position: "+widget.snapshot.lat
                                                      .toString()+";"+widget.snapshot.lng
                                                      .toString()))
                                                ],
                                              ),onTap: (){
                                        gotomap(widget.snapshot.lat,widget.snapshot.lng);

                                      },)
                                          : Container(),
                                      (widget.snapshot.messageText ==
                                                  "" &&
                                              widget.snapshot.imageUrl
                                                      .toString() !=
                                                  "null" &&
                                              widget.snapshot.imageUrl
                                                      .toString() !=
                                                  "")
                                          ? Container(
                                              height: 140,
                                              width: MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          widget
                                                              .snapshot
                                                              .imageUrl
                                                              .length *
                                                          0.24 >
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width*0.7
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.6
                                                  : MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      widget
                                                          .snapshot
                                                          .imageUrl
                                                          .length *
                                                      0.24,
                                              child: ListView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                children: widget
                                                    .snapshot.imageUrl
                                                    .map<Widget>((var st) => InkWell(
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
                                                            padding: new EdgeInsets.all(2.0),
                                                            width: 90,
                                                            height: 120,
                                                            child: new Material(
                                                                borderRadius: new BorderRadius.circular(22.0),
                                                                shadowColor: Colors.white,
                                                                elevation: 3.0,
                                                                child: Image.network(
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
                                      (widget.snapshot.messageText ==
                                                  "" &&
                                              widget.snapshot.imageUrl
                                                      .toString() !=
                                                  "null" &&
                                              widget.snapshot.imageUrl
                                                      .toString() !=
                                                  "" &&
                                              widget.snapshot.imageUrl
                                                      .length >
                                                  2)
                                          ? RaisedButton(
                                              color: Colors.grey[200],
                                              child: Text(
                                                LinkomTexts.of(context).tous(),
                                                style: TextStyle(
                                                  color: Colors.green,
                                                ),
                                              ),
                                              onPressed: () {

                                                Navigator.push(
                                                    context,
                                                    new MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            new ImageList(widget
                                                                    .snapshot
                                                                    .imageUrl)));


                                              },
                                            )
                                          : Container(),
                                      widget.snapshot.messageText == ""
                                          ? Container()
                                          : new Container(
                                              margin: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: new Container(
                                                  width: 160.0,
                                                  child: new Text(
                                                    widget.snapshot
                                                        .messageText
                                                        .toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 140,
                                                    style: new TextStyle(
                                                      // fontWeight: FontWeight.w600,
                                                      fontSize: 15.0,
                                                      color: ( widget.user_me.auth_id  == widget.list_users.firstWhere((val)=>widget.snapshot.idUser == val.auth_id).auth_id
                                                          ? Colors.black
                                                          : Colors.grey[50]),
                                                    ),
                                                  ))),
                                    ],
                                  )),
                              new Container(height: 4.0),

                              new Text(
                                  timeago.format(
                                      new DateTime.fromMillisecondsSinceEpoch(
                                          widget.snapshot.timestamp)),
                                  style: ( widget.user_me.auth_id  == widget.list_users.firstWhere((val)=>widget.snapshot.idUser == val.auth_id).auth_id
                                      ? new TextStyle(
                                          fontSize: 10.0,
                                          color: Colors.grey[600])
                                      : new TextStyle(
                                          fontSize: 10.0,
                                          color: Colors.grey[600]))),
                            ]),
                        widget.user_me.auth_id  == widget.list_users.firstWhere((val)=>widget.snapshot.idUser == val.auth_id).auth_id
                            ? new Image.asset(
                                "images/right.png",
                                width: 16.0,
                                height: 20.0,
                              )
                            : new Container(),
                        widget.user_me.auth_id  == widget.list_users.firstWhere((val)=>widget.snapshot.idUser == val.auth_id).auth_id
                            ? new Container(
                                padding: new EdgeInsets.only(bottom: 16.0),
                                child: photoUrl())
                            : new Container(),
                      ])),
            ])));
  }

  displaybottomsheet(val) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return new Container(
              height: 60.0,
              child: new Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      val['messageText'] != null
                          ? new FlatButton(
                              onPressed: () {
                                Clipboard.setData(new ClipboardData(
                                    text: val['messageText']));
                                Navigator.of(context).pop(true);
                                try {
                                  setState(() {
                                    iscolor = false;
                                  });
                                } catch (e) {}
                                Scaffold.of(context).showSnackBar(new SnackBar(
                                  content: new Text("Live Clicked"),
                                ));
                              },
                              child: new Row(children: <Widget>[
                                new Icon(
                                  Icons.content_copy,
                                  color: Fonts.col_app,
                                ),
                                new Text("Copier",
                                    style: new TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Fonts.col_app))
                              ]))
                          : new Container(),
                      new FlatButton(
                          onPressed: () {
                            //ShareText
                            Navigator.of(context, rootNavigator: true)
                                .pop('dialog');
                            //deleteMessage();
                          },
                          child: new Row(children: <Widget>[
                            new Icon(
                              Icons.delete_outline,
                              color: Fonts.col_app,
                            ),
                            new Text("Supprimer",
                                style: new TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Fonts.col_app))
                          ])),
                    ],
                  )));
        });
  }
}
