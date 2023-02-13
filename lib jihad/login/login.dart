import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location/location.dart';
import 'package:mycgem/inactive/active_widget.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/login/verify_email.dart';
import 'package:mycgem/services/location_services.dart';
import 'package:mycgem/user/edit_my_profile.dart';
import 'package:mycgem/widgets/custom_widgets/primary_button.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mycgem/login/login_w.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/auth.dart';
import 'package:mycgem/services/routes.dart';
import 'package:mycgem/services/validators.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:flutter/services.dart';

import 'commissions/commissions_choices.dart';

class Login extends StatefulWidget {
  Login(
      this.auth, this.onSignedIn, this.list_partner, this.analytics, this.chng);

  final BaseAuth auth;
  final VoidCallback onSignedIn;
  List list_partner;
  var analytics;
  var chng;

  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool _autovalidate = false;
  FocusNode _focuspassword = new FocusNode();
  FocusNode _focusemail = new FocusNode();
  final _passcontroller = new TextEditingController();
  final _emailcontroller = new TextEditingController();
  User user = new User();
  var deviceSize;
  String _authHint = '';
  ParseServer parse_s = new ParseServer();
  bool show = false;
  var lat, lng;

  var currentLocation = <String, double>{};
  var location = new Location();

  type_mb(membre) {
    bool a;

    switch (membre) {
      case 'pas_membre':
        a = true;
        break;
      case 'membre_nn_verifie':
        a = false;
        break;

      default:
        a = null;
        break;
    }

    return a;
  }

  getLocation() async {
    try {
      currentLocation = await Location_service.getLocation();
      print(currentLocation);

      lat = currentLocation["latitude"];
      lng = currentLocation["longitude"];
    } on PlatformException {
      print("noooooo");

      setState(() {});
      // showInSnackBar("Veuillez activer votre GPS");
    }
  }

  @override
  initState() {
    getLocation();
    super.initState();
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  static onLoading(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => new Dialog(
              child: new Container(
                padding: new EdgeInsets.all(16.0),
                width: 60.0,
                color: Colors.blue[200],
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    new CircularProgressIndicator(),
                    new Container(height: 8.0),
                    new Text(
                      "En cours ...",
                      style: new TextStyle(color: Colors.blue[600]),
                    ),
                  ],
                ),
              ),
            ));

    // Navigator.pop(context); //pop dialog
    //  _handleSubmitted();
  }

  void _handleSubmitted() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidate = true; // Start validating on every change.
      showInSnackBar(LinkomTexts.of(context).fix());
    } else {
      setState(() {
        show = true;
      });
      try {
        AuthResult userId = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _emailcontroller.text.replaceAll(' ', ''),
                password: _passcontroller.text);

        if (!mounted) return;

        setState(() {
          _authHint = '';
        });
        //
        String uid = userId.user.uid;

        var res = await parse_s.getparse(
            'users?where={"id1":"$uid"}&include=commissions&include=membre_user.federation&include=membre_user.region&include=membre_user&include=fonction');

        var res2 = res["results"][0];
        User user = new User.fromMap(res["results"][0]);

        // print(user.type_profil);

        final status = await OneSignal.shared.getDeviceState();
        String token = status?.userId;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("id", res2["objectId"]);

        if (user.auth_id == "fQBcc8f8pBZWK3hrREcybypfUkp1") {
          parse_s.putparse("users/" + user.id, {"token": token});
          await Firestore.instance
              .collection('user_notifications')
              .document(userId.user.uid)
              .setData({
            "send": "yes",
            "my_token": token,
            "name": res2["firstname"] + "  " + res2["familyname"],
            "image": res2["photoUrl"]
          });

          setState(() {
            show = false;
          });
          prefs.setString("id", res2["objectId"]);
          prefs.setString("user", json.encode(res["results"][0]));

          Routes.goto_home(context, widget.auth, widget.onSignedIn, user,
              widget.list_partner, true, widget.analytics, widget.chng);
        } else if (user.active == 0) {
          setState(() {
            show = false;
          });
          if (user.des == true) {
            Navigator.pushReplacement(
                context,
                new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      //new HomePage(widget.auth,widget.sign)
                      new ActiveWidget(user, widget.chng),
                ));
          } else {
            bool type_membre = type_mb(user.type_membre);

            Navigator.pushReplacement(
                context,
                new MaterialPageRoute(
                  builder: (BuildContext context) =>
                      //new HomePage(widget.auth,widget.sign)
                      new EditMyProfile(widget.auth, widget.onSignedIn,
                          widget.list_partner, widget.chng, type_membre),
                ));
          }
          /*  Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (BuildContext context) {
              return new SubmitNameOrganisme(
                  user.id,
                  user.type_profil,
                  user.fullname + " " + user.firstname,
                  user.email,
                  widget.chng);
            }));*/

          /* Navigator.push(context, new MaterialPageRoute(
                builder: (BuildContext context) {
                  return new EntrepriseForm(
                      user.id, "entreprise",widget.chng,user.entreprise.objectId);
                }));*/

        } else {
          prefs.setString("user", json.encode(res["results"][0]));

          var res2 = res["results"][0];

          var js = {"token": token, "raja": true};

          parse_s.putparse("users/" + user.id, js);
          await Firestore.instance
              .collection('user_notifications')
              .document(userId.user.uid)
              .setData({
            "send": "yes",
            "my_token": token,
            "name": res2["firstname"] + "  " + res2["familyname"],
            "image": res2["photoUrl"]
          });

          setState(() {
            show = false;
          });
          prefs.setString("id", res2["objectId"]);
          prefs.setString("user", json.encode(res["results"][0]));

          if (user.notif_user == true) {
            // _firebaseMessaging.subscribeToTopic(user_me.auth_id);
            OneSignal.shared.sendTag("userId", user.auth_id);
          }
          if (user.val_notif_opp == true) {
            OneSignal.shared.sendTag("opportunite", "opportunite");
          }
          if (user.val_notif_pub == true) {
            OneSignal.shared.sendTag("publication", "publication");
          }
          Routes.goto_home(context, widget.auth, widget.onSignedIn, user,
              widget.list_partner, true, widget.analytics, widget.chng);
        }
      } catch (e) {
        //  Navigator.pop(context);
        setState(() {
          show = false;
        });

        /* if (e.details ==
            "The password is invalid or the user does not have a password.") {
          setState(() {
            _authHint = "Le mot de passe n'est pas valide";
          });
        }
          else if (e.details ==
            "We have blocked all requests from this device due to unusual activity. Try again later. [ Access to this account has been temporarily disabled due to many failed login attempts. You can immediately restore it by resetting your password or you can try again later.") {
          setState(() {
            _authHint = "Le mot de passe n'est pas valide";
          });

        } else if (e.details.toString() ==
            "There is no user record corresponding to this identifier. The user may have been deleted.") {
          setState(() {
            _authHint =
                "il n'y a aucun utilisateur enregistré avec cette adresse";
          });
        } else*/
        if (e.message.toString() ==
            "The password is invalid or the user does not have a password.") {
          setState(() {
            _authHint =
                "L'accès à ce compte a été temporairement désactivé en raison de nombreuses tentatives de connexion infructueuses. Vous pouvez le restaurer en réinitialisant votre mot de passe ou vous pouvez réessayer plus tard.";
          });
        } else if (e.message.toString() ==
            "We have blocked all requests from this device due to unusual activity. Try again later. [ Access to this account has been temporarily disabled due to many failed login attempts. You can immediately restore it by resetting your password or you can try again later.") {
          setState(() {
            _authHint =
                "L'accès à ce compte a été temporairement désactivé en raison de nombreuses tentatives de connexion infructueuses. Vous pouvez le restaurer en réinitialisant votre mot de passe ou vous pouvez réessayer plus tard.";
          });
        } else if (e.message.toString() ==
            "There is no user record corresponding to this identifier. The user may have been deleted.") {
          setState(() {
            _authHint =
                " il n'y a aucun utilisateur enregistré avec cette adresse";
          });
        } else {
          setState(() {
            _authHint = '${e.message.toString()}';
          });
        }

        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Validators val = new Validators(context: context);

    Widget hintText() {
      return _authHint == ""
          ? new Container()
          : new Container(
              //height: 80.0,
              padding: const EdgeInsets.all(0.0),
              child: new Text(_authHint,
                  key: new Key('hint'),
                  style: new TextStyle(fontSize: 13.0, color: Colors.red[700]),
                  textAlign: TextAlign.center));
    }

    Widget email = Widgets.textfield(
            LinkomTexts.of(context).email(),
            _focusemail,
            user.email,
            _emailcontroller,
            TextInputType.emailAddress,
            val.validateEmail,
            size: ScreenUtil().setSp(13));

    Widget password =Widgets.textfield(
            LinkomTexts.of(context).password(),
            _focuspassword,
            user.password,
            _passcontroller,
            TextInputType.text,
            val.validatePassword2,
            obscure: true,
            size: ScreenUtil().setSp(13));

    var style = new TextStyle(
        color: const Color(0xffeff2f7),
        fontSize: ScreenUtil().setSp(15),
        fontWeight: FontWeight.w500);

    var style2 = new TextStyle(
        color: Fonts.col_app_fon,
        fontSize: ScreenUtil().setSp(15),
        fontWeight: FontWeight.w500);

    Widget btn_log = Align(
        alignment: Alignment.centerLeft,
        child: Container(
            width: 160.w,
            child: PrimaryButton(
              onTap: () {
                _handleSubmitted();
              },
              icon: "",
              disabledColor: Fonts.col_grey,
              fonsize: 15.5.sp,
              prefix: Container(),
              color: Fonts.col_app,
              isLoading: show,
              text: LinkomTexts.of(context).login(),
              /* child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    new Text(LinkomTexts.of(context).login(), style: style)
                  ],
                )))*/
            )));
    deviceSize = MediaQuery.of(context).size;

    return WillPopScope(
        onWillPop: () {
          Widgets.exitapp(context);
        },
        child: new Scaffold(
            key: _scaffoldKey,
            body: new Padding(
                padding: new EdgeInsets.only(
                    top: ScreenUtil().setHeight(148),
                    left: 36.0.w,
                    right: 36.0.w,
                    bottom: 18.0),
                child: new Form(
                    key: _formKey,
                    autovalidate: _autovalidate,
                    //onWillPop: _warnUserAboutInvalidData,
                    child: new Container(
                        padding: new EdgeInsets.all(8.0),
                        child: new ListView(children: <Widget>[
                          new Container(height: 8.0),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                width: 78.w,
                                height: 78.w,
                                child: Image.asset(
                                  "assets/images/logo1.png",
                                  width: 78.w,
                                )),
                          ),
                          new Container(
                            height: ScreenUtil().setHeight(12),
                          ),
                          Text(
                            'Welcome ',
                            style: TextStyle(
                              fontSize: 24,
                              color: const Color(0xff218bb1),
                              fontWeight: FontWeight.w700,
                            ),
                            softWrap: false,
                          ),
                          new Container(
                            height: ScreenUtil().setHeight(12),
                          ),
                          Text(
                            'Sign in to continue',
                            style: TextStyle(
                              fontSize: 21,
                              color: const Color(0xff999999),
                            ),
                            softWrap: false,
                          ),
                          new Container(height: 8.0),
                          new Container(
                            height: 8.0,
                          ),
                          email,
                          new Container(
                            height: ScreenUtil().setHeight(12),
                          ),
                          password,
                          new Container(
                            height: ScreenUtil().setHeight(12),
                          ),
                          new InkWell(
                              onTap: () {
                                Routes.goto(
                                  context,
                                  "reset",
                                  widget.auth,
                                  widget.onSignedIn,
                                  widget.list_partner,
                                  widget.analytics,
                                  widget.chng,
                                );
                              },
                              child: new Row(
                                children: <Widget>[
                                  new Expanded(child: new Container()),
                                  new Text(
                                    LinkomTexts.of(context).forgot_pass(),
                                    style: new TextStyle(
                                        fontSize: ScreenUtil().setSp(14),
                                        color: Fonts.col_grey2,
                                        decoration: TextDecoration.underline),
                                  )
                                ],
                              )),
                          new Container(
                            height: ScreenUtil().setHeight(16),
                          ),
                          btn_log,
                          new Container(
                            height: ScreenUtil().setHeight(52),
                          ),
                          hintText(),
                          Text(LinkomTexts.of(context).notm(),
                              style: new TextStyle(
                                  color: Fonts.col_app_fon,
                                  fontSize: ScreenUtil().setSp(14))),
                          new Container(height: 12.0.h),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  width: 160.w,
                                  child: PrimaryButton(
                                    onTap: () {
                                      Navigator.push(context,
                                          new MaterialPageRoute(
                                              builder: (BuildContext context) {
                                        return Email_Verify(widget
                                                .chng) /*LoginEntreprise(
                                                                        widget
                                                                            .chng)*/
                                            ;
                                      }));
                                    },
                                    icon: "",
                                    disabledColor: Fonts.col_grey,
                                    fonsize: 15.5.sp,
                                    prefix: Container(),
                                    color: Fonts.col_app_fon,
                                    isLoading: false,
                                    text: LinkomTexts.of(context).register(),
                                  )))
                          /* new oo(
                              padding:
                                  new EdgeInsets.only(left: 36.0, right: 36.0),
                              child: new Material(
                                  elevation: 1.0,
                                  shadowColor: Fonts.col_app_fon,
                                  borderRadius: new BorderRadius.circular(8.0),
                                  color: Colors.white,
                                  child: new MaterialButton(
                                      // color:  const Color(0xffa3bbf1),
                                      onPressed: () {

                                        /* Routes.goto(
                                                                    context,
                                                                    "register",
                                                                    widget.auth,
                                                                    widget
                                                                        .onSignedIn,
                                                                    widget
                                                                        .list_partner,
                                                                    widget
                                                                        .analytics,
                                                                    widget.chng,
                                                                  );*/
                                      },
                                      child: new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          new Image.asset(
                                            "images/reg.png",
                                            color: Fonts.col_app_fon,
                                            width: 25.0,
                                            height: 25.0,
                                            fit: BoxFit.cover,
                                          ),
                                          new Container(
                                            width: 8.0,
                                          ),
                                          //  new Container(height: 36.0,color: Colors.white,width: 1.5,),
                                          new Container(
                                            width: 8.0,
                                          ),
                                          new Text(
                                              LinkomTexts.of(context)
                                                  .register(),
                                              style: style2)
                                        ],
                                      ))))*/
                        ]))))));
  }
}
