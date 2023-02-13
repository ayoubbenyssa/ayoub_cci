import 'dart:async';
import 'dart:io';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location/location.dart';
import 'package:mycgem/annonces/add_actu.dart';
import 'package:mycgem/annonces/add_opp.dart';
import 'package:mycgem/chat/messages_list.dart';
import 'package:mycgem/fils_actualit/stream_posts.dart';
import 'package:mycgem/filter/filter_page.dart';
import 'package:mycgem/func/parsefunc.dart';

import 'package:mycgem/home/request_users.dart';
import 'package:mycgem/home/search_entreprise.dart';
import 'package:mycgem/home/search_event_pub.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/messenger/group_conversation_list.dart';
import 'package:mycgem/models/connect.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/search/list_users_results.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/connect.dart';
import 'package:mycgem/services/location_services.dart';
import 'package:mycgem/sondage/add_vote.dart';
import 'package:mycgem/user/myprofile.dart';
import 'package:mycgem/notifications/userslist.dart';
import 'package:mycgem/widgets/common.dart';
import 'package:mycgem/widgets/custom_widgets/buttons_appbar.dart';
import 'package:mycgem/widgets/custombar.dart';
import 'package:mycgem/widgets/menu.dart';
import 'package:mycgem/widgets/search_bar.dart';
import 'package:mycgem/widgets/search_items.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

var indx = 0;

class BottomNavigation extends StatefulWidget {
  BottomNavigation(this.auth, this.sign, this.user, this.list_partners,
      this.show_menu, this.analytics, this.change,
      {this.animate, this.animate1});

  var auth;
  var sign;
  User user;
  bool show_menu = false;
  List list_partners;
  var animate;
  var analytics;
  var animate1;
  var change;

  @override
  _BottomNavigationState createState() => new _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>
    with TickerProviderStateMixin {
  PageController _pageController = new PageController();
  int _page = 0;
  bool load_location = false;
  bool load_a = false;
  bool load_home = false;

  ParseServer parse_s = new ParseServer();
  List<Tab> tabs1 = <Tab>[];
  String name_search = "";

  var lat, lng;

  /// final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool gps_none = true;

  User user_me;
  int count1 = 0;
  int count2 = 0;
  String text_groupe = "0";
  bool show_group = false;
  int count3 = 0;

  setSount1(c) {
    setState(() {
      count1 = c;
    });
  }

  setSount2(c) {
    setState(() {
      count2 = c;
    });
  }

  setSount3(c) {
    setState(() {
      count3 = c;
    });
  }

  rel_group(val) {
    /*  print(val);
    setState(() {
      text_groupe = val.toString();
      show_group = true;
    });
    // getRequestLIst();
    new Timer(const Duration(seconds: 1), () {
      try {
        setState(() => show_group = false);
      } catch (e) {
        e.toString();
      }
    });*/
    setState(() {
      text_groupe = val.toString();
    });
    print(text_groupe);

    setState(() {
      show_group = true;
    });
    // getRequestLIst();
    new Timer(const Duration(seconds: 1), () {
      try {
        setState(() => show_group = false);
      } catch (e) {
        e.toString();
      }
    });
  }

  List<Tab> tabs = <Tab>[];

  TabController _tabController;
  TabController _tabController1;

//search
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  List<String> _list;
  bool _IsSearching;
  String _searchText = "";

  bool lo = false;

  rel() {
    setState(() {
      lo = true;
    });
    // getRequestLIst();
    new Timer(const Duration(seconds: 1), () {
      try {
        setState(() => lo = false);
      } catch (e) {
        e.toString();
      }
    });
  }

  bool bl = false;

  bool add;

  List<ConnectModel> conn = new List<ConnectModel>();
  bool load_conn = false;

  toggle_chat() {
    if (priv_pub == false) {
      setState(() {
        priv_pub = true;
      });
    } else {
      setState(() {
        priv_pub = false;
        ;
      });
    }
  }

  var count;
  var select = "";
  bool priv_pub = false;

  ScrollController _hideButtonController;
  ScrollController _hide_bar_mur;

  SearchBar searchBar;


  tap_Actu(value) {
    Navigator.pop(context);
    Navigator.push(
      context,
      new PageRouteBuilder(
        pageBuilder:
            (BuildContext context, Animation<double> _, Animation<double> __) {
          return new AddAnnonceACtu_Event(widget.user, widget.auth, widget.sign,
              widget.list_partners, value, widget.change);
        },
      ),
    );
  }

  row(name, icon, tap, wid, he, selec) => new ListTile(
      onTap: () {
        if (name == "Actualité" || name == "Événement") {
          tap_Actu(name);
        } else
          tap();
      },
      title: Row(children: [
        /* Image.asset(
          icon,
          width: wid,
          height: he,
        ),*/
        Container(
          width: 16.0,
        ),
        new Text(
          name,
          style: TextStyle(fontSize: 14.5.sp),
        )
      ]));

  gotosond() {
    Navigator.pop(context);
    Navigator.push(
      context,
      new PageRouteBuilder(
        pageBuilder:
            (BuildContext context, Animation<double> _, Animation<double> __) {
          return new AddVote(widget.user, widget.list_partners);
        },
      ),
    );
  }

  tap() {
    Navigator.pop(context);
    Navigator.push(
      context,
      new PageRouteBuilder(
        pageBuilder:
            (BuildContext context, Animation<double> _, Animation<double> __) {
          return new AddAnnonceOpp(
              widget.user, widget.auth, widget.sign, widget.list_partners, "");
        },
      ),
    );
  }


  show() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => new Dialog(
            child: new Container(
                height: 300.0.h,
                child: new Container(
                    // padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                    child: widget.user.verify.toString() != "1"
                        ? Container(
                            child: Container(
                                padding: EdgeInsets.only(
                                    top: 60, left: 12, right: 12),
                                child: Text(
                                  "Vous devez être membre de la CCIS pour poster une opportunité d'affaires",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Fonts.col_ap_fonn,
                                      fontSize: 15.5.sp,
                                      fontWeight: FontWeight.w700),
                                )),
                          )
                        : widget.user.entreprise.situation != "Ajour"
                            ? Container(
                                child: Container(
                                    padding: EdgeInsets.only(
                                        top: 60, left: 12, right: 12),
                                    child: Text(
                                      "Vous devez régulariser votre situation pour poster une publication.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Fonts.col_ap_fonn,
                                          fontSize: 15.5.sp,
                                          fontWeight: FontWeight.w700),
                                    )),
                              )
                            : new Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                    Container(
                                      height: 16,
                                    ),
                                    Center(
                                        child: Text("Publier :",
                                            style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w700))),
                                    Container(
                                      height: 16,
                                    ),

                                    row(
                                        "Opportunité d'affaires",
                                        "images/cost.png",
                                        tap,
                                        40.0,
                                        40.0,
                                        "Annonces"),
                                  ])))));
  }

  getRequestLIst() async {
    setState(() {
      conn = [];
      load_conn = true;
      loading = true;
    });
    var a = await Connect.get_list_connect(widget.user.id);
    // if (this.mounted) return;

    setState(() {
      conn = a["res"];
      count = a["count"] - 3;
      load_conn = false;
      loading = false;
    });
  }

  void onSubmitted(String value) {
    //here

    if (_currentLocation == null) {
      _currentLocation = {};
      _currentLocation["latitude"] = 0.0;
      _currentLocation["longitude"] = 0.0;
    }

    /**
        {"name": "Actualités / Événements ", "check": false},
        {"name": "Organismes", "check": false},
        {"name": "Utlisateurs", "check": false},
        {"name": "Opportunités d'affaires", "check": false},
     */
    switch (name_search) {
      case "Actualités ":
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) {
          return new SearchNewEvent(
            value,
            widget.user,
            widget.list_partners,
            _currentLocation["latitude"],
            _currentLocation["longitude"],
            "news",
            widget.change,
          );
        }));
        break;
      case "Utilisateurs":
        Navigator.push(context,
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
            widget.change,
          );
        }));
        break;

      case "Membres":
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) {
          return new ListsResultsEntreprises(
            value,
            widget.user,
            widget.list_partners,
            widget.analytics,
            _currentLocation["latitude"],
            _currentLocation["longitude"],
            null,
            null,
            widget.change,
          );
        }));
        break;
      case "Opportunités d'affaires":
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) {
          return new SearchNewEvent(
            value,
            widget.user,
            widget.list_partners,
            _currentLocation["latitude"],
            _currentLocation["longitude"],
            "opportunite",
            widget.change,
          );
        }));
        break;
      default:
        return;
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
  }

  serach_value(String value) {
    name_search = value;
  }

  _BottomNavigationState() {
    searchBar = new SearchBar(
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(220),
            child: SearchItems(serach_value)),
        inBar: false,
        hintText: "Rechercher",
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted);

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

  bool loading = false;

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.push(
                context,
                new PageRouteBuilder(
                  pageBuilder: (BuildContext context, Animation<double> _,
                      Animation<double> __) {
                    return MyProfile(
                        widget.user,
                        false,
                        true,
                        lat,
                        lng,
                        widget.list_partners,
                        widget.analytics,
                        widget.change);
                      // Scaffold(
                      //   appBar: AppBar(
                      //     iconTheme: IconThemeData(color: Fonts.col_app_fon),
                      //     elevation: 0,
                      //     backgroundColor: const Color(0xffeef6f8),
                      //     title: Container(),
                      //   ),
                      //   body: new MyProfile(
                      //       widget.user,
                      //       false,
                      //       true,
                      //       lat,
                      //       lng,
                      //       widget.list_partners,
                      //       widget.analytics,
                      //       widget.change));
                  },
                ),
              );
            },
            child: new Container(
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.only(left: 16, top: 8, bottom: 8),
              child: new CircleAvatar(
                backgroundImage: NetworkImage(widget.user.image.toString()),
                radius: 45.0,
              ),
            )),
        iconTheme: IconThemeData(
          color: Fonts.col_app_fon,
        ),
        centerTitle: true,
        title: GestureDetector(
            onTap: () {},
            child: Padding(
                padding: EdgeInsets.all(4),
                child: Image.asset("assets/images/logo.png",
                    width: ScreenUtil().setWidth(_page == 3 ? 50 : 50)))),
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          searchBar.getSearchAction(context),

          /* IconButton(
              onPressed: () {
                new Future.delayed(Duration.zero, () {
                  showDialogWithInsets(
                      context: context,
                      edgeInsets: EdgeInsets.symmetric(horizontal: 12),
                      builder: (_) => AlertDialog(
                          titlePadding: EdgeInsets.all(0.0),
                          contentPadding: EdgeInsets.only(top: 8.0),
                          content: new Container(
                              height: MediaQuery.of(context).size.height * 0.75,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                  child: Grid_view(
                                      _pageController,
                                      lat,
                                      lng,
                                      widget.user,
                                      widget.auth,
                                      widget.list_partners,
                                      widget.analytics,
                                      func_change_index,
                                      _page,
                                      widget.change)))));
                });
              },
              icon: Image.asset("images/3m.png",
                  color: Fonts.col_ap_fonn,
                  width: MediaQuery.of(context).size.width * 0.055,
                  height: 36)),*/
          Padding(
              padding: EdgeInsets.all(4),
              child: IconButton(
                // color: Fonts.col_app_fon,
                icon: new Stack(children: <Widget>[
                  SvgPicture.asset(
                    "assets/icons/notif.svg",
                    color: Fonts.col_ap_fonn,
                    height: 24,
                    //width: MediaQuery.of(context).size.width * 0.05,
                    // height: 32
                  ),
                  new Positioned(
                    // draw a red marble
                    top: 0.0,
                    right: 0.0,
                    child: not.toString() != "null" && not.toString() != "0"
                        ? CircleAvatar(
                            radius: 9.0,
                            backgroundColor: Colors.redAccent,
                            child: Center(
                                child: new Text(not.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.5,
                                        fontWeight: FontWeight.bold))))
                        : new Container(),
                  )
                ]),
                onPressed: () {
                  var gMessagesDbRef3 = FirebaseDatabase.instance
                      .reference()
                      .child("count_notifications");
                  gMessagesDbRef3.update({widget.user.auth_id: 0});

                  Navigator.push(context,
                      new MaterialPageRoute(builder: (BuildContext context) {
                    return new Listusers(
                        widget.user,
                        widget.auth,
                        widget.sign,
                        widget.list_partners,
                        Reload,
                        widget.analytics,
                        widget.change);
                  }));
                },
              )),
        ]);
  }

  Reload() {
    new Timer(const Duration(seconds: 1), () {
      try {
        setState(() => loading = false);
      } catch (e) {
        e.toString();
      }
    });
  }

  connect_widgets() {
    List<Widget> list = [];

    list = loading
        ? [new Container()]
        : conn
            .map((ConnectModel con) => con.author.toString() == "null"
                ? new Container()
                : new Container(
                    padding: new EdgeInsets.only(right: 2.0, left: 8.0),
                    child: new ClipOval(
                        child: new Container(
                            color: Fonts.col_app,
                            width: 30.0,
                            height: 30.0,
                            child: new Center(
                                child: FadingImage.network(
                              con.author["photoUrl"].toString(),
                              width: 36.0,
                              height: 36.0,
                              fit: BoxFit.cover,
                            ))))))
            .toList();

    list.add(count <= 0
        ? new Container()
        : new Container(
            padding: new EdgeInsets.only(right: 2.0, left: 8.0),
            child: new CircleAvatar(
              radius: 16.0,
              backgroundColor: Colors.orange[900],
              child: new Text(
                "+" + count.toString(),
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            )));

    list.add(loading
        ? new Container()
        : Container(
            width: 60.0,
            height: 40.0,
            padding: EdgeInsets.all(2),
            child: RaisedButton(
              color: Colors.grey[50],
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(12.0)),
              padding: new EdgeInsets.all(8.0),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (BuildContext context) {
                  return new UserListsRequests(
                      widget.user.id,
                      widget.user,
                      widget.auth,
                      widget.sign,
                      widget.list_partners,
                      Reload,
                      widget.analytics,
                      widget.change);
                }));
              },
              child: Text(
                LinkomTexts.of(context).details(),
                style: TextStyle(
                    color: Fonts.col_app, fontWeight: FontWeight.w900),
              ),
            ),
          ));

    return list;
  }

  Widget buildBar(BuildContext context) {
    return _page == 0
        ? searchBar.build(context)
        : new AppBar(
            title: Padding(
                padding: EdgeInsets.all(4),
                child: Image.asset("assets/images/logo.png",
                    width: ScreenUtil().setWidth(_page == 3 ? 34.w : 34.w))),
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Fonts.col_app_fonn),
            centerTitle: true,
            elevation: 1.0,
            bottom: _page == 3
                ? PreferredSize(
                    preferredSize: Size.fromHeight(!_isVisible ? 60.0 : 110.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          /* padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 8.0),*/
                          child: TextField(
                            controller: _searchQuery,
                            decoration: InputDecoration(
                                counterStyle: TextStyle(color: Colors.white),
                                isDense: true,
                                /*contentPadding:
                                          EdgeInsets.symmetric(horizontal: 6.0),*/
                                hintText:
                                    LinkomTexts.of(context).searchc() + ' ..',
                                enabledBorder: OutlineInputBorder(
                                  // width: 0.0 produces a thin "hairline" border
                                  borderSide: BorderSide(
                                      color: Colors.grey[50], width: 0.0),
                                  borderRadius: BorderRadius.circular(60.0),
                                ),
                                hintStyle: TextStyle(color: Colors.grey),
                                suffixIcon: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      end: 12.0),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                    size: 30.0,
                                  ), // icon is 48px widget.
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey[50], width: 0.0),
                                  borderRadius: BorderRadius.circular(60.0),
                                ),
                                filled: true),
                          ),
                        ),
                        conn.isEmpty
                            ? new Container()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                    new Container(
                                      width: 8.0,
                                    ),
                                    new Text(
                                      "Demandes en attente : ",
                                      style: new TextStyle(
                                          color: Fonts.col_app,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ]),
                        priv_pub
                            ? Container()
                            : Container(
                                height: 50.0,
                                child: conn.isEmpty
                                    ? new Container()
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: connect_widgets()))
                      ],
                    ))
                : PreferredSize(
                    preferredSize: Size.fromHeight(0.0), child: Container()),
            actions: <Widget>[
                !_isVisible
                    ? new IconButton(
                        icon: Icon(Icons.home),
                        onPressed: () {
                          setState(() {
                            _isVisible = true;
                          });
                        })
                    : new Container()
              ]);
  }

  Map<String, double> _currentLocation;

  StreamSubscription<Map<String, double>> _locationSubscription;

  Location _location = new Location();

  initPlatformState() async {
    Map<String, double> location;

    print("get localisation");
    // Platform messages may fail, so we use a try/catch PlatformException.

    try {
      // _permission = await _location.hasPermission();

      print("jojoojoj");
      // location = await Location_service.getLocation();

      setState(() {
        _currentLocation = location;
      });
      if (_currentLocation == null) {
        _currentLocation = {};
        _currentLocation["latitude"] = 0.0;
        _currentLocation["longitude"] = 0.0;
      } else {
        lat = location["latitude"];
        lng = location["longitude"];
      }
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        setState(() {
          gps_none = false;
        });
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        setState(() {
          gps_none = false;
        });
      }
      location = null;
    }
    print(" $lat = location[latitude]");
    print(" $lng = location[longitude]");

  }

  getLocation() async {
    //android jihad
    /* _locationSubscription =
        _location.onLocationChanged().listen((Map<String, double> result) {
      if (!this.mounted) return;
      setState(() {
        _currentLocation = result;
        if (_currentLocation == null) {
          _currentLocation = {};
          _currentLocation["latitude"] = 0.0;
          _currentLocation["longitude"] = 0.0;
        }
        lat = _currentLocation["latitude"];
        lng = _currentLocation["longitude"];

        print(lat);
      });
    });*/
    await initPlatformState();

    var js = {
      "location": {"__type": "GeoPoint", "latitude": lat, "longitude": lng},
      "lat": lat,
      "lng": lng,
    };

    await parse_s.putparse("users/" + widget.user.id, js);

    setState(() {
      load_location = true;
    });
  }

  make_user_online() async {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map["online"] = true;
    map["last_active"] = 0;
    print(
        "------------------------------------------------update data--------------------------------------------------------");
    await Firestore.instance
        .collection('users')
        .document(widget.user.auth_id)
        .updateData(map);

    FirebaseDatabase.instance
        .reference()
        .child("status")
        .update({widget.user.auth_id: true});
    FirebaseDatabase.instance
        .reference()
        .child("status")
        .onDisconnect()
        .update({widget.user.auth_id: false});
  }

  String not = "0";

  /*Widget tbs() => new TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: tabs,
        isScrollable: true,

        onTap: (val) {

          print("5555555555555555555555555555555");
          rel_group(val);
        },

        indicatorColor: Fonts.col_app_green,
        indicatorWeight: 3,
        unselectedLabelColor: Fonts.col_grey,
        //isScrollable: false,

        labelColor: Fonts.col_app,
        labelStyle: new TextStyle(
            color: Fonts.col_app,
            fontFamily: "aa",
            fontWeight: FontWeight.w500,
            fontSize: 15),
        indicatorPadding: new EdgeInsets.all(0.0),
        controller: _tabController,
      );
*/

  bool not_msg = false;

  notif_msg() async {
    FirebaseUser my_id = await FirebaseAuth.instance.currentUser();

    FirebaseDatabase.instance
        .reference()
        .child("notif_new_msg/" + my_id.uid)
        .onValue
        .listen((val) {
      var d = val.snapshot.value;
      setState(() {
        not_msg = d;
      });
    });
  }

  setNotifi() async {
    FirebaseUser my_id = await FirebaseAuth.instance.currentUser();

    FirebaseDatabase.instance
        .reference()
        .child("count_notifications/" + my_id.uid)
        .onValue
        .listen((val) {
      var d = val.snapshot.value;
      if (d != null) {
        setState(() {
          not = d.toString();
        });
      }
    });
  }

  bool _isVisible = true;
  bool _isVisible1 = true;

  func_change_index(indx) {
    setState(() {
      _page = indx;
      bl = true;
    });
  }

  _showDialog1() async {
    return await showDialog(
        builder: (BuildContext context) => new AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: Container(
                height: 160,
                child: Column(children: <Widget>[
                  Text(LinkomTexts.of(context).option()),
                ]))));
  }

  String verify;
  AnimationController controller;

  getUser(id) async {
    var a = await parse_s
        .getparse('users?where={"objectId":"$id"}&include=fonction');
    if (!this.mounted) return;
    print(a);

    setState(() {
      verify = a["results"][0]["verify"].toString();
      print(verify);
    });
  }

  Animation<Offset> offset;
  List icons = [];

  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration.zero, () {
      icons = [
        {
          "icon": "assets/icons/Home.svg",
          "name": LinkomTexts.of(context).home()
        },
        {
          "icon": "assets/icons/users.svg",
          "name": LinkomTexts.of(context).netw()
        },
        {
          "icon": "assets/icons/add.svg",
          "name": ""
        },
        {
          "icon": "assets/icons/msg.svg",
          "name": LinkomTexts.of(context).messg()
        },
        {
          "icon": "assets/icons/Menu.svg",
          "name": LinkomTexts.of(context).menu()
        }
      ];
    });
    _tabController1 = new TabController(vsync: this, length: 2);
    _tabController = new TabController(vsync: this, length: 3);
    if (widget.user.notif_user == true) {
      OneSignal.shared.sendTag("userId", widget.user.auth_id);
    }
    if (widget.user.val_notif_opp == true) {
      OneSignal.shared.sendTag("opportunite", "opportunite");
    }
    if (widget.user.val_notif_pub == true) {
      OneSignal.shared.sendTag("publication", "publication");
    }

    new Timer(Duration.zero, () {
      tabs = [
        new Tab(
            text: count1 == 0
                ? LinkomTexts.of(context).tous()
                : LinkomTexts.of(context).tous() +
                    " (" +
                    count1.toString() +
                    ")"),
        new Tab(
            text: count2 == 0
                ? LinkomTexts.of(context).g_n()
                : LinkomTexts.of(context).g_r() +
                    " (" +
                    count1.toString() +
                    ")"),
        new Tab(
            text: count3 == 0
                ? LinkomTexts.of(context).g_r()
                : LinkomTexts.of(context).g_r() +
                    " (" +
                    count2.toString() +
                    ")"),
      ];
      tabs1 = [
        new Tab(text: LinkomTexts.of(context).priv()),
        //new Tab(text: count2 == 0?"Membres":"Membres"+ " ("+ count2.toString() +")"),

        new Tab(text: LinkomTexts.of(context).group()),
      ];

      if (widget.animate != null) {
        new Timer(const Duration(seconds: 2), () {
          _pageController.animateToPage(1,
              duration: const Duration(milliseconds: 300), curve: Curves.ease);
        });
      }
    });

    _hideButtonController = new ScrollController();
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          _isVisible1 = false;
        });
      }
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _isVisible1 = true;
        });
      }
    });

    _hide_bar_mur = new ScrollController();
    _hide_bar_mur.addListener(() {
      if (_hide_bar_mur.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          _isVisible1 = false;
        });
      }
      if (_hide_bar_mur.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _isVisible1 = true;
        });
      }
    });

    getLocation().then((_) {
      if (widget.animate1 != null) {
        setState(() {
          widget.show_menu = false;
          priv_pub = true;
          _page = 2;
        });
        new Timer(const Duration(seconds: 2), () {
          _pageController.animateToPage(2,
              duration: const Duration(milliseconds: 300), curve: Curves.ease);
        });

        setState(() {
          widget.show_menu = false;
          priv_pub = true;
          _page = 2;
        });
      }
      setNotifi();
      notif_msg();
      make_user_online();
      getRequestLIst();

      /* if (widget.show_menu) {
        if (gps_none == true) {
          new Future.delayed(Duration.zero, () {
            showDialogWithInsets(
                context: context,
                edgeInsets: EdgeInsets.symmetric(horizontal: 12),
                builder: (_) => AlertDialog(
                    titlePadding: EdgeInsets.all(0.0),
                    contentPadding: EdgeInsets.only(top: 8.0),
                    content: new Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: Grid_view(
                                _pageController,
                                lat,
                                lng,
                                widget.user,
                                widget.auth,
                                widget.list_partners,
                                widget.analytics,
                                func_change_index,
                                _page)))));
          });
        }
      }*/
    });

    _IsSearching = false;
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    offset = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 1.0))
        .animate(controller);
  }

  navigationTapped(int page) async {
    setState(() {
      this._page = page;
    });

    if (this._page == 3) {
      var gMessagesDbRef3 =
          FirebaseDatabase.instance.reference().child("notif_new_msg");
      gMessagesDbRef3.update({widget.user.auth_id: false});
    }
    if (this._page == 0) {
      setState(() {
        load_home = true;
      });
      new Timer(new Duration(milliseconds: 500), () {
        setState(() {
          load_home = false;
        });
      });
    }

    _pageController.animateToPage(this._page,
        duration: const Duration(milliseconds: 100), curve: Curves.ease);
  }

  out() {
    if (_page != 0) {
      setState(() {
        _page = 0;
        _isVisible = true;
      });
      _pageController.animateToPage(0,
          duration: const Duration(milliseconds: 100), curve: Curves.ease);
    } else {
      Widgets.exitapp(context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    /// _locationSubscription.cancel();
  }

  /*@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();


  }*/

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);

    return new WillPopScope(
        onWillPop: () {
          out();
        },
        child: Scaffold(
            extendBody: true,
            // extendBodyBehindAppBar: true,
            backgroundColor: Colors.white,
            drawer: new Drawer(
                child: new Menu(
                    widget.user,
                    widget.user.id,
                    widget.auth,
                    widget.sign,
                    lat,
                    lng,
                    widget.list_partners,
                    widget.analytics,
                    func_change_index,
                    _page,
                    _pageController,
                    widget.change)),
            appBar:
                /*!_isVisible1
                ? PreferredSize(
                    preferredSize: Size.fromHeight(1),
                    child: Container(),
                  )
                :*/
                buildBar(context),
            // key: _scaffoldKey,
            body: new PageView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  load_home
                      ? Padding(
                          padding: EdgeInsets.only(top: 32),
                          child: Widgets.load())
                      : StreamPots(
                          widget.user,
                          _currentLocation != null && _currentLocation != {}
                              ? _currentLocation["latitude"]
                              : 0.0,
                          _currentLocation != null && _currentLocation != {}
                              ? _currentLocation["longitude"]
                              : 0.0,
                          widget.list_partners,
                          widget.analytics,
                          _isVisible1,
                          _hide_bar_mur,
                          widget.change),
                  FilterPage(
                      widget.user,
                      widget.change,
                      _currentLocation != null && _currentLocation != {}
                          ? _currentLocation["latitude"]
                          : 0.0,
                      _currentLocation != null && _currentLocation != {}
                          ? _currentLocation["longitude"]
                          : 0.0),
                     Container(),
                  Column(children: [
                    ButtonsTabBar(
                      backgroundColor: Fonts.col_gr,
                      radius: 42.r,
                      contentPadding: EdgeInsets.all(6.w),
                      borderWidth: 1.0,
                      controller: _tabController1,
                      borderColor: Fonts.col_app,
                      unselectedBorderColor: Fonts.col_app_fon,
                      unselectedBackgroundColor: Colors.white,
                      unselectedLabelStyle:
                      TextStyle(color: Fonts.col_app_fon, fontSize: 12.sp),
                      labelStyle: TextStyle(
                          fontSize: 12.0.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      tabs: tabs1,

                    ),
                    Expanded(
                      child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: _tabController1,
                          children: [
                            new MessagesList(
                                widget.user,
                                widget.user.auth_id,
                                _searchText,
                                _hideButtonController,
                                widget.list_partners,
                                Reload,
                                widget.auth,
                                widget.analytics,
                                widget.change),
                            show_group
                                ? Widgets.load()
                                : Group_conversation(widget.user, text_groupe,
                                    _searchText, widget.change)
                          ]),
                    ),
                  ]),
                  new Menu(
                      widget.user,
                      widget.user.id,
                      widget.auth,
                      widget.sign,
                      lat,
                      lng,
                      widget.list_partners,
                      widget.analytics,
                      func_change_index,
                      _page,
                      _pageController,
                      widget.change)
                ],
                controller: _pageController),
            bottomNavigationBar: SlideTransition(
                position: offset,
                child: Container(
                  // padding: EdgeInsets.symmetric(horizontal: 20),
                  height: Platform.isIOS ? 102.h : 70.h,
                  child: BottomAppBar(
                      color: Colors.transparent,
                      elevation: 0.0,
                      child: BottomNavigationDotBar(
                          activeColor: Fonts.col_app,
                          color: Color(0xffA5A5A5),
                          indexPageSelected: _page,

                          items: [
                            {
                              "icon": "assets/icons/Home.svg",
                              "name": LinkomTexts.of(context).home()
                            },
                            {
                              "icon": "assets/icons/users.svg",
                              "name": LinkomTexts.of(context).netw()
                            },{
                              "icon": "assets/icons/add.svg",
                              "name": ""
                            },
                            {
                              "icon": "assets/icons/msg.svg",
                              "name": LinkomTexts.of(context).messg()
                            },
                            {
                              "icon": "assets/icons/Menu.svg",
                              "name": LinkomTexts.of(context).menu()
                            }
                          ]
                              .map((icon) => BottomNavigationDotBarItem(
                                  icon: icon["icon"],
                                  name: icon["name"],
                                  onTap: () {
                                    if(icon["name"] == ""){
                                      show();

                                    }
                                    else {
                                      _pageController.animateToPage(
                                          icons.indexWhere((element) =>
                                          element["icon"] == icon["icon"]),
                                          duration:
                                          const Duration(milliseconds: 300),
                                          curve: Curves.ease);
                                    }

                                    /* Cualquier funcion - [abrir nueva venta] */
                                  }))
                              .toList())),
                ))

            /*!_isVisible
                ? new Container(
              height: 0.00,
            )
                : BottomNavigationBar(
              backgroundColor: Fonts.col_app,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey[200],
              type: BottomNavigationBarType.fixed,
              onTap: navigationTapped,
              currentIndex: _page,
              // this will be set when a new tab is tapped
              items: [
                BottomNavigationBarItem(
                    title: Text(
                      LinkomTexts.of(context).home(),
                      style:
                      TextStyle(fontSize: ScreenUtil().setSp(13.0)),
                    ),
                    icon: new Container(
                        padding: EdgeInsets.only(bottom: 4),
                        width: ScreenUtil().setWidth(22),
                        height: ScreenUtil().setWidth(22),
                        child: new Image.asset(
                          _page != 0
                              ? "images/home.png"
                              : "images/hom.png",
                          color: _page != 0
                              ? Colors.grey[200]
                              : Colors.white,
                        ))),
                BottomNavigationBarItem(
                    title: Text(
                      LinkomTexts.of(context).netw(),
                      style:
                      TextStyle(fontSize: ScreenUtil().setSp(13.0)),
                    ),
                    icon: new Container(
                        padding: EdgeInsets.only(bottom: 4),
                        width: ScreenUtil().setWidth(28),
                        height: ScreenUtil().setWidth(28),
                        child: new Image.asset(
                          _page != 1
                              ? "images/netw.png"
                              : "images/netw.png",
                        ))),
                /* BottomNavigationBarItem(
                      title: Container(),
                      icon: FloatingActionButton(
                        elevation: 6,
                        mini: true,
                        backgroundColor: Fonts.col_app_green,
                        onPressed: () {
                          show();
                        },
                        child: Icon(Icons.add),
                      ),
                    ),*/

                BottomNavigationBarItem(
                  title: Container(),
                  icon: Container(),
                ),
                BottomNavigationBarItem(
                  title: Text(
                    LinkomTexts.of(context).messg(),
                    style: TextStyle(fontSize: ScreenUtil().setSp(13.0)),
                  ),
                  icon: new Stack(children: <Widget>[
                    new Container(
                        padding: EdgeInsets.only(bottom: 4),
                        width: ScreenUtil().setWidth(22),
                        height: ScreenUtil().setWidth(22),
                        child: new Image.asset(
                          _page != 3
                              ? "images/chat.png"
                              : "images/chatw.png",
                          color: _page != 3
                              ? Colors.grey[200]
                              : Colors.white,
                        )),
                    new Positioned(
                      // draw a red marble
                      top: -2.0,
                      right: 0.0,
                      child: not_msg.toString() != "null" &&
                          not_msg.toString() != "false"
                          ? new Icon(Icons.brightness_1,
                          size: 12.0, color: Colors.redAccent)
                          : new Container(),
                    )
                  ]),
                ),
                BottomNavigationBarItem(
                    title: Text(
                      LinkomTexts.of(context).menu(),
                      style:
                      TextStyle(fontSize: ScreenUtil().setSp(13.0)),
                    ),
                    icon: new Container(
                        padding: EdgeInsets.only(bottom: 4),
                        width: ScreenUtil().setWidth(22),
                        height: ScreenUtil().setWidth(22),
                        child: new Image.asset(
                          _page != 4
                              ? "images/mnn.png"
                              : "images/mna.png",
                          color: _page != 4
                              ? Colors.grey[200]
                              : Colors.white,
                        ))),
              ],
            ),
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
            floatingActionButton: GestureDetector(
              child: new ClipOval(
                  child: new Container(
                      color: Colors.white,
                      width: ScreenUtil().setWidth(48),
                      height: ScreenUtil().setWidth(48),
                      padding: EdgeInsets.all(4),
                      child: Container(
                        width: ScreenUtil().setWidth(48),
                        height: ScreenUtil().setWidth(48),
                        decoration: BoxDecoration(
                          border: new Border.all(
                              color: const Color(0xff979797), width: 0.5),
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              Fonts.col_ap,
                              Fonts.col_app_fon.withOpacity(0.95),
                            ],
                            // begin: Alignment.topLeft,
                            //end: Alignment.bottomRight,
                          ),

                        ),
                        child: Center(
                            child: load_a
                                ? CupertinoActivityIndicator()
                                : Icon(
                              Icons.add,
                              color: Colors.white,
                              size: ScreenUtil().setWidth(26),
                            )),
                      ))),
              onTap: () async {
                setState(() {
                  load_a = true;
                });
                await getUser(widget.user.id);
                setState(() {
                  load_a = false;
                });
                show();
              },
            )*/
            ));
  }
}

class DialogInsetDefeat extends StatelessWidget {
  final BuildContext context;
  final Widget child;
  final deInset = EdgeInsets.symmetric(horizontal: -40, vertical: -24);
  final EdgeInsets edgeInsets;

  DialogInsetDefeat(
      {@required this.context, @required this.child, this.edgeInsets});

  @override
  Widget build(BuildContext context) {
    var netEdgeInsets = deInset + (edgeInsets ?? EdgeInsets.zero);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(viewInsets: netEdgeInsets),
      child: child,
    );
  }
}

/// Displays a Material dialog using the above DialogInsetDefeat class.
/// Meant to be a drop-in replacement for showDialog().
///
/// See also:
///
///  * [Dialog], on which [SimpleDialog] and [AlertDialog] are based.
///  * [showDialog], which allows for customization of the dialog popup.
///  * <https://material.io/design/components/dialogs.html>
Future<T> showDialogWithInsets<T>({
  @required BuildContext context,
  bool barrierDismissible = true,
  @required WidgetBuilder builder,
  EdgeInsets edgeInsets,
}) {
  return showDialog(
    context: context,
    builder: (_) => DialogInsetDefeat(
      context: context,
      edgeInsets: edgeInsets,
      child: Builder(builder: builder),
    ),
    barrierDismissible: barrierDismissible = true,
  );
}
