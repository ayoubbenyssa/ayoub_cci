import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/models/user.dart';

class Usernfo {
  ParseServer parse_s = new ParseServer();

   getuserdata(iduser) async {
    var response =
        await parse_s.getparse('users?where={"objectId":"$iduser"}&include=commissions&include=membre_user.federation&include=membre_user.region&include=fonction');
   /* if (response != "error" && response != "nointernet") {
    }*/
   User user = new User.fromMap(response["results"][0]);
   return user;
    ;
  }

  get_politiques() async {
    var response =
    await parse_s.getparse('politique/');
    print(response);
    return response["results"][0];

  }

  get_conditions() async {
    var response =
    await parse_s.getparse('condition/');
    return response["results"][0];
    ;
  }

}
