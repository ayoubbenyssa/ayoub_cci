import 'dart:convert';

import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/models/offers.dart';
import 'package:mycgem/models/user.dart';

class PostsServices {
  static ParseServer parseFunctions = new ParseServer();

  static get_sondage(User user, skip, verify) async {
    var url = '"active":1,"type":"sondage"';
    var ur =
        'offers?limit=5&skip=$skip&count=1&where={$url}&include=author&order=-createdAt&include=options&include=options.users';
    var getoffers = await parseFunctions.getparse(ur);
    List res = getoffers["results"];

    if (verify != "1") {
      return {"results": [], "count": 0};
    } else
      return {
        "results": res
            .map((var contactRaw) => new Offers.fromMap(contactRaw))
            .toList(),
        "count": getoffers["count"]
      };
  }

  static get_sondage_by_id(objectId, User user, skip) async {
    var url = '"active":1,"objectId":"' + objectId + '"';
    var ur =
        'offers?limit=5&skip=$skip&count=1&where={$url}&include=author&order=-createdAt&include=options&include=options.users';
    var getoffers = await parseFunctions.getparse(ur);
    List res = getoffers["results"];

    return {
      "results":
          res.map((var contactRaw) => new Offers.fromMap(contactRaw)).toList(),
      "count": getoffers["count"]
    };
  }

  static get_sondage_by_id1(objectId, User user, skip) async {
    var url = '"active":1,"objectId":"' + objectId + '"';
    var ur =
        'Group?limit=5&skip=$skip&count=1&where={$url}&include=author&order=-createdAt&include=options&include=options.users';
    var getoffers = await parseFunctions.getparse(ur);
    List res = getoffers["results"];

    return {
      "results":
          res.map((var contactRaw) => new Offers.fromMap(contactRaw)).toList(),
      "count": getoffers["count"]
    };
  }

  static get_pub_type_commissions(
      skip, type, User user, verify, String fed_id) async {
    var url;

    print(type);
    if (type == "federations") {
      url = json.encode({"federation_id": "${fed_id}", "active": 1});
    }
    if (type == "commissions") {
      url = json.encode({"commissions": "${fed_id}", "active": 1});
    } else if (type == "maregion") {
      var qq = [
        {"region_id": "${fed_id}"},
        {"regions": "${fed_id}"}
      ];

      url = jsonEncode({"\$or": qq});

      print(url);
    }

    var ur =
        'offers?limit=20&skip=$skip&where=$url&include=author&order=-createdAt&include=partner&include=membre&count=1';

    print(ur);

    var getoffers = await parseFunctions.getparse(ur);
    List res = getoffers["results"];

    if (getoffers == "nointernet") return "nointernet";
    if (getoffers == "error") return "error";
    if (getoffers["count"] == 0) return "empty";
    if (getoffers["results"].length > 0) {
      return {
        "results": res
            .map((var contactRaw) => new Offers.fromMap(contactRaw))
            .toList(),
        "count": 0
      };
    } else
      return "nomore";
  }

  static get_pub_type(skip, type, User user, verify, {selected}) async {
    var url;

    if (type == "parlement") {
      url = json.encode({"parlement": true, "active": 1});
    } else if (type == "federations") {
      url = json.encode({
        "federation_id": "${user.entreprise.federation.objectId}",
        "active": 1
      });
    } else if (type == "cgem" || type == "linkommunity") {
      url = json.encode({
        "type_promo": "$type"

        // "startDate": {"\$lte": DateTime.now().millisecondsSinceEpoch},
        //"endDate": {"\$gte": DateTime.now().millisecondsSinceEpoch}
        //,
        // "partner":{"\$inQuery":{"where":{"sponsored": 1,"status":"1"},"className":"partners"}}
      });
    } else if (type == "opportunite") {
      url = jsonEncode({
        "type": "$type",
       // "activateDate": {"\$gte": DateTime.now().millisecondsSinceEpoch},
        "active": 1
      });
    } else {
      url = jsonEncode({"type": "$type", "active": 1});
    }

    var ur =
        'offers?limit=20&skip=$skip&where=$url&include=author&order=-createdAt&include=partner&include=membre&count=1';

    var getoffers = await parseFunctions.getparse(ur);
    List res = getoffers["results"];

    if (getoffers == "nointernet") return "nointernet";
    if (getoffers == "error") return "error";
    if (getoffers["count"] == 0) return "empty";
    if (getoffers["results"].length > 0) {
      return {
        "results": res
            .map((var contactRaw) => new Offers.fromMap(contactRaw))
            .toList(),
        "count": 0
      };
    } else
      return "nomore";
  }

  static get_recent_friend_pub(my_id, skip, verify) async {
    var qu = [
      //{"type": "Mission_raja"},
      // {"type": "Hébergement_raja"},
      // {"type": "Annonces"},
      // {"type": "Annonces_raja"},
      {"type": "Général_raja"}
    ];

    var qq = [
      {"objectId": "$my_id"}
    ];

    var url = jsonEncode({"\$or": qu, "active": 1});
    var ur =
        'offers?limit=10&skip=$skip&count=1&where=$url&include=author&order=-boostn&order=-createdAt';

    var getoffers = await parseFunctions.getparse(ur);
    List res = getoffers["results"];
    if (verify != "1") {
      return {"results": [], "count": 0};
    } else
      return {
        "results": res
            .map((var contactRaw) => new Offers.fromMap(contactRaw))
            .toList(),
        "count": getoffers["count"]
      };
  }

  static get_recent_others_pub(my_id, skip) async {
    var qu = [
      //  {"type": "Mission_raja"},
      // {"type": "Hébergement_raja"},
      // {"type": "Annonces"},
      //{"type": "Annonces_raja"},

      // {"type": "Objets perdus_raja"},
      // {"type": "Général_raja"}
    ];

    var url = jsonEncode({
      "\$or": qu,
      "author": {
        "\$inQuery": {
          "where": {
            "objectId": {
              "\$dontSelect": {
                "query": {
                  "className": "connect",
                  "where": {
                    "send_requ": {"\$eq": "$my_id"},
                    "accepted": true
                  }
                },
                "key": "receive_req"
              }
            }
          },
          "className": "users"
        }
      },
      "active": 1
    });
    var ur =
        'offers?limit=10&skip=$skip&count=1&where=$url&include=author&order=-boostn&order=-createdAt';

    var getoffers = await parseFunctions.getparse(ur);
    List res = getoffers["results"];
    return {
      "results":
          res.map((var contactRaw) => new Offers.fromMap(contactRaw)).toList(),
      "count": getoffers["count"]
    };
  }

  static get_events(User user, skip, verify) async {
    var kkey = user.communitykey;
    int number = DateTime.now().millisecondsSinceEpoch;

    var tpe;

    if (verify != "1") {
      tpe = [
        {"type": "promotion"},
        {"type": "news"},
        {"type": "prod_service"}
      ];
    } else
      tpe = [
        {"type": "opportunite"},
        {"type": "promotion"},
        {"type": "news"},
        {"type": "prod_service"}
      ];

    var url = json.encode({
      "\$or": tpe,
      // "raja":true,

      // "partner":{"\$inQuery":{"where":{"sponsored": 1,"status":"1"},"className":"partners"}}
    });

    var ur =
        'offers?limit=20&skip=$skip&count=1&where=$url&include=membre&order=-sponsorise&order=-createdAt';

    /* var  url =
        '"type":"event","communitiesKey":"$kkey","activatedDate":{"\$lte":$number},"partner":{"\$inQuery":{"where":{"sponsored": 1,"status":"1"},"className":"partners"}}';
    var ur= 'offers?limit=5&skip=$skip&count=1&where={$url}&include=partner&include=membre&order=-createdAt';*/

    var getoffers = await parseFunctions.getparse(ur);
    List res = getoffers["results"];

    return {
      "results":
          res.map((var contactRaw) => new Offers.fromMap(contactRaw)).toList(),
      "count": getoffers["count"]
    };
  }

  static get_event_(User user, skip) async {
    var kkey = user.communitykey;
    int number = DateTime.now().millisecondsSinceEpoch;
    var url =
        '"type":"event","startDate":{"\$lte":$number},"endDate":{"\$gte":$number}';
    var ur =
        'offers?limit=5&skip=$skip&count=1&where={$url}&include=membre&order=-createdAt';

    var getoffers = await parseFunctions.getparse(ur);
    List res = getoffers["results"];

    return {
      "results":
          res.map((var contactRaw) => new Offers.fromMap(contactRaw)).toList(),
      "count": getoffers["count"]
    };
  }

  static get_promo(User user, skip) async {
    var kkey = user.communitykey;
    int number = DateTime.now().millisecondsSinceEpoch;
    var url =
        '"type":"promotion","communitiesKey":"$kkey","partner":{"\$inQuery":{"where":{"status":"1"},"className":"partners"}}';
    var ur =
        'offers?limit=5&skip=$skip&count=1&where={$url}&include=partner&include=membre&order=-createdAt';
    var getoffers = await parseFunctions.getparse(ur);
    List res = getoffers["results"];

    return {
      "results":
          res.map((var contactRaw) => new Offers.fromMap(contactRaw)).toList(),
      "count": getoffers["count"]
    };
  }

  static get_cov(User user, skip) async {
    var kkey = user.communitykey;
    int number = DateTime.now().millisecondsSinceEpoch;
    var url = '"active":1,"type":"cov","raja":true';
    var ur =
        'offers?limit=5&skip=$skip&count=1&where={$url}&include=author&order=-boostn&order=-createdAt';
    var getoffers = await parseFunctions.getparse(ur);
    List res = getoffers["results"];

    return {
      "results":
          res.map((var contactRaw) => new Offers.fromMap(contactRaw)).toList(),
      "count": getoffers["count"]
    };
  }

  static get_shop(User user, skip) async {
    var kkey = user.communitykey;
    int number = DateTime.now().millisecondsSinceEpoch;
    var url = '"type":"boutique"';

    var ur =
        'offers?limit=20&skip=$skip&count=1&where={$url}&include=partner&include=membre&order=-createdAt';
    var getoffers = await parseFunctions.getparse(ur);
    List res = getoffers["results"];
    return {
      "results":
          res.map((var contactRaw) => new Offers.fromMap(contactRaw)).toList(),
      "count": getoffers["count"]
    };
  }

/*

     var kkey = user.communitykey;

      url +=
      '"type":"${category.toLowerCase()}","sector":"$sector","communitiesKey":"$kkey","startDate":{"\$lte":$number},"endDate":{"\$gte":$number}';


      return 'offers?limit=20&skip=$skip&count=1&where={$url}&include=partner&include=membre';
 */

  urlpost(User user, String category, String type, String sector, skip, dep,
      dest, da, user_cov_id, cat, boutique, favorite) {
    var url = '';
    int number = DateTime.now().millisecondsSinceEpoch;

    if (favorite == true) {
      String id = user.id;
      url +=
          '"author":{"\$inQuery":{"where":{"objectId":"$id"},"className":"users"}}';
      return 'save_fav?limit=20&skip=$skip&count=1&where={$url}&include=post';
    }

    if (boutique == true && category == "Tous les produits") {
      url += '"type":"boutique"';
      return 'offers?limit=20&skip=$skip&count=1&where={$url}&include=partner&include=membre';
    }
    if (boutique == true && category != "") {
      url += '"type":"boutique","sector":"$category"';
      return 'offers?limit=20&skip=$skip&count=1&where={$url}&include=partner&include=membre';
    } else if (category != "" &&
        category != null &&
        category == "cov" &&
        dep.toString() != "null" &&
        dep != "") {
      url +=
          '"active":1,"type":"${category.toLowerCase()}","depart":"$dep","destination":{"\$regex": "$dest"},"time_dep":"$da","raja":true';
      return 'offers?limit=20&skip=$skip&count=1&where={$url}&include=author&order=-boostn&order=-createdAt';
    } else if (category != "" &&
        category != null &&
        category == "cov" &&
        user_cov_id.toString() != "null" &&
        user_cov_id.toString() != "") {
      url +=
          '"active":1,"type":"${category.toLowerCase()}","author":{"\$inQuery":{"where":{"objectId":"$user_cov_id"},"className":"users"}}';
      return 'offers?limit=20&skip=$skip&count=1&where={$url}&include=author&order=-createdAt';
    } else if (category != "" && category != null && category == "cov") {
      url += '"active":1,"type":"${category.toLowerCase()}","raja":true';

      return 'offers?limit=20&skip=$skip&count=1&where={$url}&include=author&order=-boostn&order=-createdAt';
    } else if (category != "" &&
        category != null &&
        category == "promotion" &&
        sector != "" &&
        sector != null) {
      var kkey = user.communitykey;

      url +=
          '"type":"${category.toLowerCase()}","sector":"$sector","communitiesKey":"$kkey","startDate":{"\$lte":$number},"endDate":{"\$gte":$number}';

      return 'offers?limit=20&skip=$skip&count=1&where={$url}&include=partner&include=membre';
    } else if (category != "" && category != null && category == "promotion") {
      var kkey = user.communitykey;

      url +=
          '"type":"${category}","communitiesKey":"$kkey","startDate":{"\$lte":$number},"endDate":{"\$gte":$number}';

      return 'offers?limit=20&skip=$skip&count=1&where={$url}&include=partner&include=membre';
    } else if (category != "" && category != null) {
      var key = user.communitykey;

      int number = DateTime.now().millisecondsSinceEpoch;

      if (category == "event")
        url +=
            '"type":"${category.toLowerCase()}","cat":"$cat","communitiesKey":"$key","activatedDate":{"\$lte":$number}';
      else if (category == "news")
        url +=
            '"type":"${category.toLowerCase()}","cat":"$cat","communitiesKey":"$key","startDate":{"\$lte":$number},"endDate":{"\$gte":$number}';
      else
        url +=
            '"type":"${category.toLowerCase()}","cat":"$cat","communitiesKey":"$key"';

      return 'offers?limit=20&skip=$skip&count=1&where={$url}&include=membre';
    } else if (type == "an" && user_cov_id.toString() != "null") {
      var qu = [
        //  {"type": "Mission_raja"},
        //{"type": "Hébergement_raja"},
        //{"type": "Annonces"},
        //{"type": "Objets perdus_raja"}
      ];
      var url = jsonEncode({
        "\$or": qu,
        "author": {
          "\$inQuery": {
            "where": {"objectId": "$user_cov_id"},
            "className": "users"
          }
        },
        "active": 1
      });
      return 'offers?limit=20&skip=$skip&count=1&where=$url&include=author&order=-boostn';
    } else if (type != "" && type != null) {
      url += '"type":"${type}","active":1,"raja":true';
      return 'offers?limit=20&skip=$skip&count=1&where={$url}&include=author&order=-boostn';
    }
  }
}

/*





import 'dart:convert';

import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/models/offers.dart';
import 'package:mycgem/models/user.dart';

class PostsServices{

  static ParseServer parseFunctions = new ParseServer();



  static get_recent_friend_pub(my_id,skip) async{
    var qu = [
      {"type": "Mission"},
      {"type": "Hébergement"},
      {"type": "Achat / Vente"},
      {"type": "Objets perdus"}
    ];


    /*

     var qu1 = [
    {"objectId":  {"\$select":{"query":{"className":"connect","where":{"send_requ":{"\$eq":"$my_id"},"accepted":true}},"key":"receive_req"}}},
    {"objectId":  {"\$dontSelect":{"query":{"className":"connect","where":{"send_requ":{"\$eq":"$my_id"},"accepted":true}},"key":"receive_req"}}}
    ];
     */
    var url = jsonEncode({
      "\$or": qu,
          "author": {
        "\$inQuery": {
          "where": {"objectId":  {"\$select":{"query":{"className":"connect","where":{"send_requ":{"\$eq":"$my_id"},"accepted":true}},"key":"receive_req"}}     },
          "className": "users"
        }
      },
      "active":1
    });
    var ur =  'offers?limit=10&skip=$skip&count=1&where=$url&include=author&order=-boostn';

   var getoffers = await parseFunctions.getparse(ur);
    List res =  getoffers["results"];
    return {"results":res.map((var contactRaw) => new Offers.fromMap(contactRaw))
        .toList(),"count":getoffers["count"]};
  }



  static get_recent_others_pub(my_id,skip) async{
    var qu = [
      {"type": "Mission"},
      {"type": "Hébergement"},
      {"type": "Achat / Vente"},
      {"type": "Objets perdus"}
    ];


    /*

     var qu1 = [
    {"objectId":  {"\$select":{"query":{"className":"connect","where":{"send_requ":{"\$eq":"$my_id"},"accepted":true}},"key":"receive_req"}}},
    {"objectId":  {"\$dontSelect":{"query":{"className":"connect","where":{"send_requ":{"\$eq":"$my_id"},"accepted":true}},"key":"receive_req"}}}
    ];
     */
    var url = jsonEncode({
      "\$or": qu,
      "author": {
        "\$inQuery": {
          "where": {"objectId":  {"\$dontSelect":{"query":{"className":"connect","where":{"send_requ":{"\$eq":"$my_id"},"accepted":true}},"key":"receive_req"}}     },
          "className": "users"
        }
      },
      "active":1
    });
    var ur =  'offers?limit=10&skip=$skip&count=1&where=$url&include=author&order=-boostn';

    var getoffers = await parseFunctions.getparse(ur);
    List res =  getoffers["results"];
    return {"results":res.map((var contactRaw) => new Offers.fromMap(contactRaw))
        .toList(),"count":getoffers["count"]};
  }


  static get_events(User user,skip) async {
    var kkey = user.communitykey;
    int number = DateTime.now().millisecondsSinceEpoch;


    var  url =
        '"type":"event","communitiesKey":"$kkey","activatedDate":{"\$lte":$number},"eventDate":{"\$gte":$number}';
    var ur= 'offers?limit=5&skip=$skip&count=1&where={$url}&include=partner&include=membre&order=-createdAt';
    var getoffers = await parseFunctions.getparse(ur);
    List res =  getoffers["results"];

    return {"results":res.map((var contactRaw) => new Offers.fromMap(contactRaw))
        .toList(),"count":getoffers["count"]};

}


/*


   var res = json.encode({
      "\$or": search,
      "active":1,
      "id":{"\$dontSelect":{"query":{"className":"block","where":{"userS":{"\$eq":"$id"}}},"key":"blockedS"}},
      "idblock":{"\$dontSelect":{"query":{"className":"block","where":{"blockedS":{"\$eq":"$id"}}},"key":"userS"}},
      "medz":true
    });

 */

  static get_news(User user,skip) async {
    var kkey = user.communitykey;



    var tpe  = [
      {
        "type":"event"
      },
      {
        "type":"promotion"
      },
      {
        "type":"news"
      }
    ];



    var url = json.encode({
      "\$or": tpe,
      "communitiesKey":"$kkey",
      "startDate":{"\$lte":DateTime.now().millisecondsSinceEpoch},
      "endDate":{"\$gte":DateTime.now().millisecondsSinceEpoch}
    });


    var ur= 'offers?limit=15&skip=$skip&count=1&where=$url&include=partner&include=membre&order=-createdAt';

    var getoffers = await parseFunctions.getparse(ur);
    List res =  getoffers["results"];


    return {"results":res.map((var contactRaw) => new Offers.fromMap(contactRaw))
        .toList(),"count":getoffers["count"]};
  }


  static get_promo(User user,skip) async {
    var kkey = user.communitykey;
    int number = DateTime.now().millisecondsSinceEpoch;
    var  url =
        '"type":"promotion","communitiesKey":"$kkey"';
    var ur= 'offers?limit=5&skip=$skip&count=1&where={$url}&include=partner&include=membre';
    var getoffers = await parseFunctions.getparse(ur);
    List res =  getoffers["results"];

    return {"results":res.map((var contactRaw) => new Offers.fromMap(contactRaw))
        .toList(),"count":getoffers["count"]};
  }




  static get_cov(User user,skip) async {
    var kkey = user.communitykey;
    int number = DateTime.now().millisecondsSinceEpoch;
    var  url =
        '"type":"cov"';
    var ur= 'offers?limit=5&skip=$skip&count=1&where={$url}&include=author';
    var getoffers = await parseFunctions.getparse(ur);
    List res =  getoffers["results"];

    return {"results":res.map((var contactRaw) => new Offers.fromMap(contactRaw))
        .toList(),"count":getoffers["count"]};
  }




  static get_shop(User user,skip) async {
    var kkey = user.communitykey;
    int number = DateTime.now().millisecondsSinceEpoch;
   var url = '"type":"boutique"';

    var ur='offers?limit=20&skip=$skip&count=1&where={$url}&include=partner&include=membre&order=-createdAt';
    var getoffers = await parseFunctions.getparse(ur);
    List res =  getoffers["results"];
    return {"results":res.map((var contactRaw) => new Offers.fromMap(contactRaw))
        .toList(),"count":getoffers["count"]};

  }

/*

     var kkey = user.communitykey;

      url +=
      '"type":"${category.toLowerCase()}","sector":"$sector","communitiesKey":"$kkey","startDate":{"\$lte":$number},"endDate":{"\$gte":$number}';


      return 'offers?limit=20&skip=$skip&count=1&where={$url}&include=partner&include=membre';
 */

  urlpost(User user, String category, String type, String sector, skip, dep,
      dest, da, user_cov_id, cat, boutique, favorite) {
    var url = '';
    int number = DateTime.now().millisecondsSinceEpoch;

    if (favorite == true) {

      String id = user.id;
      url += '"author":{"\$inQuery":{"where":{"objectId":"$id"},"className":"users"}}';
      return 'save_fav?limit=20&skip=$skip&count=1&where={$url}&include=post';
    }

    if (boutique == true && category == "Tous les produits") {
      url += '"type":"boutique"';
      return 'offers?limit=20&skip=$skip&count=1&where={$url}&include=partner&include=membre';
    }
    if (boutique == true && category != "") {
      url += '"type":"boutique","sector":"$category"';
      return 'offers?limit=20&skip=$skip&count=1&where={$url}&include=partner&include=membre';
    }
    else if (category != "" &&
        category != null &&
        category == "cov" &&
        dep.toString() != "null" &&
        dep != "") {
      url +=
      '"type":"${category.toLowerCase()}","depart":"$dep","destination":{"\$regex": "$dest"},"time_dep":"$da","medz":true';
      return 'offers?limit=20&skip=$skip&count=1&where={$url}&include=author&order=-boostn';
    } else if (category != "" &&
        category != null &&
        category == "cov" &&
        user_cov_id.toString() != "null" &&
        user_cov_id.toString() != "") {
      url +=
      '"type":"${category.toLowerCase()}","author":{"\$inQuery":{"where":{"objectId":"$user_cov_id"},"className":"users"}}';
      return 'offers?limit=20&skip=$skip&count=1&where={$url}&include=author&order=-createdAt';
    } else if (category != "" && category != null && category == "cov") {
      url += '"type":"${category.toLowerCase()}","medz":true';


      return 'offers?limit=20&skip=$skip&count=1&where={$url}&include=author&order=-boostn';
    } else if (category != "" &&
        category != null &&
        category == "promotion" &&
        sector != "" &&
        sector != null) {
      var kkey = user.communitykey;

      url +=
      '"type":"${category.toLowerCase()}","sector":"$sector","communitiesKey":"$kkey","startDate":{"\$lte":$number},"endDate":{"\$gte":$number}';


      return 'offers?limit=20&skip=$skip&count=1&where={$url}&include=partner&include=membre';
    } else if (category != "" && category != null && category == "promotion") {
      var kkey = user.communitykey;

      url += '"type":"${category}","communitiesKey":"$kkey","startDate":{"\$lte":$number},"endDate":{"\$gte":$number}';

      return 'offers?limit=20&skip=$skip&count=1&where={$url}&include=partner&include=membre';
    } else if (category != "" && category != null) {

      var key = user.communitykey;


      int number = DateTime.now().millisecondsSinceEpoch;

      if(category == "event")
        url +=
        '"type":"${category.toLowerCase()}","cat":"$cat","communitiesKey":"$key","activatedDate":{"\$lte":$number}';
      else if(category == "news")
        url +=
        '"type":"${category.toLowerCase()}","cat":"$cat","communitiesKey":"$key","startDate":{"\$lte":$number},"endDate":{"\$gte":$number}';
      else
        url +=
        '"type":"${category.toLowerCase()}","cat":"$cat","communitiesKey":"$key"';


      return 'offers?limit=20&skip=$skip&count=1&where={$url}&include=partner&include=membre';
    } else if (type == "an" && user_cov_id.toString() != "null") {
      var qu = [
        {"type": "Mission"},
        {"type": "Hébergement"},
        {"type": "Achat / Vente"},
        {"type": "Objets perdus"}
      ];
      var url = jsonEncode({
        "\$or": qu,
        "author": {
          "\$inQuery": {
            "where": {"objectId": "$user_cov_id"},
            "className": "users"
          }
        },
        "active":1
      });
      return 'offers?limit=20&skip=$skip&count=1&where=$url&include=author&order=-boostn';
    } else if (type != "" && type != null) {
      url += '"type":"${type}","active":1,"medz":true';
      return 'offers?limit=20&skip=$skip&count=1&where={$url}&include=author&order=-boostn';
    }
  }






}
 */
