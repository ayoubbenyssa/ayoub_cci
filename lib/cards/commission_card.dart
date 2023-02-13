import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:mycgem/cards/details_partner.dart';
import 'package:mycgem/cards/like_partner_button.dart';
import 'package:mycgem/fils_actualit/commissions_news.dart';
import 'package:mycgem/fils_actualit/federations_news.dart';
import 'package:mycgem/filter/commissions_users.dart';
import 'package:mycgem/filter/federations_users.dart';
import 'package:mycgem/models/commission.dart';
import 'package:mycgem/models/partner.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/widgets/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Commission_card_search extends StatefulWidget {
  Commission_card_search(
    this.commission,
    this.user,
    this.lat,
    this.lng,
    this.chng,
    this.display_photo,
    this.sector, {
    this.type,
  });

  Commission commission;
  User user;

  var lat;
  var lng;
  var chng;
  String type;
  bool display_photo;
  bool sector;

  @override
  _Commission_card_search_cardState createState() =>
      _Commission_card_search_cardState();
}

class _Commission_card_search_cardState extends State<Commission_card_search> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          print(widget.type);

          if (widget.type == "commission") {
            if (widget.display_photo == false)
              Navigator.push(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
                return new CommissionNews(widget.user, widget.chng,
                    widget.commission.objectId, widget.commission.name);
              }));
            else
              Navigator.push(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
                return new FilterByCommissionsUsers(widget.commission,
                    widget.user, widget.lat, widget.lng, [], null, widget.chng);
              }));
          } else {
            if (widget.sector == false)
              Navigator.push(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
                return new FeederationsNews(widget.user, widget.chng,
                    widget.commission.objectId, widget.commission.name);
              }));
            else
              Navigator.push(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
                return new FilterByFederationUsers(widget.commission,
                    widget.user, widget.lat, widget.lng, [], null, widget.chng);
              }));
          }
          /**
           * FilterByCommissionsUsers(this.commission,this.user, this.lat, this.lng, this.list_partner, this.analytics,
              this.chng)
           */
        },
        child: Container(
            padding: new EdgeInsets.all(4.0),
            child: Material(
                elevation: 0.0,
                borderRadius: new BorderRadius.circular(8.0),
                child: Container(
                  padding:
                      EdgeInsets.all(widget.display_photo == false ? 12 : 4),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        widget.display_photo == false
                            ? Container()
                            : Container(
                                color: Colors.grey[50],
                                child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    child: widget.commission.img.toString() ==
                                            "null"
                                        ? Container()
                                        : FadingImage.network(
                                            widget.commission.img,
                                            fit: BoxFit.contain,
                                          )),
                                width: 80,
                                height: 80,
                              ),
                        Container(
                          width: 12,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: widget.display_photo == false
                                      ? MediaQuery.of(context).size.width * 0.74
                                      : MediaQuery.of(context).size.width * 0.6,
                                  child: Text(
                                    (widget.sector == true &&
                                            widget.type == "federation")
                                        ? widget.commission.sectorName
                                        : widget.commission.name,
                                    maxLines: 7,
                                    style: TextStyle(
                                        color: Fonts.col_ap_fonn,
                                        fontWeight: FontWeight.w700,
                                        height: 1.4,
                                        fontSize: 15.5.sp),
                                  )),
                              Container(
                                height: 4,
                              ),
                              /* Container(
                                width: MediaQuery.of(context).size.width * 0.55,
                                child: widget.type == "commission"
                                    ? Text(
                                        widget.commission.description
                                                    .toString() ==
                                                "null"
                                            ? ""
                                            : widget.commission.description,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: "ralway",
                                          color: Colors.grey,
                                          fontSize: 14.0,
                                        ),
                                      )
                                    : Container(),
                              ),*/
                            ]),
                        Expanded(
                          child: Container(),
                        ),
                        Container(
                          width: 10,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Colors.grey[400],
                        ),
                        Container(
                          width: 10,
                        ),
                      ]),
                ))));
  }
}
