import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/widgets/common.dart';
import 'package:mycgem/youtube_videos/models/youtube_card_content.dart';
import 'package:youtube_api/youtube_api.dart';

class YoutubeCard extends StatelessWidget {
  YoutubeCard(this.user, this.content, this.chng);

  final YT_API content;
  User user;
  var chng;

  void playYoutubeVideo(text, context) {
    Navigator.push(context,
        new MaterialPageRoute<String>(builder: (BuildContext context) {
      return new WebviewScaffold(
        url: text,
        appBar: new AppBar(
          title: new Text(""),
        ),
      );
    }));
  }

  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: EdgeInsets.only(bottom: 12),
        // margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        child: GestureDetector(
            onTap: () {
              print(content.url);

              if (Platform.isAndroid)
                playYoutubeVideo(content.url.replaceAll(" ", ""), context);
              else
                Navigator.push(context, new MaterialPageRoute<String>(
                    builder: (BuildContext context) {
                  return new WebviewScaffold(
                    url: content.url.replaceAll(" ", ""),
                    appBar: new AppBar(
                      title: new Text(""),
                    ),
                  );
                }));
            },
            child: Material(
              elevation: 0.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //Container which video tumbnail

                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 2.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ClipRRect(
                            child: Stack(children: <Widget>[
                          Container(
                              height: MediaQuery.of(context).size.height * 0.36,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.grey[200],
                              child: FadingImage.network(
                                content.thumbnail["high"]["url"],
                                fit: BoxFit.cover,
                              )),
                        ])),
                      ),
                    ],
                  ),

                  Container(
                    height: 12,
                  ),

                  //Row which contain channel tumbnail along with video information
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new ClipOval(
                            child: new Container(
                                color: Colors.white,
                                width: 58.0,
                                height: 58.0,
                                child: new Center(
                                    child: new FadingImage.network(
                                  "https://api.mycgem.ma/parse/files/cgembusiness/15a228c670c6aab43079178d8d910f48_image.jpg",
                                  width: 46.0,
                                  height: 46.0,
                                  fit: BoxFit.contain,
                                )))),

                        /* Container(
                            child: CircleAvatar(

                          backgroundImage: NetworkImage(
                            "https://api.mycgem.ma/parse/files/cgembusiness/15a228c670c6aab43079178d8d910f48_image.jpg",

                          ),

                          radius: 28,
                        )),*/
                        //Container of Channel Tubmnail

                        Container(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                         // mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(height: 8.0),

                            Text(
                              content.channelTitle,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color(0XFF646464),
                                fontSize: 13.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              content.publishedAt.toString().substring(0, 10),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color(0XFFBBBBBB),
                                fontWeight: FontWeight.w800,
                                fontSize: 14.0,
                              ),
                            ),
                            SizedBox(height: 12.0),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 12, bottom: 12),
                      width: MediaQuery.of(context).size.width * 0.98,
                      child: HtmlWidget(content.title))
                ],
              ),
            )),
      ),
      Container(
        height: 8,
      ),
      Container(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        height: 1,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey[300],
      ),
      Container(
        height: 8,
      ),
    ]);
  }
}
