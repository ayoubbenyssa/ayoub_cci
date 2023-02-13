import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycgem/cards/details_partner.dart';
import 'package:mycgem/cards/shop_card.dart';
import 'package:mycgem/home/list_boutiques.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/membre.dart';
import 'package:mycgem/models/partner.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:mycgem/widgets/common.dart';

class PartnerCard extends StatefulWidget {
  PartnerCard(this.partner, this.lat, this.lng, this.user, this.onLocaleChange);

  Membre partner;
  var lat;
  var lng;
  User user;
  var onLocaleChange;

  @override
  _PartnerCardState createState() => _PartnerCardState();
}

class _PartnerCardState extends State<PartnerCard> {
  @override
  Widget build(BuildContext context) {

    Widget wid = GestureDetector(
      child: Card(

          // color: Colors.white,

          child: new ListView(children: <Widget>[
        new Container(
            height: MediaQuery.of(context).size.height * 0.48,
            child: new Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  new Positioned.fill(
                      child: new Container(
                          height: MediaQuery.of(context).size.height * 0.54,
                          decoration: new BoxDecoration(
                            color: Fonts.col_app_shadow,
                            image: new DecorationImage(
                              fit: BoxFit.contain,
                              colorFilter: new ColorFilter.mode(
                                  Colors.blueGrey[100].withOpacity(0.4),
                                  BlendMode.darken),
                              image: new NetworkImage(
                                widget.partner
                                    .logo/*==
                      "https://cgembusiness.ma//cgem/images/logos/nologo.png"
                      ? "https://res.cloudinary.com/dgxctjlpx/image/upload/v1565012657/placeholder_2_seeta8.png"
                      : widget.partner.logo*/
                                ,
                              ),
                            ),
                          ),
                          child: new Column(children: <Widget>[
                            new Row(
                              children: <Widget>[
                                new Expanded(child: new Container()),
                                Container()
                              ],
                            ),

                            /* new Hero(
                        tag: widget.user.id,
                        child:*/

                            /* new ClipOval(
                child: new Container(
                  width: 120.0,
                  height: 120.0,
                  child: new Image.network(
                    widget.partner.logo,
                    fit: BoxFit.cover,
                  ),
                )),*/

                            new Container(
                              height: 4.0,
                            ),
                          ]))),
                  new Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: new Container(
                          padding: new EdgeInsets.only(
                              left: 8.0, top: 8.0, bottom: 8.0, right: 16.0),
                          decoration: new BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15.0),
                                topLeft: Radius.circular(0.0),
                                bottomRight: Radius.circular(15.0),
                                bottomLeft: Radius.circular(0.0),
                              ),
                              gradient: new LinearGradient(
                                  colors: [
                                    Fonts.col_app,
                                    Fonts.col_app_fonn,
                                  ],
                                  begin: const FractionalOffset(0.0, 0.0),
                                  end: const FractionalOffset(1.0, 0.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp)),
                          child: new Text(LinkomTexts.of(context).entrep(),
                              style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold)))),
                  new Positioned(
                      bottom: 12,
                      right: 12,
                      child: Row(
                        children: <Widget>[
                          /* FloatingActionButton(
                    heroTag: widget.partner.objectId+"1",
                    highlightElevation: 7.0,

                    elevation:15.0,
                    //iconSize: 62,

                    child:  CircleAvatar(
                        radius: 44,
                        backgroundColor: Colors.deepOrange[900],
                        child:
                        Padding(
                            padding: EdgeInsets.all(8),
                            child:Image.asset("images/locc.png",color: Colors.white,width: 34,height: 34,))),
                    onPressed: (){

                      Navigator.push(context,   new MaterialPageRoute(
                          builder: (BuildContext context) {
                            return new ShopLIst(widget.partner.partnerKey.toString(),widget.partner.objectId,widget.lat,widget.lng
                            );
                          }));

                    },),

                  Container(width: 12,),

                 FloatingActionButton(
                   heroTag:  widget.partner.objectId+"2",
                   highlightElevation: 7.0,

                   elevation:15.0,
                    //iconSize: 62,

                    child:  CircleAvatar(
                        radius: 44,
                        backgroundColor: Colors.green[800],
                        child:
                        Padding(
                            padding: EdgeInsets.all(8),
                            child:Image.asset("images/info.png",color: Colors.white,width: 24,height: 24,))),
                    onPressed: (){

                      Navigator.push(context, new MaterialPageRoute(
                          builder: (BuildContext context) {
                            return new PartnerCardDetails(
                                widget.partner);
                          }));

                    },*/
                        ],
                      ))
                ])),
        new Container(
          height: 4.0,
        ),
        new Center(
            child: SizedBox(
          // width: 150.0,

          height: 30.0,
          child: ColorizeAnimatedTextKit(
            text: [
              widget.partner.name,
            ],
            textStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            colors: [
              Fonts.col_app_fon,
              Colors.pink[200],
              Fonts.col_app,
              Colors.black,
            ],
          ),
        )),
        new Padding(
            padding: EdgeInsets.all(8.0),
            child: new Text(widget.partner.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: new TextStyle(
                    color: Colors.blueGrey[800],
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.justify)),
        new Container(
          height: 8.0,
        ),

        /* new Padding(
              padding: EdgeInsets.all(16.0),
              child: new Text(
              widget.partner.description
              ,
              style: new TextStyle(
                  color:Colors
                      .grey[500],
                  fontSize: 15.0,
                  fontWeight:
                  FontWeight
                      .w500),
              textAlign:
              TextAlign.justify)),*/
      ])),
      onTap: () {
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) {
          return new PartnerCardDetails(widget.partner, widget.lat, widget.lng,
              widget.user, widget.onLocaleChange);
        }));

        /*Navigator.push(context,   new MaterialPageRoute(
          builder: (BuildContext context) {
            return new ShopCardDetails(widget.partner.partnerKey.toString(),widget.partner.objectId
              );
          }));*/
      },
    );

    Widget header = Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.08,
        child: Card(
          margin: EdgeInsets.all(0),
          color: Fonts.col_app_fonn,
          child: Container(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 8,
                  ),
                  Image.asset(
                    "images/sp1.png",
                    color: Colors.white,
                    width: 30,
                    height: 30,
                  ),
                  Container(
                    width: 12,
                  ),
                  Text(
                    LinkomTexts.of(context).entrep(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(15),
                        fontWeight: FontWeight.w900),
                  )

                ],
              )),
        ));

    return GestureDetector(
        onTap: () {
          Navigator.push(context,
              new MaterialPageRoute(builder: (BuildContext context) {
            return new PartnerCardDetails(widget.partner, widget.lat,
                widget.lng, widget.user, widget.onLocaleChange);
          }));
        },
        child: new Material(
            color: Colors.white,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.all(
              Radius.circular(12.0),
            )),
            elevation: 3.0,
            shadowColor: Colors.grey[800],
            child: Column(
              children: <Widget>[
                header,
                Container(
                  // color: Colors.grey[100],
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  child: FadingImage.network(
                    widget.partner.logo,
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(4),
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 16,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.96,
                            child: Text(widget.partner.name,
                                style: TextStyle(
                                    fontSize:
                                        ScreenUtil().setSp(35),
                                    fontWeight: FontWeight.bold,
                                    color: Fonts.col_app))),
                      ],
                    )),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    color: Fonts.col_cl,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.52,
                          child: Text(
                            widget.partner.description.toString() == "null"
                                ? ""
                                : widget.partner.description.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Fonts.col_app_fonn),
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        RaisedButton(
                          color: Colors.white,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.all(
                            Radius.circular(8.0),
                          )),
                          splashColor: Colors.grey,
                          elevation: 2,
                          onPressed: () {
                            Navigator.push(context, new MaterialPageRoute(
                                builder: (BuildContext context) {
                              return new PartnerCardDetails(
                                  widget.partner,
                                  widget.lat,
                                  widget.lng,
                                  widget.user,
                                  widget.onLocaleChange);
                            }));
                          },
                          child: Text(
                            LinkomTexts.of(context).details(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Fonts.col_app_green,
                                fontSize: ScreenUtil().setSp(34)),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}
