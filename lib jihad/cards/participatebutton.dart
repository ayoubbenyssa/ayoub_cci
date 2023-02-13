import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/offers.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/favorite_service.dart';
import 'package:mycgem/services/participate_service.dart';
import 'package:mycgem/services/validators.dart';

class ParticipateButton extends StatefulWidget {
  ParticipateButton(this.offer, this.user, this.analytics, this.ctx);

  var offer;
  User user;
  var analytics;
  var ctx;

  @override
  _FavoriteButtonState createState() => new _FavoriteButtonState();
}

class _FavoriteButtonState extends State<ParticipateButton>
    with TickerProviderStateMixin {
  ParseServer parse_s = new ParseServer();
  Animation<double> _heartAnimation;
  AnimationController _heartAnimationController;
  Color _heartColor = Colors.grey[400];
  bool favorite = false;
  int fav_id;
  static const int _kHeartAnimationDuration = 100;
  FavoriteService favservice = new FavoriteService();
  ParticipateServices likeFunctions = new ParticipateServices();
  bool show = false;
  final TextEditingController _textController = new TextEditingController();

  _configureAnimation() {
    Animation<double> _initAnimation(
        {@required double from,
        @required double to,
        @required Curve curve,
        @required AnimationController controller}) {
      final CurvedAnimation animation = new CurvedAnimation(
        parent: controller,
        curve: curve,
      );
      return new Tween<double>(begin: from, end: to).animate(animation);
    }

    _heartAnimationController = new AnimationController(
      duration: const Duration(milliseconds: _kHeartAnimationDuration),
      vsync: this,
    );

    _heartAnimation = _initAnimation(
        from: 1.0,
        to: 1.8,
        curve: Curves.easeOut,
        controller: _heartAnimationController);
  }

  isliked() async {
    var res = await likeFunctions.isliked(
        widget.user.id, widget.offer.objectId, part_condition);
    try {
      setState(() {
        widget.offer.liked = res;
      });
    } catch (e) {
      e.toString();
    }
  }

  toggletar() async {
    setState(() {
      show = true;
    });
    var res = await likeFunctions.like(widget.user.id, widget.offer.objectId,
        widget.user.phone, part_condition);
    if (res == false) return;
    try {
      setState(() {
        show = false;
        widget.offer.liked = res["isLiked"];
        widget.offer.numberlikes = res["numberlikes"];
      });

      if (widget.offer.liked) {
        Scaffold.of(context).showSnackBar(new SnackBar(
            content:
                new Text("Votre requette sera transmise à notre partenaire!")));
      } else {}
    } catch (e) {
      e.toString();
    }

    //  return {"numberlikes": numberlikes + 1, "isLiked": true};
  }

  int accept = 0;

  @override
  void initState() {
    super.initState();
    if (widget.user.phone.toString() != "null" && widget.user.phone != "")
      setState(() {
        _textController.text = widget.user.phone;
      });

    _configureAnimation();

    isliked();

    //verify_fav();
  }

  @override
  void dispose() {
    _heartAnimationController.dispose();
    super.dispose();
  }

  String id;

  part_condition() {
    if (widget.offer.condition == "Ouvert") {
      accept = 1;
    } else if (widget.offer.condition == "preinscription") {
      accept = 0;
    } else if (widget.offer.condition == "membre") {
      if (widget.offer.partner.objectId == widget.user.entreprise.objectId) {
        accept = 1;
      } else {
        _showDialog1();
        accept = -1;
      }
    }
    return accept;
  }

  toggle() async {
    Scaffold.of(context)
        .showSnackBar(new SnackBar(content: new Text("Suppriméé")));
  }

  String validateMobile(String value) {
    /*if (value.length <= 0)
      return "Siil vous plait entrz le numéro de téléphonne";
    else*/

    if (value.length > 0 && value.length != 10 && value.length != 12) {
      return 'Le numéro de téléphone n est pas valid';
    } else if (value.length > 0 &&
        !value.startsWith("06") &&
        !value.startsWith("07") &&
        value[0] != "+") return 'Le numéro de téléphone n est pas valid';

    return null;
  }

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  _showDialog1() async {
    return await showDialog(
        builder: (BuildContext context) => new AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: Container(
                height: 160,
                child: Column(children: <Widget>[
                  Text(
                      "Vous ne pouvez pas participer a cet évènement, car il est seulement ouvert aux membres de " +
                          widget.offer.partner.name),
                ]))));
  }

  _showDialog() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) => new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: Container(
            height: 160,
            child: Column(
              children: <Widget>[
                Text(widget.user.phone.toString() != "null" &&
                        widget.user.phone != ""
                    ? "Est ce  que c'est bien votre numéro de téléphone?"
                    : "Entrer le numéro de téléphonne"),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: Form(
                          key: _formKey,
                          child: new TextFormField(
                            autofocus: true,
                            validator: validateMobile,
                            controller: _textController,
                            decoration: new InputDecoration(
                                hintText: 'Numéro de téléphonne'),
                          )),
                    )
                  ],
                ),
              ],
            )),
        actions: <Widget>[
          new FlatButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text('Ok'),
              onPressed: () async {
                print("jdhkdk");

                /* new Timer(const Duration(milliseconds: 300), () =>  toggletar()
                );*/
              })
        ],
      ),
    );
  }

  void _handleSubmitted() {
    toggletar();
  }

  @override
  Widget build(BuildContext context) {
    Color loginGradientStart = Fonts.col_app;
    Color loginGradientEnd = Fonts.col_app;

    Color loginGradientStart1 = Colors.grey[500];
    Color loginGradientEnd1 = Colors.grey[500];

    final Widget child = new RaisedButton(
      padding: EdgeInsets.all(4),
      color: Colors.grey[100],
      elevation: 0,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.all(
        Radius.circular(6.0),
      )),
      child: new ScaleTransition(
          scale: _heartAnimation,
          child: new Text(
            widget.offer.liked == true
                ? LinkomTexts.of(context).not_int()
                : LinkomTexts.of(context).je_int(),
            style: new TextStyle(
              color: widget.offer.liked == true
                  ? Colors.black
                  : Fonts.col_app_green,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          )

          /*new Icon(
                Icons.favorite,
                color: widget.offer.liked == true ? const Color(0xffff374e):Colors.grey[400],
                size: 24.0,
              )*/
          ),
      onPressed: (() {
        //

        _handleSubmitted();
      }),
    );

    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        child,
        new Container(width: 4.0),

        /*  widget.offer.liked == true
          ? new Icon(Icons.check, color: Colors.green,)
          : new Container(),*/
        show
            ? new Container(
                width: 15.0,
                height: 15.0,
                child: new CircularProgressIndicator(
                  strokeWidth: 1.0,
                ))
            : new Container(),
        /*new Text(widget.offer.numberlikes.toString()=="null"?"0":widget.offer.numberlikes.toString(),
        style: new TextStyle(fontWeight: FontWeight.bold),),*/
      ],
    );
  }
}
