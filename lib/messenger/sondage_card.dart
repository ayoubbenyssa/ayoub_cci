import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mycgem/cards/details_partner.dart';
import 'package:mycgem/cards/option_card.dart';
import 'package:mycgem/fils_actualit/card_footer.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/language_params/scope_model_wrapper.dart';
import 'package:mycgem/models/offers.dart';
import 'package:mycgem/models/option.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/block.dart';
import 'package:mycgem/services/posts_services.dart';
import 'package:mycgem/user/details_user.dart';
import 'package:mycgem/widgets/common.dart';
import 'package:mycgem/widgets/easy_badge.dart';
import 'package:mycgem/widgets/easy_card.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:timeago/timeago.dart' as ta;

class SondageCardGroup extends StatefulWidget {
  SondageCardGroup(this.user, this.offers, this.list, this.onLocaleChange);

  Offers offers;
  User user;
  List list;
  var onLocaleChange;

  @override
  _SondageCardState createState() => _SondageCardState();
}

class _SondageCardState extends State<SondageCardGroup> {
  ParseServer parse_s = new ParseServer();

  delete() async {
    await parse_s.deleteparse("offers/" + widget.offers.objectId);
    setState(() {
      widget.offers.delete = true;
    });
  }

  bool load = false;

  loadi(val) {
    setState(() {
      widget.offers = val;
    });
    /*setState(() {
      widget.offers.delete=true;
    });
    new Timer(const Duration(milliseconds: 50), () {
      try {
        setState(() => widget.offers.delete = false);
      } catch (e) {
        e.toString();
      }
    });*/
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

  delete_option(i) async {
    var js = {
      "users": {
        "__op": "Remove",
        "objects": [
          {
            "__type": "Pointer",
            "className": "users",
            "objectId": widget.user.id
          }
        ]
      }
    };

    return parse_s.putparse('options/' + i.id, js);
  }

  int skip = 0;

  func(a) async {
    var s =
    await PostsServices.get_sondage_by_id1(a.objectId, widget.user, skip);

    setState(() {
      widget.offers = s["results"][0];
      for (Option i in s["results"][0].options) {
        print("aaaaaaaaaaaaaaaaaaaaaa");
        print(i.users.length);
        /*if (i.check == false) {
       await delete_option(i);
       setState(() {
         i.check = false;
       });
      }*/

      }
    });

    for (Option i in widget.offers.options) {
      /*if (i.check == false) {
       await delete_option(i);
       setState(() {
         i.check = false;
       });
      }*/

    }
    /* setState(() {
      widget.offers = a;
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return widget.offers.delete
        ? Container()
        : Container(
      child: Card(
          elevation: 3.0,
          child: Container(
              child: Column(
                children: <Widget>[


                 Container(width: MediaQuery.of(context).size.width*0.75,child: new EasyBadgeCard(
                    leftBadge: Colors.white,
                    title: widget.offers.title,
                    backgroundColor: Fonts.col_cl,
                    prefixIcon: "images/pv.png",

                    // prefixIconColor: Fonts.col_app_green,
                    suffixIconColor: Colors.white,
                    titleColor: Fonts.col_app,
                    descriptionColor: Colors.white,
                  )),
              Container(width: MediaQuery.of(context).size.width*0.75,child:Column(
                      children: widget.offers.options
                          .map((option) => OptionCard(widget.offers, option,
                          widget.user, func, loadi))
                          .toList())),

                ],
              ) //Text(widget.offers.title)),

          )),
    );
  }
}
