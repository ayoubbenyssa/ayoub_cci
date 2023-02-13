import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:mycgem/cards/buy_button.dart';
import 'package:mycgem/cards/details_partner.dart';
import 'package:mycgem/cards/prom_details.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/offers.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/youtube_service.dart';
import 'package:mycgem/user/details_user.dart';
import 'package:mycgem/widgets/common.dart';
import 'package:mycgem/widgets/image_widget.dart';
import 'package:mycgem/widgets/pdf_widget.dart';
import 'package:mycgem/widgets/youtube_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class PromotionsCard extends StatefulWidget {
  PromotionsCard(this.promo, this.user, this.show, this.show_im, this.chng,
      {this.verify});

  Offers promo;
  User user;

  bool show = false;
  bool show_im = true;
  double lat;
  double lng;
  var verify;
  var chng;

  @override
  _PromotionsCardState createState() => _PromotionsCardState();
}

class _PromotionsCardState extends State<PromotionsCard> {
//Promo_details

  String link_img = "", link_title = "";

  /*getLink() {
    GetLinkData.getLink(widget.promo.urlVideo).then((vall) {
      setState(() {
        link_img = vall["image"];
        link_title = vall["title"];
      });
    });
  }*/



  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    // getLink();
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
    var lat = widget.promo.latLng.toString().split(";")[0];
    var lng = widget.promo.latLng.toString().split(";")[1];
    _launched = _launch('https://www.google.com/maps/@$lat,$lng,16z');
  }

  void playYoutubeVideo() {
    Navigator.push(context,
        new MaterialPageRoute<String>(builder: (BuildContext context) {
          return new WebviewScaffold(
            url: widget.promo.urlVideo,
            withZoom: true,   // zoom
            hidden: true,
            appBar: new AppBar(
              title: new Text(""),
            ),
          );
        }));
  }

  tell() {
    /// _launched = _launch('tel:' + widget.promo.partner.tels);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    var style = new TextStyle(color: Fonts.col_app_fon, fontSize: 12.0);

    return Card(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
              padding: new EdgeInsets.all(6.0),
              // width: width * 0.64,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new GestureDetector(
                      onTap: () {
                        Navigator.push(context, new MaterialPageRoute(
                            builder: (BuildContext context) {
                              return new PartnerCardDetails(
                                widget.promo.partner,
                                widget.lat,
                                widget.lng,
                                widget.user,
                                widget.chng,
                              );
                            }));

                        /* Navigator.push(context, new MaterialPageRoute(
                            builder: (BuildContext context) {
                          return new ShopCardDetails(
                              widget.promo.partner.partnerKey.toString());
                        }));*/
                      },
                      child: new ClipOval(
                          child: widget.promo.partner == null
                              ? Container()
                              : new Container(
                              color: Fonts.col_app,
                              width: 46.0,
                              height: 46.0,
                              child: new Center(
                                  child: FadingImage.network(
                                    widget.promo.partner.im,
                                    width: 46.0,
                                    height: 46.0,
                                    fit: BoxFit.cover,
                                  ))))),
                  new Container(
                    width: 8.0,
                  ),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                          widget.promo.partner == null
                              ? ""
                              : widget.promo.partner.name,
                          style: new TextStyle(
                              color: Fonts.col_app,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.5)),
                      new Container(
                        height: 4.0,
                      ),
                      new Container(
                          width: width * 0.60,
                          child: new Text(
                            widget.promo.partner ==null?"" : widget.promo.partner.address,
                            overflow: TextOverflow.ellipsis,
                            style: new TextStyle(
                                color: Colors.grey[600],
                                //  fontWeight: FontWeight.bold,
                                fontSize: 11.0),
                          )),
                    ],
                  ),

                  // new Container(width: height*0.05),
                ],
              )),
          new Container(
              color: Colors.white,
              // height: 300.0,

              height: 355.0.h,
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.63,
                  maxWidth: MediaQuery.of(context).size.width * 0.98),
              child: !widget.show
                  ? GestureDetector(
                  onTap: () {
                    if (widget.show_im)
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (BuildContext context) {
                            return new Promo_details(
                              widget.promo,
                              widget.user,
                              widget.lat,
                              widget.lng,
                              widget.chng,
                            );
                          }));
                    else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullScreenWrapper(
                              imageProvider: NetworkImage(
                                  widget.promo.pic[0].toString()),
                            ),
                          ));
                    }
                  },
                  child: new Stack(fit: StackFit.expand, children: <Widget>[
                    ImageWidget(widget.promo.pic),
                    Positioned(
                      top: MediaQuery.of(context).size.width * 0.085,
                      right: MediaQuery.of(context).size.width * 0.085,
                      child: widget.promo.pic.length > 3
                          ? new Text(
                        "+" +
                            (widget.promo.pic.length - 3).toString(),
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
                    /**
                        Positioned(
                        bottom: 4,
                        right: 4,
                        child: widget.promo.partner.phone.toString() == "null"
                        ? Container()
                        : IconButton(
                        iconSize: 42,
                        icon: CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.green[500],
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
                        /*widget.promo.rate.toString() != "" &&
                        widget.promo.rate.toString() != "null"
                        ? Text(widget.promo.rate + "%")
                        : Container()*/
                        ,
                        ),
                     */
                    Positioned(
                      top: MediaQuery.of(context).size.width * 0.085,
                      right: MediaQuery.of(context).size.width * 0.085,
                      child: widget.promo.pic.length > 3
                          ? new Text(
                        "+" +
                            (widget.promo.pic.length - 3).toString(),
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
                      child:  IconButton(
                        iconSize: 42,
                        icon: CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.orange[500],
                            child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Image.asset(
                                  "images/pdf.png",
                                  color: Colors.white,
                                  width: 28,
                                  height: 28,
                                ))),
                        onPressed: () async{
                          widget.promo.tarif_url = widget.promo.service["lien"];


                          Navigator.push(context,
                              new MaterialPageRoute<String>(
                                  builder: (BuildContext context) {
                                    return PdfWiget(widget.promo.tarif_url,widget.promo.page_number);
                                  }));

                        },
                      )
                      /*widget.promo.rate.toString() != "" &&
                                  widget.promo.rate.toString() != "null"
                              ? Text(widget.promo.rate + "%")
                              : Container()*/
                      ,
                    ),

                    /*

                         CircleAvatar(
                      backgroundColor: Colors.amber[400],
                      child:  InkWell(
                          onTap: ()  {
                            Navigator.push(context, new MaterialPageRoute<String>(
                                builder: (BuildContext context) {
                                  return new  Scaffold(
                                    appBar: AppBar(
                                      title: new Text(widget.an.name),
                                    ),
                                    body: SimplePdfViewerWidget(
                                      completeCallback: (bool result){
                                        print("completeCallback,result:${result}");
                                      },
                                      initialUrl: widget.an.docUrl,
                                    ),
                                  );
                                }));
                          },
                          child: new Image.asset(
                            "images/pdf.png",
                            color: Colors.black,
                            width: 18.0,
                            height: 18.0,
                          )))
                         */
                    Positioned(
                      bottom: 12,
                      left: 12,
                      child:widget.promo.sector != "" &&
                          widget.promo.sector.toString() != "null"
                          ? new Container(
                          padding: EdgeInsets.all(8),
                          //alignment: Alignment.center,
                          decoration: new BoxDecoration(
                            color: HexColor(widget.promo.sector['color']),
                            borderRadius:
                            new BorderRadius.circular(4.0),
                          ),
                          child: Text(widget.promo.sector['name'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)))
                          : Container(),
                    )
                  ]))
                  : ImageWidget(widget.promo.pic)),
          new Container(
            height: 8.0,
          ),
          new Container(
              padding: new EdgeInsets.all(12.0),
              child: new Text(widget.promo.name.toString(),
                  style: new TextStyle(
                      fontSize: 13.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold))),

/*          Row(
            children: <Widget>[
              widget.promo.partner.phone.toString() == "null"
                  ? Container()
                  : new Container(
                      padding: new EdgeInsets.only(left:12.0,right: 12),
                      child: new Text("Numéro de téléphone:   ",
                          style: new TextStyle(
                              fontSize: 13.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold))),
              widget.promo.partner.phone.toString() == "null"
                  ? Container()
                  : new Container(
                      padding: new EdgeInsets.all(12.0),
                      child: new Text(widget.promo.partner.phone,
                          style: new TextStyle(
                              fontSize: 13.0,
                              color: Colors.blueGrey[800],
                              fontWeight: FontWeight.w500))),
            ],
          ),*/

          // Container(height: 4,),

          widget.show
              ? Container(
            height: 8.0,
          )
              : Container(),

          widget.show
              ? link_title == ""
              ? Container()
              : YoutubeWidget(link_title, link_img, widget.promo.urlVideo,
              playYoutubeVideo)
          /*GestureDetector(
              onTap: () {
                print("dhidhid");
                playYoutubeVideo();

              },
              child: new Container(
                  padding: EdgeInsets.only(left: 8.0,right: 8.0),
                  width: width * 0.63,
                  child: new Text(
                      widget.promo.urlVideo == ""
                          ? ""
                          : widget.promo.urlVideo,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: new TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline))
              ))*/
              : Container(),


          new Container(
            height: 8.0,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ///  BuyButton(widget.promo, widget.user, false, verify: widget.verify)
            ],
          ),
          new Container(
            height: 8.0,
          ),
        ],
      ),
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}