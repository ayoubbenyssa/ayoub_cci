import 'package:flutter/material.dart';
import 'package:mycgem/models/pays.dart';
import 'package:mycgem/services/Fonts.dart';

class SearchItems extends StatefulWidget {
  SearchItems(this.func);

  var func;

  @override
  _SearchItemsState createState() => _SearchItemsState();
}

class _SearchItemsState extends State<SearchItems> {
  List list = [
    {"name": "Actualités ", "check": false},
    {"name": "Membres", "check": false},
    {"name": "Utilisateurs", "check": false},
    {"name": "Opportunités d'affaires", "check": false},
  ];

  getList() async {
    List<SearchModel> a = list.map((e) => SearchModel.fromMap(e)).toList();
    if (!this.mounted) return;
    print(a);

    setState(() {
      list = a;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getList();
  }

  submit(SearchModel searcdel) {
    if (searcdel.check == true) {
      setState(() {
        searcdel.check = false;
        widget.func("");
      });
    } else {
      for (SearchModel i in list) {
        setState(() {
          i.check = false;
        });
      }
      setState(() {
        searcdel.check = true;
        widget.func(searcdel.name);
      });
    }
  }

  /**
      new Container(
      margin: new EdgeInsets.only(left: 8.0, right: 16.0),
      child: new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
      new Container(
      // height: 70.0,
      //width: 70.0,
      child: data[index].isselected
      ? new Icon(
      Icons.check,
      color: Colors.white,
      )
      : new Container(
      width: 25.0,
      height: 25.0,
      ),
      decoration: new BoxDecoration(
      color: data[index].isselected
      ? Fonts.col_app
      : Colors.transparent,
      border: new Border.all(
      width: 1.0,
      color: data[index].isselected
      ? Fonts.col_app
      : Colors.grey),
      borderRadius: const BorderRadius.all(
      const Radius.circular(2.0)),
      ),
      )
   */
  checkk(SearchModel model) => new InkWell(
        // padding: EdgeInsets.all(0.0),
        splashColor: Fonts.col_app,
        onTap: () {
          //widget.func();
          submit(model);
        },
        child: new Container(
          width: 26,
          height: 26,
          decoration: new BoxDecoration(
            color: model.check == true ? Fonts.col_app : Colors.transparent,
            border: new Border.all(
                width: 2.0, color: model.check ? Fonts.col_app : Colors.grey[300]),
            borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
          ),
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
                  size: 22.0,
                  color: model.check == true ? Fonts.col_app : Colors.grey[100],
                ),
                decoration: new BoxDecoration(
                  color: model.check ? Colors.grey[100] : Colors.grey[100],


                ),
              )
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      //  padding: EdgeInsets.all(4),
      children: list
          .map(
            (val) => new ListTile(
                title: Text(
                  val.name.toString(),
                  maxLines: 1,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.7),
                ),
                leading: checkk(val)),
          )
          .toList(),
    );
  }
}

class SearchModel {
  String name;
  bool check = false;

  SearchModel(this.name, this.check);

  SearchModel.fromMap(Map<String, dynamic> map)
      : name = map["name"],
        check = false;
}
