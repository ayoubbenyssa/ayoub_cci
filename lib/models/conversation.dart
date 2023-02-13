

import 'package:mycgem/models/user.dart';


class Conversation {

  String objectId;
  User owner ;
  User other ;
  int last_time;
  String last_message;

  Conversation(this.objectId, this.owner,this.other,this.last_message,this.last_time);

  Conversation.fromMap(Map<String, dynamic> map)
      : objectId = map["objectId"],
        owner = new User.fromMap(map["owner"]),
        last_time = map["last_time"],
        last_message = map["lastmessage"],
        other = new User.fromMap(map["other"]);

}
