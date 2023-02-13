import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycgem/cards/details_partner.dart';
import 'package:mycgem/chat/chatscreen.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/offers.dart';
import 'package:mycgem/models/user.dart' as prefix0;
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/block.dart';
import 'package:mycgem/user/details_user.dart';
import 'package:mycgem/user/participat_users.dart';

class ButtonWidget extends StatefulWidget {
  ButtonWidget(
      this.offer, this.user, this.ratefunc, this.lat, this.lng, this.chng);

  Offers offer;
  prefix0.User user;
  var ratefunc;
  var lat, lng;
  var chng;

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {

  block_user() async {
    await Block.insert_block(widget.user.auth_id, widget.offer.author1.auth_id,
        widget.user.id, widget.offer.author1.id);
    await Block.insert_block(widget.offer.author1.auth_id, widget.user.auth_id,
        widget.offer.author1.id, widget.user.id);

    setState(() {
      widget.user.show = false;
    });
  }

  goto() {}

  var st1 = TextStyle(
      color: Fonts.col_app,
      fontWeight: FontWeight.w500,
      fontSize: ScreenUtil().setSp(15));

  @override
  Widget build(BuildContext context) {

    return IconButton(
        icon: Icon(
          Icons.more_horiz,
          size: 32,
          color: Fonts.col_app_fonn,
        ),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext bc) {
                return Container(
                  child: new Wrap(
                    children: <Widget>[
                      Container(
                          color: const Color(0xfff3f3f3),
                          child: new ListTile(

                              title: new Text(
                                'Voir profil'.toUpperCase(),
                                style: st1,
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                if (widget.offer.author1.toString() != "null")
                                  Navigator.of(context)
                                      .push(new PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                    new Details_user(
                                        widget.offer.author1,
                                        widget.user,
                                        true,
                                        [],
                                        null,
                                        widget.chng),
                                  ));
                                else
                                  Navigator.push(context, new MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return new PartnerCardDetails(
                                            widget.offer.partner,
                                            widget.lat,
                                            widget.lng,
                                            widget.user,
                                            widget.chng);
                                      }));
                              })),
                      widget.offer.author.toString() == "null"
                          ? Container()
                          : widget.user.auth_id == widget.offer.author.auth_id
                          ? Container()
                          : new ListTile(

                        title: new Text(
                          LinkomTexts.of(context)
                              .contact()
                              .toUpperCase(),
                          style: st1,
                        ),
                        onTap: () {
                          Navigator.push(context,
                              new MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return new ChatScreen(
                                        widget.user.auth_id,
                                        widget.offer.author.auth_id,
                                        goto,
                                        false,
                                        null,
                                        null,
                                        widget.chng,
                                        user: widget.user);
                                  }));
                        },
                      ),


                      widget.offer.type == "event"
                          ? Container(
                          child: new ListTile(

                            title: new Text(
                              LinkomTexts.of(context)
                                  .particip()
                                  .toUpperCase(),
                              style: st1,
                            ),
                            onTap: () {
                              Navigator.pop(context);

                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                    //new HomePage(widget.auth,widget.sign)
                                    new Participate(
                                      /*com,*/
                                        widget.user,
                                        widget.offer.objectId,
                                        widget.chng),
                                  ));
                            },
                          ))
                          : Container(),
                    ],
                  ),
                );
              });
        });
  }
}
