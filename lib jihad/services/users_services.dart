import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/models/user.dart';

class UserServices {


  static ParseServer parse_s = new ParseServer();

  static get_users_list( List<String> list1) async {


    List<String> list = [];

    for (String item in list1) {
      list.add('"' + item + '"');
    }

    var wherecondition = '"id1":{"\$in":$list}';


    var url = 'users?where={$wherecondition,"raja":true,"active":1}&include=commissions&include=membre_user.federation&include=membre_user.region&order=familyname&include=fonction';


    print("-------sjsjsjsjsj");

    var getoffers = await parse_s.getparse(url);
    List res = getoffers["results"];


    return res.map((var contactRaw) => new User.fromMap(contactRaw)).toList();
  }


}
