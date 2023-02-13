import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:mycgem/entreprise/search_entreprise.dart';
import 'package:mycgem/home/search_entreprise.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/parc_events_stream/parc_events_stream.dart';
import 'package:mycgem/services/Fonts.dart';

class EntrepriseStream extends StatefulWidget {
  EntrepriseStream(this.user, this.lat, this.lng, this.list_partner,
      this.analytics, this.chng);

  User user;
  var lat, lng;
  List list_partner;
  var analytics;
  var chng;

  @override
  _EntrepriseStreamState createState() => _EntrepriseStreamState();
}

class _EntrepriseStreamState extends State<EntrepriseStream> {
  int count1 = 0;

  setSount1(c) {
    setState(() {
      count1 = c;
    });
  }

  SearchBar searchBar;

  Widget defaultappbar(context) => AppBar(
        iconTheme: IconThemeData(color: Fonts.col_app_fon),
        elevation: 1,
        actions: [
          searchBar.getSearchAction(context),

          /*  IconButton(icon: Icon(Icons.search),onPressed: (){

      },)*/
        ],
        backgroundColor: Colors.white,
        title: Text(
          "Membres",
          style: TextStyle(
              color: Fonts.col_app_fon,
              fontSize: 15.5.sp,
              fontWeight: FontWeight.w700),
        ),
      );

  void onSubmitted(String value) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new ListsResultsEntreprises(
        value,
        widget.user,
        [],
        widget.analytics,
        0.0,
        0.0,
        null,
        null,
        widget.chng,
      );
    }));
  }

  /* Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new UserListsResults(
          value,
          widget.user,
          widget.list_partners,
          widget.analytics,
          _currentLocation["latitude"],
          _currentLocation["longitude"],
          null,
          null,
          widget.change);
    }));*/

  _EntrepriseStreamState() {
    searchBar = new SearchBar(
        inBar: false,
        hintText: "Rechercher",
        buildDefaultAppBar: defaultappbar,
        setState: setState,
        onSubmitted: onSubmitted);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: searchBar.build(context),
        body: Container(
            color: Fonts.col_grey.withOpacity(0.16),
            child: new StreamParcPub(
              Container(
                  height:
                      8) /*Center(
                  child: SearchWidgetEntreprise(
                      widget.user,
                      [],
                      widget.lat != null ? widget.lat : 0.0,
                      widget.lng != null ? widget.lng : 0.0,
                      null,
                      null,
                      widget.chng))*/
              ,
              widget.lat,
              widget.lng,
              widget.user,
              "1",
              widget.list_partner,
              widget.analytics,
              setSount1,
              widget.chng,
              user_stream: "entreprise",
              revue: false,
              favorite: false,
              boutique: false,
            )));
  }
}
