import 'dart:async';
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong/latlong.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/login/commissions/commissions_choices.dart';
import 'package:mycgem/models/commission.dart';
import 'package:mycgem/models/community.dart';
import 'package:mycgem/services/routes.dart';
import 'package:mycgem/user/edit_profile.dart';
import 'package:mycgem/user/organisme_update.dart';
import 'package:mycgem/user/phonewidget.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/models/user.dart';
import 'package:photo_view/photo_view.dart';
import 'package:mycgem/pages/conditions.dart';
import 'package:mycgem/pages/politique.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/user/bio.dart';
import 'package:mycgem/user/competences.dart';
import 'package:mycgem/user/link_profile.dart';
import 'package:mycgem/user/name_info_user.dart';
import 'package:mycgem/user/objectifs.dart';
import 'package:mycgem/user/organisme_title.dart';
import 'package:intl/intl.dart';

enum AppBarBehavior { normal, pinned, floating, snapping }

class MyProfile extends StatefulWidget {
  MyProfile(
    this.user,
    this.show,
    this.show_myprofile,
    this.lat,
    this.lng,
    this.list_partners,
    this.analytics,
    this.chng,
  );

  User user;
  bool show = true;
  var lat;
  var lng;
  bool show_myprofile = true;
  var list_partners;
  var analytics;
  var chng;

  @override
  _Details_userState createState() => _Details_userState();
}

class _Details_userState extends State<MyProfile>
    with TickerProviderStateMixin {
  AnimationController _containerController;
  bool uploading = false;
  String commissions_names = "";

  double _appBarHeight = 190.0;
  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;
  Animation<double> width;
  Animation<double> heigth;
  Distance distance = new Distance();
  ParseServer parse_s = new ParseServer();
  bool val1 = true;
  String type = "";
  bool val2 = false;
  bool val = true;
  bool val_visible = true;
  bool val_loc = true;
  bool val_des = false;
  bool val_not = true;
  bool val_notif_pub = true;
  bool val_notif_opp = true;

  int count2 = 0;
  int count3 = 0;
  int count4 = 0;
  int count5 = 0;
  int count6 = 0;
  int count7 = 0;

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

  setSount4(c) {
    setState(() {
      count4 = c;
    });
  }

  setSount5(c) {
    setState(() {
      count5 = c;
    });
  }

  TabController _tabController;

  // List<Tab> tabs = <Tab>[];

  update() async {
    Map<String, dynamic> mapp = User.toMap(widget.user);
    print(mapp);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", mapp.toString());
  }

  save_image(image) async {
    setState(() {
      uploading = true;
    });

    int timestamp = new DateTime.now().millisecondsSinceEpoch;
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child("profile/img_" + timestamp.toString() + ".jpg");
    await storageReference.put(image).onComplete.then((val) {
      val.ref.getDownloadURL().then((val) {
        var js = {
          "photoUrl": val.toString(),
        };

        parse_s.putparse("users/" + widget.user.id, js);

        if (!mounted) return;

        setState(() {
          widget.user.image = val.toString();
          update();
          uploading = false;
        });
      });
    });
  }

  make_user_online() async {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map["online"] = true;
    map["offline"] = "";

    map["last_active"] = 0;
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

  getOnlineUser() async {
    DocumentSnapshot a = await Firestore.instance
        .collection('users')
        .document(widget.user.auth_id)
        .get();

    if (!this.mounted) return;

    if (a.data["offline"].toString() == "offline") {
      setState(() {
        widget.user.online = false;
        widget.user.offline = "offline";
        val = false;
      });
    } else
      setState(() {
        val = true;
      });
  }

  Future _cropImage(image) async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
    );
    if (croppedFile != null) {
      image = croppedFile;
      //ImageProperties properties = await FlutterNativeImage.getImageProperties(image.path);
      File compressedFile =
          await FlutterNativeImage.compressImage(image.path, quality: 70);
      save_image(compressedFile);
    }
  }

//        prefs.setString("user", json.encode(res["results"][0]));

  /*Widget tbs() => new TabBar(
        isScrollable: true,
        unselectedLabelColor: Colors.grey[700],
        labelColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: new BubbleTabIndicator(
          insets: EdgeInsets.all(0.0),
          padding: EdgeInsets.all(0.0),
          indicatorHeight: 24.0,
          indicatorRadius: 4.0,
          indicatorColor: Fonts.col_app,
          tabBarIndicatorSize: TabBarIndicatorSize.tab,
        ),
        tabs: tabs,
        controller: _tabController,
      );*/

  @override
  void initState() {
    if (widget.show == false) {
      widget.user.online = false;
      getOnlineUser();
      widget.user.list = [];
      widget.user.list_obj = [];

      if (widget.user.objectif != null) {
        for (var i in widget.user.objectif) {
          setState(() {
            widget.user.list_obj.add(i);
          });
        }
      }

      if (widget.user.cmpetences != null) {
        for (var i in widget.user.cmpetences) {
          widget.user.list.add(i);
        }
      }

      val_visible = widget.user.raja == false ? false : true;
      val_loc = widget.user.active_loc == 1 ? true : false;
      /* widget.user.dis = distance
          .as(
          LengthUnit.Kilometer,
          new LatLng(double.parse(widget.user.lat),
              double.parse(widget.user.lng)),
          new LatLng(widget.lat, widget.lng))
          .toString() +
          " Km(s)";*/
    }
    _containerController = new AnimationController(
        duration: new Duration(milliseconds: 2000), vsync: this);
    super.initState();
    width = new Tween<double>(
      begin: 160.0,
      end: 160.0,
    ).animate(
      new CurvedAnimation(
        parent: _containerController,
        curve: Curves.ease,
      ),
    );
    heigth = new Tween<double>(
      begin: 160.0,
      end: 160.0,
    ).animate(
      new CurvedAnimation(
        parent: _containerController,
        curve: Curves.ease,
      ),
    );
    heigth.addListener(() {
      setState(() {
        if (heigth.isCompleted) {}
      });
    });
    _containerController.forward();
  }

  @override
  void dispose() {
    _containerController.dispose();
    super.dispose();
  }

  _handleCameraButtonPressed() async {
    Navigator.of(context).pop(true);
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    _cropImage(image);
  }

  _handleGalleryButtonPressed() async {
    Navigator.of(context).pop(true);
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _cropImage(image);
  }

  open_bottomsheet() {
    showModalBottomSheet<bool>(
        context: context,
        builder: (BuildContext context) {
          return new Container(
              height: 112.0,
              child: new Container(
                  // padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                  child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                    new ListTile(
                        onTap: _handleCameraButtonPressed,
                        title: new Text("Prendre une photo")),
                    new ListTile(
                        onTap: _handleGalleryButtonPressed,
                        title: new Text("Photo depuis la galerie")),
                  ])));
        });
  }

  desactivate_compte() async {
    Widgets.onLoading(context);
    await Firestore.instance
        .collection('user_notifications')
        .document(widget.user.auth_id)
        .updateData({"send": "no"});

    String id = widget.user.id;
    var query =
        '"author":{"\$inQuery":{"where":{"objectId":"$id"},"className":"users"}}';
    var url = "offers?where={$query}";

    var res = await parse_s.getparse(url);

    for (var i in res["results"]) {
      print(i["objectId"]);
      parse_s.putparse("offers/" + i["objectId"], {"active": 0});
    }
    var js = {"token": "", "active": 0, "des": true};
    await parse_s.putparse("users/" + widget.user.id, js);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.setString("Slides", "yess");
    prefs.setString("cov", "cov");
    prefs.setString("homes", "homes");
    prefs.setString("con", "con");
    prefs.setString("par", "par");
    prefs.setString("pub", "pub");
    prefs.setString("shop", "shop");

    await FirebaseAuth.instance.signOut();
    Navigator.of(context, rootNavigator: true).pop('dialog');

    Routes.go_login(context, null, null, [], widget.analytics, widget.chng);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    /* tabs = [
      new Tab(
          text: count2 == 0
              ? LinkomTexts.of(context).infos()
              : LinkomTexts.of(context).infos() +
                  " (" +
                  count2.toString() +
                  ")"),
      new Tab(
          text: count3 == 0
              ? "Status"
              : "Status" + " (" + count3.toString() + ")"),
      new Tab(
          text: count4 == 0
              ? LinkomTexts.of(context).ann()
              : LinkomTexts.of(context).ann() + " (" + count4.toString() + ")"),
      new Tab(
          text: count5 == 0
              ? LinkomTexts.of(context).sond()
              : LinkomTexts.of(context).sond() +
                  " (" +
                  count5.toString() +
                  ")"),
    ];
    _tabController = new TabController(vsync: this, length: tabs.length);*/
  }

  ///  List<Commission> cms = [];

  goto_comm() async {
    List<Commission> pr = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) =>
                //new HomePage(widget.auth,widget.sign)
                new CommissionsListChoice(widget.user.id,
                    comm: List<Commission>.from(widget.user
                        .commissions)) /*Submit_type_profile(
                  /*com,*/
                  null,
                  null,
                  widget.list_partner,
                  */
            ));
    print("<3");

    setState(() {
      print(pr.length);

      widget.user.commissions = pr;
      /* for (Commission com in pr) {
        commissions_names = commissions_names + " " + com.name + ", ";
      }*/
      // id_spec = pr[0].id;
      // prfs1 = new Speciality(pr[0].id, pr[0].type, pr[0].Name);
    });
  }

  Widget coomissions_widget() => widget.user.verify.toString() != "1"
      ? Container()
      : new InkWell(
          child: new Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.only(left: 8, right: 4, top: 12, bottom: 12),
              decoration: new BoxDecoration(
                border: new Border.all(color: Colors.grey[400], width: 1.0),
                borderRadius: new BorderRadius.circular(4.0),
              ),
              child: new Row(children: <Widget>[
                new Container(width: 8.0),
                new Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: new Text(LinkomTexts.of(context).commission(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: new TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[500]))),
                new Container(
                  width: 4.0,
                ),
                new Container(
                  width: 8.0,
                ),
                new Expanded(child: new Container()),
                new Image.asset(
                  "images/arr.png",
                  width: 20,
                  height: 20,
                ),
                new Container(
                  width: 8.0,
                ),
              ])),
          onTap: () async {
            goto_comm();
          });

  @override
  Widget build(BuildContext context) {
    /*Widget gsm = Widgets.textfield0(
      "GSM",
      _focusphone,
      user.phone,
      _phonecontroller,
      TextInputType.phone,
    );*/

    var divider = new Container(
      color: Colors.grey[300],
      width: 10000.0,
      height: 1.0,
    );

    Widget a(text) => new Container(
          padding: new EdgeInsets.all(6.0),
          //  width: 150.0,
          //alignment: Alignment.center,
          decoration: new BoxDecoration(
            border: new Border.all(color: Colors.blue, width: 1.0),
            color: Colors.transparent,
            borderRadius: new BorderRadius.circular(8.0),
          ),
          child: new Text(
            "#" + text,
            style: new TextStyle(color: Colors.blue),
          ),
        );

    edit_name() async {
      User us = await Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) {
        return new InfoUser1(widget.user);
      }));

      setState(() {
        widget.user = us;
      });
    }

    edit_titre() async {
      User us = await Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) {
        return new OrganismeTitle(widget.user);
      }));

      setState(() {
        widget.user = us;
      });
    }

    edit_comp() async {
      User us = await Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) {
        return new Cmpetences(widget.user);
      }));

      setState(() {
        widget.user.cmpetences = us.cmpetences;
      });
    }

    Community community;

    edit_link(type) async {
      //
      User us = await Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) {
        return new Link_profile(widget.user, type);
      }));

      setState(() {
        widget.user = us;
      });
    }

    make_user_offline() async {
      Map<String, dynamic> map = new Map<String, dynamic>();
      map["online"] = false;
      map["last_active"] = new DateTime.now().millisecondsSinceEpoch;
      map["offline"] = "offline";

      Firestore.instance
          .collection('users')
          .document(widget.user.auth_id)
          .updateData(map);

      FirebaseDatabase.instance
          .reference()
          .child("status")
          .update({widget.user.auth_id: false});

      FirebaseDatabase.instance
          .reference()
          .child("status")
          .update({widget.user.auth_id: false});
    }

    edit_objectifs() async {
      User us = await Navigator.push(
        context,
        new PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> _,
              Animation<double> __) {
            return new Objectifs_widget(widget.user);
          },
        ),
      );

      setState(() {
        widget.user = us;
      });
    }

    save_niveau(va) {
      var js = {
        "niveau": va,
      };

      parse_s.putparse("users/" + widget.user.id, js);
    }

    edit_bio() async {
      User us = await Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) {
        return new Bio(widget.user);
      }));

      setState(() {
        widget.user = us;
      });
    }

    edit_num() async {
      User us = await Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) {
        return new PhoneWidget(widget.user);
      }));

      setState(() {
        widget.user = us;
      });
    }

    edit_phone() {}

    editwidget(colors, tap) {
      return new InkWell(
          child: new Container(
              padding: EdgeInsets.only(left: 8.0, right: 8.0),
              child: new Icon(
                Icons.edit,
                color: colors,
              )),
          onTap: () {
            tap();
          });
    }

    Widget phone_widget = new Row(
      children: <Widget>[
        new Text("Numéro de téléphone:"),
        new Container(
          width: 12,
        ),
        editwidget(Fonts.col_app, edit_phone)
      ],
    );

    String fedrations_names = "";

    /*
    goto_feds() async {
      String pr = await Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) =>
                  //new HomePage(widget.auth,widget.sign)
                  new FederationListChoice(widget.user
                      .id) /*Submit_type_profile(
                  /*com,*/
                  null,
                  null,
                  widget.list_partner,
                  */
              ));
      print("<3");

      setState(() {
        fedrations_names = pr;
      });
    }
    */

    Widget coomissions_feds() => new InkWell(
        child: new Container(
            margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
            padding: EdgeInsets.only(left: 8, right: 4, top: 12, bottom: 12),
            decoration: new BoxDecoration(
              border: new Border.all(color: Colors.grey[400], width: 1.0),
              borderRadius: new BorderRadius.circular(4.0),
            ),
            child: new Row(children: <Widget>[
              new Container(width: 8.0),
              new Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: new Text(
                      fedrations_names.toString() == "" ||
                              fedrations_names.toString() == "null"
                          ? LinkomTexts.of(context).fed()
                          : fedrations_names.toString().toUpperCase(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: new TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[500]))),
              new Container(
                width: 4.0,
              ),
              new Container(
                width: 8.0,
              ),
              new Expanded(child: new Container()),
              new Image.asset(
                "images/arr.png",
                width: 20,
                height: 20,
              ),
              new Container(
                width: 8.0,
              ),
            ])),
        onTap: () async {
          // goto_feds();
        });

    Widget details = new ListView(children: <Widget>[
      new Container(height: 8.0),
      Container(
          height: 56.h,
          child: RaisedButton(
              color: Fonts.col_ap_fonn,
              child: Text(
                "Modifier mon organisme",
                style: TextStyle(color: Colors.white, fontSize: 18.sp),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new EditMyOrganisme(widget.user.entreprise)));
              })),
      new Container(height: 8.0.h),

      //  phone_widget,

      coomissions_widget(),

      Column(
        children: List<Commission>.from(widget.user.commissions)
            .map((Commission e) => Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(e.name, textAlign: TextAlign.left),
                    Container(
                      height: 8,
                    ),
                    Container(
                      width: 600,
                      height: 1,
                      color: Fonts.col_grey.withOpacity(0.4),
                    ),
                    Container(
                      height: 8,
                    ),
                  ],
                )))
            .toList(),
      ),

      Container(
        height: 12,
      ),

      ///widget.user.verify.toString() != "1" ? Container() : coomissions_feds(),
      Container(
        height: 12,
      ),
      new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        new Center(
            child: new Text("Numéro de téléphone",
                style: new TextStyle(
                    color: Colors.grey[800], fontWeight: FontWeight.w600))),
        new Container(width: 12.0),
        editwidget(Fonts.col_app, edit_num)
      ]),

      widget.user.phone != "" && widget.user.phone.toString() != "null"
          ? Container(
              height: 12,
            )
          : Container(),

      widget.user.phone != "" && widget.user.phone.toString() != "null"
          ? Center(
              child: new Container(
              // padding:
              // new EdgeInsets.only(left: 16.0, right: 16.0),
              // width: 300.0,
              child: new Text(widget.user.phone.toString(),
                  style: TextStyle(color: Colors.grey[800])),
            ))
          : new Container(
              child: new Center(
                child: new Text(
                  "Ajouter votre numéro de téléphone ..",
                  style: new TextStyle(color: Colors.grey, fontSize: 16.0),
                ),
              ),
            ),

      Container(
        height: 8,
      ),

      new Container(
        height: 1.0,
        width: 1000.0,
        color: Colors.grey[300],
      ),
      Container(
        height: 8,
      ),

      new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        new Center(
            child: new Text(LinkomTexts.of(context).compe(),
                style: new TextStyle(
                    color: Colors.grey[800], fontWeight: FontWeight.w600))),
        new Container(width: 12.0),
        editwidget(Fonts.col_app, edit_comp)
      ]),
      new Container(height: 12.0),
      widget.user.cmpetences != null && widget.user.cmpetences.isNotEmpty
          ? new Center(
              child: new Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: widget.user.cmpetences.map((String item) {
                    return a(item);
                  }).toList()))
          : new Container(
              padding: new EdgeInsets.only(top: 16.0, bottom: 24.0),
              child: new Center(
                child: new Text(
                  "Ajoutez votre domaine d’expertise",
                  style: new TextStyle(color: Colors.grey[500], fontSize: 16.0),
                ),
              ))
      /* new Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: <Widget>[

                              a("PHP"),
                              a("#CSS"),
                              a("#Javascript")
                            ],
                          )*/
      ,
      new Container(
        height: 14.0,
      ),
      new Container(
        height: 1.0,
        width: 1000.0,
        color: Colors.grey[300],
      ),
      new Container(
        height: 12.0,
      ),
      new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        new Center(
            child: new Text(
          LinkomTexts.of(context).objs(),
          style: new TextStyle(
              color: Colors.grey[800], fontWeight: FontWeight.w600),
        )),
        Container(width: 12.0),
        editwidget(Fonts.col_app, edit_objectifs)
      ]),
      new Container(
        height: 12.0,
      ),

      widget.user.list_obj.isNotEmpty
          ? new Center(
              child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: widget.user.list_obj.map((String item) {
                    return new Container(
                        padding: new EdgeInsets.all(8.0),
                        margin: new EdgeInsets.only(bottom: 8.0),
                        height: 36.0,
                        //alignment: Alignment.center,
                        decoration: new BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: new BorderRadius.circular(8.0),
                        ),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Icon(Icons.bookmark_border,
                                color: Fonts.col_app),
                            new Container(
                              width: 4.0,
                            ),
                            new Text(
                              item,
                              style: new TextStyle(color: Fonts.col_app_fon),
                            )
                          ],
                        ));
                  }).toList()))
          : new Container(
              padding: new EdgeInsets.only(top: 16.0, bottom: 24.0),
              child: new Center(
                child: new Text(
                  "Aucun objectif n'a été mentionné",
                  style: new TextStyle(color: Colors.grey[500], fontSize: 16.0),
                ),
              )),
      new Container(
        height: 12.0,
      ),
      new Container(
        height: 12.0,
      ),
      new Container(
        height: 1.0,
        width: 1000.0,
        color: Colors.grey[300],
      ),
      new Container(
        height: 12.0,
      ),

      new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        new Center(
            child: new Text("BIO",
                style: new TextStyle(
                    color: Colors.grey[800], fontWeight: FontWeight.w600))),
        new Container(width: 12.0),
        editwidget(Fonts.col_app, edit_bio)
      ]),

      new Container(
        height: 8.0,
      ),
      widget.user.bio != "" && widget.user.bio.toString() != "null"
          ? new Container(
              padding: new EdgeInsets.only(left: 16.0, right: 16.0),
              width: 300.0,
              child: new Text(widget.user.bio.toString()),
            )
          : new Container(
              child: new Center(
                child: new Text(
                  "Ajouter une description ..",
                  style: new TextStyle(color: Colors.grey, fontSize: 16.0),
                ),
              ),
            ),
      new Container(height: 8.0),
      new Container(
        height: 1.0,
        width: 1000.0,
        color: Colors.grey[300],
      ),
      new Container(height: 14.0),

      new GestureDetector(
          onTap: () {},
          child: new Row(
            children: <Widget>[
              new Container(
                width: 12.0,
              ),
              new Image.asset(
                "images/linked.png",
                width: 60.0,
                height: 60.0,
              ),
              new Container(
                width: 12.0,
              ),
              widget.user.linkedin_link != "" &&
                      widget.user.linkedin_link.toString() != "null"
                  ? new Center(
                      child: new Container(
                          width: 180.0,
                          child: new Text(
                            widget.user.linkedin_link.toString(),
                            style: new TextStyle(color: Colors.grey[600]),
                          )))
                  : new Text(
                      "Profil Linkedin:",
                      style: new TextStyle(
                          color: Colors.grey[800], fontWeight: FontWeight.w600),
                    ),
              new Expanded(child: Container()),
              new InkWell(
                  child: new Container(
                      padding: new EdgeInsets.all(16.0),
                      decoration: new BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.blue[50],
                            offset: new Offset(0.0, 0.8),
                            blurRadius: 30.0,
                          ),
                        ],
                      ),
                      child: new Icon(
                        Icons.edit,
                        color: Fonts.col_app,
                      )),
                  onTap: () {
                    edit_link("linkedin");

                    // open_bottomsheet();
                  }),
            ],
          )),

      new Container(height: 14.0),

      new GestureDetector(
          onTap: () {},
          child: new Row(
            children: <Widget>[
              new Container(
                width: 12.0,
              ),
              new Image.asset(
                "images/twitter.png",
                width: 60.0,
                height: 60.0,
              ),
              new Container(
                width: 12.0,
              ),
              widget.user.twitter_link != "" &&
                      widget.user.twitter_link.toString() != "null"
                  ? new Center(
                      child: new Text(
                      widget.user.twitter_link.toString(),
                      style: new TextStyle(color: Colors.grey[600]),
                    ))
                  : new Text(
                      "Profil Twitter:",
                      style: new TextStyle(
                          color: Colors.grey[800], fontWeight: FontWeight.w600),
                    ),
              new Expanded(child: Container()),
              new InkWell(
                  child: new Container(
                      padding: new EdgeInsets.all(16.0),
                      decoration: new BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.blue[50],
                            offset: new Offset(0.0, 0.8),
                            blurRadius: 30.0,
                          ),
                        ],
                      ),
                      child: new Icon(
                        Icons.edit,
                        color: Fonts.col_app,
                      )),
                  onTap: () {
                    edit_link("twitter");

                    // open_bottomsheet();
                  }),
            ],
          )),
      new Container(
        height: 12.0,
      ),
      divider,
      new Center(
          child: new Container(
              padding: new EdgeInsets.only(
                  top: 16.0, left: 8.0, right: 8.0, bottom: 16.0),
              // color: Colors.grey[100],
              child: new Text(
                "Paramètres :",
                style: new TextStyle(
                    color: Colors.grey[800], fontWeight: FontWeight.bold),
              ))),
      divider,
      new Container(
        color: Colors.grey[50],
        padding:
            new EdgeInsets.only(left: 16.0, right: 8.0, top: 4.0, bottom: 4.0),
        // color: Colors.grey[100],
        child: new Row(
          children: <Widget>[
            new Text(
              "Mode en ligne :",
              style: new TextStyle(fontSize: 15.0),
            ),
            new Expanded(child: new Container(width: 12.0)),
            new Switch(
              value: val,
              onChanged: (bool value) {
                setState(() {
                  val = value;
                });

                if (val) {
                  make_user_online();
                } else {
                  make_user_offline();
                }
              },
            )
          ],
        ),
      ),

      divider,

      new Container(
        color: Colors.grey[50],

        padding: new EdgeInsets.only(
          bottom: 4.0,
          top: 4.0,
          left: 16.0,
          right: 8.0,
        ),
        // color: Colors.grey[100],
        child: new Row(
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width * 0.78,
                child: new Text("Je veux recevoir les notifications "
                    "de messages et des demandes de connexion :")),
            new Expanded(child: new Container(width: 12.0)),
            new Switch(
                value: widget.user.notif_user,
                onChanged: (value) async {
                  setState(() {
                    widget.user.notif_user = value;
                  });

                  if (widget.user.notif_user == true) {
                    OneSignal.shared.sendTag("userId", widget.user.auth_id);
                    /* await _firebaseMessaging
                                        .subscribeToTopic(user.auth_id);*/

                    parse_s.putparse(
                        "users/" + widget.user.id, {"notif_user": "on"});
                  } else {
                    OneSignal.shared.deleteTag("userId");

                    /* await _firebaseMessaging
                                        .unsubscribeFromTopic(user.auth_id);*/

                    parse_s.putparse(
                        "users/" + widget.user.id, {"notif_user": "off"});
                  }
                })
          ],
        ),
      ),
      divider,
      new Container(
        color: Colors.grey[50],

        padding: new EdgeInsets.only(
          bottom: 4.0,
          top: 4.0,
          left: 16.0,
          right: 8.0,
        ),
        // color: Colors.grey[100],
        child: new Row(
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width * 0.78,
                child: new Text("Je veux recevoir les notifications "
                    "d'actualités et d'évènements :")),
            new Expanded(child: new Container(width: 12.0)),
            new Switch(
                value: widget.user.val_notif_pub,
                onChanged: (value) async {
                  setState(() {
                    widget.user.val_notif_pub = value;
                  });

                  if (widget.user.val_notif_pub == true) {
                    /* await _firebaseMessaging
                                        .subscribeToTopic("publication");*/
                    OneSignal.shared.sendTag("publication", "publication");

                    parse_s.putparse(
                        "users/" + widget.user.id, {"val_notif_pub": "on"});
                  } else {
                    OneSignal.shared.deleteTag("publication");

                    /*await _firebaseMessaging
                                        .unsubscribeFromTopic("publication");*/

                    parse_s.putparse(
                        "users/" + widget.user.id, {"val_notif_pub": "off"});
                  }
                })
          ],
        ),
      ),
      divider,

      new Container(
        color: Colors.grey[50],

        padding: new EdgeInsets.only(
          bottom: 4.0,
          top: 4.0,
          left: 16.0,
          right: 8.0,
        ),
        // color: Colors.grey[100],
        child: new Row(
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width * 0.78,
                child: new Text("Je veux recevoir les notifications "
                    "d'opportunité d'affaires :")),
            new Expanded(child: new Container(width: 12.0)),
            new Switch(
                value: widget.user.val_notif_opp,
                onChanged: (value) async {
                  setState(() {
                    widget.user.val_notif_opp = value;
                  });

                  if (widget.user.val_notif_opp == true) {
                    OneSignal.shared.sendTag("opportunite", "opportunite");

                    parse_s.putparse(
                        "users/" + widget.user.id, {"val_notif_opp": "on"});
                  } else {
                    print("noooo");
                    OneSignal.shared.deleteTag("opportunite");

                    parse_s.putparse(
                        "users/" + widget.user.id, {"val_notif_opp": "off"});
                  }
                })
          ],
        ),
      ),
      divider,
      new Container(
        color: Colors.grey[50],

        padding: new EdgeInsets.only(
          bottom: 4.0,
          top: 4.0,
          left: 16.0,
          right: 8.0,
        ),
        // color: Colors.grey[100],
        child: new Row(
          children: <Widget>[
            new Text("Je veux désactiver mon compte :"),
            new Expanded(child: new Container(width: 12.0)),
            new Switch(
                value: val_des,
                onChanged: (val) {
                  setState(() {
                    val_des = val;
                  });
                  if (val) {
                    desactivate_compte();
                  } else {
                    print(false);
                  }
                })
          ],
        ),
      ),
      divider,

      new InkWell(
          onTap: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => new Potique()));
          },
          child: new Container(
            color: Colors.grey[50],
            padding: new EdgeInsets.only(
              top: 12.0,
              bottom: 12.0,
              left: 16.0,
              right: 8.0,
            ),
            // color: Colors.grey[100],
            child: new Row(
              children: <Widget>[
                new Text("Politique de confidentialité :"),
                new Expanded(child: new Container(width: 12.0)),
                new Icon(Icons.arrow_right)
              ],
            ),
          )),
      divider,
      new InkWell(
          onTap: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => new Conditions()));
          },
          child: new Container(
            color: Colors.grey[50],

            padding: new EdgeInsets.only(
              top: 12.0,
              bottom: 12.0,
              left: 16.0,
              right: 8.0,
            ),
            // color: Colors.grey[100],
            child: new Row(
              children: <Widget>[
                new Text(
                  "Conditions générales d'utilisation :",
                  style: TextStyle(),
                ),
                new Expanded(child: new Container(width: 12.0)),
                new Icon(Icons.arrow_right)
              ],
            ),
          ))
    ]);

    Widget page = new Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        new CustomScrollView(
          shrinkWrap: false,
          slivers: <Widget>[
            new SliverAppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              elevation: 0.0,
              forceElevated: true,
              expandedHeight: _appBarHeight,
              pinned: _appBarBehavior == AppBarBehavior.pinned,
              floating: _appBarBehavior == AppBarBehavior.floating ||
                  _appBarBehavior == AppBarBehavior.snapping,
              snap: _appBarBehavior == AppBarBehavior.snapping,
              flexibleSpace: new FlexibleSpaceBar(
                //: IconThemeData(color: Fonts.col_app_fon),

                title: new Text(""),
                background: new Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    new Container(
                      width: width.value,
                      height: _appBarHeight,

                      /*decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image: new NetworkImage(widget.user.image),
                                fit: BoxFit.cover,
                              ),
                            ),*/
                      child: new Container(
                          decoration: new BoxDecoration(
                            color: Fonts.col_app.withOpacity(0.06),
                            /*image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    colorFilter: new ColorFilter.mode(
                                        Colors.black.withOpacity(0.3),
                                        BlendMode.dstATop),
                                    image: new NetworkImage(
                                      widget.user.image,
                                    ),
                                  ),*/
                          ),
                          child: new Column(children: <Widget>[
                            new Row(
                              children: <Widget>[
                                new Expanded(child: new Container()),
                              ],
                            ),
                            new Container(
                              height: 4.0,
                            ),
                            /*new GestureDetector(
                                      onTap: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => FullScreenWrapper(
                                                imageProvider: NetworkImage(widget.user.image),
                                              ),
                                            )
                                        );
                                      },
                                      child:*/ /*new Hero(
                                        tag: widget.user.id,
                                        child: */
                            new Container(
                                child: new Stack(children: [
                              new Center(
                                  child: new Container(
                                child: new CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(widget.user.image),
                                  radius: 45.0,
                                ),
                              )),
                              new Positioned(
                                  bottom: 0.0,
                                  //bottom: 8.0,
                                  left: 46.0,
                                  right: -8.0,
                                  child: new CircleAvatar(
                                      radius: 20.0,
                                      backgroundColor: Colors.blue[300],
                                      child: new IconButton(
                                          color: Colors.grey[100],
                                          icon: new Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            open_bottomsheet();
                                          }))),
                              uploading
                                  ? new Positioned(
                                      top: 8.0,
                                      //bottom: 8.0,
                                      left: 8.0,
                                      right: 8.0,
                                      child: new Center(
                                          child: new CircularProgressIndicator(
                                              // backgroundColor: Colors.grey,
                                              //value: 16.0,
                                              )))
                                  : new Container()
                            ])),
                            new Container(
                              height: 8.0,
                            ),
                            new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Container(width: 28.0),
                                  new Container(
                                      child: new Center(
                                          child: new Text(
                                    widget.user.age.toString() != ""
                                        ? toBeginningOfSentenceCase(widget
                                                .user.firstname
                                                .toString()) +
                                            " " +
                                            widget.user.fullname
                                                .toString()
                                                .toUpperCase() +
                                            ", " +
                                            widget.user.age.toString() +
                                            " ans"
                                        : toBeginningOfSentenceCase(widget
                                                .user.firstname
                                                .toString()) +
                                            " " +
                                            widget.user.fullname
                                                .toString()
                                                .toUpperCase(),
                                    style: new TextStyle(
                                        color: Colors.black,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w700),
                                  ))),
                                  editwidget(Fonts.col_app, edit_name),
                                ]),
                            new Container(
                              height: 6.0,
                            ),
                            new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Container(width: 28.0),
                                  new Container(
                                      child: new Center(
                                          child: new Text(
                                              widget.user.fonction.name
                                                      .toString() +
                                                  " à " +
                                                  widget.user.organisme,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: new TextStyle(
                                                  color: Colors.grey[400],
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.center))),
                                  // editwidget(Fonts.col_app, edit_titre),
                                ]),
                          ])),
                    ),
                  ],
                ),
              ),
            ),
            //  new SliverToBoxAdapter(child: Center(child: tbs())),
            new SliverToBoxAdapter(
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: details

                    /* TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: _tabController,
                        children: [
                          details,
                          StreamParcPub(
                            new Container(),
                            widget.lat,
                            widget.lng,
                            widget.user,
                            "0",
                            [],
                            widget.analytics,
                            setSount3,
                            widget.chng,
                            type: "an",
                            profile: "profile",
                            user_id_cov: "Général",
                            favorite: false,
                            boutique: false,
                          ),
                          StreamParcPub(
                            new Container(),
                            widget.lat,
                            widget.lng,
                            widget.user,
                            "0",
                            [],
                            widget.analytics,
                            setSount2,
                            widget.chng,
                            type: "an",
                            profile: "profile",
                            user_id_cov: "Annonces",
                            favorite: false,
                            boutique: false,
                          ),
                          StreamParcPub(
                            new Container(),
                            widget.lat,
                            widget.lng,
                            widget.user,
                            "0",
                            [],
                            widget.analytics,
                            setSount5,
                            widget.chng,
                            type: "sondage",
                            profile: "profile",
                            favorite: false,
                            boutique: false,
                          ),
                        ])*/
                    ))
          ],
        ),
      ],
    );

    Widget informatin(icon , text){
      return  Container(
        child: Row(
          children: [
            Image.asset(icon ,height: 18 , width: 11, ),
            SizedBox(width: 11,),
            Container(
              child:
              Text(text,style: TextStyle(color: Color(0xffa5a5a5),fontFamily: "louis george cafe", fontSize: 13,fontWeight: FontWeight.w300)),

            ),
          ],
        ),
      );
    }

    Widget parametre(text,switchh){
      return Container(
        margin: EdgeInsets.only(bottom: 11),
        height: 40,
        width: 300,
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
        decoration: BoxDecoration(
          color: Color(0xffF8F8F8),
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Row(
          children: [
            Container(
              width: 235,
              child: Text(text,maxLines: 2,style: TextStyle(color: Color(0xffa5a5a5),fontSize: 11,fontWeight: FontWeight.w300,fontFamily: "louis george cafe"),),
            ),
            Expanded(child: Container()),
            Container(
              child: switchh,
            ),
          ],
        ),
      );
    }

    row(name, icon,tap) => new ListTile(
        onTap: () {
          tap();
        },
        title: Row(children: [
          Image.asset(
            icon,
            width: 20,
            height: 20,
            // color: Fonts.col_app,
          ),
          Container(
            width: 16.0,
          ),
          new Text(
            name,
            style: TextStyle(fontSize: 14.5, color: Colors.white),
          )
        ]));
     bool more_commissions = false ;
    Widget page2 = Container(
        color: Color.fromRGBO(247, 247, 247, 100),
        child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.only(left: 27, right: 27,top: 60),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.5),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                  ),
                  color: Colors.white,
                ),
                child: ListView(
                  children: [
                    SizedBox(height: 20,),
                    Container(
                      child: Row(
                        children: [
                          Expanded(child: Container()),
                          InkWell(
                              onTap : () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                        new EditMyOrganisme(widget.user.entreprise)));
                              },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(25)),
                                border: Border.all(color: Color(0xff218bb1),),
                              ),
                              height: 25,
                              width: 142,
                              padding: EdgeInsets.only(
                                  left: 15,right: 14,bottom: 5,top: 5
                              ),
                              child: Text("Modifier l’organisme ",style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 11 , color: Color(0xff218bb1)
                              ),),
                            ),
                          ),
                          SizedBox(width: 27,),
                        ],
                      ),
                    ),


                    SizedBox(height: 23,),
                    Container(
                      child: Row(
                        children: [
                          Icon(Icons.account_circle,size: 20,),
                          SizedBox(width: 11,),
                          Container(
                            child: Row(
                              children: [
                                Text(toBeginningOfSentenceCase(widget
                                    .user.firstname
                                    .toString())
                                    .toUpperCase(),style: TextStyle(color: Color(0xff272c6e) ,fontSize:18 ,fontWeight: FontWeight.bold ,fontFamily: "louis george cafe" ),),
                                SizedBox(width: 5,),
                                Text(toBeginningOfSentenceCase(widget
                                    .user.fullname
                                    .toString()),style: TextStyle(color: Color(0xff272c6e),fontSize:18 ,fontWeight: FontWeight.w500,fontFamily: "louis george cafe"),)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12,),

                    Container(
                      padding: EdgeInsets.only(left: 43,),

                      child: Text(  widget.user.fonction.name
                          .toString() +
                          " à " +
                          widget.user.organisme,maxLines: 1,style: TextStyle(color: Color(0xff187fb2),fontFamily: "louis george cafe", fontSize: 13,fontWeight: FontWeight.w500),),
                    ),
                    SizedBox(height: 12,),


                    Container(
                      padding: EdgeInsets.only(left: 43,),
                      child: Text(widget.user.bio,
                        style: TextStyle(color: Color(0xffa5a5a5),fontFamily: "louis george cafe", fontSize: 13,fontWeight: FontWeight.w300),),
                    ),


                    SizedBox(height: 12,),

                    Column(
                      children: [

                        new Row(mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(Icons.account_circle,size: 20,),
                              SizedBox(width: 11,),
                          new Center(
                              child: new Text(LinkomTexts.of(context).compe(),
                                   style: TextStyle(color: Color(0xffa5a5a5),fontFamily: "louis george cafe", fontSize: 13,fontWeight: FontWeight.w300)
                              )
                          ),


                          // new Container(width: 12.0),
                          // editwidget(Fonts.col_app, edit_comp)
                        ]),


                        new Container(height: 12.0),
                        widget.user.cmpetences != null && widget.user.cmpetences.isNotEmpty
                            ? new Center(
                            child: new Wrap(
                                crossAxisAlignment: WrapCrossAlignment.start,
                                spacing: 8.0,
                                runSpacing: 8.0,
                                children: widget.user.cmpetences.map((String item) {
                                  return a(item);
                                }).toList()))
                            : new Container(
                            padding: new EdgeInsets.only(top: 10.0, bottom: 12.0),
                            child: new Center(
                              child: new Text(
                                "Ajoutez votre domaine d’expertise",
                                style: new TextStyle(color: Color(0xffa5a5a5),fontFamily: "louis george cafe", fontSize: 13,fontWeight: FontWeight.w300),
                              ),
                            ))
                      ],
                    ),

                    SizedBox(height: 12,),

                    new Row(
                        mainAxisAlignment: MainAxisAlignment.start , children: <Widget>[

                      Icon(Icons.account_circle,size: 20,),
                      SizedBox(width: 11,),
                      new Center(
                          child: new Text(
                            LinkomTexts.of(context).objs(),
                            style: new TextStyle(
                                color: Color(0xffa5a5a5),
                                fontFamily: "louis george cafe",
                                fontSize: 13,
                                fontWeight: FontWeight.w300),
                          )
                      ),
                      // Container(width: 12.0),
                      // editwidget(Fonts.col_app, edit_objectifs)
                    ]),
                    new Container(
                      height: 12.0,
                    ),

                    widget.user.list_obj.isNotEmpty
                        ? new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: widget.user.list_obj.map((String item) {
                              return new Container(
                                  padding: new EdgeInsets.all(8.0),
                                  margin: new EdgeInsets.only(bottom: 8.0),
                                  height: 36.0,
                                  //alignment: Alignment.center,
                                  decoration: new BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: new BorderRadius.circular(8.0),
                                  ),
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Icon(Icons.bookmark_border,
                                          color: Fonts.col_app),
                                      new Container(
                                        width: 4.0,
                                      ),
                                      new Text(
                                        item,
                                        style: new TextStyle(color: Fonts.col_app_fon),
                                      )
                                    ],
                                  ));
                            }).toList())
                        : new Container(
                        padding: new EdgeInsets.only(top: 16.0, bottom: 24.0),
                        child: new Center(
                          child: new Text(
                            "Aucun objectif n'a été mentionné",
                            style: new TextStyle(color: Colors.grey[500], fontSize: 16.0),
                          ),
                        )),
                    new Container(
                      height: 12.0,
                    ),
                    new Container(
                      height: 12.0,
                    ),



                    Container(
                      child: Row(
                        children: [
                          Icon(Icons.email,size: 20,),
                          SizedBox(width: 11,),
                          Container(
                            child:
                            Text(widget.user.email,style: TextStyle(color: Color(0xffa5a5a5),fontFamily: "louis george cafe", fontSize: 13,fontWeight: FontWeight.w300)),

                          ),
                        ],
                      ),
                    ),

                    informatin("assets/images/user.png" , widget.user.age),
                    informatin("assets/images/user.png" , widget.user.phone),


                    InkWell(
                      onTap: (){
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (_) => new Dialog(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                child: Container(
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(20.r)),
                                            child: Container(
                                                padding: EdgeInsets.all(16.w),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(22.r),
                                                    border: Border.all(
                                                        color: Fonts.col_app.withOpacity(0.5),
                                                        width: 1)),
                                                child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        height: 16,
                                                      ),
                                                      Center(
                                                          child: Text("Link your account",
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.w700))),
                                                      Container(
                                                        height: 16,
                                                      ),
                                                      row( widget.user.instargram_link.toString() == "null" ? "Profil Instagram": widget.user.instargram_link.toString(), "images/instagram.png",edit_link("linkedin")),
                                                      row( widget.user.linkedin_link.toString() == "null" ? "Profil Linkedin" : widget.user.linkedin_link.toString(), "images/linked.png",edit_link("linkedin")),
                                                      row( widget.user.twitter_link.toString() == "null" ?  "Profil Twitter" : widget.user.twitter_link.toString(), "images/twitter.png",edit_link("twitter")),
                                                    ]
                                                )
                                            )
                                    )
                                )
                            )
                        );
                      },

                      child: Row(
                        children: [
                          Row(
                            children: [
                              informatin("images/user.png" , "Link your account "),
                              SizedBox(width: 3,),
                              Image.asset("images/instagram.png",height: 17,width: 17,),
                              SizedBox(width: 3,),
                              Image.asset("images/linked.png",height: 17,width: 17,),
                              SizedBox(width: 3,),
                              Image.asset("images/twitter.png",height: 17,width: 17,),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 30.6,
                    ),
                    Container(
                      color: Color(0xffF2F2F2),
                      height: 1,
                      width: 270.5,
                    ),
                    SizedBox(
                      height: 20.6,
                    ),

                    // coomissions_widget(),

                    widget.user.verify.toString() != "1"
                        ? Container()
                        :   Container(
                      padding: EdgeInsets.symmetric(horizontal: 9 ,vertical: 5.8),
                      width: 312,
                      decoration: BoxDecoration(
                        // border: Border.all(color: Color(0xff707070),width: 0.5),
                          color: Color(0xffEAF8FF),
                          borderRadius: BorderRadius.all(Radius.circular(21))
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    goto_comm();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(LinkomTexts.of(context).commission(),style: TextStyle(fontFamily: "louis george cafe",color: Color(0xff262B6D), fontWeight: FontWeight.normal, fontSize: 12),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: IconButton(onPressed: (){
                                    setState(() {
                                      print("more_commissions == $more_commissions");
                                      more_commissions = more_commissions ? false : true   ;
                                      print("more_commissions == $more_commissions");

                                    });
                                  },icon : Icon(Icons.arrow_drop_down_circle_outlined,color: Color(0xff262B6D) ,size: 20,)),
                                )
                              ],
                          ),
                        ),
                          ! more_commissions ?  Container() : Column(
                          children: List<Commission>.from(widget.user.commissions)
                              .map((Commission e) => Padding(
                              padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(e.name, textAlign: TextAlign.left),
                                  Container(
                                    height: 8,
                                  ),
                                  Container(
                                    width: 600,
                                    height: 1,
                                    color: Fonts.col_grey.withOpacity(0.4),
                                  ),
                                  Container(
                                    height: 8,
                                  ),
                                ],
                              )))
                              .toList(),
                        )
                        ],
                      ),
                    ),
                    // new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                    //   new Center(
                    //       child: new Text(LinkomTexts.of(context).compe(),
                    //           style: new TextStyle(
                    //               color: Colors.grey[800], fontWeight: FontWeight.w600))),
                    //   new Container(width: 12.0),
                    //   editwidget(Fonts.col_app, edit_comp)
                    // ]),
                    // new Container(height: 12.0),
                    // widget.user.cmpetences != null && widget.user.cmpetences.isNotEmpty
                    //     ? new Center(
                    //     child: new Wrap(
                    //         crossAxisAlignment: WrapCrossAlignment.start,
                    //         spacing: 8.0,
                    //         runSpacing: 8.0,
                    //         children: widget.user.cmpetences.map((String item) {
                    //           return a(item);
                    //         }).toList()))
                    //     : new Container(
                    //     padding: new EdgeInsets.only(top: 16.0, bottom: 24.0),
                    //     child: new Center(
                    //       child: new Text(
                    //         "Ajoutez votre domaine d’expertise",
                    //         style: new TextStyle(color: Colors.grey[500], fontSize: 16.0),
                    //       ),
                    //     ))
                    /* new Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: <Widget>[

                              a("PHP"),
                              a("#CSS"),
                              a("#Javascript")
                            ],
                          )*/
                    // ,

                    // new Container(
                    //   height: 12.0,
                    // ),
                    // new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                    //   new Center(
                    //       child: new Text(
                    //         LinkomTexts.of(context).objs(),
                    //         style: new TextStyle(
                    //             color: Colors.grey[800], fontWeight: FontWeight.w600),
                    //       )),
                    //   Container(width: 12.0),
                    //   editwidget(Fonts.col_app, edit_objectifs)
                    // ]),
                    // new Container(
                    //   height: 12.0,
                    // ),
                    //
                    // widget.user.list_obj.isNotEmpty
                    //     ? new Center(
                    //     child: new Column(
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: widget.user.list_obj.map((String item) {
                    //           return new Container(
                    //               padding: new EdgeInsets.all(8.0),
                    //               margin: new EdgeInsets.only(bottom: 8.0),
                    //               height: 36.0,
                    //               //alignment: Alignment.center,
                    //               decoration: new BoxDecoration(
                    //                 color: Colors.grey[100],
                    //                 borderRadius: new BorderRadius.circular(8.0),
                    //               ),
                    //               child: new Row(
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 mainAxisSize: MainAxisSize.min,
                    //                 children: <Widget>[
                    //                   new Icon(Icons.bookmark_border,
                    //                       color: Fonts.col_app),
                    //                   new Container(
                    //                     width: 4.0,
                    //                   ),
                    //                   new Text(
                    //                     item,
                    //                     style: new TextStyle(color: Fonts.col_app_fon),
                    //                   )
                    //                 ],
                    //               ));
                    //         }).toList()))
                    //     : new Container(
                    //     padding: new EdgeInsets.only(top: 16.0, bottom: 24.0),
                    //     child: new Center(
                    //       child: new Text(
                    //         "Aucun objectif n'a été mentionné",
                    //         style: new TextStyle(color: Colors.grey[500], fontSize: 16.0),
                    //       ),
                    //     )),
                    // new Container(
                    //   height: 12.0,
                    // ),
                    // new Container(
                    //   height: 12.0,
                    // ),










                    SizedBox(height: 34,),
                    informatin("assets/images/user.png" , "Paramètre avancé "),

                    SizedBox(height: 34,),

                    parametre("Mode en ligne",Switch(

                      value: val,
                      onChanged: (bool value) {
                        setState(() {
                          val = value;
                        });

                        if (val) {
                          make_user_online();
                        } else {
                          make_user_offline();
                        }
                      },
                    )),
                    parametre("Je veux recevoir les notifications "
                        "de messages et des demandes de connexion ",
                        Switch(
                            value: widget.user.notif_user,
                            onChanged: (value) async {
                              setState(() {
                                widget.user.notif_user = value;
                              });

                              if (widget.user.notif_user == true) {
                                OneSignal.shared.sendTag("userId", widget.user.auth_id);
                                /* await _firebaseMessaging
                                        .subscribeToTopic(user.auth_id);*/

                                parse_s.putparse(
                                    "users/" + widget.user.id, {"notif_user": "on"});
                              } else {
                                OneSignal.shared.deleteTag("userId");

                                /* await _firebaseMessaging
                                        .unsubscribeFromTopic(user.auth_id);*/

                                parse_s.putparse(
                                    "users/" + widget.user.id, {"notif_user": "off"});
                              }
                            })),
                    parametre("Je veux recevoir les notifications "
                        "d'actualités et d'évènements",
                        Switch(
                            value: widget.user.val_notif_pub,
                            onChanged: (value) async {
                              setState(() {
                                widget.user.val_notif_pub = value;
                              });

                              if (widget.user.val_notif_pub == true) {
                                /* await _firebaseMessaging
                                        .subscribeToTopic("publication");*/
                                OneSignal.shared.sendTag("publication", "publication");

                                parse_s.putparse(
                                    "users/" + widget.user.id, {"val_notif_pub": "on"});
                              } else {
                                OneSignal.shared.deleteTag("publication");

                                /*await _firebaseMessaging
                                        .unsubscribeFromTopic("publication");*/

                                parse_s.putparse(
                                    "users/" + widget.user.id, {"val_notif_pub": "off"});
                              }
                            })),
                        parametre("Je veux recevoir les notifications "
                        "d'opportunité d'affaires",
                        Switch(
                            value: widget.user.val_notif_opp,
                            onChanged: (value) async {
                              setState(() {
                                widget.user.val_notif_opp = value;
                              });

                              if (widget.user.val_notif_opp == true) {
                                OneSignal.shared.sendTag("opportunite", "opportunite");

                                parse_s.putparse(
                                    "users/" + widget.user.id, {"val_notif_opp": "on"});
                              } else {
                                print("noooo");
                                OneSignal.shared.deleteTag("opportunite");

                                parse_s.putparse(
                                    "users/" + widget.user.id, {"val_notif_opp": "off"});
                              }
                            })),
                    parametre("Je veux désactiver mon compte", Switch(
                        value: val_des,
                        onChanged: (val) {
                          setState(() {
                            val_des = val;
                          });
                          if (val) {
                            desactivate_compte();
                          } else {
                            print(false);
                          }
                        })
                       ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (BuildContext context) => new Potique()));
                          },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 11),
                          height: 40,
                          width: 300,
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                          decoration: BoxDecoration(
                            color: Color(0xffF8F8F8),
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                child: Text("Politique de confidentialité",style: TextStyle(color: Color(0xffa5a5a5),fontSize: 11,fontWeight: FontWeight.w300,fontFamily: "louis george cafe"),),
                              ),
                              Expanded(child: Container()),
                              Container(
                                child: Icon(Icons.keyboard_arrow_right,size: 22,),
                              ),
                            ],
                          ),
                        ),
                      ),

                    SizedBox(height: 20,),

                    InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) => new Edit_profile(widget.user)
                            )
                        );
                      },
                      child: Center(child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle ,
                          border: Border.all(color : Color(0xffF8F8F8) ,width: 0.5),
                          color :Colors.white,
                        ),
                        height: 48,
                        width: 48,
                        child: CircleAvatar(
                          child: Icon(Icons.edit,size: 30,),
                        ),
                      ),
                      ),
                    ),

                    SizedBox(height: 20,),


                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 59,top: 10),
                height: 88,width: 88,
                child: CircleAvatar(
                  backgroundImage:
                  NetworkImage(widget.user.image),
                  radius: 45.0,
                ),
              ),

            ]
        )
      )

    ;
    return widget.show
        ? new Theme(
            data: new ThemeData(
              brightness: Brightness.light,
              primaryColor: Colors.grey[50],
              platform: Theme.of(context).platform,
            ),
            child: Scaffold(

              appBar: AppBar(
                backgroundColor: Color.fromRGBO(247, 247, 247, 100),
                elevation: 0.0,
                iconTheme: IconThemeData(color: Color(0xff272C6E)),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Profile", style: TextStyle(color: Color(0xff272C6E),fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "louis george cafe"),),
                    Container(
                      margin: EdgeInsets.only(right: 10,),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(9)),

                      ),
                      child: Center(
                        child: Image.asset("images/logo.png"),
                      ),
                    ),
                  ],
                ),

              ),
              body: page2,

            )
          )
        : Scaffold(

      appBar: AppBar(
        backgroundColor: Color.fromRGBO(247, 247, 247, 100),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Color(0xff272C6E)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Profile", style: TextStyle(color: Color(0xff272C6E),fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "louis george cafe"),),
            Container(
              margin: EdgeInsets.only(right: 10,),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(9)),

              ),
              child: Center(
                child: Image.asset("images/logo.png"),
              ),
            ),
          ],
        ),

      ),
      body: page2,

    );
  }

/*
*/
}

// class FullScreenWrapper extends StatelessWidget {
//   final ImageProvider imageProvider;
//   final Widget loadingChild;
//   final Color backgroundColor;
//   final dynamic minScale;
//   final dynamic maxScale;
//
//   FullScreenWrapper(
//       {this.imageProvider,
//       this.loadingChild,
//       this.backgroundColor,
//       this.minScale,
//       this.maxScale});
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         appBar: new AppBar(
//           iconTheme: IconThemeData(color: Colors.black),
//           backgroundColor: Colors.black,
//           actions: <Widget>[
//             new IconButton(
//                 icon: new Icon(
//                   Icons.close,
//                   color: Colors.grey[50],
//                   size: 26.0,
//                 ),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 })
//           ],
//         ),
//         backgroundColor: Colors.black87,
//         body: new Container(
//             constraints: BoxConstraints.expand(
//               height: MediaQuery.of(context).size.height,
//             ),
//             child: new PhotoView(
//               imageProvider: imageProvider,
//               loadingChild: loadingChild,
//               //backgroundColor: backgroundColor,
//               minScale: minScale,
//               maxScale: maxScale,
//             )));
//   }
// }
