import 'dart:convert';

import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/models/chatmessage.dart';

class MessagesServices {
  static ParseServer parseFunctions = new ParseServer();

  static getListMessages(my_id, his_id, skip) async {


    String a = my_id+'_'+his_id;
    String b  = his_id+'_'+my_id;

    print(a);
    print(b);

    var qq = [
      {"key": "$a"},
      {"key": "$b"}
    ];

    var url = jsonEncode({
      "\$or": qq

    });

    var ur =
        'Message?limit=60&skip=$skip&count=1&where=$url&include=author,to&order=-createdAt';

    var getoffers = await parseFunctions.getparse(ur);
    List res = getoffers["results"];

    print("jdopjdopjdopjpo");
    print(res);
    return {
      "results":
          res.map((var contactRaw) => new ChatMessage.fromMap(contactRaw)).toList(),
      "count": getoffers["count"]
    };
  }


  static getListMessagesGroupes(title,skip) async {
    var ur =
        'Group?limit=60&skip=$skip&count=1&where={"title":"$title"}&include=author,to,post,options&order=-createdAt';

    var getoffers = await parseFunctions.getparse(ur);
    List res = getoffers["results"];
    print("yesssssssss");
    return {
      "results":
      res.map((var contactRaw) => new ChatMessage.fromMap(contactRaw)).toList(),
      "count": getoffers["count"]
    };
  }
}
