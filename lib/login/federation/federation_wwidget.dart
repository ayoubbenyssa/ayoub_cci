import 'package:flutter/material.dart';
import 'package:mycgem/models/commission.dart';
import 'package:mycgem/models/partner.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/widgets/common.dart';

class Commission_card_c extends StatefulWidget {
  Commission_card_c(this.com,this.funcall,this.searchText,this.func);

  Commission com;
  var funcall;
  var searchText;
  var func;


  @override
  _Entreprise_cardState createState() => _Entreprise_cardState();
}

class _Entreprise_cardState extends State<Commission_card_c> {
  List<String> st = [];

  var load=true;

  submit() {


    //

    if (widget.com.check == true) {
      setState(() {
        widget.com.check = false;
        print(widget.com.check);

        st = [];
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
        widget.com.check = true;
        st.add(widget.com.objectId);
        st.add(widget.com.name);
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
                  child: FadingImage.network(
                    widget.com.img ,
                    fit: BoxFit.contain,
                  ),
                  width: 70,
                  height: 70,
                ),
                title: Text(
                  widget.com.name,
                  maxLines: 1,
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                subtitle: Text(
                  widget.com.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                ),
                trailing: checkk()),
          ),
        ));
  }
}
