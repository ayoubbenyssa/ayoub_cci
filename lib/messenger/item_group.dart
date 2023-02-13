import 'package:flutter/material.dart';
import 'package:mycgem/language_params/scope_model_wrapper.dart';
import 'package:mycgem/messenger/stream_messages.dart';
import 'package:mycgem/messenger/stream_messages_group.dart';
import 'package:mycgem/models/conversation.dart';
import 'package:mycgem/models/conversation_g.dart';
import 'package:mycgem/models/user.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:timeago/timeago.dart' as ta;

class GroupMessageItem extends StatefulWidget {
  GroupMessageItem(this.conversation, this.user, this.searchtext, this.chng);

  Conversationg conversation;
  User user;
  String searchtext = "";
  var chng;

  @override
  _MessageItemState createState() => _MessageItemState();
}

class _MessageItemState extends State<GroupMessageItem> {
  initData() async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject('conversation_g'))
          ..whereEqualTo('objectId', widget.conversation.objectId);
    LiveQuery liveQuery = LiveQuery();
    await liveQuery.subscribe(query);

    liveQuery.on(LiveQueryEvent.update, (value) {
      print("ihihihihihihihihihiihihihihhiihihii");
      if (this.mounted) {
        setState(() {
          widget.conversation.last_time =
              (value as ParseObject).get('last_time');
          widget.conversation.last_message =
              (value as ParseObject).get('lastmessage');
          widget.conversation.disactivate =
              (value as ParseObject).get('disactivate');

          print((value as ParseObject).get('disactivate'));
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return widget.conversation.disactivate == true
        ? Container()
        : (!widget.conversation.title
                    .toLowerCase()
                    .contains(widget.searchtext.toLowerCase()) &&
                widget.searchtext.isNotEmpty)
            ? new Container()
            : new Container(
                // color: (vumoi == true ? Colors.grey[50] : Colors.green[50]),
                child: new FlatButton(
                    // padding: new EdgeInsets.only(top: 8.0,left: 8.0,right: 8.0,bottom: 8.0),
                    onPressed: () {
                      Navigator.push(
                        context,
                        new PageRouteBuilder(
                          pageBuilder: (BuildContext context,
                              Animation<double> _, Animation<double> __) {
                            return new StreamMessagesGroup(
                                widget.user, widget.conversation, widget.chng);
                          },
                        ),
                      );
                    },
                    child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(height: 8.0),
                          new Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new ClipOval(
                                  child: new Container(
                                      width: 56.0,
                                      height: 56.0,
                                      child: new Image.network(
                                        widget.conversation.logo,
                                        fit: BoxFit.cover,
                                      ))),
                              new Container(width: 8.0),
                              new Container(
                                //padding: new EdgeInsets.all(4.0),
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.52,
                                      // padding: new EdgeInsets.only(bottom: 2.0),
                                      child: Text(
                                        widget.conversation.title,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    new Container(height: 2.0),
                                    Container(
                                        width: 140.0,
                                        child:
                                            new Text(widget.conversation.desc,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: new TextStyle(
                                                  color: Colors.grey[800],
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12.0,
                                                ))),
                                    new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          new Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.42,
                                              padding: new EdgeInsets.only(
                                                  top: 2.0), //error
                                              child: new Text(
                                                  widget
                                                      .conversation.last_message
                                                      .toString(),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: new TextStyle(
                                                    fontSize: 13.0,
                                                    fontStyle: FontStyle.italic,
                                                  ))),
                                          new Container(width: 8.0),
                                        ]),
                                  ],
                                ),
                              ),
                              new Expanded(child: new Container()),
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  new Row(children: <Widget>[
                                    new Container(width: 2.0),
                                    ScopedModelDescendant<AppModel1>(
                                        builder: (context, child, model) => new Text(
                                            ta.format(
                                                new DateTime.fromMillisecondsSinceEpoch(
                                                    widget.conversation.last_time),
                                                locale: model.locale == "ar"
                                                    ? "ar"
                                                    : "fr"),
                                        style: new TextStyle(
                                            color: Colors.grey,
                                            fontSize: 11.0))),
                                  ]),
                                  new Container(
                                    height: 16.0,
                                  ),
                                  // menusubscribe
                                ],
                              )
                            ],
                          ),
                          new Container(
                            height: 8.0,
                          ),
                          new Container(
                              height: 0.5,
                              width: 900.0,
                              color: Colors.grey[400])
                        ])));
  }
}
