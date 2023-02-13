import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/messenger/item_group.dart';
import 'package:mycgem/models/conversation_g.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/conversation_services.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class Group_conversation extends StatefulWidget {
  Group_conversation(this.user, this.text_group, this.searchText, this.chng);

  User user;

  String text_group;
  var chng;


  String searchText = "";

  @override
  _Group_conversationState createState() => _Group_conversationState();
}

class _Group_conversationState extends State<Group_conversation> {
  List<Conversationg> conv = new List<Conversationg>();

  bool loading = true;

  initData() async {
    String id = widget.user.id;
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject('conversation_g'));
    LiveQuery liveQuery = LiveQuery();
    await liveQuery.subscribe(query);

    liveQuery.on(LiveQueryEvent.update, (value) {
      print("ssssss");

      if (this.mounted) {
        setState(() {
          print((value as ParseObject).get('authors'));

          get_conv_group();

          /* if((value as ParseObject).get('authors').isNotEmpty)
            {


              for(var i in (value as ParseObject).get('authors')) {
                print(i);
                print(i.objectId);
               Conversationg item = conv.firstWhere((r) => r.objectId ==  (value as ParseObject).get('objectId'));
              }
            }*/

          //var tt = (value as ParseObject).get('authors');
          // print(tt.objectId);
          //print(tt[0]["objectId"]);

          //  print(tt[0]);

          // print(jsonDecode(tt)[0]);
        });
      }
    });
  }

  /*

  method: put
url: http://localhost:1337/parse/classes/GameScore/ZKHiH6ysBK
header: X-Parse-Application-Id:myAppId
        Content-Type:application/json

date : {"authors":{
           "__op":"AddUnique", //Remove, Add
            "objects":[{
                   "__type":"Pointer",
                   "className":"Author",
                   "objectId":"6ikM9JT7s7"
                       },
                       {
                    "__type":"Pointer",
                    "className":"Author",
                    "objectId":"iE6rOKDcGl"
                        }]
}
}
   */

  ParseServer parse_s = new ParseServer();

  get_conv_group() async {
/*    parse_s.postparse("conversation_g", {

       'title':"Général",
      "lastmessage": "Aucun message",
    "authors":{
    "__op":"AddUnique", //Remove, Add
    "objects":[{
    "__type":"Pointer",
    "className":"_User",
    "objectId":"FvQm3qzVwK"
    },
    {
    "__type":"Pointer",
      "className":"_User",
    "objectId":"G561X25ahC"
    }]
    },

      "last_time": new DateTime.now().millisecondsSinceEpoch/*new DateTime.now().toString()*/,
    });*/

    List<Conversationg> a;

    if (widget.text_group == "0")
      a = await ConversationServices.get_list_conv_group(widget.user.id);
    else if (widget.text_group == "2")
      a = await ConversationServices.get_list_conv_group1(
          widget.user.id, "regional");
    else
      a = await ConversationServices.get_list_conv_group1(
          widget.user.id, "national");

    if (!this.mounted) return;

    setState(() {
      conv = a;
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_conv_group();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Widgets.load()
        : conv.isEmpty
            ? Center(
                child: Text(LinkomTexts.of(context).aucun_g()+ "!"),
              )
            : Center(
                child: ListView(
                padding: EdgeInsets.all(0.0),
                children: List.generate(conv.length, (index) {
                  return GroupMessageItem(conv[index], widget.user,widget.searchText, widget.chng);
                }),
              ));
  }
}
