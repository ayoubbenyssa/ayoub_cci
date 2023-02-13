import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as clientHttp;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong/latlong.dart';
import 'package:mycgem/inactive/inactive_widget.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/alphabets.dart';
import 'package:mycgem/models/community.dart';
import 'package:mycgem/models/fonction.dart';
import 'package:mycgem/services/send_email_service.dart';
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
import 'package:mycgem/widgets/arc_clip.dart';
import 'package:mycgem/widgets/bottom_menu.dart';
import 'package:intl/intl.dart';

enum AppBarBehavior { normal, pinned, floating, snapping }

class EditMyProfile extends StatefulWidget {
  EditMyProfile(this.auth, this.sign, this.list_partner, this.chng,
      this.membre);

  var auth;
  var sign;
  bool show_myprofile = true;
  List list_partner;
  var chng;
  bool membre;

  @override
  _Details_userState createState() => _Details_userState();
}

class _Details_userState extends State<EditMyProfile>
    with TickerProviderStateMixin {
  AnimationController _containerController;
  bool uploading = false;
  User user = new User();
  double _appBarHeight = 200.0;
  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;
  Animation<double> width;
  Animation<double> heigth;
  Distance distance = new Distance();
  ParseServer parse_s = new ParseServer();
  final _phonecontroller = new TextEditingController();
  FocusNode _focusphone = new FocusNode();
  bool val1 = false;
  String type = "";
  bool val2 = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool val = true;
  bool val_visible = true;
  bool val_loc = false;
  bool val_not = true;
  bool val_notif_pub = true;
  bool val_notif_opp = true;

  get_user_info() async {
    user.image =
    "https://res.cloudinary.com/dgxctjlpx/image/upload/v1604854416/Capture_d_e%CC%81cran_2020-11-08_a%CC%80_17.15.31_x6wjqr.png";
    user.anne_exp = "";
    user.cmpetences = [];
    user.bio = "";
    // user.date_naissance = ;
    user.sexe = "";
    user.fonction = Fonction(name: "", id: "");
    user.organisme = "";
    user.phone = "";
    user.email = "";
    user.firstname = "";
    user.fullname = "";
    user.linkedin_link = "";
    user.community = "";
    user.block_list = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var my_id = prefs.getString("id");

    // User us =   await  user_info.getuserdata(my_id);  //if (!mounted) return;

    var response = await parse_s.getparse(
        'users?where={"objectId":"$my_id"}&include=commissions&include=membre_user.federation&include=membre_user.region&include=fonction');
    User us = new User.fromMap(response["results"][0]);

    Map<String, dynamic> map = new Map<String, dynamic>();
    map["online"] = true;
    map["offline"] = "";
    map["last_active"] = 0;

    await Firestore.instance
        .collection('users')
        .document(user.auth_id)
        .setData(map);

    if (!this.mounted) return;

    setState(() {
      user = us;
      if (user.image.toString() == "null") {
        String alpha = user.firstname[0].toString().toLowerCase();
        setState(() {
          user.image = Alphabets.list[0][alpha];
        });
      }
      // user.image = user.image;

      _phonecontroller.text = user.phone;
      type = user.sexe;
    });
  }

  save_image(image) async {
    setState(() {
      uploading = true;
    });

    int timestamp = new DateTime.now().millisecondsSinceEpoch;
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child("profile/img_" + timestamp.toString() + ".jpg");
    StorageUploadTask uploadTask = storageReference.put(image);
    await storageReference
        .put(image)
        .onComplete
        .then((val) {
      val.ref.getDownloadURL().then((val) {
        var js = {
          "photoUrl": val.toString(),
        };
        parse_s.putparse("users/" + user.id, js);

        if (!mounted) return;

        setState(() {
          user.image = val.toString();
          uploading = false;
        });
      });
    });
  }

  Community community = null;

  make_user_online() async {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map["online"] = true;
    map["offline"] = "";

    map["last_active"] = 0;
    await Firestore.instance
        .collection('users')
        .document(user.auth_id)
        .updateData(map);

    FirebaseDatabase.instance
        .reference()
        .child("status")
        .update({user.auth_id: true});
    FirebaseDatabase.instance
        .reference()
        .child("status")
        .onDisconnect()
        .update({user.auth_id: false});
  }

  getOnlineUser() async {
    DocumentSnapshot a = await Firestore.instance
        .collection('users')
        .document(user.auth_id)
        .get();

    if (a.data.toString() != "null") {
      if (a.data["offline"].toString() == "offline") {
        setState(() {
          user.online = false;
          user.offline = "offline";
          val = false;
        });
      } else
        setState(() {
          val = true;
        });
    }
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

  @override
  void initState() {
    get_user_info().then((_) {
      user.online = false;
      getOnlineUser();
      user.list = [];
      user.list_obj = [];

      if (user.objectif != null) {
        for (var i in user.objectif) {
          user.list_obj.add(i);
        }
      }

      /* if (user.cmpetences != null) {
        for (var i in user.cmpetences) {
          user.list.add(i);
        }
      }*/


    });

    /*  user.dis = distance
              .as(
                  LengthUnit.Kilometer,
                  new LatLng(double.parse(user.lat), double.parse(user.lng)),
                  new LatLng(widget.lat, widget.lng))
              .toString() +
          " Km(s)";*/

    _containerController = new AnimationController(
        duration: new Duration(milliseconds: 2000), vsync: this);
    super.initState();

    width = new Tween<double>(
      begin: 180.0,
      end: 180.0,
    ).animate(
      new CurvedAnimation(
        parent: _containerController,
        curve: Curves.ease,
      ),
    );
    heigth = new Tween<double>(
      begin: 180.0,
      end: 180.0,
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

  /*

    Calculate  tyhe distance between the community and the user
     */
  String type_membre = "";

  save_user() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String my_id = prefs.getString("id");

    prefs.setString("com_name", user.community);
    prefs.setString("com_id", user.communitykey);
    final status = await OneSignal.shared.getDeviceState();
    final String token = status?.userId;

    await Firestore.instance
        .collection('user_notifications')
        .document(user.auth_id)
        .setData({
      "my_token": token,
      "name": user.firstname + "  " + user.fullname.toUpperCase(),
      "image": user.image
    });

 //   String tk = await _firebaseMessaging.getToken();

    if (widget.membre == true)
      type_membre = "pas_membre";
    else if (widget.membre == false)
      type_membre = "membre_nn_verifie";
    else
      type_membre = "membre_verifie";

    print("--------------------Membre---------------");
    print(widget.membre);
    var js = {
      "active": widget.membre == null ? 1 : 0,
      "token": token,
      "raja": true,
      "type_membre": type_membre
    };

    var jsonsearch = {
      "objectId": user.id,
      "firstname": user.firstname,
      "fullname": user.fullname,
      "email": user.email,
      "phone": user.phone,
      "organisme": user.organisme,
      "titre": user.fonction.name,
      "cmpetences": user.cmpetences,
      "community": user.community
    };

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode("cgem" + ':' + "Cgem2k20"));

    var a = await clientHttp.post(
        "https://search.mycgem.ma/users/user/" + user.id.toString(),
        headers: {
          HttpHeaders.authorizationHeader: basicAuth,
          "Content-type": "application/json"
        },
        body: json.encode(jsonsearch));

    var resp = await parse_s.putparse("users/" + user.id, js);

    var uid = user.auth_id;
    var response = await parse_s.getparse(
        'users?where={"id1":"$uid"}&include=commissions&include=membre_user.federation&include=membre_user.region&include=fonction');
    prefs.setString("user", json.encode(response["results"][0]));

    user = User.fromMap(response["results"][0]);

    var kkey = user.auth_id + "_" + "cERx66ukune7A97cAfoO8PhIzur1";
  /*  DatabaseReference gMessagesDbRef2 =
   FirebaseDatabase.instance.reference().child("room_medz").child(kkey);
    gMessagesDbRef2.set({
      "token": token,
      "name": user.firstname + " " + user.fullname,
      user.auth_id: true,
      "lastmessage": "Bienvenido sur CCIS Connect",
      "key": kkey,
      "me": false,
      "timestamp": ServerValue.timestamp /*new DateTime.now().toString()*/,
    });

    FirebaseDatabase.instance
        .reference()
        .child("message_medz")
        .child(kkey)
        .push()
        .set({
      'timestamp': ServerValue.timestamp,
      'messageText': '''Bienvenue sur MyCGEM,

L’application dédiée à la communauté des affaires.
Cordialement
L’équipe MyCGEM
     ''',
      'idUser': user.id,
    });
*/
    print(user.verify_code);
    if (user.verify_code == true) {
      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) =>
              new BottomNavigation(
                  widget.auth,
                  widget.sign,
                  user,
                  widget.list_partner,
                  true,
                  null,
                  widget.chng)));
    } else if (widget.membre == false) {
      if (user.entreprise.emails.length > 0) {
        await EmailService.sendCustomMail3(user.entreprise.emails[0],
            "Demande d’accès à CCIS Connect", '''Bonjour,<br><br>

          ${user.firstname + ' ' +
                user.fullname.toUpperCase()} de l’organisme ${user.entreprise
                .name} souhaite accéder à MyCGEM, l'application 100% dédiée à la communauté des affaires. <br>
          
          Autorisez-vous son accès à l’application ? Si oui, <a href="https://api.mycgem.ma/active?id=${user
                .id}&token=${user.entreprise.objectId}">
          Cliquez ici</a>. <br><br>
          
          Cordialement,<br>
          
          L'équipe MyCGEM
          ''');
      }
      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) =>
              new InactiveWidget(widget.chng, false, user)));
    } else if (widget.membre == true) {
      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) =>
              new InactiveWidget(widget.chng, true, user)));
    } else
      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) =>
              new BottomNavigation(
                  widget.auth,
                  widget.sign,
                  user,
                  widget.list_partner,
                  true,
                  null,
                  widget.chng)));
    /*  } else {
      prefs.setString("user_actif", "false");
      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => new InactiveWidget(
                  community,
                  widget.auth,
                  widget.sign,
                  widget.list_partner, widget.analytics)));
    }*/
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

    void onLoading(context) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) =>
          new Dialog(
            child: new Container(
              padding: new EdgeInsets.all(16.0),
              width: 40.0,
              color: Colors.transparent,
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Widgets.load(),
                  new Container(height: 8.0),
                  new Text(
                    "En cours ..",
                    style: new TextStyle(
                      color: Fonts.col_app_fonn,
                    ),
                  ),
                ],
              ),
            ),
          ));
    }

    void showInSnackBar(String value) {
      _scaffoldKey.currentState
          .showSnackBar(new SnackBar(content: new Text(value)));
    }

    applyChanges() async {
      if (user.organisme.toString() == "null" || user.organisme == "") {
        showInSnackBar("Entrer la fonction !");
      } else {
        onLoading(context);

        save_user();
      }
    }

    Widget a(text) =>
        new Container(
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
            return new InfoUser1(user);
          }));

      setState(() {
        user = us;
      });
    }

    edit_titre() async {
      User us = await Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) {
            return new OrganismeTitle(user);
          }));

      setState(() {
        user = us;
      });
    }

    edit_comp() async {
      User us = await Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) {
            return new Cmpetences(user);
          }));

      print(us.cmpetences.length);

      setState(() {
        user.cmpetences = us.cmpetences;
      });
    }

    edit_link(type) async {
      //
      User us = await Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) {
            return new Link_profile(user, type);
          }));

      setState(() {
        user = us;
      });
    }

    edit_objectifs() async {
      User us = await Navigator.push(
        context,
        new PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> _,
              Animation<double> __) {
            return new Objectifs_widget(user);
          },
        ),
      );

      setState(() {
        user = us;
      });
    }

    edit_bio() async {
      User us = await Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) {
            return new Bio(user);
          }));

      setState(() {
        user = us;
      });
    }

    make_user_offline() async {
      Map<String, dynamic> map = new Map<String, dynamic>();
      map["online"] = false;
      map["last_active"] = new DateTime.now().millisecondsSinceEpoch;
      map["offline"] = "offline";

      Firestore.instance
          .collection('users')
          .document(user.auth_id)
          .updateData(map);

      FirebaseDatabase.instance
          .reference()
          .child("status")
          .update({user.auth_id: false});

      FirebaseDatabase.instance
          .reference()
          .child("status")
          .update({user.auth_id: false});
    }

    edit_num() async {
      User us = await Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) {
            return new PhoneWidget(user);
          }));

      setState(() {
        user = us;
      });
    }

    edit_phone() {}

    editwidget(colors, tap) {
      return new InkWell(
          child: new Container(
            /*decoration: new BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                    color: colors,
                    offset: new Offset(0.0, 0.8),
                    blurRadius: 30.0,
                  ),
                ],
              ),*/
              child: new Icon(
                Icons.edit,
                color: colors,
              )),
          onTap: () {
            tap();

            // open_bottomsheet();
          });
    }

    Widget phone_widget = new Row(
      children: <Widget>[
        new Text("Numéro de téléphone:"),
        new Expanded(child: new Container()),
        editwidget(Fonts.col_app, edit_phone)
      ],
    );

    Widget sexe_widget = new Container(
        child: ExpansionTile(
          //backgroundColor: Colors.grey[100],
            title: new Container(
              // color: Colors.grey[100],
                child: new Row(
                  children: <Widget>[
                    new Image.asset(
                      "images/eq.png",
                      width: 20.0,
                      height: 20.0,
                    ),
                    new Container(
                      width: 12.0,
                    ),
                    new Row(children: <Widget>[
                      new Container(
                          child: new Text(
                            "Sexe: ",
                            style: new TextStyle(fontSize: 15.0),
                          )),
                      new Container(width: 12.0),
                      new Text("$type",
                          style:
                          new TextStyle(fontSize: 12.0, color: Colors.black)),
                    ]),
                  ],
                )),
            children: [
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text("Homme"),
                  new Checkbox(
                    value: val1,
                    onChanged: (bool value) {
                      setState(() {
                        val1 = value;
                        val2 = !value;
                        type = "Homme";
                      });
                    },
                  ),
                  new Container(width: 16.0),
                  new Text("Femme"),
                  new Checkbox(
                    value: val2,
                    onChanged: (bool value) {
                      setState(() {
                        val2 = value;
                        val1 = !value;
                        type = "Femme";
                      });
                    },
                  )
                ],
              ),
            ]));

    Widget page = new Container(
      color: Colors.grey[50],
      child: new Container(
        color: Colors.transparent,
        child: new Container(
          //alignment: Alignment.center,

          decoration: new BoxDecoration(
            color: Colors.white,
            // borderRadius: new BorderRadius.circular(10.0),
          ),
          child: new Stack(
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
                    /*pinned: _appBarBehavior == AppBarBehavior.pinned,
                    floating: _appBarBehavior == AppBarBehavior.floating ||
                        _appBarBehavior == AppBarBehavior.snapping,
                    snap: _appBarBehavior == AppBarBehavior.snapping,*/
                    flexibleSpace: new FlexibleSpaceBar(
                      title: new Row(children: <Widget>[
                        new Expanded(child: new Container()),
                      ]),
                      background: ClipPath(
                          clipper: new ArcClipper2(),
                          child: new Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              new Container(
                                width: width.value,
                                height: _appBarHeight,
                                decoration: new BoxDecoration(
                                    color: Fonts.col_app.withOpacity(0.06)),
                                child: new Container(
                                    decoration: new BoxDecoration(
                                        color: Fonts.col_app.withOpacity(0.06)),
                                    child: new Column(children: <Widget>[
                                      new Row(
                                        children: <Widget>[
                                          new Expanded(child: new Container()),
                                        ],
                                      ),
                                      new Container(
                                        height: 16.0,
                                      ),
                                      new Container(
                                          child: new Stack(children: [
                                            new Center(
                                                child: new Container(
                                                  child: new CircleAvatar(
                                                    backgroundImage: NetworkImage(
                                                        user.image.toString()),
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
                                                    backgroundColor: Colors
                                                        .white,
                                                    child: new IconButton(
                                                        color: Colors.grey[100],
                                                        icon: new Icon(
                                                          Icons.edit,
                                                          color: Fonts.col_app,
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
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Container(width: 28.0),
                                            new Container(
                                                child: new Center(
                                                    child: new Text(
                                                      user.age.toString() !=
                                                          "" &&
                                                          user.age.toString() !=
                                                              "null"
                                                          ? toBeginningOfSentenceCase(
                                                          user.firstname
                                                              .toString()) +
                                                          " " +
                                                          user.fullname
                                                              .toString()
                                                              .toUpperCase() +
                                                          ", " +
                                                          user.age.toString() +
                                                          " ans"
                                                          : toBeginningOfSentenceCase(
                                                          user.firstname
                                                              .toString()) +
                                                          " " +
                                                          user.fullname
                                                              .toString()
                                                              .toUpperCase(),
                                                      style: new TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 17.0,
                                                          fontWeight: FontWeight
                                                              .w600),
                                                    ))),
                                            editwidget(
                                                Fonts.col_app, edit_name),
                                          ]),
                                      new Container(
                                        height: 6.0,
                                      ),
                                      new Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Container(width: 28.0),
                                            new Container(
                                                child: new Center(
                                                    child: new Text(
                                                        user.fonction.name
                                                            .toString() !=
                                                            "null" &&
                                                            user.organisme
                                                                .toString() !=
                                                                "null" &&
                                                            user.fonction.name
                                                                .toString() !=
                                                                "" &&
                                                            user.organisme
                                                                .toString() !=
                                                                ""
                                                            ? user.fonction
                                                            .name +
                                                            " à " +
                                                            user.organisme
                                                            : "Ajouter le titre" +
                                                            "    à " +
                                                            user.organisme
                                                                .toString(),
                                                        style: new TextStyle(
                                                            color: user.fonction
                                                                .name
                                                                .toString() !=
                                                                "null" &&
                                                                user.organisme
                                                                    .toString() !=
                                                                    "null" &&
                                                                user.fonction
                                                                    .name
                                                                    .toString() !=
                                                                    "" &&
                                                                user.organisme
                                                                    .toString() !=
                                                                    ""
                                                                ? Colors
                                                                .grey[800]
                                                                : Colors
                                                                .red[200],
                                                            fontSize: 16.0,
                                                            fontWeight: FontWeight
                                                                .w600),
                                                        textAlign: TextAlign
                                                            .center))),
                                            /* editwidget(
                                                Fonts.col_app, edit_titre),*/
                                          ]),
                                      new Container(
                                        height: 6.0,
                                      ),
                                      /*  new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            new Center(
                                                child: new Text(
                                              user.community.toString(),
                                              style: new TextStyle(
                                                  color: Colors.grey[200],
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.w400),
                                            )),
                                            new Container(
                                              height: 4.0,
                                            ),
                                          ])*/
                                    ])),
                              ),
                            ],
                          )),
                    ),
                  ),
                  new SliverList(
                    delegate: new SliverChildListDelegate(<Widget>[
                      new Container(height: 12.0),
                      /* new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Center(
                                child: new Text("Commission:",
                                    style: new TextStyle(
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.w600))),
                            new Container(width: 12.0),
                           // editwidget(Fonts.col_app, edit_com)
                          ]),*/
                      new Container(height: 8.0),
                      /*  Center(
                          child: OutlineButton(
                              color: Colors.blue,
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(8.0)),
                              child: Text(
                                user.community.toString() != "null" &&
                                        user.community.toString() != ""
                                    ? user.community
                                    : "Rejoindre votre communauté",
                                style: TextStyle(
                                    color: Colors.green[700], fontSize: 16),
                              ),
                              onPressed: () async {
                              //  edit_com();
                              })),*/

                      // new Container(height: 12.0),
                      // commiss_widget,
                      new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Center(
                                child: new Text("Numéro de téléphone",
                                    style: new TextStyle(
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.w600))),
                            new Container(width: 12.0),
                            editwidget(Fonts.col_app, edit_num)
                          ]),
                      user.phone != "" && user.phone.toString() != "null"
                          ? Container(
                        height: 12,
                      )
                          : Container(),
                      user.phone != "" && user.phone.toString() != "null"
                          ? Center(
                          child: new Container(
                            // padding:
                            // new EdgeInsets.only(left: 16.0, right: 16.0),
                            // width: 300.0,
                            child: new Text(user.phone.toString(),
                                style: TextStyle(color: Colors.grey[800])),
                          ))
                          : new Container(
                        child: new Center(
                          child: new Text(
                            "Ajouter votre numéro de téléphone ..",
                            style: new TextStyle(
                                color: Colors.grey, fontSize: 16),
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
                      new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Center(
                                child: new Text(LinkomTexts.of(context).compe(),
                                    style: new TextStyle(
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.w600))),
                            new Container(width: 12.0),
                            editwidget(Fonts.col_app, edit_comp)
                          ]),
                      new Container(height: 12.0),
                      user.cmpetences != null && user.cmpetences.isNotEmpty
                          ? new Center(
                          child: new Wrap(
                              crossAxisAlignment: WrapCrossAlignment.start,
                              spacing: 4.0,
                              runSpacing: 4.0,
                              children: user.cmpetences.map((String item) {
                                return a(item);
                              }).toList()))
                          : new Container(
                          padding:
                          new EdgeInsets.only(top: 16.0, bottom: 24.0),
                          child: new Center(
                            child: new Text(
                              "Ajoutez votre domaine d’expertise",
                              style: new TextStyle(
                                  color: Colors.grey[500], fontSize: 16.0),
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
                      new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Center(
                                child: new Text(
                                  LinkomTexts.of(context).objs(),
                                  style: new TextStyle(
                                      color: Colors.grey[800],
                                      fontWeight: FontWeight.w600),
                                )),
                            Container(width: 12.0),
                            editwidget(Fonts.col_app, edit_objectifs)
                          ]),
                      new Container(
                        height: 12.0,
                      ),
                      user.list_obj != null && user.list_obj.isNotEmpty
                          ? new Center(
                          child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: user.list_obj.map((String item) {
                                return new FlatButton(
                                    padding: new EdgeInsets.all(0.0),
                                    onPressed: () {
                                      //swipeRight();
                                    },
                                    child: new Container(
                                        height: 36.0,
                                        //alignment: Alignment.center,
                                        decoration: new BoxDecoration(
                                          color: Colors.grey[50],
                                          borderRadius:
                                          new BorderRadius.circular(
                                              8.0),
                                        ),
                                        child: new Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            new Icon(Icons.bookmark_border,
                                                color: Fonts.col_app_fon),
                                            new Container(
                                              width: 4.0,
                                            ),
                                            new Text(
                                              item,
                                              style: new TextStyle(
                                                  color: Fonts.col_app_fon),
                                            )
                                          ],
                                        )));
                              }).toList()))
                          : new Container(
                          padding:
                          new EdgeInsets.only(top: 16.0, bottom: 24.0),
                          child: new Center(
                            child: new Text(
                              "Aucun objectif n'a été mentionné",
                              style: new TextStyle(
                                  color: Colors.grey[500], fontSize: 16.0),
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
                      new Container(height: 8.0),
                      /*  sexe_widget,
                      Container(
                        height: 8,
                      ),*/
                      new Container(
                        height: 1.0,
                        width: 1000.0,
                        color: Colors.grey[300],
                      ),
                      Container(
                        height: 8,
                      ),
                      Container(
                        height: 12,
                      ),
                      new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Center(
                                child: new Text("BIO",
                                    style: new TextStyle(
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.w600))),
                            new Container(width: 12.0),
                            editwidget(Fonts.col_app, edit_bio)
                          ]),
                      new Container(
                        height: 8.0,
                      ),
                      user.bio != "" && user.bio.toString() != "null"
                          ? new Container(
                        padding:
                        new EdgeInsets.only(left: 4.0, right: 4.0),
                        width: 300.0,
                        child: new Text(user.bio.toString()),
                      )
                          : new Container(
                        child: new Center(
                          child: new Text(
                            "Ajouter une description ..",
                            style: new TextStyle(color: Colors.grey),
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
                              user.linkedin_link != "" &&
                                  user.linkedin_link.toString() != "null"
                                  ? new Center(
                                  child: new Container(
                                      width: 180.0,
                                      child: new Text(
                                        user.linkedin_link.toString(),
                                        style: new TextStyle(
                                            color: Colors.grey[600]),
                                      )))
                                  : new Text(
                                "Profil Linkedin:",
                                style: new TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w600),
                              ),
                              new Expanded(child: Container()),
                              new InkWell(
                                  child: new Container(
                                      padding: new EdgeInsets.all(16.0),
                                      decoration: new BoxDecoration(
                                        boxShadow: [
                                          new BoxShadow(
                                            color: Fonts.col_app_shadow,
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
                              user.twitter_link != "" &&
                                  user.twitter_link.toString() != "null"
                                  ? new Center(
                                  child: new Text(
                                    user.twitter_link.toString(),
                                    style: new TextStyle(
                                        color: Colors.grey[600]),
                                  ))
                                  : new Text(
                                "Profil Twitter:",
                                style: new TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w600),
                              ),
                              new Expanded(child: Container()),
                              new InkWell(
                                  child: new Container(
                                      padding: new EdgeInsets.all(16.0),
                                      decoration: new BoxDecoration(
                                        boxShadow: [
                                          new BoxShadow(
                                            color: Fonts.col_app_shadow,
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
                                  top: 16.0,
                                  left: 8.0,
                                  right: 8.0,
                                  bottom: 16.0),
                              // color: Colors.grey[100],
                              child: new Text(
                                "Paramètres:",
                                style: new TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.bold),
                              ))),
                      divider,
                      new Container(
                        color: Colors.grey[50],
                        padding: new EdgeInsets.only(
                            left: 16.0, right: 8.0, top: 4.0, bottom: 4.0),
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
                                  print("online");
                                } else {
                                  make_user_offline();
                                }
                              },
                            )
                          ],
                        ),
                      ),
                      divider,
                      /**
                       *   new Container(
                          color: Colors.grey[50],
                          padding: new EdgeInsets.only(
                          left: 16.0, right: 8.0, top: 4.0, bottom: 4.0),
                          // color: Colors.grey[100],
                          child: new Row(
                          children: <Widget>[
                          new Text(
                          "Je veux être visible :",
                          style: new TextStyle(fontSize: 15.0),
                          ),
                          new Expanded(child: new Container(width: 12.0)),
                          new Switch(
                          value: val_visible,
                          onChanged: (bool value) {
                          setState(() {
                          val_visible = value;
                          });

                          if (val_visible) {
                          print("jiiiii");
                          parse_s.putparse(
                          "users/" + user.id, {"raja": true});
                          } else {
                          print("noooo");
                          parse_s.putparse(
                          "users/" + user.id, {"raja": false});
                          }
                          },
                          )
                          ],
                          ),
                          ),
                       */
                      divider,
                      new Container(
                        color: Colors.grey[50],
                        padding: new EdgeInsets.only(
                            left: 16.0, right: 8.0, top: 4.0, bottom: 4.0),
                        // color: Colors.grey[100],
                        child: new Row(
                          children: <Widget>[
                            new Text(
                              "Localisation visible :",
                              style: new TextStyle(fontSize: 15.0),
                            ),
                            new Expanded(child: new Container(width: 12.0)),
                            new Switch(
                              value: val_loc,
                              onChanged: (bool value) {
                                setState(() {
                                  val_loc = value;
                                });

                                if (val_loc) {

                                  parse_s.putparse(
                                      "users/" + user.id, {"active_loc": 1});
                                } else {
                                  print("noooo");
                                  parse_s.putparse(
                                      "users/" + user.id, {"active_loc": 0});
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
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.78,
                                child: new Text(
                                    "Je veux recevoir les notifications "
                                        "de messages et des demandes de connexion :")),
                            new Expanded(child: new Container(width: 12.0)),
                            new Switch(
                                value: user.notif_user,
                                onChanged: (value) async {
                                  setState(() {
                                    user.notif_user = value;
                                  });

                                  if (user.notif_user == true) {
                                    OneSignal.shared.sendTag("userId", user.auth_id);
                                   /* await _firebaseMessaging
                                        .subscribeToTopic(user.auth_id);*/

                                    parse_s.putparse("users/" + user.id,
                                        {"notif_user": "on"});
                                  } else {
                                    OneSignal.shared.deleteTag("userId");

                                    /* await _firebaseMessaging
                                        .unsubscribeFromTopic(user.auth_id);*/

                                    parse_s.putparse("users/" + user.id,
                                        {"notif_user": "off"});
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
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.78,
                                child: new Text(
                                    "Je veux recevoir les notifications "
                                        "d'actualités et d'évènements :")),
                            new Expanded(child: new Container(width: 12.0)),
                            new Switch(
                                value: user.val_notif_pub,
                                onChanged: (value) async {
                                  setState(() {
                                    user.val_notif_pub = value;
                                  });

                                  if (user.val_notif_pub == true) {
                                   /* await _firebaseMessaging
                                        .subscribeToTopic("publication");*/
                                    OneSignal.shared.sendTag("publication", "publication");


                                    parse_s.putparse("users/" + user.id,
                                        {"val_notif_pub": "on"});
                                  } else {
                                    OneSignal.shared.deleteTag("publication");

                                    /*await _firebaseMessaging
                                        .unsubscribeFromTopic("publication");*/

                                    parse_s.putparse("users/" + user.id,
                                        {"val_notif_pub": "off"});
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
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.78,
                                child: new Text(
                                    "Je veux recevoir les notifications "
                                        "d'opportunité d'affaires :")),
                            new Expanded(child: new Container(width: 12.0)),
                            new Switch(
                                value: user.val_notif_opp,
                                onChanged: (value) async {
                                  setState(() {
                                    user.val_notif_opp = value;
                                  });

                                  if (user.val_notif_opp == true) {
                                    OneSignal.shared.sendTag("opportunite", "opportunite");

                                    /* await _firebaseMessaging
                                        .subscribeToTopic("opportunite");*/

                                    parse_s.putparse("users/" + user.id,
                                        {"val_notif_opp": "on"});
                                  } else {
                                    print("noooo");
                                    OneSignal.shared.deleteTag("opportunite");

                                    /*await _firebaseMessaging
                                        .unsubscribeFromTopic("opportunite");*/

                                    parse_s.putparse("users/" + user.id,
                                        {"val_notif_opp": "off"});
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
                                    builder: (BuildContext context) =>
                                    new Potique()));
                          },
                          child: new Container(
                            color: Colors.grey[50],
                            padding: new EdgeInsets.only(
                                left: 16.0,
                                right: 8.0,
                                top: 16.0,
                                bottom: 16.0),
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
                                    builder: (BuildContext context) =>
                                    new Conditions()));
                          },
                          child: new Container(
                            color: Colors.grey[50],

                            padding: new EdgeInsets.only(
                                left: 16.0,
                                right: 8.0,
                                top: 16.0,
                                bottom: 16.0),
                            // color: Colors.grey[100],
                            child: new Row(
                              children: <Widget>[
                                new Text(
                                    "Conditions générales d'utilisation :"),
                                new Expanded(child: new Container(width: 12.0)),
                                new Icon(Icons.arrow_right)
                              ],
                            ),
                          ))
                    ]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    //const Color(0xffff374e),
    return WillPopScope(
        onWillPop: () {
          Widgets.exitapp(context);
        },
        child: new Scaffold(
          bottomNavigationBar: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.07,
              color: Fonts.col_app,
              child: RaisedButton(
                elevation: 0,
                color: Fonts.col_app,
                padding: EdgeInsets.all(0),
                child:
                /*new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                show
                ? Container(
                width: 20,
                    height: 20,

                    // padding: EdgeInsets.all(8),
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Colors.white),
                    ))
                      :Container(),*/
                Text(
                  LinkomTexts.of(context).sve(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 16),
                ),
                onPressed: () {
                  applyChanges();
                },
              )),
          key: _scaffoldKey,
          appBar: new AppBar(
            elevation: 1.0,
            title: new Text("Profil"),
            actions: <Widget>[],
          ),
          body: page,
        ));
  }

/*
*/
}

/*


 */
class FullScreenWrapper extends StatelessWidget {
  final ImageProvider imageProvider;
  final Widget loadingChild;
  final Color backgroundColor;
  final dynamic minScale;
  final dynamic maxScale;

  FullScreenWrapper({this.imageProvider,
    this.loadingChild,
    this.backgroundColor,
    this.minScale,
    this.maxScale});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.black,
          actions: <Widget>[
            new IconButton(
                icon: new Icon(
                  Icons.close,
                  color: Colors.grey[50],
                  size: 26.0,
                ),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
        backgroundColor: Colors.black87,
        body: new Container(
            constraints: BoxConstraints.expand(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
            ),
            child: new PhotoView(
              imageProvider: imageProvider,
              loadingChild: loadingChild,
              //backgroundColor: backgroundColor,
              minScale: minScale,
              maxScale: maxScale,
            )));
  }
}
