import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';
import 'package:mycgem/cards/header_card.dart';
import 'package:mycgem/fils_actualit/card_footer.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/offers.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/block.dart';
import 'package:mycgem/widgets/app_appbar.dart';
import 'package:mycgem/widgets/image_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class OppCard extends StatefulWidget {
  OppCard(this.offer, this.user, this.lat, this.lng, this.context, this.bl,
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

class _ParcPubCardState extends State<OppCard> {
  ParseServer parse_s = new ParseServer();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    delete() async {
      await parse_s.deleteparse("offers/" + widget.offer.objectId);
      setState(() {
        widget.offer.delete = true;
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

    compare_dates() {

      print(widget.offer.hour);
      int minutes =  DateTime.fromMillisecondsSinceEpoch(widget.offer.activatedDate).minute;
      int hours =  DateTime.fromMillisecondsSinceEpoch(widget.offer.activatedDate).minute;

      DateTime event = DateTime.fromMillisecondsSinceEpoch(widget.offer.activatedDate);
      DateTime time = new DateTime(
          event.year, event.month, event.day, hours + 2, minutes, 0, 0, 0);

      if (DateTime.now().isBefore(time))
        return false;
      else
        return true;
    }

    block_user() async {
      await Block.insert_block(
          widget.user.auth_id,
          widget.offer.author1.auth_id,
          widget.user.id,
          widget.offer.author1.id);
      await Block.insert_block(widget.offer.author1.auth_id,
          widget.user.auth_id, widget.offer.author1.id, widget.user.id);

      setState(() {
        widget.user.show = false;
      });
    }

    ratefunc() {}

    List<Widget> op = [
      HeaderCard(widget.offer, widget.user, widget.lat, widget.lng, widget.chng,
          block_user, ratefunc),
      widget.offer.pic.toString() != "null" &&
              widget.offer.pic.toString() != "[]"
          ? Container(
              color: Colors.grey[200],
              // constraints: ConstrainedBox(constraints: null),
              //height: MediaQuery.of(context).size.height*0.42,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.63,
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
                          "+" + (widget.offer.pic.length - 3).toString(),
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
                      ? widget.offer.partner.phone.toString() == "null"
                          ? Container()
                          : IconButton(
                              iconSize: 42,
                              icon: CircleAvatar(
                                  radius: 28,
                                  backgroundColor: Fonts.col_app,
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
                                      builder: (BuildContext context) {
                                return new WebviewScaffold(
                                  url: widget.offer.docUrl,
                                  withJavascript: true,
                                  withZoom: true,
                                  // zoom
                                  hidden: true,
                                  appBar: new AppBar(
                                    title: new Text(widget.offer.name),
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
                                color: Fonts.col_app.withOpacity(0.8),
                                borderRadius: new BorderRadius.circular(4.0),
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
      InkWell(
        onTap: () {
          if (widget.bl == false)
            Navigator.push(context,
                new MaterialPageRoute(builder: (BuildContext context) {
              return new OppCard(widget.offer, widget.user, widget.lat,
                  widget.lng, context, true, widget.chng);
            }));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 4,
              ),
              /**
                  Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  widget.offer.type_offre_or_demande
                  .toString() ==
                  "null"
                  ? Container()
                  : Container(
                  padding: EdgeInsets.all(6),
                  decoration: new BoxDecoration(
                  color: widget.offer.type_offre_or_demande ==
                  "Offre"
                  ? Fonts.col_app.withOpacity(0.1)
                  : Fonts.col_gr.withOpacity(0.1),
                  border: new Border.all(
                  color: widget.offer.type_offre_or_demande ==
                  "Offre"
                  ? Fonts.col_app
                  : Fonts.col_gr,
                  width: 1.5),
                  borderRadius:
                  new BorderRadius.circular(
                  8.0),
                  ),
                  child: Text(
                  widget.offer.type_offre_or_demande
                  .toString() ==
                  "null"
                  ? ""
                  : widget.offer
                  .type_offre_or_demande
                  .toString(),
                  style: Theme.of(context)
                  .textTheme
                  .display2
                  .copyWith(
                  fontSize: 16,
                  color: Fonts.col_app_fonn,
                  fontWeight:
                  FontWeight.w700,
                  height: 1.2),
                  ))
                  ],
                  ),
               */
              Container(height: 8),
              Text(
                widget.offer.name,
                maxLines: 10,
                style: TextStyle(
                    fontSize: 15.5.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    height: 1.2),
              ),
              Container(
                height: 12,
              ),
              Row(
                children: <Widget>[
                  Text(
                    LinkomTexts.of(context).typ() + ": ",
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w700,
                        height: 1.2),
                  ),
                  Container(
                    width: 8,
                  ),
                  Text(
                    widget.offer.type_op == "RC"
                        ? "Recherche de collaboration"
                        : widget.offer.type_op,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 16.0.sp,
                        color: Fonts.col_app,
                        fontWeight: FontWeight.w700,
                        height: 1.2),
                  ),
                ],
              ),
              Container(
                height: 8,
              ),
              compare_dates()==true?   Row(
                children: <Widget>[
                  Text(
                    "Expiré le : ",
                    maxLines: 2,
                    style: Theme.of(context).textTheme.display2.copyWith(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        height: 1.2),
                  ),
                  widget.offer.activatedDate.toString() == "null"
                      ? Container()
                      : Text(
                    new DateFormat('dd-MM-yyyy').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            widget.offer.activatedDate)),
                    maxLines: 2,
                    style: Theme.of(context).textTheme.display2.copyWith(
                        fontSize: 14,
                        color: const Color(0xffff374e),
                        fontWeight: FontWeight.w600,
                        height: 1.2),
                  ),
                ],
              ): Row(
                children: <Widget>[
                  Text(
                    LinkomTexts.of(context).valid() + ":  ",
                    maxLines: 2,
                    style: Theme.of(context).textTheme.display2.copyWith(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        height: 1.2),
                  ),
                  widget.offer.activatedDate.toString() == "null"
                      ? Container()
                      : Text(
                          new DateFormat('dd-MM-yyyy').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  widget.offer.activatedDate)),
                          maxLines: 2,
                          style: Theme.of(context).textTheme.display2.copyWith(
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
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          LinkomTexts.of(context).budget() + ":  ",
                          maxLines: 2,
                          style: Theme.of(context).textTheme.display2.copyWith(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              height: 1.2),
                        ),
                        (widget.offer.budget.toString() == "null" ||
                                widget.offer.budget.toString() == "")
                            ? Container()
                            : Text(
                                widget.offer.budget + " Dhs",
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
                  /*  Expanded(
                                      child: Container(),
                                    ),*/
                ],
              ),
              Container(
                height: 8,
              ),
              widget.bl == true
                  ? HtmlWidget(widget.offer.description.toString() == "null"
                      ? ""
                      : widget.offer.description)
                  : Container(),
              Container(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  widget.bl == false
                      ? InkWell(
                          child: Text(
                            LinkomTexts.of(context).details() + " ..",
                            style: TextStyle(
                                color: Fonts.col_app,
                                fontWeight: FontWeight.w800,
                                decoration: TextDecoration.underline,
                                fontSize: 16),
                          ),
                        )
                      : Container(),
                ],
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
      CardFooter(widget.offer, widget.user, delete, context, widget.listp, null,
          widget.lat, widget.lng, widget.chng)
    ];

    return widget.bl == true
        ? Scaffold(
            appBar: MyCgemBarApp(
              widget.offer.name,
              actionswidget: Container(),
            ),
            body: ListView(children: op),
          )
        : widget.offer.delete
            ? Container()
            : Container(
                padding: new EdgeInsets.only(left: 8.0, right: 8, top: 8),
                child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    child: Container(
                        // height: ScreenUtil().setHeight(236.0),

                        child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            child: Column(children: op)))));
  }
}
