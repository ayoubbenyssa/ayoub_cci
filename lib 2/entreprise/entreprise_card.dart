import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mycgem/login/create_new_entreprise.dart';
import 'package:mycgem/models/membre.dart';
import 'package:mycgem/models/partner.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/widgets/common.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Entreprise_card extends StatefulWidget {
  Entreprise_card(this.partner, this.funcall, this.searchText, this.func);

  Membre partner;
  var funcall;
  var searchText;
  var func;

  @override
  _Entreprise_cardState createState() => _Entreprise_cardState();
}

class _Entreprise_cardState extends State<Entreprise_card> {
  Membre st;

  var load = true;

  submit() {
    //

    if (widget.partner.check == true) {
      setState(() {
        widget.partner.check = false;
        print(widget.partner.check);

        st = null;
        widget.func(st);
      });
      /*
            {
              "__type": "Pointer",
              "className": "apebi_communities",
              "objectId": widget.com.objectId
            }
             */
      //print(  widget.list.remove(widget.com));
    } else {
      widget.funcall();
      setState(() {
        widget.partner.check = true;
        st = widget.partner;
        widget.func(st);
      });
      //  widget.list.add(widget.com);
    }
  }

  checkk() => new IconButton(
        padding: EdgeInsets.all(0.0),
        splashColor: Fonts.col_app,
        onPressed: () {
          //widget.func();

          submit();
        },
        icon: new Container(
          margin: new EdgeInsets.only(left: 8.0, right: 0.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Container(
                // height: 70.0,
                //width: 70.0,
                child: new Icon(
                  Icons.check,
                  size: 20.0,
                  color: widget.partner.check == true
                      ? Fonts.col_app
                      : Fonts.col_grey,
                ),
                decoration: new BoxDecoration(
                  color: widget.partner.check
                      ? Colors.grey[100]
                      : Colors.grey[100],
                  border: new Border.all(
                      width: 1.5,
                      color: widget.partner.check
                          ? Fonts.col_app
                          : Fonts.col_grey),
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(8.0)),
                ),
              )
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return (!widget.partner.name
                .toLowerCase()
                .contains(widget.searchText.toLowerCase()) &&
            widget.searchText.isNotEmpty)
        ? Container()
        : InkWell(
            onTap: () {
              submit();
            },
            child:Container(
                child: ListTile(
                    /* leading: Container(
                  color: Colors.grey[50],
                  child: FadingImage.network(
                    widget.partner.logo ==
                            "https://cgembusiness.ma//cgem/images/logos/nologo.png"
                        ? "https://res.cloudinary.com/dgxctjlpx/image/upload/v1565012657/placeholder_2_seeta8.png"
                        : widget.partner.logo,
                    fit: BoxFit.contain,
                  ),
                  width: 70,
                  height: 70,
                ),*/
                    title: Text(
                      widget.partner.name,
                      maxLines: 4,
                      style: TextStyle(
                          color: widget.partner.check == true
                              ? Fonts.col_app_fon
                              : Fonts.col_grey2,
                          fontWeight: widget.partner.check == true
                              ? FontWeight.w800
                              : FontWeight.w500,
                          fontSize: 14,
                          height: 1.2),
                    ),
                    /* subtitle: Text(
                  widget.partner.activities,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                ),*/
                    trailing: checkk()),

            ));
  }
}
