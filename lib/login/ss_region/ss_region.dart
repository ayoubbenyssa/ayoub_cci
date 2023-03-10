import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:mycgem/cards/region_card.dart';
import 'package:mycgem/entreprise/entreprise_card.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/login/ss_region/ss_region_card.dart';
import 'package:mycgem/models/partner.dart';
import 'package:mycgem/models/region.dart';
import 'package:mycgem/parc_events_stream/parc_events_stream.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/partners_list.dart';
import 'package:mycgem/widgets/widgets.dart';

class SSRegionsList extends StatefulWidget {
  SSRegionsList();



  @override
  _EntreproseListState createState() => _EntreproseListState();
}

class _EntreproseListState extends State<SSRegionsList> {
  List<String> entreprise = new List<String>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool load=true;

  SearchBar searchBar;
  final TextEditingController _searchQuery = new TextEditingController();
  bool _IsSearching;
  String _searchText = "";
  List<SSRegion> ent = new List<SSRegion>();

  getList() async {
    var a = await PartnersList.get_list_ss_regions();
    if (!this.mounted) return;
    setState(() {
      ent = a;
      load=false;
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

  sete(List<String> ent) {
    entreprise = ent;
    print(entreprise);
  }

  func() {
    for (SSRegion i in ent) {
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
              if (entreprise.isEmpty) {
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
          "R??gions",
          style: TextStyle(color: Fonts.col_app_fonn),
        ),
        actions: <Widget>[

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
                        hintText: '   Rechercher une sous r??gion',
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
      body: ListView(
        padding: EdgeInsets.all(4),
        children: load?[Center(child: Widgets.load())]:ent
            .map((val) => new SSRegion_card(val, func, _searchText, sete))
            .toList(),
      ) /*StreamParcPub(
          new Container(), widget.lat, widget.lng, null, "0", null, null,setSount1,
          video: false,revue: false,
          favorite: false, boutique: false, entreprise: ["id"], func: sete,searchText:_searchText)*/
      ,
    );
  }
}
