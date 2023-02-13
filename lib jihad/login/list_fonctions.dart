import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/fonction.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/partners_list.dart';
import 'package:mycgem/widgets/widgets.dart';

class ListFonctions extends StatefulWidget {
  ListFonctions();

  @override
  _ListFonctionsState createState() => _ListFonctionsState();
}

class _ListFonctionsState extends State<ListFonctions> {
  Fonction entreprise;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool load = true;

  SearchBar searchBar;
  final TextEditingController _searchQuery = new TextEditingController();
  bool _IsSearching;
  String _searchText = "";
  List<Fonction> ent = new List<Fonction>();

  getList() async {
    var a = await PartnersList.get_list_fonctions();
    if (!this.mounted) return;
    setState(() {
      ent = a;
      load = false;
    });
  }

  _ListFonctionsState() {
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

  sete(Fonction ent) {
    entreprise = ent;
  }

  func() {
    for (Fonction i in ent) {
      setState(() {
        i.check = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getList();
  }

  sub() async {
    Navigator.pop(context);

    /* SharedPreferences prefs = await SharedPreferences.getInstance();
    String id  = prefs.getString("id");
    Navigator.pushReplacement(context,
        new MaterialPageRoute(builder: (BuildContext context) {
          return new CreateNewEntrepriseForm(widget.email,id, null);///chngggg
        }));*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: Container(
            height: MediaQuery.of(context).size.height * 0.07,
            color: Fonts.col_app,
            child: RaisedButton(
              elevation: 0,
              color: Fonts.col_app,
              padding: EdgeInsets.all(0),
              child: Text(
                "CONFIRMER",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16),
              ),
              onPressed: () {
                if (entreprise == null) {
                  _scaffoldKey.currentState.showSnackBar(new SnackBar(
                    content: new Text(LinkomTexts.of(context).ve_e()),
                  ));
                } else
                  Navigator.pop(context, entreprise);
              },
            )),
        appBar: AppBar(
          elevation: 1.0,
          iconTheme: IconThemeData(color: Fonts.col_app_fonn),
          backgroundColor: Fonts.col_app_shadow,
          title: Text(
            "Fonctions",
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
                          contentPadding:
                              EdgeInsets.only(left: 20.0, right: 16),
                          hintText: 'Rechercher une fonction',
                          enabledBorder: OutlineInputBorder(
                            // width: 0.0 produces a thin "hairline" border
                            borderSide:
                                BorderSide(color: Fonts.col_app, width: 0.0),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          hintStyle: TextStyle(color: Fonts.col_app),
                          suffixIcon: Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: 12.0, end: 12.0),
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
          children: load
              ? [Center(child: Widgets.load())]
              : ent
                  .map((val) => new FonctionItem(val, func, _searchText, sete))
                  .toList(),
        ));
  }
}

class FonctionItem extends StatefulWidget {
  FonctionItem(this.partner, this.funcall, this.searchText, this.func);

  Fonction partner;
  var funcall;
  var searchText;
  var func;

  @override
  _FonctionItem_cardState createState() => _FonctionItem_cardState();
}

class _FonctionItem_cardState extends State<FonctionItem> {
  Fonction st;

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
                  size: 28.0,
                  color: widget.partner.check == true
                      ? Colors.blue
                      : Colors.grey[300],
                ),
                decoration: new BoxDecoration(
                  color: widget.partner.check
                      ? Colors.grey[100]
                      : Colors.grey[100],
                  border: new Border.all(
                      width: 2.0,
                      color: widget.partner.check
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
    return (!widget.partner.name
                .toLowerCase()
                .contains(widget.searchText.toLowerCase()) &&
            widget.searchText.isNotEmpty)
        ? Container()
        : InkWell(
            onTap: () {
              submit();
            },
            child: Card(
              child: Container(
                child: ListTile(
                    title: Text(
                      widget.partner.name,
                      maxLines: 4,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
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
              ),
            ));
  }
}
