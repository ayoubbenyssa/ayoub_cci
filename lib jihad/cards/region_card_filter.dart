import 'package:flutter/material.dart';
import 'package:mycgem/cards/regions_Details.dart';
import 'package:mycgem/fils_actualit/regions_news.dart';
import 'package:mycgem/filter/region_users.dart';
import 'package:mycgem/models/partner.dart';
import 'package:mycgem/models/region.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/widgets/common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Region_card_filter extends StatefulWidget {
  Region_card_filter(this.region, this.user, this.lat, this.lng, this.chng,
      this.reg, this.show_post);

  Region region;
  User user;
  double lat;
  double lng;
  bool reg;
  var chng;
  bool show_post;

  @override
  _Entreprise_cardState createState() => _Entreprise_cardState();
}

class _Entreprise_cardState extends State<Region_card_filter> {
  List<String> st = [];

  var load = true;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (widget.reg == true) {
            if (widget.show_post == false)
              Navigator.push(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
                return new RegionsNews(widget.user, widget.chng,
                    widget.region.id, widget.region.name);
              }));
            else
              Navigator.push(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
                return new FilterByRegionsUsers(widget.region, widget.user,
                    widget.lat, widget.lng, [], null, widget.chng);
              }));
          } else {
            Navigator.push(context,
                new MaterialPageRoute(builder: (BuildContext context) {
              return new RegionDetails(widget.region);
            }));
          }
        },
        child: Container(
            padding: EdgeInsets.only(left: 4, right: 4),
            child: Card(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(8.0)),
              elevation: 0.0,
              child: Container(
                padding: EdgeInsets.only(left: 4, right: 4),
                child: ListTile(
                  title: Text(
                    widget.region.name,
                    maxLines: 2,
                    style: TextStyle(
                        color: Fonts.col_ap_fonn,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Colors.grey[400],
                  ),
                ),
              ),
            )));
  }
}
