import 'package:flutter/material.dart';
import 'package:mycgem/models/partner.dart';
import 'package:mycgem/models/region.dart';
import 'package:mycgem/models/ville.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/widgets/common.dart';

class Ville_card extends StatefulWidget {
  Ville_card(this.region,this.funcall,this.searchText,this.func);

  Ville region;
  var funcall;
  var searchText;
  var func;


  @override
  _Entreprise_cardState createState() => _Entreprise_cardState();
}

class _Entreprise_cardState extends State<Ville_card> {
  List<String> st = [];

  var load=true;

  submit() {


    //

    if (widget.region.check == true) {
      setState(() {
        widget.region.check = false;
        print(widget.region.check);

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
        widget.region.check = true;
        st.add(widget.region.id);
        st.add(widget.region.name);
        st.add(widget.region.num);
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
              color: widget.region.check == true
                  ? Colors.blue
                  : Colors.grey[300],
            ),
            decoration: new BoxDecoration(
              color: widget.region.check
                  ? Colors.grey[100]
                  : Colors.grey[100],
              border: new Border.all(
                  width: 2.0,
                  color: widget.region.check
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
    return (!widget.region.name.toLowerCase().contains(widget.searchText.toLowerCase()) &&
        widget.searchText.isNotEmpty)
        ? new Container()
        :InkWell(
        onTap: () {
          submit();
        },
        child: Card(
          child: Container(
            child: ListTile(

                title: Text(
                  widget.region.name.toString().toUpperCase(),
                  maxLines: 1,
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),

                trailing: checkk()),
          ),
        ));
  }
}
