import 'package:flutter/material.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/parc_events_stream/parc_events_stream.dart';
import 'package:mycgem/search/search_user_widget.dart';
import 'package:mycgem/services/search_service.dart';
import 'package:mycgem/widgets/app_appbar.dart';

class UserListsResults extends StatefulWidget {
  UserListsResults(this.text, this.user_me, this.list, this.analytics, this.lat,
      this.lng, this.bl, this.chat, this.chng,
      {this.func_users});

  String text = "";
  User user_me;
  var list;
  var analytics;
  var lat;
  var lng;
  var bl;
  var chat;
  var func_users;
  var chng;

  @override
  _UserListsResultsState createState() => _UserListsResultsState();
}

class _UserListsResultsState extends State<UserListsResults> {
  List<User> users = new List<User>();
  SearchFunctions func = new SearchFunctions();
  bool loading = true;
  int count = 0;

  @override
  void initState() {
    super.initState();
  }

  int count1 = 0;

  setSount1(c) {
    setState(() {
      count1 = c;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyCgemBarApp(
          widget.text,
          actionswidget: Container(),
        ),
        body: new StreamParcPub(
          new Container(),
          widget.lat,
          widget.lng,
          widget.user_me,
          "0",
          widget.list,
          widget.analytics,
          setSount1,
          widget.chng,
          favorite: false,
          chat: widget.chat,
          boutique: false,
          revue: false,
          video: false,
          bl_search: widget.bl,
          funct_users: widget.func_users,
          search: widget.text,
        ) /*loading == true
            ? Center(
            child: new SpinKitFadingCube(
              color: Colors.blue,
            ))
            :count ==0?new Center(child: new Text("Aucun resultat trouvé")): new ListView(
                children: users.map((User user) {
                  return UserSearchWidget(widget.user_me,user,widget.list, widget.analytics);
                }).toList(),
              )*/
        );
  }
}
