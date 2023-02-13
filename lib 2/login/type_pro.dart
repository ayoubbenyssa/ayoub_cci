import 'package:flutter/material.dart';
import 'package:mycgem/models/pro.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/partners_list.dart';

class TypePro extends StatefulWidget {
  TypePro();

  @override
  _AvailableTaimeState createState() => new _AvailableTaimeState();
}

class _AvailableTaimeState extends State<TypePro> {
  List<Pro> time_av = [];
  var zone;
  Pro time_available;

  get_available_time() async {
    PartnersList.get_type().then((sp) {
      try {
        setState(() {
          time_av = sp;
        });
      } catch (e) {}
    });
  }

  @override
  void initState() {
    get_available_time();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Widget btn_confirm =new Container(
      padding: EdgeInsets.only(left: 16.0,right: 16.0),
      margin: EdgeInsets.only(left: 16.0,right: 16.0),

      width: 50.0,

        child: new RaisedButton(
          onPressed: () {
            Navigator.pop(context, time_available.name.toString());
          },
          color: Fonts.col_app,
          child: new Text('Ok', style: new TextStyle(color: Fonts.col_app_fon)),
        ),
      );

    row(title, List<Pro> data, index) {
      return new Container(
        margin: new EdgeInsets.all(2.0),
        // height: 45.0,
        //decoration:
        //LoDocDesign.buildShadowAndRoundedCorners3(Colors.grey[600]),
        child: Column(children: <Widget>[
          new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new InkWell(
                  //highlightColor: Colors.red,
                  splashColor: Fonts.col_app,
                  onTap: () {
                    setState(() {
                      data.forEach((element) => element.check = false);
                      data[index].check = true;
                      time_available = data[index];
                    });
                  },
                  child: new Container(
                    margin: new EdgeInsets.only(left: 8.0, right: 16.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Container(
                          // height: 70.0,
                          //width: 70.0,
                          child: data[index].check
                              ? new Icon(
                                  Icons.check,
                                  color: Colors.white,
                                )
                              : new Container(
                                  width: 25.0,
                                  height: 25.0,
                                ),
                          decoration: new BoxDecoration(
                            color: data[index].check
                                ? Fonts.col_app
                                : Colors.transparent,
                            border: new Border.all(
                                width: 1.0,
                                color: data[index].check
                                    ? Fonts.col_app
                                    : Colors.grey),
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(2.0)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
               Container(
                 width: MediaQuery.of(context).size.width*0.6,
                   child: new Text(title)),
              ]),
          Container(height: 4.0),
          Divider()
        ]),
      );
    }

    List<Widget> listwidget = new List<Widget>();

    ListWidge() {
      return time_av.map((Pro ti) {
        return row(ti.name, time_av, time_av.indexOf(ti));
      }).toList();
    }

    if (time_av.isEmpty) {
      listwidget.add(new Center(
          child: new RefreshProgressIndicator(
        backgroundColor: Colors.grey[200],
      )));
    } else if (time_av.isEmpty) {
      listwidget.add(new Center(
        child: new Text(
          "", //LoDocText.of(context).no(),
          style: new TextStyle(color: Fonts.col_app, fontSize: 20.0),
        ),
      ));
    } else {
      listwidget = ListWidge();
      listwidget.add(new Container(width:50.0,child: btn_confirm));
    }

    return new SimpleDialog(
      titlePadding: new EdgeInsets.all(0.0),
      //title: const Text(''),
      children: listwidget,
    );
  }
}
