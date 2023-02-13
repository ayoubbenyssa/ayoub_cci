import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as clientHttp;
import 'package:connectivity/connectivity.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/models/offers.dart';

class AppServices {
  static ParseServer parse_s = new ParseServer();
  String urlParse = "http://217.182.139.190:1383/parse/";
  final JsonDecoder _decoder = new JsonDecoder();



  static hasArabicCharacters(String text) {
    var regex = new RegExp(
        "[\u0600-\u06ff]|[\u0750-\u077f]|[\ufb50-\ufc3f]|[\ufe70-\ufefc]");

    return regex.hasMatch(text);
  }



  static go_webview(url, context) {
    Navigator.push(context,
        new MaterialPageRoute<String>(builder: (BuildContext context) {
          return WebviewScaffold(
            appBar: AppBar(
              title: Text(""),

            ),
            url: url,
            withJavascript: true,
            withZoom: true,   // zoom
            hidden: true,
          );
        }));
  }

  static   /// Fixes name cases; Capitalizes Each Word.
  String normaliseName(String name) {
    final stringBuffer = StringBuffer();

    var capitalizeNext = true;
    for (final letter in name.toString().toLowerCase().codeUnits) {
      // UTF-16: A-Z => 65-90, a-z => 97-122.
      if (capitalizeNext && letter >= 97 && letter <= 122) {
        stringBuffer.writeCharCode(letter - 32);
        capitalizeNext = false;
      } else {
        // UTF-16: 32 == space, 46 == period
        if (letter == 32 || letter == 46) capitalizeNext = true;
        stringBuffer.writeCharCode(letter);
      }
    }

    return stringBuffer.toString();
  }
  static  capitalizeFirstofEach(text) => text.toString()== "null"?"":normaliseName(text);


  static matchUrl(value) {
    RegExp regExp = new RegExp(
        r'(http|ftp|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:/~\+#]*[\w\-\@?^=%&amp;/~\+#])?');
    return regExp.hasMatch(value);
  }

  isconnectedfunction() async {
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  paramsparsejson() {
    return {
      "X-Parse-Application-Id": "C9EcHeKgPkRnUrWtYw3y5A8DaFcJfMhQmSp",
      "Content-Type": 'applicaton/json',
      'X-Parse-Master-Key': 'nTrWtYw3y5A8DaFcJfMhPmSpUsXuZw4z6B8'
    };
  }

  paramsparsenojson() {

    return {

      "X-Parse-Application-Id": "C9EcHeKgPkRnUrWtYw3y5A8DaFcJfMhQmSp",
      'X-Parse-Master-Key': 'nTrWtYw3y5A8DaFcJfMhPmSpUsXuZw4z6B8'
    };
  }



  uploadparse(geturl, File dat, classe) async {
    List<int> data = await dat.readAsBytes();
    var con = await isconnectedfunction();
    var results;
    if (con) {
      var url = Uri.parse(Uri.encodeFull(urlParse + geturl));
      var response =
          await clientHttp.post(url, headers: paramsparsejson(), body: data);
      String jsonBody = response.body;
      var statusCode = response.statusCode;
      if (statusCode < 200 || jsonBody == null || statusCode >= 300) {
        results = "error";
      } else {
        var postsContainer = _decoder.convert(jsonBody);
        /*  var data2 =
        JSON.encode({"photo": postsContainer['url'], "classe": classe});
        clientHttp.post(url2, headers: paramsparsenojson(), body: data2);*/
        results = postsContainer["url"];
      }
    } else {
      results = "nointernet";
    }
    return results;
  }

  static fetchpostsnearby(distance, lat, lng) async {
    var wherecondition = "";

    wherecondition +=
        '"location": {"\$nearSphere": { "__type": "GeoPoint","latitude": $lat, "longitude": $lng },"\$maxDistanceInKilometers": $distance},"raja":true';

    var url = 'offers?limit=120&include=author&';
    url = url + 'where={$wherecondition}';
    var results = await parse_s.getparse(url);

    if (results == "nointernet") return "nointernet";
    if (results == "error") return "error";
    if (results["count"] == 0) return "empty";

    if (results["results"].length > 0) {
      List postsItems = results['results'];

      return postsItems.map((raw) => new Offers.fromMap(raw)).toList();
    }
    return [];
  }
}
