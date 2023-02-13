import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/models/membre.dart';
import 'package:mycgem/models/shop.dart';

class EmailverifyServices {
  static ParseServer parse_s = new ParseServer();

  static get_contact_by_email(String email) async {
    String url = "";

    url =
        'users?where= {"rl":true,"\$or":[{"emails":"$email"},{"membre_user":{"\$inQuery":{"where":{"email":"$email"},"className":"membres"}}}]}&include=membre_user';

    var getcity = await parse_s.getparse(url);


    print("hdhdhdhdhdh");
    print(getcity);

    if (getcity == "No Internet") return "No Internet";
    if (getcity == "error") return "error";
    List res = getcity["results"];
    return res;
  }

  static get_members_by_email(String email) async {
    String url = "";


    print("!!!!!!!!!!!!!!!!!!!!!!!");
    print(email);
    print("!!!!!!!!!!!!!!!!!!!!!!!");


    url =

        ///{"emails":"$email"},{"membre_user":{"\$inQuery":{"where":{"emails":"$email"},"className":"membres"}}}
        'membres?where={"email":"$email"}';

    var getcity = await parse_s.getparse(url);
    if (getcity == "No Internet") return "No Internet";
    if (getcity == "error") return "error";
    List res = getcity["results"];
    return res.map((e) => Membre.fromMap(e)).toList();
  }
}
