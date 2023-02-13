import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/pays.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/widgets/widgets.dart';

class PaysLIst extends StatefulWidget {
  PaysLIst();


  @override
  _PaysLIstState createState() => _PaysLIstState();
}

class _PaysLIstState extends State<PaysLIst> {
  List<String> pays = new List<String>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool load=true;

  SearchBar searchBar;
  final TextEditingController _searchQuery = new TextEditingController();
  bool _IsSearching;
  String _searchText = "";
  List<Pays> pays_list = new List<Pays>();

  getList() async {
    List<Pays> a =  Pays.pays.map((e) => Pays.fromMap(e)).toList();
    if (!this.mounted) return;
    print(a);

    setState(() {
      pays_list = a;
      load=false;
    });
  }

  _PaysLIstState() {
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

  sete(List<String> ent) {
    pays = ent;
    print(pays);
  }

  func() {
    for (Pays i in pays_list) {
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
            padding: EdgeInsets.all(0),
            child: Text(
              LinkomTexts.of(context).sve(),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 16),
            ),
            onPressed: () {
              if (pays.isEmpty) {
                _scaffoldKey.currentState.showSnackBar(new SnackBar(
                  content: new Text("Veuillez choisir un pays"),
                ));
              } else
                Navigator.pop(context, pays);
            },
          )),
      appBar: AppBar(
        elevation: 1.0,
        iconTheme: IconThemeData(color: Fonts.col_app_fonn),
        backgroundColor: Fonts.col_app_shadow,
        title: Text(
          "Pays",
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
                        contentPadding: EdgeInsets.only(left:20.0,right: 16),
                        hintText: 'Rechercher pays',
                        enabledBorder: OutlineInputBorder(
                          // width: 0.0 produces a thin "hairline" border
                          borderSide:
                          BorderSide(color: Fonts.col_app, width: 0.0),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        hintStyle: TextStyle(color: Fonts.col_app),
                        suffixIcon: Padding(
                          padding: const EdgeInsetsDirectional.only(start: 12.0,end: 12.0),
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
      body: ListView(
        padding: EdgeInsets.all(4),
        children: load?[Center(child: Widgets.load())]:pays_list
            .map((val) => new Pays_card(val, func, _searchText, sete))
            .toList(),
      ) /*StreamParcPub(
          new Container(), widget.lat, widget.lng, null, "0", null, null,setSount1,
          video: false,revue: false,
          favorite: false, boutique: false, entreprise: ["id"], func: sete,searchText:_searchText)*/
      ,
    );
  }
}



class Pays_card extends StatefulWidget {
  Pays_card(this.region,this.funcall,this.searchText,this.func);

  Pays region;
  var funcall;
  var searchText;
  var func;


  @override
  Pays_card_cardState createState() => Pays_card_cardState();
}

class Pays_card_cardState extends State<Pays_card> {
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
