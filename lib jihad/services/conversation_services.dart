



import 'dart:convert';

import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/models/conversation.dart';
import 'package:mycgem/models/conversation_g.dart';

class ConversationServices{

  static ParseServer parse_s = new ParseServer();


  static get_list_conv(id) async {
    var qq = [
      {"owner":{"\$inQuery":{"where":{"objectId":"$id"},"className":"users"}}},
      {"other":{"\$inQuery":{"where":{"objectId":"$id"},"className":"users"}}}
    ];

    var ur = jsonEncode({
      "\$or": qq

    });

    String url = 'conversation?where=$ur&include=owner&include=other&order=-last_time';
    var getcity = await parse_s.getparse(url);
    if (getcity == "No Internet") return "No Internet";
    if (getcity == "error") return "error";
    List res =  getcity["results"];
    print('llmdlmf,dlmfdlmkfdlmkfdlmdklmfjkfjkld');
    print(res);

    return res.map((var contactRaw) => new Conversation.fromMap(contactRaw))
        .toList();
  }



  static get_conv(my_id, his_id) async {


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
        'conversation?count=1&where=$url';

    var getoffers = await parse_s.getparse(ur);
    List res = getoffers["results"];
    if(res.length == 0)
      return null;
    else
    return new Conversation.fromMap(res[0])
    ;
  }


  static get_list_conv_group(id) async {

//&where={"authors":{"\$inQuery":{"where":{"objectId":"$id"},"className":"_User"}}}

//where={"authors":{"\$inQuery":{"where":{"objectId":"$id"},"className":"_User"}}}&
    String url = 'conversation_g?include=authors&order=-last_time&where={"disactivate":false,"authors":{"__type":"Pointer","className":"users","objectId":"$id"}}';
    var getcity = await parse_s.getparse(url);
    if (getcity == "No Internet") return "No Internet";
    if (getcity == "error") return "error";
    List res =  getcity["results"];
    print(res);

    return res.map((var contactRaw) => new Conversationg.fromMap(contactRaw))
        .toList();
  }


  static get_list_conv_group1(id,type) async {

//&where={"authors":{"\$inQuery":{"where":{"objectId":"$id"},"className":"_User"}}}

//where={"authors":{"\$inQuery":{"where":{"objectId":"$id"},"className":"_User"}}}&
    String url = 'conversation_g?include=authors&order=-last_time&where={"type_group":"$type","disactivate":false,"authors":{"__type":"Pointer","className":"users","objectId":"$id"}}';
    var getcity = await parse_s.getparse(url);
    if (getcity == "No Internet") return "No Internet";
    if (getcity == "error") return "error";
    List res =  getcity["results"];
    print(res);

    return res.map((var contactRaw) => new Conversationg.fromMap(contactRaw))
        .toList();
  }

}