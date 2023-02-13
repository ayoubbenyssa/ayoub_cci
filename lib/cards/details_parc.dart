import 'dart:async';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:mycgem/cards/details_partner.dart';
import 'package:mycgem/cards/like_widget.dart';
import 'package:mycgem/cards/vidoeoplay.dart';
import 'package:mycgem/chat/chatscreen.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/language_params/scope_model_wrapper.dart';
import 'package:mycgem/models/offers.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/youtube_service.dart';
import 'package:mycgem/widgets/app_appbar.dart';
import 'package:mycgem/widgets/common.dart';
import 'package:mycgem/widgets/image_widget.dart';
import 'package:mycgem/widgets/pdf_widget.dart';
import 'package:mycgem/widgets/youtube_widget.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:timeago/timeago.dart' as ta;

class DetailsParc extends StatefulWidget {
  DetailsParc(this.offer, this.user, this.tpe, this.listp, this.auth,
      this.analytics, this.onLocaleChange, this.lat, this.lng);

  Offers offer;
  User user;
  var tpe;
  var listp;
  var auth;
  var analytics;
  var onLocaleChange;
  var lat;
  var lng;

  @override
  _ShopCardState createState() => _ShopCardState();
}

class _ShopCardState extends State<DetailsParc> {
  ParseServer parseFunctions = new ParseServer();

  String link_img = "", link_title = "";

  getLink() {
    GetLinkData.getLink(widget.offer.urlVideo).then((vall) {
      setState(() {
        link_img = vall["image"];
        link_title = vall["title"];
      });
    });
  }
  final regex =
  RegExp(r'.*\?v=(.+?)($|[\&])', caseSensitive: false, multiLine: false);

  @override
  void initState() {
    parseFunctions.putparse(
        "offers/" + widget.offer.objectId, {"count": widget.offer.count + 1});
    // getLink();

    print("yesjsjs");
    print(widget.offer.dis);

    super.initState();
  }

  func_update_likes(i) {
    setState(() {
      widget.offer.likes_post =
          (int.parse(widget.offer.likes_post) + i).toString();
    });
  }

  void onLoading(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => new Dialog(
          child: new Container(
            padding: new EdgeInsets.all(16.0),
            width: 40.0,
            color: Colors.transparent,
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                new RefreshProgressIndicator(),
                new Container(height: 8.0),
                new Text(
                  "En cours ..",
                  style: new TextStyle(
                    color: Fonts.col_app_fonn,
                  ),
                ),
              ],
            ),
          ),
        ));

    // Navigator.pop(context); //pop dialog
    //  _handleSubmitted();
  }

  confirmer(my_id, his_id, user_me, user) async {
    // widget.delete();

    onLoading(context);

    DatabaseReference gMessagesDbRef2 = FirebaseDatabase.instance
        .reference()
        .child("room_medz")
        .child(my_id + "_" + his_id);
    Navigator.of(context, rootNavigator: true).pop('dialog');

    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
          return new ChatScreen(my_id, his_id, widget.listp, false, widget.auth,
              widget.analytics, widget.onLocaleChange,
              user: user_me);
        }));
  }

  //For ùaking a call
  Future _launched;

  Future _launch(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  gotomap() {
    var lat = widget.offer.latLng.toString().split(";")[0];
    var lng = widget.offer.latLng.toString().split(";")[1];
    _launched = _launch('https://www.google.com/maps/@$lat,$lng,16z');
  }

  void playYoutubeVideo() {
    Navigator.push(context,
        new MaterialPageRoute<String>(builder: (BuildContext context) {
          return new WebviewScaffold(
            url: widget.offer.urlVideo,
            withZoom: true, // zoom
            hidden: true,
            appBar: MyCgemBarApp(
              "",
              actionswidget: Container(),
            ),
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: MyCgemBarApp(
        "",
        actionswidget: Container(),
      ),
      body: new ListView(
        children: <Widget>[
          ImageWidget(widget.offer.pic),
          Container(
            color: Fonts.col_cl,
            child: new Container(
                color: Fonts.col_cl,
                padding: new EdgeInsets.all(16.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (BuildContext context) {
                                return new PartnerCardDetails(
                                    widget.offer.partner,
                                    widget.lat,
                                    widget.lng,
                                    widget.user,
                                    widget.onLocaleChange);
                              }));
                        },
                        child: new ClipOval(
                            child: new Container(
                                color: Fonts.col_app,
                                width: MediaQuery.of(context).size.width * 0.12,
                                height:
                                MediaQuery.of(context).size.width * 0.12,
                                child: new Center(
                                    child: FadingImage.network(
                                      widget.offer.partner.logo,
                                      width:
                                      MediaQuery.of(context).size.width * 0.12,
                                      height:
                                      MediaQuery.of(context).size.width * 0.12,
                                      fit: BoxFit.cover,
                                    ))))),
                    new Container(
                      width: 8.0,
                    ),
                    new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width * 0.63,
                            child: new Text(widget.offer.partner.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: new TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w600,
                                    fontSize: ScreenUtil().setSp(15)))),
                        new Container(height: 0.0),
                        ScopedModelDescendant<AppModel1>(
                            builder: (context, child, model) =>
                            widget.offer.sponsorise != 1
                                ? new Text(
                              ta.format(widget.offer.create,
                                  locale: model.locale == "ar"
                                      ? "ar"
                                      : "fr"),
                              style: new TextStyle(
                                  color: Fonts.col_grey,
                                  //  fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil().setSp(15)),
                            )
                                : Row(
                              children: <Widget>[
                                Text(
                                  "Sponsorisé",
                                  style: TextStyle(
                                      color: Fonts.col_grey,
                                      fontSize:
                                      ScreenUtil().setSp(15),
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  width: 4,
                                ),
                                Image.asset(
                                  "images/spon.png",
                                  color: Fonts.col_grey,
                                  width: 18,
                                  height: 18,
                                )
                              ],
                            )),
                      ],
                    ),
                    new Expanded(child: new Container()),
                    widget.tpe != "1"
                        ? new Container(
                        child: new FavoriteButton(
                          widget.offer,
                          widget.user,
                          true,
                          func_update_likes,
                        ))
                        : new Container(),
                    Container(
                      width: 4,
                    )
                    /*  ButtonWidget(widget.offer, widget.user, ratefunc,
                        widget.lat, widget.lng, widget.onLocaleChange)*/
                  ],
                )),
          ),
          Container(
            height: 8,
          ),
          widget.offer.type == "event"
              ? new Container(
            padding: new EdgeInsets.only(
                top: 6.0, bottom: 6.0, left: 16.0, right: 16.0),
            width: width * 0.64,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Container(
                  width: 4.0,
                ),

                // new Container(width: height*0.05),
              ],
            ),
          )
              : Container(),
          new Container(
            padding: new EdgeInsets.only(left: 24.0, right: 24.0),
            child: Text(
              widget.offer.name,
              style: new TextStyle(
                  color: Colors.blueGrey[800], fontWeight: FontWeight.bold),
            ),
          ),
          new Container(height: 8.0),
          widget.offer.urlVideo == "" || widget.offer.urlVideo.toString() == "null"
              ? Container()
              :  (Container(
            // padding: EdgeInsets.only(top: 8.h, bottom: 4.h),
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 8.0.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: YtbeVideo(regex.firstMatch(widget.offer.urlVideo).group(1),widget.offer.urlVideo)))

          /*GestureDetector(
              onTap: () {
                print("dhidhid");
                playYoutubeVideo();

              },
              child: new Container(
                padding: EdgeInsets.only(left: 16.0,right: 16.0),
                  width: width * 0.63,
                  child: new Text(
                      widget.offer.urlVideo == ""
                          ? ""
                          : widget.offer.urlVideo,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: new TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline))
              ))*/,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.end,
              children: widget.offer.categories
                  .map((e) => Padding(
                padding: EdgeInsets.only(right: 4),
                child: Chip(

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(12))),
                  backgroundColor: Fonts.col_app,
                  label: Text(
                    e,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ))
                  .toList(),
            ),
          ),
          new Container(
              padding: new EdgeInsets.only(left: 16.0, right: 16.0),
              child: HtmlWidget(
                widget.offer.description
                    .toString()
                    .replaceAll(RegExp(r'(\\n)+'), ''),
              )),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.end,
              children: widget.offer.tags
                  .map((e) => Padding(
                padding: EdgeInsets.only(right: 4),
                child: Chip(

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(12))),
                  backgroundColor: Fonts.col_app.withOpacity(0.1),
                  label: Text(
                    e,
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ))
                  .toList(),
            ),
          ),
          Container(height: 12,),

          InkWell(
            onTap: () {
              if (Platform.isIOS)
                Navigator.push(context, new MaterialPageRoute<String>(
                    builder: (BuildContext context) {
                      return new WebviewScaffold(
                        url: widget.offer.docUrl,
                        withZoom: true, // zoom
                        hidden: true,
                        appBar: new AppBar(
                          title: new Text(""),
                        ),
                      );
                    }));
            },
            child: Row(
              children: <Widget>[
                Container(width: 6),
                widget.offer.docUrl.toString() == "null" ||
                    widget.offer.docUrl == ""
                    ? Container()
                    : IconButton(
                  iconSize: 42,
                  icon: CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.blue[500],
                      child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Image.asset(
                            "images/pdf.png",
                            color: Colors.white,
                            width: 28,
                            height: 28,
                          ))),
                  onPressed: () {

                    Navigator.push(context, new MaterialPageRoute<String>(
                        builder: (BuildContext context) {
                          return PdfWiget(
                            widget.offer.docUrl,
                            0,
                            title: widget.offer.name,
                          );
                        }));
                    /*  if (Platform.isIOS)
                            Navigator.push(context,
                                new MaterialPageRoute<String>(
                                    builder: (BuildContext context) {
                              return new WebviewScaffold(
                                url: widget.offer.docUrl,
                                appBar: new AppBar(
                                  title: new Text(""),
                                ),
                              );
                            }));
                          else
                            Navigator.push(
                              context,
                              new MaterialPageRoute<String>(
                                builder: (BuildContext context) {
                                  return new Scaffold(
                                    appBar: AppBar(
                                      title: new Text(
                                        widget.offer.name,
                                      ),
                                    ),
                                    body: SimplePdfViewerWidget(
                                      completeCallback: (bool result) {
                                        print(
                                            "completeCallback,result:${result}");
                                      },
                                      initialUrl: widget.offer.docUrl,
                                    ),
                                  );
                                },
                              ),
                            );*/
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
