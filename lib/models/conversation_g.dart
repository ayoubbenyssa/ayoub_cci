import 'package:mycgem/models/user.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class Conversationg {
  String objectId;
  List members;
  int last_time;
  String last_message;
  String logo;
  String title;
  List<dynamic> lst;
  var disactivate;
  var desc;
  var text="";
  var mm;
  var demandes;
  var membre;





  Conversationg(this.objectId, this.members, this.last_message, this.last_time,
      this.logo, this.lst);

  Conversationg.fromMap(Map<String, dynamic> map)
      : objectId = map["objectId"],
        last_time = map["last_time"],
        last_message = map["lastmessage"],
        title = map["title"],
        desc = map["description"],
        disactivate = map["disactivate"],
        logo = map["image"],
        lst = map["ids_admin"],
        demandes =  map["demandes"]
            .map((var contactRaw) => new User.fromMap(contactRaw))
            .toList(),
        members = map["authors"]
            .map((var contactRaw) => new User.fromMap(contactRaw))
            .toList();
}
