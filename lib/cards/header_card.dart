import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycgem/cards/details_partner.dart';
import 'package:mycgem/cards/option_widgets.dart';
import 'package:mycgem/language_params/scope_model_wrapper.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/app_services.dart';
import 'package:mycgem/user/details_user.dart';
import 'package:mycgem/widgets/apebi_pre.dart';
import 'package:mycgem/widgets/common.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:timeago/timeago.dart' as ta;

import 'package:intl/intl.dart';

class HeaderCard extends StatefulWidget {
  HeaderCard(this.offers, this.user, this.lat, this.lng, this.onLocaleChange,
      this.block_user, this.ratefunc);

  var offers;
  User user;
  var lat, lng;
  var onLocaleChange;
  var block_user;
  var ratefunc;

  @override
  _HeaderCardState createState() => _HeaderCardState();
}

class _HeaderCardState extends State<HeaderCard> {
  @override
  Widget build(BuildContext context) {
    return widget.offers.author1.toString() == "null" &&
            widget.offers.partner.toString() == "null"
        ? Container()
        : new Container(
            padding: new EdgeInsets.all(8.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                InkWell(
                    onTap: () {
                      if (widget.offers.author1.toString() != "null")
                        Navigator.of(context).push(new PageRouteBuilder(
                          pageBuilder: (_, __, ___) => new Details_user(
                              widget.offers.author1,
                              widget.user,
                              true,
                              [],
                              null,
                              widget.onLocaleChange),
                        ));
                      else {

                        if( widget.offers.partner.objectId == "v9bGl0EENk" )
                          {
                            Navigator.push(context,
                                new MaterialPageRoute(builder: (BuildContext context) {
                                  return new Presentation();
                                }));
                          }
                        else
                        Navigator.push(context, new MaterialPageRoute(
                            builder: (BuildContext context) {
                              return new PartnerCardDetails(
                                  widget.offers.partner,
                                  widget.lat,
                                  widget.lng,
                                  widget.user,
                                  widget.onLocaleChange);
                            }));
                      }
                    },
                    child: new ClipOval(
                            child: new Container(
                                color: Fonts.col_app,
                                /*
                             widget.user.verify.toString() != "1"
            ?
                             */
                                width: MediaQuery.of(context).size.width * 0.12,
                                height:
                                    MediaQuery.of(context).size.width * 0.12,
                                child: new Center(
                                    child: FadingImage.network(
                                  widget.offers.author1.toString() == "null"
                                      ? widget.offers.partner.logo.toString() ==
                                              "null"
                                          ? widget.offers.partner.im.toString()
                                          : widget.offers.partner.logo
                                      : widget.offers.author1.image,
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
                        width: MediaQuery.of(context).size.width * 0.60,
                        child: new Text(
                            widget.offers.author1.toString() == "null"
                                ? widget.offers.partner.logo.toString() ==
                                        "null"
                                    ? widget.offers.partner.username
                                    : widget.offers.partner.name
                                : AppServices.capitalizeFirstofEach(widget
                                        .offers.author1.firstname
                                        ?.toLowerCase()) +
                                    " " +
                                    widget.offers.author1.fullname
                                        .toString()
                                        .toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: new TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w700,
                                fontSize: ScreenUtil().setSp(14.5)))),
                    new Container(height: 2.0),
                    widget.offers.sponsorise != 1
                        ? ScopedModelDescendant<AppModel1>(
                            builder: (context, child, model) => new Text(
                                  ta.format(widget.offers.create,
                                      locale:
                                          model.locale == "ar" ? "ar" : "fr"),
                                  style: new TextStyle(
                                      color: Fonts.col_grey,
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.w600),
                                ))
                        : Row(
                            children: <Widget>[
                              Text(
                                "Sponsorisé",
                                style: TextStyle(
                                    color: Fonts.col_grey,
                                    fontSize: 12.0.sp,
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
                          ),
                  ],
                ),
                new Expanded(child: new Container()),

                // type()

                ButtonWidget(widget.offers, widget.user, widget.ratefunc,
                    widget.lat, widget.lng, widget.onLocaleChange),
                Container(
                  width: 12,
                )
                /* widget.offers.pic.isEmpty
                            ? MenuCard(
                            widget.offers, widget.user, delete, Colors.black)*/
                //   : Container()
              ],
            ));
  }
}
