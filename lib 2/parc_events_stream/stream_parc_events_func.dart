import 'dart:convert';

import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/models/annonces.dart';
import 'package:mycgem/models/commission.dart';
import 'package:mycgem/models/conversation_g.dart';
import 'package:mycgem/models/favorite.dart';
import 'package:mycgem/models/membre.dart';
import 'package:mycgem/models/offers.dart';
import 'package:mycgem/models/partner.dart';
import 'package:mycgem/models/region.dart';
import 'package:mycgem/models/revue.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/models/video.dart';
import 'package:mycgem/services/search_apis.dart';
import 'package:youtube_api/youtube_api.dart';

class StreamPostsFunctions {
  ParseServer parseFunctions = new ParseServer();

  YoutubeAPI ytApi = new YoutubeAPI(key, maxResults: 20);
  List<YT_API> ytResult = [];

  static String key = "AIzaSyBP-USv93bW62QGsFja7AALATGwv1WzWpQ";

  callAPI(skip) async {
    print('UI callled');

    print(skip);
    print("ndndndn");

    var res;
    // if (skip == 0)

    print(66666);
    print('AIzaSyDI51TS3pNwxFzlFgM3XKnIHmGog1v3kCk');

    res = await ytApi.channel(
        "UCZd6KbdnDNzyG2JJMTJNLRA"/*, "AIzaSyDI51TS3pNwxFzlFgM3XKnIHmGog1v3kCk"*/);
    //else*/
    //res = await ytApi.nextPage();

    print(res[0]);
    return {"results": res, "count": 1267};
  }

  urlpost(
      User user,
      String category,
      String type,
      String sector,
      skip,
      dep,
      dest,
      da,
      user_cov_id,
      cat,
      boutique,
      favorite,
      search,
      entreprise,
      suivis,
      search_posts,
      search_type,
      idp,
      type_promo,
      sector_promo,
      search_entreprise,
      type_groupe,
      verify,
      user_stream,
      likepost, id) async {
    var url = '';
    int number = DateTime.now().millisecondsSinceEpoch;

    if (favorite == true) {
      String id = user.id;
      url +=
      '"author":{"\$inQuery":{"where":{"objectId":"$id"},"className":"users"}}';
      return 'save_fav?limit=20&skip=$skip&where={$url}&include=post';
    } else if (boutique == true && category == "Tous les produits") {
      url += '"type":"boutique"';
      return 'offers?limit=20&skip=$skip&where={$url}&include=partner&include=membre&order=-createdAt';
    } else if (boutique == true && category != "") {
      url += '"type":"boutique","sector":"$category"';
      return 'offers?limit=20&skip=$skip&where={$url}&include=partner&include=membre&order=-createdAt';
    } else if (category != "" &&
        category != null &&
        category == "cov" &&
        dep.toString() != "null" &&
        dep != "") {
      url +=
      '"type":"${category.toLowerCase()}","depart":"$dep","idp":"$idp","destination":{"\$regex": "$dest"},"time_dep":"$da","raja":true';
      return 'offers?limit=20&skip=$skip&where={$url}&include=author&order=-boostn';
    } else if (category != "" &&
        category != null &&
        category == "cov" &&
        user_cov_id.toString() != "null" &&
        user_cov_id.toString() != "") {
      url +=
      '"type":"${category.toLowerCase()}","idp":"$idp","author":{"\$inQuery":{"where":{"objectId":"$user_cov_id"},"className":"users"}}';
      return 'offers?limit=20&skip=$skip&where={$url}&include=author&order=-createdAt';
    } else if (category != "" && category != null && category == "cov") {
      url += '"type":"${category.toLowerCase()}","raja":true,"idp":"$idp"';

      return 'offers?limit=20&skip=$skip&where={$url}&include=author&order=-boostn';
    } else if (category == "promotion") {
      if (sector_promo != null && sector_promo != "")
        url +=
        '"type":"tarif","sector_":{"\$inQuery":{"where":{"objectId":"$sector_promo"},"className":"sectors_convention"}}';
      else //"type":"${category.toLowerCase()}",
        url += '"type":"tarif"';

      return 'offers?limit=20&skip=$skip&where={$url}&include=partner&include=membre&order=page_number&include=sector_&include=service';
    } else if (category != "" &&
        category != null &&
        category == "opportunite") {
      if (sector == "") {
        if (cat != "" && cat.toString() != "null") {
          ///},{"author": {"\$inQuery": {"where": {"membre_user": {"\$inQuery": {"where": {"objectId": "$cat"},"className": "membres"}}},"className": "users"}}}
          url +=
          '"activateDate":{"\$gte":$number},"type":"${category.toLowerCase()}","\$or":[{"membre":{"\$inQuery":{"where":{"objectId":"$cat"},"className":"membres"}}},{"author": {"\$inQuery": {"where": {"membre_user": {"\$inQuery": {"where": {"objectId": "$cat"},"className": "membres"}}},"className": "users"}}}]';
        } else
          url +=
          '"type":"${category.toLowerCase()}","activateDate":{"\$gte":$number}';
      } else {
        url +=
        '"type_op":"$sector","type":"${category.toLowerCase()}","activateDate":{"\$gte":$number}';
      }

      var a, sk;

      if (verify != "1") {
        a = 2;
        sk = skip;
      } else {
        a = 20;
        sk = 0;
      }

      return 'offers?limit=$a&skip=$sk&count=1&where={$url}&include=partner&include=membre&include=author&order=-createdAt';
    } else if (search_posts != "" && search_posts.toString() != "null") {
      print("-----------------------------------------------");
      print(search_posts);
      var resultsearch = await SearchApis.searchposts_posts(search_posts);

      var wherecondition = '"objectId":{"\$in":$resultsearch}';

      return 'offers?limit=20&skip=$skip&count=1&where={$wherecondition,"type":"$search_type"}&include=partner&include=membre';
    } else if (likepost != "" && likepost.toString() != "null") {
      var url = jsonEncode({
        "post": {
          "\$inQuery": {
            "where": {"objectId": "$likepost"},
            "className": "offers"
          }
        }
      });
      return 'likes?limit=20&skip=$skip&count=1&where=$url&include=author&order=-objectId';
    } else if (category != "" &&
        category != null &&
        category == "opportunite") {
      var kkey = user.communitykey;

      url += //,"startDate":{"\$lte":$number
      '"type":"${category}","communitiesKey":"$kkey"}';

      return 'offers?limit=20&skip=$skip&where={$url}&include=partner&include=membre&order=-createdAt';
    } else if (category != "" && category != null) {
      var key = user.communitykey;

      int number = DateTime.now().millisecondsSinceEpoch;

      if (category == "event") {
        if (cat != "" &&
            cat.toString() != "null" &&
            suivis.toString() != "null" &&
            suivis == true) {
          String myid = user.id;

          url +=
          '"type":"${category.toLowerCase()}","membre": {"\$inQuery": {"where": {"objectId":  {"\$select":{"query":{"className":"likepartner","where":{"idUser":"$myid"}},"key":"iden"}}},"className": "membres"}}';

          //"objectId":{"\$select":{"query":{"className":"likepartner","where":{"iden":"$cat"}}}}';
        } else if (cat != "" && cat.toString() != "null") {
          /* url +=
              '"type":"${category.toLowerCase()}","startDate":{"\$lte":$number},"endDate": {"\$gte": $number},"partner":{"\$inQuery":{"where":{"objectId":"$cat"},"className":"partners"}}';*/

          url +=
          //,{"author": {"\$inQuery": {"where": {"membre_user": {"\$inQuery": {"where": {"objectId": "$cat"},"className": "membres"}}},"className": "users"}}}
          '"\$or":[{"type": "event"},{"type": "event_user"}],"membre": {"\$inQuery": {"where": {"objectId": "$cat"},"className": "membres"}}';
        } else
          url += '"type":"${category.toLowerCase()}"';
      }
      /*else if (category == "prod_service") {
        if (cat != "" &&
            cat.toString() != "null" &&
            suivis.toString() != "null" &&
            suivis == true) {
          String myid = user.id;
          url +=
              '"type":"${category.toLowerCase()}","endDate": {"\$gte": $number},"startDate":{"\$lte":$number}, "partner": {"\$inQuery": {"where": {"objectId":  {"\$select":{"query":{"className":"likepartner","where":{"idUser":"$myid"}},"key":"iden"}}     },"className": "partners"}}';

          //"objectId":{"\$select":{"query":{"className":"likepartner","where":{"iden":"$cat"}}}}';
        } else if (cat != "" && cat.toString() != "null") {
          url +=
              '"type":"${category.toLowerCase()}","partner":{"\$inQuery":{"where":{"objectId":"$cat"},"className":"partners"}}';
        } else
          url += '"type":"${category.toLowerCase()}"';
      }*/
      else if (category == "news") {
        if (cat != "" &&
            cat.toString() != "null" &&
            suivis.toString() != "null" &&
            suivis == true) {
          String myid = user.id;
          url +=
          '"type":"${category.toLowerCase()}","membre": {"\$inQuery": {"where": {"objectId":  {"\$select":{"query":{"className":"likepartner","where":{"idUser":"$myid"}},"key":"iden"}}     },"className": "membres"}}';

          //"objectId":{"\$select":{"query":{"className":"likepartner","where":{"iden":"$cat"}}}}';
        } else if (cat != "" && cat.toString() != "null") {
          /**
              ,{"author": {"\$inQuery": {"where": {"membre_user": {"\$inQuery": {"where": {"objectId": "$cat"},"className": "membres"}}},"className": "users"}}}
           */
          url +=
          '"\$or":[{"type": "news"},{"type": "news_user"}],"membre": {"\$inQuery": {"where": {"objectId": "$cat"},"className": "membres"}}';
        } else
          url += '"type":"${category.toLowerCase()}"';
      } else if (category == "news") {
        if (cat != "" &&
            cat.toString() != "null" &&
            suivis.toString() != "null" &&
            suivis == true) {
          String myid = user.id;
          url +=
          '"type":"${category.toLowerCase()}", "partner": {"\$inQuery": {"where": {"objectId":  {"\$select":{"query":{"className":"likepartner","where":{"idUser":"$myid"}},"key":"iden"}}     },"className": "partners"}}';

          //"objectId":{"\$select":{"query":{"className":"likepartner","where":{"iden":"$cat"}}}}';
        } else if (cat != "" && cat.toString() != "null") {
          url +=
          '"type":"${category.toLowerCase()}","partner":{"\$inQuery":{"where":{"objectId":"$cat"},"className":"partners"}}';
        } else
          url += '"type":"${category.toLowerCase()}"';
      } else
        url += '"type":"${category.toLowerCase()}"';

      return 'offers?limit=20&skip=$skip&where={$url}&include=author&include=membre&order=-createdAt&count=1';
    } else if (type == "an" && user_cov_id.toString() != "null") {
      var qu = [
        {"type": "$user_cov_id"},
      ];

      String iduser = user.id;

      var url = jsonEncode({
        "\$or": qu,
        "author": {
          "\$inQuery": {
            "where": {"objectId": "$iduser"},
            "className": "users"
          }
        },
        "active": 1
      });
      return 'offers?limit=20&skip=$skip&where=$url&include=author&order=-sponsorise';
    } else if (type != "" && type != null) {
      url += '"type":"${type}","active":1,"raja":true';
      return 'offers?limit=20&skip=$skip&where={$url}&include=author&order=-boostn&include=partner&include=membre';
    }
  }

  /*
  "partner":{"\$inQuery":{"where":{"order_partner":{"\$lte":0}},"className":"partners"}}
   */

  /*
   var genre;
  var type_groupe;
  var tpe_group;
   */
  fetchposts(User user, active,
      {String category = "",
        idpost,
        filter,
        Region region,
        revue,
        video,
        String type = "",
        int skip = 0,
        search_entreprise,
        var entreprise,
        partner_id,
        member,
        idp,
        suivis = false,
        sector,
        dep,
        dest,
        genre,
        type_groupe,
        tpe_group,
        da,
        user_cov_id,
        sector_promo,
        gender,
        cat,
        search,
        boutique,
        likepost,
        type_promo,
        search_posts,
        search_type,
        favorite,
        user_stream,
        Commission commission,
        Commission federation,
        obj,
        lat,
        lng}) async {
    var url = "";
    String ur = "";

    if (user_stream.toString() != "null" && user_stream == "users") {
      if (filter == "proche") {
        /**
            Utilisateurs proche de vous
         */

        var qu = [
          {"active": 1},
          {"rl": true}
        ];

        var ur_q;

        if (lat.toString() == "null") {
          ur_q = jsonEncode({"\$or": qu});
          ur =
          'where=$ur_q&limit=20&skip=$skip&include=membre_user&include=commissions&include=membre_user.federation&include=membre_user.region';
        } else {
          ur = 'where=${jsonEncode({
            "\$or": qu,
            "location": {
              "\$nearSphere": {
                "__type": "GeoPoint",
                "latitude": lat,
                "longitude": lng
              }
            }
          })}&limit=20&skip=$skip&include=membre_user&include=commissions&include=membre_user.federation&include=membre_user.region';
        }
      } else if (filter == "new") {
        ur =
        'where={"raja":true,"active":1}&limit=20&skip=$skip&include=membre_user&include=commissions&include=membre_user.federation&include=membre_user.region&count=1&order=-createdAt';
      } else if (filter == "region") {
        String id_reg = region.id;

        var qu = [
          {"active": 1},
          {"rl": true}
        ];

        var ur_q = jsonEncode({
          "active": 1,
          "region": {
            "\$inQuery": {
              "where": {"objectId": "$id_reg"},
              "className": "regions"
            }
          }
        });
        url =
        'membres?where=$ur_q&limit=20&skip=$skip&include=region&include=ville&include=federation&include=region&count=1&order=-createdAt';
        print(url);

      }

      else if (filter == "commissions") {
        var qu = [
          {"active": 1},
          {"rl": true}
        ];
        String id_com = commission.id;

        var ur_q = jsonEncode({
          "\$or": qu,
          "membre_user": {
            "\$inQuery": {
              "where": {"commission": "$id_com"},
              "className": "membres"
            }
          }
        });

        ur =
        'where=$ur_q&limit=20&skip=$skip&include=membre_user&include=commissions&include=membre_user.federation&include=membre_user.region&count=1&order=-createdAt';
      } else if (filter == "federations") {
        //Utlisateurs selon federation
        String id_fed = federation.id;


        var qu = [
          {"active": 1},
          {"rl": true}
        ];

        var ur_q = jsonEncode({
          "active": 1,
          "federation": {
            "\$inQuery": {
              "where": {"objectId": "$id_fed"},
              "className": "federations"
            }
          }
        });
        url =
        'membres?where=$ur_q&limit=20&skip=$skip&include=region&include=ville&include=federation&include=region&count=1&order=-createdAt';
        print(url);

        /* var qu = [
          {"active": 1},
          {"rl": true}
        ];

        var ur_q = jsonEncode({
          "\$or": qu,
          "membre_user": {
            "\$inQuery": {
              "where": {
                "federation": {
                  "\$inQuery": {
                    "where": {"objectId": "$id_fed"},
                    "className": "federations"
                  }
                }
              },
              "className": "membres"
            }
          }
        });
        ur =
            'where=$ur_q&limit=20&skip=$skip&include=membre_user&include=commissions&include=membre_user.federation&include=membre_user.region&count=1&order=-createdAt';*/
      } else if (filter == "old") {
        ur =
        'where={"raja":true,"active":1}&limit=20&skip=$skip&include=membre_user&include=commissions&include=membre_user.federation&include=membre_user.region&count=1&order=createdAt';
      } else if (filter == "last") {
        ur =
        'where={"raja":true,"active":1}&limit=20&skip=$skip&include=membre_user&include=commissions&include=membre_user.federation&include=membre_user.region&count=1&order=-last_active';
      } else if (filter == "objectifs") {
        ur =
        'where={"raja":true,"active":1,"objectif":"$obj"}&limit=20&skip=$skip&include=membre_user&include=commissions&include=membre_user.federation&include=membre_user.region&include=fonction&count=1&order=-createdAt';
      } else if (filter == "gender") {
        ur =
        'where={"raja":true,"active":1,"gender":"$gender"}&limit=20&skip=$skip&include=membre_user&include=commissions&include=membre_user.federation&include=membre_user.region&include=fonction&count=1&order=-createdAt';
      } else if (filter == "relation") {
        String myid = user.id;
        var qq = [
          {"receive_req": "$myid"},
          {"send_requ": "$myid"}
        ];

        ur = jsonEncode({"\$or": qq, "accepted": true});
        url = 'connect?where=$ur&include=sendd&include=receivedd&count=1';
      }

      if (filter != "relation" && filter != "region" && filter != "federations") {
        print(
            "hdhdhhdhdhdhdhdhdhdhdhdhhdhdhdhdhdhduuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu");
        print(filter);
        url = "users?" + ur;
      }
    } else if (user_stream.toString() != "null" &&
        user_stream == "entreprise") {
      print(
          "hdhdhhdhdhdhdhdhdhdhdhdhhdhdhdhdhdhduuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu");
      url =
      'membres?where={"active":1}&order=nme&include=region&include=ville&include=federation&skip=$skip&limit=20';
    } else if (user_stream.toString() != "null" && user_stream == "region") {
      String id = user.auth_id;
      String my_id = user.id;

      url = 'regions?order=region&skip=$skip&limit=2O';
    } else if (user_stream.toString() != "null" &&
        user_stream == "commission") {
      String id = user.auth_id;
      String my_id = user.id;

      url = 'commissions?order=order&skip=$skip&limit=2O';
    } else if (user_stream.toString() != "null" &&
        user_stream == "federation") {
      String id = user.auth_id;
      String my_id = user.id;

      url = 'federations?order=nme&skip=$skip&limit=2O';
    }
    /*else if (type == "sondage") {
      String ii = user.id;
      String tt = genre;
      url =
          'offers?limit=20&skip=$skip&count=1&where={"type":"sondage","author":{"\$inQuery":{"where":{"objectId":"$ii"},"className":"users"}}}&include=author&order=-createdAt&include=options&include=options.users';
    } */ /*else if (revue != false && revue != null) {
      url = 'revue?limit=20&skip=$skip&count=1&order=-createdAt';
    } */
    else if (video != false && video != null) {
      url = 'videos?limit=20&skip=$skip&count=1';
    } else if (idpost != "" && idpost != null) {
      url =
      'participate?limit=20&include=author&skip=$skip&count=1&where={"post":{"\$inQuery":{"where":{"objectId":"$idpost"},"className":"offers"}}}';
    } else if (member != "" && member != null) {
      /**
       * Les membres de l'organisme
       */
      var qu = [
        {"active": 1},
        {"rl": true}
      ];

      var ur_q = jsonEncode({
        "\$or": qu,
        "membre_user": {
          "\$inQuery": {
            "where": {"objectId": "$member"},
            "className": "membres"
          }
        },
      });

      url =
      'users?limit=20&skip=$skip&where=$ur_q&include=membre_user.federation&include=membre_user.region&include=commissions&include=fonction';
    } else if (search_entreprise != "" && search_entreprise != null) {
      var resultsearch = await SearchApis.searchentreprise(search_entreprise);

      print(resultsearch);
      var wherecondition = '"objectId":{"\$in":$resultsearch}';

      url =
      'membres?limit=20&skip=$skip&count=1&where={$wherecondition,"active":1}';
    } else if (search != "" && search != null) {
      var resultsearch = await SearchApis.searchposts(search);

      print("-------------@@@@@---");
      var wherecondition = '"objectId":{"\$in":$resultsearch}';

      var qu = [
        {"active": 1},
        {"rl": true},
      ];

      var ur_q;

      ur_q = jsonEncode({
        "\$or": qu,
        "objectId": {"\$in": resultsearch}
      });

      url =
      'users?limit=20&skip=$skip&count=1&where=$ur_q&order=firstname&order=familyname&include=fonction';
      print(url);
    } else if (entreprise.toString() != "[]" &&
        entreprise.toString() != "null") {
      url = 'membres?limit=20&skip=$skip&where={"active":1}&order=nme';



    } else {
      url = await urlpost(
          user,
          category,
          type,
          sector,
          skip,
          dep,
          dest,
          da,
          user_cov_id,
          cat,
          boutique,
          favorite,
          search,
          entreprise,
          suivis,
          search_posts,
          search_type,
          idp,
          type_promo,
          sector_promo,
          search_entreprise,
          type_groupe,
          active,
          user_stream,
          likepost,region== null?'':region.id);

      print("-----------7777777");
      print(url);
    }

    /*


    */
    var results;

    if (revue != false && revue != null) {
      results = await parseFunctions.getparse(url + "&order=createdAt");
    } else if (user_stream.toString() != "null" && user_stream == "users"  ) {

      if(filter == "region"){
        var ur_q = jsonEncode({
          "active": 1,
          "region": {
            "\$inQuery": {
              "where": {"objectId": "${region.id}"},
              "className": "regions"
            }
          }
        });
        url =
        'membres?where=$ur_q&limit=20&skip=$skip&include=region&include=ville&include=federation&include=region&count=1&order=-createdAt';        results = await parseFunctions.getparse(url);

      }
      else
        results = await parseFunctions.getparse(url);
    }

    else if (video != false && video != null) {
      results = await callAPI(skip);
    } else {
      results = await parseFunctions.getparse(url + "&order=-createdAt");
    }
    return data(
        user,
        category,
        type,
        results,
        favorite,
        search,
        entreprise,
        member,
        idpost,
        video,
        revue,
        search_entreprise,
        type_groupe,
        active,
        user_stream,
        filter,
        likepost);
  }

  data(
      user,
      category,
      type,
      results,
      favorite,
      search,
      entreprise,
      member,
      idpost,
      video,
      revue,
      search_entreprise,
      type_groupe,
      active,
      user_stream,
      filter,
      likepost
      /*report, likes, favorite*/) {
    if (results == "nointernet") return "nointernet";
    if (results == "error") return "error";
    if (results["count"] == 0) return "empty";

    /// if (results["results"] == 0) return "empty";
    if (results["results"].length > 0) {
      List postsItems = results['results'];

      print(postsItems);

      if (user_stream.toString() != "null" && user_stream == "users") {
        if (filter == "proche") {
          return {
            'results': postsItems.map((raw) => new User.fromMap(raw)).toList(),
            'count': 10000
          };
        } else if (filter == "region")
          return {
            'results':
            postsItems.map((raw) => new Membre.fromMap(raw)).toList(),
            'count': results['count']
          };
        else if (filter == "federations")
          return {
            'results':
            postsItems.map((raw) => new Membre.fromMap(raw)).toList(),
            'count': results['count']
          };
        else if (filter == "relation") {
          Map map = {};
          List lst2 = [];

          List lst = postsItems
              .map((raw) => new User.fromMap(user.id == raw["send_requ"]
              ? raw["receivedd"]
              : raw["sendd"]))
              .toList();

          for (User i in lst) {
            map[i.id] = i;
          }
          print(map);

          map.forEach((key, value) {
            lst2.add(value);
          });

          return {'results': lst2, 'count': results['count']};
        }
        return {
          'results': postsItems.map((raw) => new User.fromMap(raw)).toList(),
          'count': results['count']
        };
      } else if (likepost != "" && likepost != null) {
        return {
          'results':
          postsItems.map((raw) => new User.fromMap(raw["author"])).toList(),
          'count': results['count']
        };
      } else if (user_stream.toString() != "null" &&
          user_stream == "entreprise") {
        return {
          'results': postsItems.map((raw) => new Membre.fromMap(raw)).toList(),
          'count': results['count']
        };
      }


      else if (user_stream.toString() != "null" && user_stream == "region") {
        return {
          'results': postsItems.map((raw) => new Region.fromMap(raw)).toList(),
          'count': results['count']
        };
      }


      else if (user_stream == "commission" || user_stream == "federation") {
        return {
          'results':
          postsItems.map((raw) => new Commission.fromDoc(raw)).toList(),
          'count': results['count']
        };
      } else if (type_groupe != false && type_groupe != null) {
        return {
          'results':
          postsItems.map((raw) => new Conversationg.fromMap(raw)).toList(),
          'count': results['count']
        };
      } else if (revue != false && revue != null) {
        return {
          'results': postsItems.map((raw) => new Revue.fromMap(raw)).toList(),
          'count': results['count']
        };
      } else if (search_entreprise != null) {
        return {
          'results': postsItems.map((raw) => new Membre.fromMap(raw)).toList(),
          'count': results['count']
        };
      } else if (video != false && video != null) {
        return {'results': postsItems, 'count': 1267};
      } else if (idpost != "" && idpost != null) {
        return {
          'results':
          postsItems.map((raw) => new User.fromMap(raw["author"])).toList(),
          'count': results['count']
        };
      } else if (member != "" && member != null) {
        return {
          'results': postsItems.map((raw) => new User.fromMap(raw)).toList(),
          'count': results['count']
        };
      }
      if (search != "" && search != null) {
        return {
          'results': postsItems.map((raw) => new User.fromMap(raw)).toList(),
          'count': results['count']
        };
      }
      if (favorite == true) {
        return {
          'results':
          postsItems.map((raw) => new Favorite.fromMap(raw)).toList(),
          'count': results['count']
        };
      } else if (category != "" && category != null) {
        return {
          'results': postsItems.map((raw) => new Offers.fromMap(raw)).toList(),
          'count': results['count']
        };
      } else if (entreprise.toString() != "[]" &&
          entreprise.toString() != 'null') {
        return {
          'results': postsItems.map((raw) => new Membre.fromMap(raw)).toList(),
          'count': results['count']
        };
      } else if (type != "" && type != null) {
        if (type == "Annonces" && active != "1") {
          return {
            'results':
            postsItems.map((raw) => new Offers.fromMap(raw)).toList(),
            'count': results['count']
          };
        } else
          return {
            'results':
            postsItems.map((raw) => new Offers.fromMap(raw)).toList(),
            'count': results['count']
          };
      } else {
        return {
          'results': postsItems.map((raw) => new Offers.fromMap(raw)).toList(),
          'count': results['count']
        };
      }
    }
    return "nomoreresults";
  }
}
