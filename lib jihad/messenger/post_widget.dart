import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycgem/annonces/details_annonce.dart';
import 'package:mycgem/cards/details_parc.dart';
import 'package:mycgem/messenger/details_ann_group.dart';
import 'package:mycgem/models/offers.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';

class PostWidget extends StatefulWidget {
  PostWidget(this.offer, this.user,this.chng);

  Offers offer;
  User user;
  var chng;


  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(child: Container(
      width: MediaQuery.of(context).size.width * 0.74,
      child: new InkWell(
          // padding: EdgeInsets.all(0),
          onTap: () {


            print("jdjdjjd");
            Navigator.push(context, new MaterialPageRoute(
                builder: (BuildContext context) {
                  return new DetailsAnnonceGroup(
                      widget.offer, widget.offer.author, [],
                      null, [], widget.chng
                  );
                }));
           /* Navigator.push(context,
                new MaterialPageRoute(builder: (BuildContext context) {
              return new DetailsParc(
                  widget.offer, widget.user, widget.offer.type, [], null, null);
            }));*/


            /*  } else if (widget.an.type == "promotion") {

                        Navigator.push(context, new MaterialPageRoute(
                            builder: (BuildContext context) {
                              return new Promo_details(
                                  widget.an, widget.user,widget.lat,widget.lng);
                            }));
                      } else if (widget.an.type == "boutique") {
                        Navigator.push(context, new MaterialPageRoute(
                            builder: (BuildContext context) => ProductPage(widget.an,widget.user,widget.lat,widget.lng)));

                      }*/
          },
          child: Row(
            children: <Widget>[
              Stack(children: <Widget>[
                ClipRRect(
                    borderRadius: new BorderRadius.circular(12.0),
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                        color: Colors.grey[100],
                        child: SizedBox(
                          child: widget.offer.pic.toString() != "null" &&
                                  widget.offer.pic.isNotEmpty
                              ? Image.network(
                                  widget.offer.pic[0],
                                  fit: BoxFit.cover,
                                )
                              : new Image.asset("images/logo.png",
                                  fit: BoxFit.cover),
                          width: ScreenUtil().setHeight(140.0),
                          height: ScreenUtil().setHeight(130.0),
                        ))),
              ]),
              Expanded(
                flex: 1,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        children: <Widget>[

                          Text(
                            widget.offer.type.toString(),
                            style: TextStyle(
                                color: Fonts.col_app,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                      Container(height: 8,),
                      Text(
                        widget.offer.title.toString().toUpperCase(),
                        maxLines: 2,
                        style: Theme.of(context).textTheme.display2.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            height: 1.2),
                      ),
                      Container(
                        height: 2.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[],
                      ),
                      Text(
                        widget.offer.description.toString() == "null"
                            ? "----Aucune description ----"
                            : widget.offer.description.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey),
                      ),
                      Container(
                        height: 8.0,
                      ),



                    ],
                  ),
                ),
              ),
            ],
          )),
    ),onTap: (){

    },);
  }
}
