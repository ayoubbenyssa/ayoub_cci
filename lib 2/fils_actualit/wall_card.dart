import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:mycgem/annonces/annonces_tabs.dart';
import 'package:mycgem/annonces/details_annonce.dart';
import 'package:mycgem/cards/details_parc.dart';
import 'package:mycgem/cards/header_card.dart';
import 'package:mycgem/cards/prom_details.dart';
import 'package:mycgem/fils_actualit/card_footer.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/home/opportunite.dart';
import 'package:mycgem/home/events.dart';
import 'package:mycgem/home/publications.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/offers.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/products/products_services.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/block.dart';
import 'package:mycgem/widgets/image_widget.dart';

//import 'package:simple_pdf_viewer/simple_pdf_viewer.dart';
import 'package:url_launcher/url_launcher.dart';

class Wall_card extends StatefulWidget {
  Wall_card(this.offers, this.user, this.list, this.lat, this.lng,
      this.analytics, this.chng);

  Offers offers;
  User user;
  var list;
  var lat;
  var lng;
  var analytics;
  var chng;

  @override
  _Wall_carState createState() => _Wall_carState();
}

class _Wall_carState extends State<Wall_card> {
  ParseServer parse_s = new ParseServer();

  delete() async {
    await parse_s.deleteparse("offers/" + widget.offers.objectId);
    setState(() {
      widget.offers.delete = true;
    });
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

  block_user() async {
    await Block.insert_block(widget.user.auth_id, widget.offers.author1.auth_id,
        widget.user.id, widget.offers.author1.id);
    await Block.insert_block(widget.offers.author1.auth_id, widget.user.auth_id,
        widget.offers.author1.id, widget.user.id);

    setState(() {
      widget.user.show = false;
    });
  }

  //

// Mission
//Hébergement
  //Objets perdus

  tap() {
    if (widget.offers.type == "Mission_raja" ||
        widget.offers.type == "Objets perdus_raja" ||
        widget.offers.type == "Hébergement_raja" ||
        widget.offers.type == "Annonces") {
      Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) {
            return new DetailsAnnonce(widget.offers, widget.user, widget.list, null,
                widget.analytics, widget.chng);
          }));
    } else if (widget.offers.type == "news" || widget.offers.type == "event") {
      Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) {
            return new DetailsParc(
                widget.offers,
                widget.user,
                widget.offers.type,
                widget.list,
                null,
                widget.analytics,
                widget.chng,
                widget.lat,
                widget.lng);
          }));
    } else if (widget.offers.type == "promotion") {
      Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) {
            return new Promo_details(
              widget.offers,
              widget.user,
              widget.lat,
              widget.lng,
              widget.chng,
            );
          }));
    }
  }

  var st = TextStyle(
      color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14.5.sp);

  Widget text_desc() => Container(
    padding: EdgeInsets.only(left: 16.0, right: 16, top: 12, bottom: 12),
    color: widget.offers.pic.toString() != "null" &&
        widget.offers.pic.toString() != "[]"
        ? Fonts.col_cl.withOpacity(0.5)
        : Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                widget.offers.title.toString() == "null"
                    ? Container()
                    : InkWell(
                    onTap: () {
                      tap();

                      ///ji
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.82,
                        child: new Text(
                          widget.offers.title.toString() == "null"
                              ? ""
                              : widget.offers.title.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: ScreenUtil().setSp(14.5),
                            fontWeight: FontWeight.w700,
                          ),
                        ))),
                widget.offers.items.toString() == "null"
                    ? InkWell(
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.86,
                        child: new Text(
                          widget.offers.name.toString() == "null"
                              ? widget.offers.description.toString()
                              : widget.offers.name.toString(),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize:
                            widget.offers.name.toString() == "null"
                                ? ScreenUtil().setSp(14.5)
                                : ScreenUtil().setSp(14.5),
                            fontWeight:
                            widget.offers.name.toString() == "null"
                                ? FontWeight.w500
                                : FontWeight.bold,
                          ),
                        )))
                    : Container(),
                Container(
                  height: 4,
                ),
                widget.offers.summary.toString() == "null"
                    ? Container()
                    : InkWell(
                    onTap: () {
                      tap();

                      ///ji
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.82,
                        child: new Text(
                          widget.offers.summary.toString() == "null"
                              ? ""
                              : widget.offers.summary.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                          TextStyle(fontSize: ScreenUtil().setSp(14.5)),
                        ))),
              ],
            )),

        //wid()
      ],
    ),
  );

  void playYoutubeVideo(text) {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(
        "****************************************************************************");
    print(widget.offers.pic);
  }

  @override
  Widget build(BuildContext context) {
    var textcat = new TextStyle(color: Colors.grey[700], fontSize: 12.0);

    getLinWidget() {
      if (widget.offers.items.toString() == "null" ||
          widget.offers.items == []) {
        return Container();
      } else {
        if (widget.offers.items.length == 1) {
          return new GestureDetector(
              onTap: () {
                // _launched = _launch(post.link);
              },
              child: new Text(widget.offers.items[0],
                  style: new TextStyle(
                      wordSpacing: 1.0,
                      color: Colors.blue[700],
                      fontSize: 15.0,
                      fontWeight: FontWeight.w900)));
        } else {
          return new GestureDetector(
              onTap: () {
                print(widget.offers.items[0]);
                playYoutubeVideo(widget.offers.items[0]);
                //  _launched = _launch(items[0]);
              },
              child: new Container(
                  padding: EdgeInsets.only(top: 4),
                  child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        /* new Container(
                    padding: new EdgeInsets.only(left: 16.0, bottom: 8.0),
                    child: new Text(link1.title.toString(),
                        style: new TextStyle(color: Colors.grey[700]))),*/
                        new SizedBox(
                            height: 200.0,
                            child: new Stack(
                              children: <Widget>[
                                new Positioned.fill(
                                  child: new Image.network(
                                    widget.offers.items[1].toString(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                new Positioned(
                                    left: 2,
                                    right: 2,
                                    top: 2,
                                    bottom: 2,
                                    child: Image.asset("images/youtube.png"))
                              ],
                            )),
                        new Container(
                            color: Colors.grey[200],
                            padding: new EdgeInsets.only(
                                left: 16.0, bottom: 8.0, top: 8.0, right: 16),
                            child: new Text(widget.offers.items[3].toString(),
                                style: textcat)),
                        new Container(
                            width: 5000.0,
                            color: Colors.grey[200],
                            padding: new EdgeInsets.only(
                                left: 16.0, bottom: 8.0, right: 16),
                            child: new Text(widget.offers.items[2].toString(),
                                style: new TextStyle(
                                    color: Colors.grey[500], fontSize: 11.0)))
                      ])));
        }
      }
    }

    tell() {
      _launched = _launch('tel:' + widget.offers.partner.phone);
    }

    ratefunc() {}

    return widget.offers.delete
        ? Container()
        : Container(
      // color: Colors.blue[50],
        padding: new EdgeInsets.only(left: 8.0, right: 8, top: 8),
        child: new Material(
            elevation: 0,
            shadowColor: Fonts.col_app,
            borderRadius: new BorderRadius.circular(18.0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                HeaderCard(widget.offers, widget.user, widget.lat,
                    widget.lng, widget.chng, block_user, ratefunc),
                widget.offers.pic.toString() != "null" &&
                    widget.offers.pic.toString() != "[]"
                    ? Container(
                  color: Colors.grey[200],
                  // constraints: ConstrainedBox(constraints: null),
                  //height: MediaQuery.of(context).size.height*0.42,
                  constraints: BoxConstraints(
                    maxHeight:
                    MediaQuery.of(context).size.height * 0.63,
                    maxWidth:
                    MediaQuery.of(context).size.width * 0.98,
                    // minWidth: 150.0,
                  ),
                  child: Stack(children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          tap();
                        },
                        child: Container(
                            color: Colors.grey[200],
                            // height: MediaQuery.of(context).size.height*0.42,
                            child: ImageWidget(widget.offers.pic)
                          /* : new Swiper(
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return new Container(
                                                        color: Colors.grey[200],
                                                        child: Hero(
                                                            tag: widget.offers
                                                                .pic[index]
                                                                .toString(),
                                                            child:
                                                                new FadingImage
                                                                    .network(
                                                              widget
                                                                      .offers
                                                                      .pic[
                                                                          index]
                                                                      .toString()
                                                                  /*"http://via.placeholder.com/350x150"*/,
                                                              fit: BoxFit.cover,
                                                            )));
                                                  },
                                                  itemCount:
                                                      widget.offers.pic.length,
                                                  pagination:
                                                      new SwiperPagination(),
                                                  control: new SwiperControl(),
                                                )*/
                        )),
                    Positioned(
                      top: MediaQuery.of(context).size.width * 0.085,
                      right: MediaQuery.of(context).size.width * 0.09,
                      child: widget.offers.pic.length > 3
                          ? new Text(
                        "+" +
                            (widget.offers.pic.length - 3)
                                .toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w600),
                      )
                          : Container()
                      /*widget.promo.rate.toString() != "" &&
                                  widget.promo.rate.toString() != "null"
                              ? Text(widget.promo.rate + "%")
                              : Container()*/
                      ,
                    ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: widget.offers.type == "promotion" ||
                          widget.offers.type == "boutique"
                          ? widget.offers.partner.phone.toString() ==
                          "null"
                          ? Container()
                          : IconButton(
                        iconSize: 42,
                        icon: CircleAvatar(
                            radius: 28,
                            backgroundColor:
                            Colors.blue[500],
                            child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Image.asset(
                                  "images/tel.png",
                                  color: Colors.white,
                                  width: 28,
                                  height: 28,
                                ))),
                        onPressed: () {
                          tell();
                        },
                      )
                          : Container()
                      /*widget.promo.rate.toString() != "" &&
                                  widget.promo.rate.toString() != "null"
                              ? Text(widget.promo.rate + "%")
                              : Container()*/
                      ,
                    ),
                    /* Positioned(
                                bottom: 4,
                                right: 4,
                                child: widget.offers.docUrl.toString() !=
                                            "null" &&
                                        widget.offers.docUrl.toString() != ""
                                    ? IconButton(
                                        iconSize: 42,
                                        icon: CircleAvatar(
                                            radius: 28,
                                            backgroundColor: Fonts.col_gr,                                            child: Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Image.asset(
                                                  "images/pdf.png",
                                                  color: Colors.white,
                                                  width: 28,
                                                  height: 28,
                                                ))),
                                        onPressed: () {
                                          print("dhdhjkjkjkjkdhhd");
                                          if(Platform.isIOS == true)
                                          Navigator.push(context, new MaterialPageRoute<String>(
                                              builder: (BuildContext context) {
                                                return new WebviewScaffold(
                                                  url: widget.offers.docUrl,
                                                  withJavascript: true,
                                                  withZoom: true,   // zoom
                                                  hidden: true,
                                                  appBar: new AppBar(
                                                    title: new Text(widget.offers.name),
                                                  ),
                                                );
                                              }));
                                         /* else
                                            Navigator.push(context,
                                                new MaterialPageRoute<String>(
                                                    builder:
                                                        (BuildContext context) {
                                                      return new Scaffold(
                                                        appBar: AppBar(
                                                          title: new Text(
                                                            "",
                                                          ),
                                                        ),
                                                        body: SimplePdfViewerWidget(
                                                          completeCallback:
                                                              (bool result) {
                                                            print(
                                                                "completeCallback,result:${result}");
                                                          },
                                                          initialUrl:widget.offers.docUrl,
                                                        ),
                                                      );
                                                    }));*/
                                        },
                                      )
                                    : Container()*/
                    /*widget.promo.rate.toString() != "" &&
                                  widget.promo.rate.toString() != "null"
                              ? Text(widget.promo.rate + "%")
                              : Container()*/

                    Positioned(
                      bottom: 12,
                      left: 12,
                      child: widget.offers.type == "promotion" ||
                          widget.offers.type == "boutique"
                          ? widget.offers.rate.toString() != "" &&
                          widget.offers.rate.toString() !=
                              "null"
                          ? new Container(
                          padding: EdgeInsets.all(8),
                          //alignment: Alignment.center,
                          decoration: new BoxDecoration(
                            color: Fonts.col_app
                                .withOpacity(0.8),
                            borderRadius:
                            new BorderRadius.circular(
                                4.0),
                          ),
                          child: Text(widget.offers.rate,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight:
                                  FontWeight.bold)))
                          : Container()
                          : Container(),
                    )
                  ]),
                )
                    : new Container(),
                Row(
                  children: <Widget>[
                    Expanded(child: Container()),
                  ],
                ),

                Container(
                  child: Column(
                    children: <Widget>[
                      text_desc(),
                      Container(height: 4),
                      getLinWidget(),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    children: widget.offers.categories
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
                CardFooter(
                    widget.offers,
                    widget.user,
                    delete,
                    context,
                    widget.list,
                    widget.analytics,
                    widget.lat,
                    widget.lng,
                    widget.chng)
              ],
            )));
  }
}
