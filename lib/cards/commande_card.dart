import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';
import 'package:mycgem/annonces/details_annonce.dart';
import 'package:mycgem/cards/details_parc.dart';
import 'package:mycgem/cards/details_partner.dart';
import 'package:mycgem/fils_actualit/card_footer.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/language_params/scope_model_wrapper.dart';
import 'package:mycgem/models/offers.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/widgets/common.dart';
import 'package:mycgem/widgets/image_widget.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as ta;
import 'package:video_player/video_player.dart';

class CommCard extends StatefulWidget {
  CommCard(this.offer, this.user, this.lat, this.lng, this.context, this.bl,
      this.chng);

  Offers offer;
  User user;
  var listp;
  var auth;
  var analytics;
  var context;
  var lat;
  var lng;
  var bl;
  var chng;

  @override
  _ParcPubCardState createState() => _ParcPubCardState();
}

class _ParcPubCardState extends State<CommCard> {
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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

    Widget op = Container(
      margin: EdgeInsets.all(8),
      child: Material(
        color: Colors.white,
        elevation: 2,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Container(
          // height: ScreenUtil().setHeight(236.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child: Column(
              children: <Widget>[
                new Container(
                    color: Fonts.col_app.withOpacity(0.05),
                    padding: new EdgeInsets.all(8.0),
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
                                  widget.chng,
                                );
                              }));
                            },
                            child: new ClipOval(
                                child: new Container(
                                    color: Fonts.col_app,
                                    width: 42.0,
                                    height: 42.0,
                                    child: new Center(
                                        child: FadingImage.network(
                                      widget.offer.partner.logo,
                                      width: 42.0,
                                      height: 42.0,
                                      fit: BoxFit.cover,
                                    ))))),
                        new Container(
                          width: 8.0,
                        ),
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: new Text(widget.offer.partner.name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: new TextStyle(
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11.5))),
                            new Container(height: 2.0),
                            ScopedModelDescendant<AppModel1>(
                                builder: (context, child, model) => new Text(
                                      ta.format(widget.offer.create,
                                          locale: model.locale == "ar"
                                              ? "ar"
                                              : "fr"),
                                      style: new TextStyle(
                                          color: Colors.grey[600],
                                          //  fontWeight: FontWeight.bold,
                                          fontSize: 11.0),
                                    )),
                          ],
                        ),
                        new Expanded(child: new Container()),

                        //type()
                        /* widget.offers.pic.isEmpty
                            ? MenuCard(
                            widget.offers, widget.user, delete, Colors.black)*/
                        //   : Container()
                      ],
                    )),
                InkWell(
                    onTap: () {
                      if (widget.bl == false)
                        Navigator.push(context, new MaterialPageRoute(
                            builder: (BuildContext context) {
                          return new CommCard(
                              widget.offer,
                              widget.user,
                              widget.lat,
                              widget.lng,
                              context,
                              true,
                              widget.chng);
                        }));
                    },
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Container(
                                  height: 4,
                                ),
                                Text(
                                  widget.offer.name.toString(),
                                  maxLines: 2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .display2
                                      .copyWith(
                                          fontSize: 15.5,
                                          color: Fonts.col_app_fonn,
                                          fontWeight: FontWeight.w700,
                                          height: 1.2),
                                ),
                                Container(
                                  height: 8,
                                ),
                                Row(
                                  children: <Widget>[
                                    /* Text(
                                      LinkomTexts.of(context).typ()+": ",
                                      maxLines: 2,
                                      style: Theme.of(context)
                                          .textTheme
                                          .display2
                                          .copyWith(
                                          fontSize: 14,
                                          color: Colors.grey[800],
                                          fontWeight: FontWeight.w900,
                                          height: 1.2),
                                    ),
                                    Container(
                                      width: 8,
                                    ),
                                    Text(
                                      widget.offer.type_op.toString(),
                                      maxLines: 2,
                                      style: Theme.of(context)
                                          .textTheme
                                          .display2
                                          .copyWith(
                                          fontSize: 14,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600,
                                          height: 1.2),
                                    ),*/
                                  ],
                                ),
                                Container(
                                  height: 8,
                                ),
                                widget.offer.pic.toString() != "null" &&
                                        widget.offer.pic.toString() != "[]"
                                    ? Container(
                                        color: Colors.grey[200],
                                        // constraints: ConstrainedBox(constraints: null),
                                        //height: MediaQuery.of(context).size.height*0.42,
                                        constraints: BoxConstraints(
                                          maxHeight: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.63,
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.98,
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
                                                  child: ImageWidget(
                                                      widget.offer.pic)
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
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.085,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.09,
                                            child: widget.offer.pic.length > 3
                                                ? new Text(
                                                    "+" +
                                                        (widget.offer.pic
                                                                    .length -
                                                                3)
                                                            .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 32,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )
                                                : Container()
                                            /*widget.promo.rate.toString() != "" &&
                                  widget.promo.rate.toString() != "null"
                              ? Text(widget.promo.rate + "%")
                              : Container()*/
                                            ,
                                          ),
                                          /**
                                              Positioned(
                                              bottom: 4,
                                              right: 4,
                                              child: widget.offer.type ==
                                              "promotion" ||
                                              widget.offer.type ==
                                              "boutique"
                                              ? widget.offer.partner.phone
                                              .toString() ==
                                              "null"
                                              ? Container()
                                              : IconButton(
                                              iconSize: 42,
                                              icon: CircleAvatar(
                                              radius: 28,
                                              backgroundColor:
                                              Colors
                                              .blue[500],
                                              child: Padding(
                                              padding:
                                              EdgeInsets
                                              .all(8),
                                              child:
                                              Image.asset(
                                              "images/tel.png",
                                              color: Colors
                                              .white,
                                              width: 28,
                                              height: 28,
                                              ))),
                                              onPressed: () {},
                                              )
                                              : Container()
                                              /*widget.promo.rate.toString() != "" &&
                                              widget.promo.rate.toString() != "null"
                                              ? Text(widget.promo.rate + "%")
                                              : Container()*/
                                              ,
                                              ),
                                           */
                                          Positioned(
                                            bottom: 4,
                                            right: 4,
                                            child: widget.offer.docUrl
                                                            .toString() !=
                                                        "null" &&
                                                    widget.offer.docUrl
                                                            .toString() !=
                                                        ""
                                                ? IconButton(
                                                    iconSize: 42,
                                                    icon: CircleAvatar(
                                                        radius: 28,
                                                        // backgroundColor: Colors.orange[500],
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8),
                                                            child: Image.asset(
                                                              "images/pdf.png",
                                                              color:
                                                                  Colors.white,
                                                              width: 28,
                                                              height: 28,
                                                            ))),
                                                    onPressed: () {

                                                      Navigator.push(context, new MaterialPageRoute<String>(
                                                          builder: (BuildContext context) {
                                                            return new WebviewScaffold(
                                                              url: widget.offer.docUrl,
                                                              withZoom: true,   // zoom
                                                              hidden: true,
                                                              appBar: new AppBar(
                                                                title: new Text(widget.offer.name),
                                                              ),
                                                            );
                                                          }));


                                                    },
                                                  )
                                                : Container()
                                            /*widget.promo.rate.toString() != "" &&
                                  widget.promo.rate.toString() != "null"
                              ? Text(widget.promo.rate + "%")
                              : Container()*/
                                            ,
                                          ),
                                        ]),
                                      )
                                    : new Container(),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      LinkomTexts.of(context).valid() + ":  ",
                                      maxLines: 2,
                                      style: Theme.of(context)
                                          .textTheme
                                          .display2
                                          .copyWith(
                                              fontSize: 15,
                                              color: Fonts.col_app,
                                              fontWeight: FontWeight.w600,
                                              height: 1.2),
                                    ),
                                    Text(
                                      new DateFormat('dd-MM-yyyy')
                                          .format(widget.offer.create),
                                      maxLines: 2,
                                      style: Theme.of(context)
                                          .textTheme
                                          .display2
                                          .copyWith(
                                              fontSize: 14,
                                              color: const Color(0xffff374e),
                                              fontWeight: FontWeight.w600,
                                              height: 1.2),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 8,
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Fonts.col_app.withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            LinkomTexts.of(context).budget() +
                                                ":  ",
                                            maxLines: 2,
                                            style: Theme.of(context)
                                                .textTheme
                                                .display2
                                                .copyWith(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.2),
                                          ),
                                          Text(
                                            widget.offer.budget.toString() ==
                                                    "null"
                                                ? "0 Dhs"
                                                : widget.offer.budget + " Dhs",
                                            maxLines: 2,
                                            style: Theme.of(context)
                                                .textTheme
                                                .display2
                                                .copyWith(
                                                    fontSize: 14,
                                                    color: Colors.amber[700],
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.2),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(),
                                    ),
                                    /* Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.blue[50],
                                        borderRadius:
                                        BorderRadius.circular(6.0),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            LinkomTexts.of(context).caut()+ ":  ",
                                            maxLines: 2,
                                            style: Theme.of(context)
                                                .textTheme
                                                .display2
                                                .copyWith(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                height: 1.2),
                                          ),
                                          Text(
                                            widget.offer.cautions.toString() ==
                                                "null"
                                                ? "0 Dhs"
                                                : widget.offer.cautions
                                                .toString() +
                                                " Dhs",
                                            maxLines: 2,
                                            style: Theme.of(context)
                                                .textTheme
                                                .display2
                                                .copyWith(
                                                fontSize: 14,
                                                color: Colors.amber[700],
                                                fontWeight: FontWeight.w600,
                                                height: 1.2),
                                          ),
                                        ],
                                      ),
                                    )*/
                                  ],
                                ),
                                Container(
                                  height: 16,
                                ),
                                HtmlWidget(
                                  widget.bl == true
                                      ? widget.offer.description == ""
                                          ? ""
                                          : widget.offer.description
                                      : widget.offer.description == ""
                                          ? ""
                                          : widget.offer.description.length <
                                                  270
                                              ? widget.offer.description
                                              : widget.offer.description
                                                      .substring(0, 270) +
                                                  "..",

                                ),
                                Container(
                                  height: 8,
                                ),

                                /*
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.grey),
                             */

                                /*
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.grey),
                             */
                                Container(
                                  height: 12.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                Container(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Concurrents",
                          style: TextStyle(color: Fonts.col_app, fontSize: 18),
                        ),
                        Container(
                          height: 8,
                        ),
                        Row(
                          children: <Widget>[
                            new ClipOval(
                                child: new Container(
                                    color: Fonts.col_app,
                                    width: 55.0,
                                    height: 55.0,
                                    child: new Image.asset("images/icons/1.jpg",
                                        fit: BoxFit.cover))),
                            Container(
                              width: 12,
                            ),
                            new ClipOval(
                                child: new Container(
                                    color: Fonts.col_app,
                                    width: 55.0,
                                    height: 55.0,
                                    child: new Image.asset("images/icons/2.jpg",
                                        fit: BoxFit.cover))),
                            Container(
                              width: 12,
                            ),
                            new ClipOval(
                                child: new Container(
                                    color: Fonts.col_app,
                                    width: 55.0,
                                    height: 55.0,
                                    child: new Image.asset("images/icons/3.png",
                                        fit: BoxFit.cover))),

                            FlatButton(
                              onPressed: (){

                              },
                              child: Text(
                                "Voir tous",
                                style: TextStyle(
                                  fontSize: 16,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w900),
                              ),
                            )
                          ],
                        )
                      ],
                    )),
                Container(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                   Expanded(child: Container(),),
                    Container(
                      width: 12,
                    ),
                    RaisedButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.all(
                        Radius.circular(8.0),
                      )),
                      color: Fonts.col_app,
                      child: Text(
                        "POSTULER",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: () {},
                    ),
                   Container(
                     width: 12,
                   ),
                  ],
                ),
                CardFooter(widget.offer, widget.user, null, context,
                    widget.listp, null, widget.lat, widget.lng, widget.chng)
              ],
            ),
          ),
        ),
      ),
    );

    return widget.bl == true
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Fonts.col_app_shadow,
              elevation: 1,
              title: Text(
                widget.offer.name,
                style: TextStyle(color: Fonts.col_app_fonn, fontSize: 14),
              ),
            ),
            body: op,
          )
        : op;
  }
}
