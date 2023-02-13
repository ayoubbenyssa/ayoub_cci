import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:mycgem/models/commission.dart';
import 'package:mycgem/models/partner.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/widgets/common.dart';

class Commission_card_c extends StatefulWidget {
  Commission_card_c(this.com,this.commissions,this.searchText,this.func,this.type);

  Commission com;
  List<Commission> commissions ;
  var searchText;
  var func;
  String type;


  @override
  _Entreprise_cardState createState() => _Entreprise_cardState();
}

class _Entreprise_cardState extends State<Commission_card_c> {
  List<Commission> st = [];

  var load=true;

  submit() {

    if (widget.com.check == true) {
      setState(() {
        widget.com.check = false;
        widget.func(widget.com,-1);
        // widget.func(st);
      });

    } else {
    //  widget.funcall();
      setState(() {
        widget.com.check = true;
        st.add(widget.com);

       // st.add(widget.com.name);
        widget.func(widget.com,1);
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
              size: 28.0,
              color: widget.com.check == true
                  ? Colors.blue
                  : Colors.grey[300],
            ),
            decoration: new BoxDecoration(
              color: widget.com.check
                  ? Colors.grey[100]
                  : Colors.grey[100],
              border: new Border.all(
                  width: 2.0,
                  color: widget.com.check
                      ? Colors.blue[300]
                      : Colors.grey[300]),
              borderRadius:
              const BorderRadius.all(const Radius.circular(36.0)),
            ),
          )
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return (!widget.com.name.toLowerCase().contains(widget.searchText.toLowerCase()) &&
        widget.searchText.isNotEmpty)
        ? new Container()
        :InkWell(
        onTap: () {
          submit();
        },
        child: Card(
          child: Container(
            child: ListTile(
                leading: Container(
                  color: Colors.grey[50],
                  child:     widget.com.img.toString()== "null"?Container():FadingImage.network(
                    widget.com.img ,
                    fit: BoxFit.contain,
                  ),
                  width: 70,
                  height: 70,
                ),
                title: Text(
                  widget.com.name.toString(),
                  maxLines: 4,
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                /* widget.type=="fed"?Text(""):Text(
                  widget.com.description.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                ),*/
                trailing: checkk()),
          ),
        ));
  }
}
