import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycgem/entreprise/entreprise_card.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/login/create_new_entreprise.dart';
import 'package:mycgem/models/membre.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/partners_list.dart';
import 'package:mycgem/widgets/custom_widgets/primary_button.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EntreproseListInscription extends StatefulWidget {
  EntreproseListInscription(this.email);

  String email;

  // String id;

  @override
  _EntreproseListState createState() => _EntreproseListState();
}

class _EntreproseListState extends State<EntreproseListInscription> {
  Membre entreprise;

//  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool load = true;

  SearchBar searchBar;
  final TextEditingController _searchQuery = new TextEditingController();
  bool _IsSearching;
  String _searchText = "";
  List<Membre> ent = new List<Membre>();
  ScrollController _rrectController = ScrollController();

  getList() async {
    var a = await PartnersList.get_list_entreprise12(0);
    if (!this.mounted) return;
    setState(() {
      ent = a;
      load = false;
    });
  }

  _EntreproseListState() {
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

  sete(Membre ent) {
    entreprise = ent;
  }

  func() {
    for (Membre i in ent) {
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

  sub() async {
    Navigator.pop(context);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("id");
    Navigator.pushReplacement(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new CreateNewEntrepriseForm(widget.email, id, null);

      ///chngggg
    }));
  }

  @override
  Widget build(BuildContext context) {
    return /*Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height*0.07,
          color: Fonts.col_app,
          child: RaisedButton(
            elevation: 0,
            color: Fonts.col_app,
            padding: EdgeInsets.all(0),
            child: Text(
              "SUIVANT",
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
          "Membres",
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
                        hintText: 'Rechercher un organisme',
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
      body:*/
        Column(children: [
      Container(
        height: 16.h,
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Fonts.col_app_fon),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text(
              "Membres",
              style: TextStyle(
                  color: Fonts.col_app_fonn,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
      Container(
        height: 16,
      ),
      Column(children: <Widget>[
        Container(
         // height: 40,
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: TextField(
              controller: _searchQuery,
              decoration: InputDecoration(
                  counterStyle: TextStyle(color: Fonts.col_app),
                  isDense: true,
                  contentPadding: EdgeInsets.only(left: 20.0, right: 16, top: 0, bottom: 0),
                  hintText: 'Rechercher un organisme',
                  enabledBorder: OutlineInputBorder(
                    // width: 0.0 produces a thin "hairline" border
                    borderSide: BorderSide(color: Fonts.col_app_shadow, width: 0.0),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  hintStyle: TextStyle(color: Fonts.col_grey2, fontSize: 15),
                  suffixIcon: Padding(
                    padding: const EdgeInsetsDirectional.only(
                        start: 12.0, end: 12.0),
                    child: SvgPicture.asset(
                      "assets/icons/search.svg",
                    ), // icon is 48px widget.
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Fonts.col_app_shadow, width: 0.0),
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  fillColor: Fonts.col_app_shadow,
                  filled: true),
            ))
      ]),

      /*AppBar(
            elevation: 1.0,
            iconTheme: IconThemeData(color: Fonts.col_app_fonn),
            backgroundColor: Fonts.col_app_shadow,
            title: Text(
              "Membres",
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
                            hintText: 'Rechercher un organisme',
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
          ),*/
      Container(
          padding: EdgeInsets.only(left: 18.0, right: 18.0, top: 12.0),
          child: RichText(
              textAlign: TextAlign.justify,
              text: new TextSpan(
                text: "",
                children: <TextSpan>[
                  new TextSpan(
                    text:
                        "Si vous n'avez pas trouvé votre organisme sur la liste, ",
                    style: TextStyle(
                      color: Fonts.col_app_fon,
                      fontSize: 16,
                      fontFamily: 'coffee',
                    ),
                  ),
                  new TextSpan(
                      text: //(dans une entreprise déjà inscrite au niveau de la plateforme)
                          "cliquez ici pour l'ajouter  ",
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          sub();
                        },
                      style: new TextStyle(
                          decoration: TextDecoration.underline,
                          color: Fonts.col_gr,
                          fontFamily: 'coffee',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500))
                ],
              ))),
      Container(
        height: 12,
      ),
      Expanded(
          child: DraggableScrollbar.rrect(
              controller: _rrectController,
              backgroundColor: Fonts.col_gr,
              alwaysVisibleScrollThumb: true,
              heightScrollThumb: 52.h,
              child: ListView(
                controller: _rrectController,
                padding: EdgeInsets.all(4),
                children: load
                    ? [Center(child: Widgets.load())]
                    : ent
                        .map((val) =>
                            new Entreprise_card(val, func, _searchText, sete))
                        .toList(),
              ))),
      Container(
        height: 12,
      ),
      Container(
          width: 120.w,
          child: PrimaryButton(
            onTap: () {
              if (entreprise == null) {
                Scaffold.of(context).showSnackBar(new SnackBar(
                  content: new Text("Veuillez choisir une entreprise"),
                ));
              } else
                Navigator.pop(context, entreprise);
            },
            icon: "",
            disabledColor: Fonts.col_grey,
            fonsize: 15.0,
            prefix: Container(),
            color: Fonts.col_app,
            isLoading: false,
            text: "Enregistrer",
            /* child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      new Text(LinkomTexts.of(context).login(), style: style)
                    ],
                  )))*/
          )),
      Container(
        height: 12,
      ),
    ]);
  }
}
