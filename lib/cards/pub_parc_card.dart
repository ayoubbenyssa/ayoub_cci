import 'dart:async';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:intl/intl.dart';
import 'package:mycgem/cards/details_parc.dart';
import 'package:mycgem/fils_actualit/card_footer.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/home/events.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/offers.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/block.dart';
import 'package:mycgem/widgets/image_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'header_card.dart';

class ParcPubCard extends StatefulWidget {
  ParcPubCard(this.offer, this.user, this.tpe, this.listp, this.auth,
      this.analytics, this.context, this.lat, this.lng, this.onLocaleChange);

  Offers offer;
  User user;
  var tpe;
  var listp;
  var auth;
  var analytics;
  var context;
  double lat;
  double lng;
  var onLocaleChange;

  @override
  _ParcPubCardState createState() => _ParcPubCardState();
}

class _ParcPubCardState extends State<ParcPubCard> {
  ParseServer parse_s = new ParseServer();

  delete() async {
    await parse_s.deleteparse("offers/" + widget.offer.objectId);
    setState(() {
      widget.offer.delete = true;
    });
  }

  getnumbet() async {
    var idpost = widget.offer.objectId;

    var url =
        'participate?limit=0&&count=1&where={"post":{"\$inQuery":{"where":{"objectId":"$idpost"},"className":"offers"}}}';
    var a = await parse_s.getparse(url);
    if (!this.mounted) return;

    setState(() {
      widget.offer.numb = a["count"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getnumbet();
  }

  block_user() async {
    await Block.insert_block(widget.user.auth_id, widget.offer.author1.auth_id,
        widget.user.id, widget.offer.author1.id);
    await Block.insert_block(widget.offer.author1.auth_id, widget.user.auth_id,
        widget.offer.author1.id, widget.user.id);

    setState(() {
      widget.user.show = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    ratefunc(a) {
      setState(() {
        widget.offer = a;
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


    gotomap() {
      var lat = widget.offer.latLng.toString().split(";")[0];
      var lng = widget.offer.latLng.toString().split(";")[1];
      _launched = _launch('https://www.google.com/maps/@$lat,$lng,16z');
    }



    var st = TextStyle(
        color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14.5.sp);



    return widget.offer.delete
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
                children: <Widget>[
                  HeaderCard(widget.offer, widget.user, widget.lat, widget.lng,
                      widget.onLocaleChange, block_user, ratefunc),
                  widget.offer.pic.toString() != "null" &&
                          widget.offer.pic.toString() != "[]"
                      ? Container(
                          color: Colors.grey[200],
                          // constraints: ConstrainedBox(constraints: null),
                          //height: MediaQuery.of(context).size.height*0.42,
                          constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.63,
                            maxWidth: MediaQuery.of(context).size.width * 0.98,
                            // minWidth: 150.0,
                          ),
                          child: Stack(children: <Widget>[
                            GestureDetector(
                                onTap: () {
                                  //tap();
                                },
                                child: Container(
                                    color: Colors.grey[200],
                                    // height: MediaQuery.of(context).size.height*0.42,
                                    child: ImageWidget(widget.offer.pic)
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
                              child: widget.offer.pic.length > 3
                                  ? new Text(
                                      "+" +
                                          (widget.offer.pic.length - 3)
                                              .toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(14.5),
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
                              child: widget.offer.type == "promotion" ||
                                      widget.offer.type == "boutique"
                                  ? widget.offer.partner.phone.toString() ==
                                          "null"
                                      ? Container()
                                      : IconButton(
                                          iconSize: 42,
                                          icon: CircleAvatar(
                                              radius: 28,
                                              backgroundColor: Colors.blue[500],
                                              child: Padding(
                                                  padding: EdgeInsets.all(8),
                                                  child: Image.asset(
                                                    "images/tel.png",
                                                    color: Colors.white,
                                                    width: 28,
                                                    height: 28,
                                                  ))),
                                          onPressed: () {
                                            //tell();
                                          },
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
                              child: widget.offer.docUrl.toString() != "null" &&
                                      widget.offer.docUrl.toString() != ""
                                  ? IconButton(
                                      iconSize: 42,
                                      icon: CircleAvatar(
                                          radius: 28,
                                          backgroundColor: Fonts.col_gr,
                                          child: Padding(
                                              padding: EdgeInsets.all(8),
                                              child: Image.asset(
                                                "images/pdf.png",
                                                color: Colors.white,
                                                width: 28,
                                                height: 28,
                                              ))),
                                      onPressed: () {
                                        if (Platform.isIOS == true)
                                          Navigator.push(context,
                                              new MaterialPageRoute<String>(
                                                  builder:
                                                      (BuildContext context) {
                                            return new WebviewScaffold(
                                              url: widget.offer.docUrl,
                                              withJavascript: true,
                                              withZoom: true,
                                              // zoom
                                              hidden: true,
                                              appBar: new AppBar(
                                                title:
                                                    new Text(widget.offer.name),
                                              ),
                                            );
                                          }));
                                        /*else
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
                                                  initialUrl:widget.offer.docUrl,
                                                ),
                                              );
                                            }));*/
                                      },
                                    )
                                  : Container()

                              /*widget.promo.rate.toString() != "" &&
                                  widget.promo.rate.toString() != "null"
                              ? Text(widget.promo.rate + "%")
                              : Container()*/
                              ,
                            ),
                            Positioned(
                              bottom: 12,
                              left: 12,
                              child: widget.offer.type == "promotion" ||
                                      widget.offer.type == "boutique"
                                  ? widget.offer.rate.toString() != "" &&
                                          widget.offer.rate.toString() != "null"
                                      ? new Container(
                                          padding: EdgeInsets.all(8),
                                          //alignment: Alignment.center,
                                          decoration: new BoxDecoration(
                                            color:
                                                Fonts.col_app.withOpacity(0.8),
                                            borderRadius:
                                                new BorderRadius.circular(4.0),
                                          ),
                                          child: Text(widget.offer.rate,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)))
                                      : Container()
                                  : Container(),
                            )
                          ]),
                        )
                      : new Container(),
                  Container(
                    color: Fonts.col_cl,
                    child: Column(
                      children: <Widget>[
                        new InkWell(
                            // padding: EdgeInsets.all(0),
                            onTap: () {
                              Navigator.push(context, new MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return new DetailsParc(
                                    widget.offer,
                                    widget.user,
                                    widget.offer.type,
                                    [],
                                    null,
                                    widget.analytics,
                                    widget.onLocaleChange,
                                    widget.lat,
                                    widget.lng);
                              }));
                              /*  } else if (widget.an.type == "promotion") {

                        Navigator.push(context, new MaterialPageRoute(
                            builder: (BuildContext context) {
                              return new Promo_details(
                                  widget.an, widget.user,widget.lat,widget.lng);
                            }));
                      } else if (widget.an.type == "boutique") {
                        Navigator.push(context, new MaterialPageRoute(
                            builder: (BuildContext context) => ProductPage(widget.an,widget.user,widget.lat,widget.lng)));

                      }*/
                            },
                            child: Row(children: <Widget>[
                              /*  Stack(
                            children: <Widget>[
                          Container(
                              color: Colors.grey[100],
                              child: SizedBox(
                                child: widget.offer.pic.toString() != "null" &&
                                        widget.offer.pic.isNotEmpty
                                    ? Image.network(
                                        widget.offer.pic[0],
                                        fit: BoxFit.fitHeight,
                                      )
                                    : new Image.asset("images/logo.png",
                                        width: 65.0,
                                        height: 65.0,
                                        fit: BoxFit.contain),
                                width:
                                    ScreenUtil().setHeight(240.0),
                                height: ScreenUtil().setHeight(
                                    widget.offer.type == "event" ? 280 : 230.0),
                              )),

                          Positioned(
                            right: 8,
                            top: 8,
                            child: widget.tpe == true
                              ? RaisedButton(
                            color: const Color(0xffeae7f5),
                            padding: EdgeInsets.all(0),
                            shape: new RoundedRectangleBorder(
                                borderRadius:
                                new BorderRadius.circular(10.0)),
                            onPressed: () {
                              Navigator.push(context, new MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return new Events(
                                        widget.lat,
                                        widget.lng,
                                        widget.user,
                                        [],
                                        null,
                                        0,
                                        widget.analytics,
                                        widget.onLocaleChange);
                                  }));
                            },
                            child: Text(LinkomTexts.of(context).event(),
                                style: st),
                          )
                              : Container(),)
                          /* new Positioned(
                              top: 4.0,
                              left: 0.0,
                              child: widget.offer.sponsorise != 1
                                  ? Container()
                                  : new Container(
                                      padding: new EdgeInsets.only(
                                          left: 8.0,
                                          top: 6.0,
                                          bottom: 6.0,
                                          right: 6.0),
                                      decoration: new BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.0),
                                            topLeft: Radius.circular(0.0),
                                            bottomRight: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(0.0),
                                          ),
                                          gradient: new LinearGradient(
                                              colors: [
                                                Colors.grey[200],
                                                Colors.blue[100],
                                              ],
                                              begin: const FractionalOffset(
                                                  0.0, 0.0),
                                              end: const FractionalOffset(
                                                  1.0, 0.0),
                                              stops: [0.0, 1.0],
                                              tileMode: TileMode.clamp)),
                                      child: spons)),*/
                        ]),*/
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 16),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Container(
                                        height: 8.0,
                                      ),
                                      Text(
                                        widget.offer.name,
                                        maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .display2
                                            .copyWith(
                                              color: Colors.grey[800],
                                              fontSize: ScreenUtil().setSp(15),
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                      Text(
                                        widget.offer.summary.toString() ==
                                                "null"
                                            ? ""
                                            : widget.offer.summary,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: ScreenUtil().setSp(14.5)),
                                      ),
                                      Container(
                                        height: 8.0,
                                      ),
                                      widget.offer.type.contains("event")
                                          ? Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.date_range,
                                                  color: Fonts.col_app_fon,
                                                  size: 14.0,
                                                ),
                                                Container(
                                                  width: 4,
                                                ),
                                                new Text(
                                                  widget.offer.endDate == ""
                                                      ? ""
                                                      : new DateFormat(
                                                              'dd-MM-yyyy')
                                                          .format(DateTime
                                                              .fromMillisecondsSinceEpoch(
                                                                  widget.offer
                                                                      .endDate)),
                                                  style: new TextStyle(
                                                      color: Colors.grey[800],
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: ScreenUtil()
                                                          .setSp(12.5)),
                                                ),
                                                new Text(
                                                  widget.offer.hour
                                                                  .toString() !=
                                                              "null" &&
                                                          widget.offer.hour
                                                                  .toString() !=
                                                              ""
                                                      ? " à "
                                                      : "",
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.grey[800],
                                                      fontSize: ScreenUtil()
                                                          .setSp(12.5)),
                                                ),
                                                new Text(
                                                  widget.offer.hour
                                                              .toString() !=
                                                          "null"
                                                      ? widget.offer.hour
                                                          .toString()
                                                      : "",
                                                  style: new TextStyle(
                                                      color: Colors.grey[800],
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: ScreenUtil()
                                                          .setSp(12.5)),
                                                ),
                                                Expanded(child: Container()),

                                              ],
                                            )
                                          : Container(),
                                      Container(
                                        height: 8,
                                      ),
                                      /*

                                widget.offer.type != "prod_service" &&
                                        widget.offer.type != "news"
                                    ? widget.offer.dis ==
                                            "-.- " +
                                                LinkomTexts.of(context).km()
                                        ? Container()
                                        : new Container(
                                            width: width * 0.64,
                                            child: new Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                (widget.offer.dis ==
                                                    "-.- Km" || widget.offer.dis =="" )?Container():   new GestureDetector(
                                                    onTap: () {
                                                      gotomap();
                                                    },
                                                    child: new Container(
                                                        padding:
                                                            new EdgeInsets.only(
                                                                left: 2.0,
                                                                bottom: 2.0,
                                                                top: 2.0,
                                                                right: 2.0),
                                                        //  width: 150.0,
                                                        //alignment: Alignment.center,
                                                        decoration:
                                                            new BoxDecoration(
                                                          border:
                                                              new Border.all(
                                                                  color: Colors
                                                                      .blue,
                                                                  width: 0.5),
                                                          color: Colors
                                                              .transparent,
                                                          borderRadius:
                                                              new BorderRadius
                                                                      .circular(
                                                                  4.0),
                                                        ),
                                                        child:
                                                            new Row(children: <
                                                                Widget>[
                                                          new Icon(
                                                              Icons.directions,
                                                              color: Colors
                                                                  .blue[600],
                                                              size: 12.0),
                                                          new Container(
                                                            width: 4.0,
                                                          ),
                                                          new Text(
                                                            "Itinéraire",
                                                            style: new TextStyle(
                                                                color:
                                                                    Colors.blue,
                                                                fontSize: 11.5),
                                                          )
                                                        ]))),
                                                Expanded(
                                                  child: Container(),
                                                ),
                                                new GestureDetector(
                                                    onTap: () {
                                                      gotomap();
                                                    },
                                                    child: new Text(
                                                        widget.offer.dis
                                                            .toString(),
                                                        style: new TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 11.0))),
                                              ],
                                            ))
                                    : Container()



                                */
                                    ],
                                  ),
                                ),
                              ),
                            ])),
                        Container(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                  widget.offer.type.contains("event")
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[],
                        )
                      : Container(),
                  CardFooter(
                      widget.offer,
                      widget.user,
                      delete,
                      context,
                      widget.listp,
                      null,
                      widget.lat,
                      widget.lng,
                      widget.onLocaleChange,
                      ratefunc: ratefunc)
                ],
              ),
            ),
          );
  }
}
