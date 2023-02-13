import 'dart:async';
import 'dart:io';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:mycgem/home/entreprise_view.dart';
import 'package:mycgem/filter/filterbylocalion.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/teeeeest.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/login/login_w.dart';
import 'package:mycgem/models/myview.dart';
import 'package:mycgem/models/shop.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/partners_list.dart';
import 'package:flutter/services.dart';
import 'package:latlong/latlong.dart';
import 'package:mycgem/widgets/no_wifi.dart';
import 'package:mycgem/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  HomePage(this.auth, this.onSignedIn, this.lat, this.lng, this.user,
      this.list_partner, this.load, this.analytics, this.bl, this.chng);

  var auth;
  var onSignedIn;
  double lat;
  double lng;
  User user;
  List list_partner;
  var load;
  var analytics;
  bool bl = false;
  var chng;

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController animationController;
  bool _menuShown = false;

  String type = "all";
  List<User> users = new List<User>();
  Distance distance = new Distance();
  double dis;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ParseServer parse_s = new ParseServer();
  bool gps_none = true;
  Map<String, dynamic> map = new Map<String, dynamic>();
  List<String> list = new List<String>();
  List<String> list2 = new List<String>();
  int state = 1;

  //Position position;
  var subscription;
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = new Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  List<dynamic> lst = new List<dynamic>();
  int skip = 0;
  int j = 0;

  List<Tab> tabs = <Tab>[];

  TabController _tabController;

  Future<List<User>> getUsers() async {
    List<User> posts = [];
  }

  var lat, lng;
  var count;

  filter(text) {
    if (text == "user") {
      skip = 0;
      type = "user";
      setState(() {
        lst = [];
      });
      get_users_data("user");
    } else if (text == "entreprise") {
      type = "entreprise";
      setState(() {
        lst = [];
      });
      skip = 0;
      get_entreprise("");
    } else {
      type = "all";

      setState(() {
        lst = [];
      });
      skip = 0;
      get_users_data("all");
    }
  }

  get_entreprise(type) async {
    widget.list_partner = await PartnersList.get_list_entreprise(skip);
    if (!this.mounted) return;
    setState(() {
      lst = widget.list_partner;
    });
  }

  get_users_data(type) async {
    if (type == "user") {
      setState(() {
        widget.list_partner = [];
      });
    } else {
      var a = await PartnersList.get_list_partners();
      if (!this.mounted) return;
      setState(() {
        widget.list_partner = a;
      });
    }

    String id = widget.user.auth_id;
    String my_id = widget.user.id;

    try {
      lat = widget.lat;
      lng = widget.lng;

      var url;

      if (lat.toString() == "null") {
        if (type == "user") {
          url = //"medz":true,
              'where={"raja":true,"active":1,"id1":{"\$dontSelect":{"query":{"className":"block","where":{"userS":{"\$eq":"$id"}}},"key":"blockedS"}},'
              '"idblock":{"\$dontSelect":{"query":{"className":"block","where":{"blockedS":{"\$eq":"$id"}}},"key":"userS"}},'
              '"objectId":{"\$dontSelect":{"query":{"className":"connect","where":{"send_requ":{"\$eq":"$my_id"}}},"key":"receive_req"}}'
              '}&limit=24&skip=$skip&include=membre_user&include=membre_user.federation&include=membre_user.region';
        } else {
          url = //"medz":true,
              'where={"raja":true,"active":1,"id1":{"\$dontSelect":{"query":{"className":"block","where":{"userS":{"\$eq":"$id"}}},"key":"blockedS"}},'
              '"idblock":{"\$dontSelect":{"query":{"className":"block","where":{"blockedS":{"\$eq":"$id"}}},"key":"userS"}},'
              '"objectId":{"\$dontSelect":{"query":{"className":"connect","where":{"send_requ":{"\$eq":"$my_id"}}},"key":"receive_req"}}'
              '}&limit=20&skip=$skip&include=membre_user&include=commissions&include=membre_user.federation&include=membre_user.region';
        }
      } else {
        if (type == "user") {
          url = //"medz":true,
              'where={"raja":true,"active":1,"id1":{"\$dontSelect":{"query":{"className":"block","where":{"userS":{"\$eq":"$id"}}},"key":"blockedS"}},'
              '"idblock":{"\$dontSelect":{"query":{"className":"block","where":{"blockedS":{"\$eq":"$id"}}},"key":"userS"}},'
              '"objectId":{"\$dontSelect":{"query":{"className":"connect","where":{"send_requ":{"\$eq":"$my_id"}}},"key":"receive_req"}},'
              '"location": {"\$nearSphere": {"__type": "GeoPoint","latitude": $lat,"longitude":$lng}}}&limit=24&skip=$skip&include=membre_user&include=commissions&include=membre_user.federation&include=membre_user.region';
        } else {
          url = //"medz":true,
              'where={"raja":true,"active":1,"id1":{"\$dontSelect":{"query":{"className":"block","where":{"userS":{"\$eq":"$id"}}},"key":"blockedS"}},'
              '"idblock":{"\$dontSelect":{"query":{"className":"block","where":{"blockedS":{"\$eq":"$id"}}},"key":"userS"}},'
              '"objectId":{"\$dontSelect":{"query":{"className":"connect","where":{"send_requ":{"\$eq":"$my_id"}}},"key":"receive_req"}},'
              '"location": {"\$nearSphere": {"__type": "GeoPoint","latitude": $lat,"longitude":$lng}}}&limit=20&skip=$skip&include=membre_user&include=commissions&include=membre_user.federation&include=membre_user.region';
        }
      }

      var res = await parse_s.getparse('users?$url');
      if (!this.mounted) return;

      List sp = res["results"];

      /* count =
          res["count"] + (res["count"] % 20) ~/ 3 + (res["count"] ~/ 20) * 6;*/

      List<User> usrs =
          sp.map((var contactRaw) => new User.fromMap(contactRaw)).toList();

      for (int i = 0; i < usrs.length; i++) {
        setState(() {
          lst.add(usrs[i]);
        });

        if (widget.list_partner.length > 0) {
          if (i % 5 == 0) {
            if (j == widget.list_partner.length) {
              j = 0;
            }
            setState(() {
              lst.add(widget.list_partner[j]);
              j++;
            });
          }
        }
      }

      if (res["results"].length < 20) {
        lst.add(new MyView("", ""));
      }
    } on PlatformException {}
  }

  click(type) {
    if (type == "entreprise") {
      type = "entreprise";
      setState(() {
        lst = [];
      });
      skip = skip + 24;
      get_entreprise("");
    } else if (type == "user") {
      setState(() {
        lst = [];
        skip = skip + 24;
      });
      getUserss(type);
    } else {
      setState(() {
        lst = [];
        skip = skip + 20;
      });
      getUserss(type);
    }
  }

  getUserss(type) async {
    await get_users_data(type);
    if (widget.bl == true) {

      _tabController.animateTo(2);
      type = "entreprise";
      setState(() {
        lst = [];
      });
      skip = 0;
      get_entreprise("");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<Null> initConnectivity() async {
    String connectionStatus;
    try {
      connectionStatus = (await _connectivity.checkConnectivity()).toString();

      if (connectionStatus != "ConnectivityResult.none") {}
    } on PlatformException catch (e) {
      connectionStatus = 'Failed to get connectivity.';
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _connectionStatus = connectionStatus;
    });
  }

  editloc() async {
    var res = await parse_s.getparse('shops?limit=500&skip=0');
    List sp = res["results"];
    List<Shop> usrs =
        sp.map((var contactRaw) => new Shop.fromMap(contactRaw)).toList();

    for (int i = 0; i < usrs.length; i++) {
      if (usrs[i].latLng.toString() != "null" &&
          usrs[i].latLng.toString() != "") {
        var js = {
          "type": "shop",
          "latLng": usrs[i].latLng,
          "description": usrs[i].description,
          "pictures": usrs[i].pic,
          "name": usrs[i].name,
          ""
              "location": {
            "__type": "GeoPoint",
            "latitude": double.parse(usrs[i].latLng.toString().split(";")[0]),
            "longitude": double.parse(usrs[i].latLng.toString().split(";")[1])
          },
          "lat": double.parse(usrs[i].latLng.toString().split(";")[0]),
          "lng": double.parse(usrs[i].latLng.toString().split(";")[1])
        };

        var resp = await parse_s.postparse("offers/", js);
      }
    }
  }

  gett() async {
    var response = await parse_s.getparse('offers?limit=1000');

    for (var i in response["results"]) {
      var js = {"union": true};
      parse_s.putparse("offers/" + i["objectId"], js);
    }
  }

  display_slides() async {
    //Restez informés sur  tout ce qui se passe au sein de votre communauté à travers l’actualité et les événements.
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString("homes") != "homes") {
      new Timer(new Duration(seconds: 1), () {
        setState(() {
          _menuShown = true;
        });

        prefs.setString("homes", "homes");
      });
    }
  }

  @override
  void initState() {
    super.initState();

    display_slides();
    getUserss(type);
    initConnectivity();
  }

  Widget sizb(wid) => Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Container(
          margin: new EdgeInsets.only(bottom: 7.0, top: 8.0),
          color: Colors.grey[100],
          height: 8.0,
          width: wid,
        ),
      );

  onp() {
    setState(() {
      _menuShown = false;
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    tabs = [
      new Tab(text: LinkomTexts.of(context).pers()),
      new Tab(text: LinkomTexts.of(context).entrep())
    ];

    _tabController = new TabController(vsync: this, length: tabs.length);

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  tap(val){
    if(val == 0){
      setState(() {
        state=1;
      });
    }
    else{
      setState(() {
        state=2;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    Widget tbs = new TabBar(
      isScrollable: true,
      onTap: (val) {
       tap(val);
      },
      tabs: tabs,

      indicatorColor: Fonts.col_app_green,
      indicatorWeight: 3,
      unselectedLabelColor: Fonts.col_grey,
      //isScrollable: false,

      labelColor: Fonts.col_app,
      labelStyle: new TextStyle(
          color: Fonts.col_app,
         // fontFamily: "aa",
          fontWeight: FontWeight.w500,
          fontSize: 15),
      indicatorPadding: new EdgeInsets.all(0.0),
      controller: _tabController,
    );
    ;

    Animation opacityAnimation =
        Tween(begin: 0.0, end: 1.0).animate(animationController);
    if (_menuShown)
      animationController.forward();
    else
      animationController.reverse();

    return
      Positioned.fill(
          child: _connectionStatus == "ConnectivityResult.none"
              ? NoWifi(initConnectivity, false)
              : new Container(
                  color: Colors.grey[200],
                  child: new Stack(fit: StackFit.expand, children: <Widget>[
                    Column(children: [
                     /* Container(
                          width: MediaQuery.of(context).size.width,
                          color: const Color(0xffeff6fb),
                          height: 50,
                          child: Center(child: tbs)),*/
                      Expanded(
                          child: new Container(
                              // padding: new EdgeInsets.only(top: 0.0),
                              child: state == 1
                                  ? UsersStream(widget.user, this.lat, this.lng,
                                      [], widget.analytics, widget.chng)
                                  : EntrepriseStream(
                                      widget.user,
                                      this.lat,
                                      this.lng,
                                      [],
                                      widget.analytics,
                                      widget
                                          .chng) /*new UserWid(
                                lst,
                                widget.user.auth_id,
                                lat,
                                lng,
                                widget.user.id,
                                widget.user,
                                click,
                                widget.auth,
                                widget.onSignedIn,
                                widget.list_partner,
                                count,
                                widget.load,
                                widget.analytics,
                                tbs,
                                type,
                                widget.chng)*/
                              ))
                    ])
                  ]),
                ));
  }
}
