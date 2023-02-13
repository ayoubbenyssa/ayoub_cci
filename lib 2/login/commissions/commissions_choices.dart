import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:mycgem/entreprise/entreprise_card.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/login/commissions/commission_wwidget.dart';
import 'package:mycgem/models/commission.dart';
import 'package:mycgem/models/partner.dart';
import 'package:mycgem/parc_events_stream/parc_events_stream.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/partners_list.dart';
import 'package:mycgem/services/sector_services.dart';
import 'package:mycgem/widgets/widgets.dart';

class CommissionsListChoice extends StatefulWidget {
  CommissionsListChoice(this.id,{this.comm});

  String id;
  List<Commission> comm;

  @override
  _CommissionsListChoiceState createState() => _CommissionsListChoiceState();
}

class _CommissionsListChoiceState extends State<CommissionsListChoice> {
  List<String> commissions = new List<String>();
  List<Commission> commissions_new = new List<Commission>();
  ParseServer parseFunctions = new ParseServer();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool load = true;

  SearchBar searchBar;
  final TextEditingController _searchQuery = new TextEditingController();
  bool _IsSearching;
  String _searchText = "";
  List<Commission> comms = new List<Commission>();


///WillPopScope(
//        onWillPop: () {
//
  update_commission_users(){
    List lst = [];
    List lst2 = [];
    for (Commission i in commissions_new) {
      lst.add({
        "__type": "Pointer",
        "className": "commissions",
        "objectId": i.objectId
      });

      lst2.add(i.objectId);
    }

    var js = {
      "commissions": {"__op": "AddUnique", "objects": lst},
      "commissions_list": lst2
    };


    parseFunctions.putparse("users/" + widget.id, js);
  }

  getList() async {

    ///commissions_new = widget.comm;

    var a = await SectorsServices.get_list_com();
    if (!this.mounted) return;
    setState(() {
      comms = a;

    });

    for (Commission i in comms) {
      print("yessssss");
      print(widget.comm);
      if (widget.comm.where((element) => element.objectId == i.objectId).toList().length==1) {
      setState(() {
        i.check = true;
        commissions_new.add(i);
      });

      }
    }
    setState(() {
      load = false;
    });
  }

  _CommissionsListChoiceState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  sete(Commission ent,inc) {
    print(commissions_new.length);

    print(ent.name);

    if(inc == 1) {
      commissions_new.add(ent);
    }
    else if(inc == -1)
      commissions_new.remove(ent);
    else
      return commissions_new;
  }

  func() {
    for (Commission i in comms) {
      setState(() {
        i.check = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: Container(
          color: Fonts.col_app,
          child: RaisedButton(
            elevation: 0,
            color: Fonts.col_app,
            padding: EdgeInsets.all(20),
            child: Text(
              LinkomTexts.of(context).sve(),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 16),
            ),
            onPressed: () {
              if (commissions_new.isEmpty) {
                _scaffoldKey.currentState.showSnackBar(new SnackBar(
                  content: new Text("Veuillez choisir une commission"),
                ));
              } else
                {
                  print(commissions_new);
                  update_commission_users();

                  String res = "";

                  Navigator.pop(context, commissions_new);

                }
            },
          )),
      appBar: AppBar(
        elevation: 1.0,
        iconTheme: IconThemeData(color: Fonts.col_app_fonn),
        backgroundColor: Fonts.col_app_shadow,
        title: Text(
          "Commissions permanentes",
          style: TextStyle(color: Fonts.col_app_fonn),
        ),
        actions: <Widget>[
          /* InkWell(
            child: Container(
                padding: EdgeInsets.all(12.0),
                child: Icon(Icons.save, color: Fonts.col_app)),
            onTap: () {
              if (entreprise.isEmpty) {
                _scaffoldKey.currentState.showSnackBar(new SnackBar(
                  content: new Text("Veuillez choisir une entreprise"),
                ));
              } else
                Navigator.pop(context, entreprise);
            },
          )*/
        ],
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 8.0),
                  child: TextField(
                    controller: _searchQuery,
                    decoration: InputDecoration(
                        counterStyle: TextStyle(color: Fonts.col_app),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 6.0),
                        hintText: '   Rechercher une commission',
                        enabledBorder: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderSide:
                              BorderSide(color: Fonts.col_app, width: 0.0),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        hintStyle: TextStyle(color: Fonts.col_app),
                        suffixIcon: Padding(
                          padding: const EdgeInsetsDirectional.only(end: 12.0),
                          child: Icon(
                            Icons.search,
                            color: Fonts.col_app,
                            size: 30.0,
                          ), // icon is 48px widget.
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Fonts.col_app, width: 0.0),
                          borderRadius: BorderRadius.circular(60.0),
                        ),
                        filled: true),
                  ),
                ),
              ],
            )),
      ),
      body: Container(
          color: Fonts.col_grey.withOpacity(0.16),
          child: ListView(
            padding: EdgeInsets.all(4),
            children: load
                ? [Center(child: Widgets.load())]
                : comms
                    .map((val) =>
                        new Commission_card_c(val, comms, _searchText, sete,""))
                    .toList(),
          )) /*StreamParcPub(
          new Container(), widget.lat, widget.lng, null, "0", null, null,setSount1,
          video: false,revue: false,
          favorite: false, boutique: false, entreprise: ["id"], func: sete,searchText:_searchText)*/
      ,
    );
  }
}
