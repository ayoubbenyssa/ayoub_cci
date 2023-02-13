import 'package:mycgem/models/option.dart';
import 'package:mycgem/models/user.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class ChatMessage {
  String lastmessage = "";
  DateTime timestamp;
  String nameUser = "";
  String idUser = "";
  String key = "";
  String text = "";
  User user_owner;
  String objectId = "";
  var doc_url;
  var doc_name;
  var type;
  var title;
  var options;
  var createdAt;

  // User user_to;
  String id_send;

  String audio = "";
  List image = [];
  String post_id;
  String post_title;
  String post_title1;

  String post_type;
  String post_desc;
  List post_pic;

  //String  post_id;

  var lat;
  var lng;

  ChatMessage(myid,
      {this.lastmessage,
      timestamp,
      this.doc_url,
      this.doc_name,
      this.post_id,
      this.post_desc,
      this.createdAt,
      this.type,
      this.title,
      this.options,
      this.post_pic,
      this.post_title,
      this.post_title1,
      this.post_type});

  ChatMessage.fromMap(Map<String, dynamic> map)
      : text = "${map['text']}",
        id_send = map["id_send"],
        doc_url = map["file"],
        doc_name = map["docname"],
        objectId = "${map['objectId']}",
        audio = "${map['audio']}",
        lat = map["lat"],
        lng = map["lng"],
        post_title1 = map['post_title1'],
        image = map['image'],
        post_title = map['post_title'],
        type = map['type'],
        title = map['title'],
        options = map["options"].toString() == "null"
            ? []
            : map["options"].map((val) => new Option.fromMap(val)).toList(),
        createdAt = map['createdAt'],
        post_desc = map['post_desc'],
        post_type = map['post_type'],
        post_id = map["post_id"],
        post_pic = map["post_pic"],
        user_owner = User.fromMap(map["author"]),
        timestamp = DateTime.parse("${map['createdAt']}");

  /*

    print((value as ParseObject).objectId);
        print((value as ParseObject).updatedAt);
        print((value as ParseObject).createdAt);
        print((value as ParseObject).get('objectId'));
        print((value as ParseObject).get('updatedAt'));
        print((value as ParseObject).get('createdAt'));
   */
  ChatMessage.fromParseObject(ParseObject map, User me, {other})
      : text = (map as ParseObject).get('text'),
        audio = (map as ParseObject).get('audio'),
        id_send = (map as ParseObject).get('id_send'),
        lat = (map as ParseObject).get('lat'),
        lng = (map as ParseObject).get('lng'),
        doc_url = (map as ParseObject).get('doc_name'),
        doc_name = (map as ParseObject).get('doc_url'),
        post_type = (map as ParseObject).get('post_type'),
        post_id = (map as ParseObject).get('post_id'),
        post_title = map['post_title'],
        post_title1 = map['post_title1'],
        post_desc = map['post_desc'],
        post_pic = map['post_pic'],

        /*        post_type = (map as ParseObject).get('post_type'),

  
     post_title = map['post_title'],
        post_desc = map['post_desc'],
        post_type = map['post_type'],
        post_id = map["post_id"],
        post_pic = map["post_pic"],
   */

        /*
    doc_name = map["doc_name"],
        objectId = "${map['objectId']}",
   */
        image = (map as ParseObject).get('image'),
        user_owner = (map as ParseObject).get('id_send') == me.id ? me : other,
        timestamp = DateTime.parse("${(map as ParseObject).get('createdAt')}");

  ChatMessage.fromParseObject1(ParseObject map, User me, {options})
      : text = (map as ParseObject).get('text'),
        objectId = (map as ParseObject).get('objectId'),
        audio = (map as ParseObject).get('audio'),
        id_send = (map as ParseObject).get('id_send'),
        type = (map as ParseObject).get('type'),
        lat = (map as ParseObject).get('lat'),
        lng = (map as ParseObject).get('lng'),
        post_type = (map as ParseObject).get('post_type'),
        post_id = (map as ParseObject).get('post_id'),
        post_title = map['post_title'],
        post_title1 = map['post_title1'],
        post_desc = map['post_desc'],
        post_pic = map['post_pic'],
        image = (map as ParseObject).get('image'),
        doc_url = (map as ParseObject).get('doc_name'),
        doc_name = (map as ParseObject).get('doc_url'),
        options = options.toString() == "null" ? [] : options,
        user_owner = me,
        timestamp = DateTime.parse("${(map as ParseObject).get('createdAt')}");
}
/*
ChatMessage.fromParseObject(ParseObject map, User me, User other)
      : text = (map as ParseObject).get('text'),
        audio = (map as ParseObject).get('audio'),
        lat = (map as ParseObject).get('lat'),
        lng = (map as ParseObject).get('lng'),
        image = (map as ParseObject).get('image'),
        user_me = (map as ParseObject).get('objectId') == me.id ? me : other,
        user_to = (map as ParseObject).get('objectId') != me.id ? me : other,
        timestamp = DateTime.parse("${(map as ParseObject).get('createdAt')}");

*/
