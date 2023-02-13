import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:mycgem/cards/promotion_card.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/offers.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';

class Promo_details extends StatefulWidget {
  Promo_details(this.promo, this.user, this.lat, this.lng, this.chng);

  Offers promo;
  User user;
  double lat;
  double lng;
  var chng;

  @override
  _Promo_detailsState createState() => _Promo_detailsState();
}

class _Promo_detailsState extends State<Promo_details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(),
        body: new ListView(
          children: <Widget>[
            PromotionsCard(
              widget.promo,
              widget.user,
              true,
              false,
              widget.chng,
            ),
            InkWell(
              onTap: () {
                if (Platform.isIOS)
                  Navigator.push(context, new MaterialPageRoute<String>(
                      builder: (BuildContext context) {
                    return new WebviewScaffold(
                      url: widget.promo.docUrl,
                      withZoom: true,   // zoom
                      hidden: true,
                      appBar: new AppBar(
                        title: new Text(""),
                      ),
                    );
                  }));

              },
              child: Row(
                children: <Widget>[
                  widget.promo.docUrl.toString() == "null" ||
                          widget.promo.docUrl == ""
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
                            if (Platform.isIOS)
                              Navigator.push(context,
                                  new MaterialPageRoute<String>(
                                      builder: (BuildContext context) {
                                return new WebviewScaffold(
                                  url: widget.promo.docUrl,
                                  withZoom: true,   // zoom
                                  hidden: true,
                                  appBar: new AppBar(
                                    title: new Text(""),
                                  ),
                                );
                              }));

                          },
                        ),
                 /* Text(
                    LinkomTexts.of(context).here(),
                    style: TextStyle(
                        color: Fonts.col_app,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w800),
                  ),*/
                ],
              ),
            )
          ],
        ));
  }
}
