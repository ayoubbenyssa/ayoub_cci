

import 'dart:convert';

import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/models/user.dart';

class SearchFunctions{

  ParseServer parse_s = new ParseServer();

/*
        "firstname": {"\$text":{"\$search":{"\$term":"jihad"}}}

 */


/*

        "firstname": {"\$text":{"\$search":{"\$term":"$text"}, "\$caseSensitive": true }} //{"\$text":{"\$search":{"\$term":"$text"}}}

 */
  search_text(String text,id) async {



    print("_________________________________________________________________________________________________");

    text = text.toLowerCase();
    var search = [
      {
        "email": {"\$regex": "$text"}
      },
      {
        "firstname": {"\$regex": "$text"} //{"\$text":{"\$search":{"\$term":"$text"}}}
      },
      {
        "familyname": {"\$regex": "$text"}
      },
      {
        "organisme": {"\$regex": "$text"}
      }
    ];
    var res = json.encode({
      "\$or": search,
      "active":1,
      "id":{"\$dontSelect":{"query":{"className":"block","where":{"userS":{"\$eq":"$id"}}},"key":"blockedS"}},
      "idblock":{"\$dontSelect":{"query":{"className":"block","where":{"blockedS":{"\$eq":"$id"}}},"key":"userS"}},
      "raja":true
    });
    String url =                                     //{"\$or":[{"userS":{"$eq":"$id"}},{"userS":{"$eq":"$id"}}]}
        'where=$res';

    print(url);
    //',"objectId":{"\$nin":$list2}'+',"objectId":{"\$nin":$list}

    var ress = await parse_s.getparse('users?$url&include=fonction');
    List sp = ress["results"];
    List<User> usrs =
    sp.map((var contactRaw) => new User.fromMap(contactRaw)).toList();

   return usrs;
  }




}

/*

    var search = [
      {
        "text": {"\$regex": "$text"}
      },
      {
        "name": {"\$regex": "$text"}
      }
    ];
    var res = JSON.encode({
      "\$or": search,
      "author": {"\$exists": true}
    });
    var url =
        'news?limit=20&skip=$skip&order=-publishedAt&include=author&count=1';
 */