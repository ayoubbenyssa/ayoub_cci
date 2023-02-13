import 'package:flutter/material.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/connect.dart';
import 'package:mycgem/services/search_service.dart';
import 'package:mycgem/user/user_accept_widget.dart';
import 'package:mycgem/widgets/widgets.dart';

class UserListsRequests extends StatefulWidget {
  UserListsRequests(this.my_id, this.user_me, this.auth, this.sign,
      this.list_partners, this.load, this.analytics, this.chng);

  String my_id;
  User user_me;
  String text = "";
  var auth;
  var sign;
  var list_partners;
  var load;
  var analytics;
  var chng;

  @override
  _UserListsResultsState createState() => _UserListsResultsState();
}

class _UserListsResultsState extends State<UserListsRequests> {
  List users = new List();
  SearchFunctions func = new SearchFunctions();
  bool loading = true;
  int count = 0;

  @override
  void initState() {
    super.initState();

    Connect.get_list_connect_all(widget.my_id).then((val) {
      setState(() {
        loading = false;
        users = val["res"];
        count = users.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text(widget.text),
        ),
        body: loading == true
            ? Widgets.load()
            : count == 0
                ? new Center(child: new Text(LinkomTexts.of(context).aucun()))
                : new ListView(
                    children: users.map((var user) {
                      User us = new User.fromMap(user.author);

                      return UserAcceptWidget(
                          us,
                          widget.user_me,
                          widget.auth,
                          widget.sign,
                          widget.list_partners,
                          widget.load,
                          widget.analytics,
                          widget.chng);
                    }).toList(),
                  ));
  }
}
