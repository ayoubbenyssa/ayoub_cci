import 'dart:convert';
import 'dart:io';

import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/models/user.dart';
import 'package:http/http.dart' as clientHttp;

class SearchApis {
  static JsonDecoder _decoder = new JsonDecoder();
  ParseServer parseFunctions = new ParseServer();

  static searchposts_posts(text) async {
    var json2 = new Map();
    json2 = {
      "from": 0,
      "size": 200,
      "query": {
        "multi_match": {
          //  "fuzziness": 1,
          "query": text.toLowerCase(),
          "boost": 3.0,
          "type": "phrase_prefix",
          "max_expansions": 1000,
          //  "use_dis_max": "true",
          "tie_breaker": 1,
          "prefix_length": 1,
          "fields": [
            "category",
            "summary",
            "name",
            "description",
            "type",
            "choix",
            "cat"
          ]
        }
      }
    };

    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode("cgem" + ':' + "Cgem2k20"));

    String urls = "https://search.mycgem.ma/posts/post/_search";
    print(urls);
    var responses = await clientHttp.post(urls,
        headers: {
          HttpHeaders.authorizationHeader: basicAuth,
          "content-type": "application/json; charset=utf-8"},
        body: json.encode(json2));
    print(
        "________________888886666DHDHDDUD**************************####################################@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    print(responses.body);

    if (responses.statusCode < 200 ||
        responses.body == null ||
        responses.statusCode >= 300) {
      return "error";
    } else {
      var postsContainer = _decoder.convert(responses.body);
      List<String> list = new List<String>();
      for (var item in postsContainer['hits']['hits']) {
        print("1234");
        print(item);
        list.add('"' + item['_id'] + '"');
      }
      return list;
    }
  }

  /*

  OR is spelled should
AND is spelled must
NOR is spelled should_not
Example:

You want to see all the items that are (round AND (red OR blue)):

{
    "query": {
        "bool": {
            "must": [
                {
                    "term": {"shape": "round"}
                },
                {
                    "bool": {
                        "should": [
                            {"term": {"color": "red"}},
                            {"term": {"color": "blue"}}
                        ]
                    }
                }
            ]
        }
    }
}
   */
  static searchposts_posts_filter(text, cat, type, choix) async {
    var json2 = new Map();
    json2 = {
      "from": 0,
      "size": 200,
      "query": {
        "multi_match": {
          //  "fuzziness": 1,
          "query": text.toLowerCase(),
          "boost": 3.0,
          "type": "phrase_prefix",
          "max_expansions": 1000,
          //  "use_dis_max": "true",
          "tie_breaker": 1,
          "prefix_length": 1,
          "fields": ["category", "summary", "name", "description", "type"]
        }
      }
    };
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode("cgem" + ':' + "Cgem2k20"));

    String urls = "https://search.mycgem.ma/posts/post/_search";
    print(urls);
    var responses = await clientHttp.post(urls,
        headers: {
          HttpHeaders.authorizationHeader: basicAuth,
      "content-type": "application/json; charset=utf-8"},
        body: json.encode(json2));
    print(
        "________________888886666DHDHDDUD**************************####################################@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    print(responses.body);

    if (responses.statusCode < 200 ||
        responses.body == null ||
        responses.statusCode >= 300) {
      return "error";
    } else {
      var postsContainer = _decoder.convert(responses.body);
      List<String> list = new List<String>();
      for (var item in postsContainer['hits']['hits']) {
        print("1234");
        print(item);
        list.add('"' + item['_id'] + '"');
      }
      return list;
    }
  }

  /* Future<List<User>> searchposts(String text) async {
    var json2 = new Map();

    if (text != "") {
      json2 = {
        "query": {
          "multi_match": {
            "query": text,
            "boost": 1.0,
            "max_expansions": 100,
            "use_dis_max": "true",
            "fuzziness": 1,
            "tie_breaker": 2,
            "prefix_length": 3,
            "fields": [
              "titre",
              "familyname",
              "firstname",
              "email",
              "organisme"
            ]
          }
        },
        "sort": [
          {"createdAt": "desc"}
        ]
      };
    } else {
      json2 = {
        "query": {"match_all": {}},
        "sort": [
          {"createdAt": "desc"}
        ]
      };
    }

    String jsonData2 = json.encode(json2);

    String urls =
        "https://search-wupee-gcpqucncgwkijnybrj6clgbkcy.us-east-1.es.amazonaws.com/posts/post/_search";

    var responses = await clientHttp.post(urls,
        headers: {
          "Content-Type": "applicaton/json",
        },
        body: jsonData2);

    var postsContainer = _decoder.convert(responses.body);

    var d = postsContainer['hits']['hits'];

    return d
        .map((contactRaw) => new User.fromMap(contactRaw["_source"]))
        .toList();
  }*/

  fetchsearch({text = "", skip = 0}) async {
    var search = [
      {
        "text": {"\$regex": "$text"}
      },
      {
        "name": {"\$regex": "$text"}
      }
    ];
    var res = json.encode({
      "\$or": search,
      "author": {"\$exists": true}
    });
    var url =
        'users?limit=20&skip=$skip&order=-publishedAt&include=author&count=1&include=commissions&include=membre_user.federation&include=membre_user.region&include=fonction';
    url = url + '&where=$res';
    var results = await parseFunctions.getparse(url);
    if (results == "nointernet") return "nointernet";
    if (results == "error") return "error";
    if (results["count"] == 0) return "empty";
    if (results["results"].length > 0) {
      List postsItems = results['results'];
      return {
        'results': postsItems.map((raw) => new User.fromMap(raw)).toList(),
        'count': results['count']
      };
    }
    return "nomoreresults";
  }

  static searchentreprise(String text) async {
    var json2 = new Map();
    json2 = {
      "from": 0,
      "size": 200,
      "query": {
        "multi_match": {
          "query": text.toLowerCase(),
          "boost": 3.0,
          "max_expansions": 1000,
          // "use_dis_max": "true",
          //"fuzziness": 1,
          "tie_breaker": 1,
          "type": "phrase_prefix",
          "prefix_length": 1,
          "fields": ["username", "description","activities","emails","ice","name"]
        }
      }
    };
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode("cgem" + ':' + "Cgem2k20"));

    String urls = "https://search.mycgem.ma/entreprises/entreprise/_search";
    var responses = await clientHttp.post(urls,
        headers: {
          HttpHeaders.authorizationHeader: basicAuth,
          "content-type": "application/json; charset=utf-8"},
        body: json.encode(json2));

    print(responses.body);
    if (responses.statusCode < 200 ||
        responses.body == null ||
        responses.statusCode >= 300) {
      return "error";
    } else {
      var postsContainer = _decoder.convert(responses.body);
      List<String> list = new List<String>();
      for (var item in postsContainer['hits']['hits']) {
        list.add('"' + item["_id"] + '"');
      }
      return list;
    }
  }

  static searchposts(String text) async {
    print(
        "________________888886666DHDHDDUD**************************####################################@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    var json2 = new Map();
    json2 = {
      "from": 0,
      "size": 200,
      "query": {
        "multi_match": {
          "query": text, //text.toLowerCase(),
          "boost": 3.0,
          "max_expansions": 1000,
          "type": "phrase_prefix",
          "tie_breaker": 1,
          "prefix_length": 1,
          "fields": [
            "objectId",
            "titre",
            "fullname",
            "firstname",
            "name",
            "email",
            "organisme",
            "cmpetences"
          ]
        }
      }
    };
    String urls = "https://search.mycgem.ma/users/user/_search";


    print(urls);
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode("cgem" + ':' + "Cgem2k20"));

    var responses = await clientHttp.post(urls,
        headers: {
          HttpHeaders.authorizationHeader: basicAuth,
          "content-type": "application/json; charset=utf-8"
        },
        body: json.encode(json2));
    print(
        "________________888886666DHDHDDUD**************************####################################@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
    print(responses.body);

    if (responses.statusCode < 200 ||
        responses.body == null ||
        responses.statusCode >= 300) {
      return "error";
    } else {
      var postsContainer = _decoder.convert(responses.body);
      List<String> list = new List<String>();
      for (var item in postsContainer['hits']['hits']) {
        list.add(item['_id'] );
      }
      return list;
    }
  }

}
