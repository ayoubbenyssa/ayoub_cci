import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/login/login.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/user/edit_my_profile.dart';
import 'package:mycgem/widgets/bottom_menu.dart';
import 'package:mycgem/widgets/custom_widgets/primary_button.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InactiveWidget extends StatefulWidget {
  InactiveWidget(this.chng, this.membre, this.user);

  var chng;
  bool membre;
  User user;

  // List list_partner;
  //var analytics;
  //var func;

  @override
  _InactiveWidgetState createState() => new _InactiveWidgetState();
}

class _InactiveWidgetState extends State<InactiveWidget> {
  bool loading = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  submit() {
    setState(() {
      loading = true;
    });
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  @override
  void initState() {
    super.initState();
    print("d^^^ld^^^^^^^^pd^^d^^p^^p^^pd^^dpd^^d^^p");
  }

  String text = "";
  bool load = false;
  ParseServer parse_s = new ParseServer();

  goto() async {
    setState(() {
      load = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString("id").toString();
    print(id);

    var a = await parse_s
        .getparse('users?where={"active":1,"objectId":"$id"}&include=fonction');
    if (!this.mounted) return;
    setState(() {
      load = false;
    });

    if (a["results"].length == 1) {
      User user = new User.fromMap(a["results"][0]);

      Navigator.pushReplacement(
          context,
          new MaterialPageRoute(
              builder: (BuildContext context) => new BottomNavigation(
                  null, null, user, [], false, null, widget.chng,
                  animate: true)));
    } else {
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: new Text("Votre compte est en attente de vérification !")));
    }
  }

  @override
  Widget build(BuildContext context) {
    var style = new TextStyle(
        color: const Color(0xffeff2f7),
        fontSize: 20.0,
        fontWeight: FontWeight.w500);

    Widget ess = PrimaryButton(
        icon: "",
        disabledColor: Fonts.col_grey,
        fonsize: 15.5,
        prefix: Container(),
        color: Fonts.col_app,
        isLoading: load,
        onTap: () {
          goto();
        },
        text: "Réessayer");

    var style2 = new TextStyle(
        color: Colors.grey[700], fontSize: 20.0, fontWeight: FontWeight.w500);

    /*
    Widget ess = new Padding(
        padding: new EdgeInsets.only(left: 36.0, right: 36.0, top: 36.0),
        child: new Material(
            elevation: 4.0,
            shadowColor: Colors.grey[700],
            borderRadius: new BorderRadius.circular(8.0),
            color: Fonts.col_app,
            child: new MaterialButton(
                onPressed: () {
                //  widget.func();
                  //nearDistance();

                  Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                        builder: (BuildContext context) =>
                        //new HomePage(widget.auth,widget.sign)
                        new EditMyProfile(null,null,[], widget.chng, false

                  ),
                      ));


                },
                child: new Text(LinkomTexts.of(context).continu(), style: style))));

*/

    var style0 = new TextStyle(
        color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500);

    Widget ret = PrimaryButton(
        icon: "",
        disabledColor: Fonts.col_grey,
        fonsize: 15.5,
        prefix: Container(),
        color: Fonts.col_app_fon,
        isLoading: false,
        onTap: () {
          //  widget.func();
          //nearDistance();

          Navigator.pushReplacement(context,
              new MaterialPageRoute(builder: (BuildContext context) {
            return new Login(null, null, [], null, widget.chng);
          }));
        },
        text: "Retourner");

    return new Scaffold(
        key: _scaffoldKey,
        body: new Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/images/background.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(children: [
              Container(
                height: 140.0.h,
              ),
              Stack(children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 36.0.h, left: 16.w, right: 16.w),
                  child: Material(
                    elevation: 1,
                    borderRadius: new BorderRadius.circular(16.0),
                    color: Colors.white,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // new Container(height:8.0),

                        Container(
                          height: 36.0.h,
                        ),
                        new Padding(
                            padding: EdgeInsets.all(12.0),
                            child: new Text(
                              widget.membre == true
                                  ? "Votre demande est en cours de vérification, vous serez contacté pour "
                                      "activer le compte de votre organisme."
                                  : "Afin de vérifier votre appartenance à ${widget.user.entreprise.name},  un email de validation a été envoyé à votre administrateur de compte sur l'email ${widget.user.entreprise.email}. Sa validation est nécessaire avant que vous puissiez rejoindre la communauté CCIS !",
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                  color: Fonts.col_app_fon,
                                  height: 1.2,
                                  fontSize: 18.0),
                            )),
                        new Container(height: 50.0),
                        !loading ? new Container() : Widgets.load(),

                        Container(
                          height: 12,
                        ),
                        new Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ret,
                            Container(
                              width: 12,
                            ),
                            ess
                          ],
                        )),

                        Container(
                          height: 16,
                        ),

                        /* Container(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: RichText(
                          textAlign: TextAlign.justify,
                          text: new TextSpan(
                            text: "",
                            children: <TextSpan>[
                              new TextSpan(
                                text:
                                "Pour toute information complémentaire, contactez-nous à ",
                                style: TextStyle(
                                    color: Colors.grey[600], fontSize: 18),
                              ),
                              new TextSpan(
                                  text: //(dans une entreprise déjà inscrite au niveau de la plateforme)
                                  "mycgem@cgem.ma",
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      final Uri _emailLaunchUri = Uri(
                                        scheme: 'mailto',
                                        path: 'mycgem@cgem.ma',
                                      );

// ...

                                      launch(_emailLaunchUri.toString());
                                    },
                                  style: new TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500))
                            ],
                          ))),*/

                        //  new Center(child: ess),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      width: 78.w,
                      height: 78.w,
                      child: Image.asset(
                        "assets/images/logo2.png",
                        width: 78.w,
                      )),
                ),
              ]),
              Expanded(
                child: Container(),
              ),
              Center(
                child: Container(
                    width: 258.w,
                    child: Image.asset("assets/images/logo_bk.png")),
              ),
              Container(
                height: 56.h,
              )
            ])));
  }
}
//Revenir en arrière
