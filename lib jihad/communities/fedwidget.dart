import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:mycgem/communities/details_com.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/language_params/scope_model_wrapper.dart';
import 'package:mycgem/login/join_com.dart';
import 'package:mycgem/models/commission.dart';
import 'package:mycgem/models/community.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/widgets/common.dart';
import 'package:mycgem/widgets/groups_commission.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Fedwidget extends StatefulWidget {
  Fedwidget(this.com, this.auth, this.sign, this.id, this.user, this.show,
      this.list, this.view, this.chng);

  Commission com;
  var auth;
  var sign;
  String id = "";
  ParseServer parse_s = new ParseServer();
  User user;
  bool show;
  List<Commission> list = [];
  bool view;
  var chng;

  @override
  _CommunitywidgetState createState() => _CommunitywidgetState();
}

class _CommunitywidgetState extends State<Fedwidget> {
  @override
  Widget build(BuildContext context) {
    var style = new TextStyle(
        fontWeight: FontWeight.w900, color: Colors.black, fontSize: 18.0);



    return Container(
       padding: EdgeInsets.only(left: 4, right: 4, top: 4),
      child: Card(
          shape: new RoundedRectangleBorder(
              borderRadius:
              new BorderRadius.circular(8.0)),
          elevation: 0.0,
          child: Column(children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Padding(
                padding: EdgeInsets.all(8),
                child: InkWell(
                    onTap: () {},
                    child: Material(
                        borderRadius: BorderRadius.all(Radius.circular(22)),
                        elevation: 2,
                        child: ClipRRect(
                            //<--clipping image
                            borderRadius: BorderRadius.all(Radius.circular(22)),
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.26,
                                width: MediaQuery.of(context).size.width * 0.26,
                                child: Hero(
                                    tag: widget.com.objectId,
                                    child: widget.com.img.toString() == "null"
                                        ? Container()
                                        : FadingImage.network(
                                            widget.com.img,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.28,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.26,
                                            fit: BoxFit.fitWidth,
                                          ))))))),
            Container(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 4,
                ),
                ScopedModelDescendant<AppModel1>(
                    builder: (context, child, model) => Container(
                        width: MediaQuery.of(context).size.width * 0.62,
                        child: Text(
                          model.locale == "ar"
                              ? widget.com.name_ar.toString()
                              : widget.com.name.toString(),
                          maxLines: 4,
                          style: TextStyle(
                              color: Fonts.col_ap_fonn,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700),
                        ))),
                Container(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      "Adresse : ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.46,
                        child: Text(
                          widget.com.address.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ))
                  ],
                ),
                Container(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      "Tél : ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.46,
                      child:   Text(
                      widget.com.tel.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ))
                  ],
                ),
                Container(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      "Fax : ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.46,
                      child:  Text(
                      widget.com.fax.toString(),
                      style: TextStyle(fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ))
                  ],
                ),
                Container(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      "E-mail : ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.46,
                      child:   Text(
                      widget.com.email.toString(),
                      style: TextStyle(fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ))
                  ],
                ),

                /* ScopedModelDescendant<AppModel1>(
                  builder: (context, child, model) => ScopedModel<AppModel1>(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.68,
                      child:     HtmlWidget(

                       model.locale=="ar"?widget.com.desc_ar.toString():widget.com.description.toString()
                            .replaceAll(RegExp(r'(\\n)+'), '').toString().substring(0,270)+"...",
                        config: new Config(
                          baseUrl: Uri.parse('/'),
                          onLinkTap: (String url) {},
                        ),
                      ), /*Text(
                      widget.com.description.toString() == 'null'
                          ? "Aucune description trouvée                                          "
                              "                                                      "
                          : widget.com.description.toString(),
                      maxLines: 3,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    )*/)))*/
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(child: Container(),),
            Container(
                width: MediaQuery.of(context).size.width * 0.44,
                child: RaisedButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(4.0)),
                  padding: EdgeInsets.all(4),
                  color: Fonts.col_app,
                  child: Text(
                    LinkomTexts.of(context).details(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new ComDetails(widget.com, true)));
                  },
                )),
            Container(
              width: 16,
            ),

          ],
        ),
            Container(height: 6,)

          ])),
    ) /*new GestureDetector(
        onTap: () {
          // nearDistance();
        },
        child: new Container(
          margin: EdgeInsets.only(top: 1,bottom: 1),
          height: MediaQuery.of(context).size.height*0.2,
            decoration: new BoxDecoration(
                color: Colors.grey[800],
                image: new DecorationImage(
                    fit: BoxFit.fitWidth,
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.24), BlendMode.dstATop),
                    image: new NetworkImage(widget.com.img))),
            child:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

                Container(width: 8,),
               Container(width: MediaQuery.of(context).size.width*0.75,
                 child:_buildTextContainer(context)),
                checkk,
                Expanded(child: Container()),

                ],)

            ))*/
        ;

    /*
    new Material(

              elevation: 4.0,
              borderRadius: new BorderRadius.circular(2.0),
              child:
               new Padding(
            padding: const EdgeInsets.all(
              // vertical: 4.0,
              0.0,
            ),
            child:
     */
  }
}
