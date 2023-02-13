import 'package:flutter/material.dart';
import 'package:mycgem/cards/details_partner.dart';
import 'package:mycgem/models/membre.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/widgets/common.dart';

class Entreprise_card_search extends StatefulWidget {
  Entreprise_card_search(this.partner, this.user,this.lat,this.lng,this.chng);

  Membre partner;
  User user;

  var lat;
  var lng;
  var chng;

  @override
  _Entreprise_cardState createState() => _Entreprise_cardState();
}

class _Entreprise_cardState extends State<Entreprise_card_search> {
  @override
  Widget build(BuildContext context) {
    return InkWell(child: Container(
        padding: new EdgeInsets.all(4.0),
    child:  Material(
        elevation: 0.0,
        borderRadius: new BorderRadius.circular(8.0),
        child: Container(
          padding: EdgeInsets.all(4),
      child:
          Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
       GestureDetector(
           onTap: (){

             Navigator.push(context,
                 new MaterialPageRoute(builder: (BuildContext context) {
                   return new PartnerCardDetails(widget.partner, widget.lat, widget.lng,
                       widget.user, widget.chng);
                 }));
           },

           child:  Container(
          color: Colors.grey[50],
          child: FadingImage.network(
            widget.partner.logo.toString() ==
                    "null" || widget.partner.logo.toString() ==""
                ? "https://res.cloudinary.com/dgxctjlpx/image/upload/v1565012657/placeholder_2_seeta8.png"
                : widget.partner.logo,
            fit: BoxFit.contain,
          ),
          width: 70,
          height: 70,
       )),
        Container(width: 12,),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              width: MediaQuery.of(context).size.width*0.62,
              child:  Text(
            widget.partner.name,
            maxLines: 4,
            style: TextStyle(fontWeight: FontWeight.w900,height: 1.3),
          )),
         /* Container(
              width: MediaQuery.of(context).size.width*0.65,
              child: Text(
            widget.partner.activities,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
            ),
          )),*/
        ]),
        Expanded(child: Container(),),
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
    ))),onTap: (){

      Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) {
            return new PartnerCardDetails(widget.partner, widget.lat, widget.lng,
                widget.user, widget.chng);
          }));
    },);
  }
}
