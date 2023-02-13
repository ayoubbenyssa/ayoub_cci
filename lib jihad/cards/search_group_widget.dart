import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/home/connect_accept_widget.dart';
import 'package:mycgem/models/conversation_g.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/app_services.dart';
import 'package:mycgem/services/block.dart';
import 'package:mycgem/user/details_user.dart';
import 'package:http/http.dart' as clientHttp;
import 'package:intl/intl.dart';
class UserSearchWidgetGroup extends StatefulWidget {
  UserSearchWidgetGroup(
      this.user_me, this.user, this.list, this.analytics, this.chat,
      {this.funct_users});

  User user;
  User user_me;
  var list;
  var analytics;
  Conversationg chat;
  var funct_users;

  @override
  _UserSearchWidgetState createState() => _UserSearchWidgetState();
}

class _UserSearchWidgetState extends State<UserSearchWidgetGroup> {
  ParseServer parse_s = new ParseServer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //  print(widget.chat.members.firstWhere(widget.user));

    widget.user.mm = false;
    for (dynamic i in widget.chat.members) {

      if (i.id == widget.user.id) {
        widget.user.mm = true;
      }
    }

    /* ids = new Map<String, dynamic>.from(widget.chat.value["ids"]).keys.toList();
    ids_o = new Map<String, dynamic>.from(widget.chat.value["ids_o"]).keys.toList();

    if (ids.contains(widget.user.auth_id)) {
      widget.user.mm = true;
    } else {
      widget.user.mm = false;
    }*/
  }

  var ab = {};

  toggle() async {
    print(1);
    print(widget.user.mm);
    print(2);

    if (widget.user.mm) {
      var js = {
        "authors": {
          "__op": "Remove", //Remove, Add
          "objects": [
            {
              "__type": "Pointer",
              "className": "users",
              "objectId": widget.user.id
            }
          ]
        }
      };
      var a =
          await parse_s.putparse("conversation_g/" + widget.chat.objectId, js);
      setState(() {
        widget.user.mm = false;
      });
      widget.funct_users();
      //Delete
    } else {
      clientHttp.post(
          "https://us-central1-cgembusiness-5e7e3.cloudfunctions.net/sendCustomNotificationToGroupe",
          body: {"keys": widget.user.token, "message": widget.chat.title});

      /*
      
      sendCustomNotification(token,message){

    let headers = new Headers({ 'Content-Type': 'application/json' });
    let options = new RequestOptions({ headers: headers });
return this.http.post(
        "https://us-central1-cgembusiness-5e7e3.cloudfunctions.net/sendCustomNotificationToGroupe",
        {message : message,keys : token},
        options)
        .map((response) => {

            console.log(response.json());
            return response.json()
        })
        .toPromise();
}
       */

      print("+++");

      var js = {
        "authors": {
          "__op": "AddUnique", //Remove, Add
          "objects": [
            {
              "__type": "Pointer",
              "className": "users",
              "objectId": widget.user.id
            }
          ]
        }
      };
      var a =
          await parse_s.putparse("conversation_g/" + widget.chat.objectId, js);
      setState(() {
        widget.user.mm = true;
      });

      widget.funct_users();

      //Add
    }

    //  widget.funct_users(ids_o);
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
                          child: new Image.network(widget.user.image,
                              fit: BoxFit.cover))),
                  new Container(width: 12.0),
                  new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: new Text(
                                AppServices.capitalizeFirstofEach(  widget.user.firstname?.toLowerCase() )+
                                    " " +
                                    widget.user.fullname?.toUpperCase(),
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.0))),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: new Text(
                                widget.user.fonction.name +
                                    " à " +
                                    widget.user.organisme,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: new TextStyle(color: Colors.grey[800])))
                      ]),
                  new Expanded(child: new Container()),
                  IconButton(
                    icon: Image.asset(
                      widget.user.mm
                          ? "images/icons/min.png"
                          : "images/icons/plus.png",
                      color:
                          widget.user.mm ? Colors.red[700] : Colors.green[600],
                    ),
                    onPressed: () {
                      toggle();
                    },
                  ),
                  Container(
                    width: 8,
                  )
                ],
              )),
        ),
      ]),
      onTap: () {},
    );
  }
}
