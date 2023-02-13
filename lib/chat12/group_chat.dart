import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mycgem/models/conversation.dart';
import 'package:mycgem/models/conversation_g.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/search/list_users_results.dart';
import 'package:mycgem/search/search_user_widget.dart';
import 'package:mycgem/services/Fonts.dart';

class ChatGroupUsers extends StatefulWidget {
  ChatGroupUsers(this.list_users, this.user_me, this.partners, this.analytics,
       this.conv,this.func, this.chng);

  List<dynamic> list_users;
  User user_me;
  var partners;
  var analytics;
  Conversationg conv;
  var func;
  var chng;



  @override
  _ChatGroupUsersState createState() => _ChatGroupUsersState();
}

class _ChatGroupUsersState extends State<ChatGroupUsers> {
  final _textController = new TextEditingController();

  bool load = true;

  chng(a) async {
    setState(() {
      load = false;
    });
    new Timer(const Duration(milliseconds: 300), () {
      try {
        setState(() => load = true);
      } catch (e) {
        e.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return load == false
        ? Container()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Fonts.col_app_shadow,
              iconTheme: IconThemeData(color: Fonts.col_app_fonn),
              title: Text(
                "Les membres de groupe",
                style: TextStyle(color: Fonts.col_app_fonn),
              ),
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(
                      widget.conv.lst.contains(widget.user_me.id)
                          ?  MediaQuery.of(context).size.height * 0.08:MediaQuery.of(context).size.height * 0.01),
                  child: widget.conv.lst.contains(widget.user_me.id)
                      ? Card(
                          color: Fonts.col_app_shadow,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: new TextFormField(
                                  autofocus: true,
                                  controller: _textController,
                                  decoration: new InputDecoration(
                                      hintText: 'Ajouter un membre au groupe'),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: 8,
                                ),
                              ),
                              RaisedButton(
                                color: Fonts.col_app,
                                onPressed: () {
                                  Navigator.push(context, new MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return new UserListsResults(
                                        _textController.text,
                                        widget.user_me,
                                        [],
                                        null,
                                        null,
                                        null,
                                        "true",
                                        widget.conv,
                                        widget.chng,
                                        func_users: widget.func);
                                  }));
                                },
                                child: Text(
                                  "Rechercher".toUpperCase(),
                                  style: TextStyle(),
                                ),
                              )
                            ],
                          ),
                        )
                      : Container()),
            ),
            body: ListView(
              children: widget.list_users
                  .map((dynamic user) => UserSearchWidget(
                      widget.user_me, user, widget.partners, widget.analytics, widget.chng))
                  .toList(),
            ),
          );
  }
}
