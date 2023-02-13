import 'package:flutter/material.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/parc_events_stream/parc_events_stream.dart';
import 'package:mycgem/search/search_user_widget.dart';
import 'package:mycgem/services/search_service.dart';

class SearchNewEvent extends StatefulWidget {
  SearchNewEvent(this.text,this.user_me,this.list,this.lat,this.lng,this.type, this.chng);

  String text = "";
  User user_me;
  var list;
  var lat;
  var lng;
  var chng;
  String type;

  @override
  _UserListsResultsState createState() => _UserListsResultsState();
}

class _UserListsResultsState extends State<SearchNewEvent> {
  List<User> users = new List<User>();
  SearchFunctions func = new SearchFunctions();
  bool loading = true;
  int count = 0;
  int count1 = 0;

  setSount1(c) {
    setState(() {
      count1 = c;
    });
  }
  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text(widget.text+' ('+count1.toString() +')'),
        ),
        body:  new StreamParcPub(
          new Container(),
          widget.lat,
          widget.lng,
          widget.user_me,
          "0",
          widget.list,
          null,
          setSount1,
          widget.chng,
          favorite: false,
          boutique: false,
          revue: false,
          search_posts: widget.text,
          search_type: widget.type,
        )/*loading == true
            ? Center(
            child: new SpinKitFadingCube(
              color: Colors.blue,
            ))
            :count ==0?new Center(child: new Text("Aucun resultat trouvé")): new ListView(
                children: users.map((User user) {
                  return UserSearchWidget(widget.user_me,user,widget.list, widget.analytics);
                }).toList(),
              )*/);
  }
}
