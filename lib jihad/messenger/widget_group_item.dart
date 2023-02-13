import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/home/connect_accept_widget.dart';
import 'package:mycgem/models/conversation_g.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/block.dart';
import 'package:mycgem/user/details_user.dart';

class UserGroupItelm extends StatefulWidget {
  UserGroupItelm(this.user_me, this.group, this.list, this.analytics);

  Conversationg group;
  User user_me;
  var list;
  var analytics;

  @override
  _UserSearchWidgetState createState() => _UserSearchWidgetState();
}

class _UserSearchWidgetState extends State<UserGroupItelm> {
  Distance distance = new Distance();
  var currentLocation = <String, double>{};
  var location = new Location();
  var lat, lng;
  ParseServer parse_s = new ParseServer();

  /*

   var js = {
        "authors":{
          "__op":"AddUnique", //Remove, Add
          "objects":[{
            "__type":"Pointer",
            "className":"users",
            "objectId": widget.user.id
          }]
        }
      };
      var a = await parse_s.putparse("conversation_g/"+widget.chat.objectId, js);
      setState(() {
        widget.user.mm = true;
      });
   */

  submit() async {

    if (widget.group.mm) {
      var js = {
        "demandes": {
          "__op": "Remove", //Remove, Add
          "objects": [
            {
              "__type": "Pointer",
              "className": "users",
              "objectId": widget.user_me.id
            }
          ]
        }
      };

      await parse_s.putparse("conversation_g/" + widget.group.objectId, js);

      if (!this.mounted) return;

      print("aaaaaaaaaa");
      setState(() {
        widget.group.mm = false;
      });

      print(widget.user_me.mm);
      //Delete
    } else {
      print("+++");

      var js = {
        "demandes": {
          "__op": "AddUnique", //Remove, Add
          "objects": [
            {
              "__type": "Pointer",
              "className": "users",
              "objectId": widget.user_me.id
            }
          ]
        }
      };
      var a =
          await parse_s.putparse("conversation_g/" + widget.group.objectId, js);
      setState(() {
        widget.group.mm = true;
      });
      //Add
    }

    //  widget.funct_users(ids_o);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.group.mm = false;

    for (dynamic i in widget.group.members) {
      print(i.id);
      print(widget.user_me.id);
      if (i.id == widget.user_me.id) {
        widget.group.membre = "membre";
      }
    }

    for (dynamic i in widget.group.demandes) {
      print(i.id);
      print(widget.user_me.id);
      if (i.id == widget.user_me.id) {
        widget.group.mm = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      child: new Column(children: <Widget>[
        new Container(
          padding: new EdgeInsets.all(8.0),
          height: 80.0,
          width: MediaQuery.of(context).size.width,
          child: new Material(
              elevation: 4.0,
              borderRadius: new BorderRadius.circular(8.0),
              child: new Row(
                children: <Widget>[
                  Container(
                    width: 8,
                  ),
                  new ClipOval(
                      child: new Container(
                          // padding: EdgeInsets.all(8),
                          width: 50.0,
                          height: 50.0,
                          child: new Image.network(widget.group.logo,
                              fit: BoxFit.cover))),
                  new Container(width: 12.0),
                  new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: new Text(widget.group.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: new TextStyle(color: Colors.grey[800]))),
                        new Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: new Text(widget.group.desc,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.0))),
                      ]),
                  new Expanded(child: new Container()),
                  RaisedButton(
                    onPressed: () {
                      widget.group.membre == "membre" ? null : submit();
                    },
                    color: widget.group.membre == "membre"
                        ? Colors.grey
                        : widget.group.mm == false
                            ? Fonts.col_app
                            : Colors.grey,
                    child: Text(
                      widget.group.membre == "membre"
                          ? "Membre"
                          : widget.group.mm
                              ? "Annuler"
                              : "Rejoindre",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    width: 8,
                  )
                ],
              )),
        ),
      ]),
      onTap: () async {
        /* Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) {
              return new Invite_view(posts[index].auth_id, posts[index].notif_id,id,widget.user_me,go,delete_not);
            }));*/
      },
    );
  }
}
