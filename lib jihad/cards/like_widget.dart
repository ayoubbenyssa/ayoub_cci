import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mycgem/models/video.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mycgem/models/like.dart';
import 'package:mycgem/models/offers.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/favorite_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteButton extends StatefulWidget {
  FavoriteButton(this.offer, this.user, this.show, this.func_update_comment);

  var offer;
  User user;
  bool show = false;
  var func_update_comment;

  @override
  _FavoriteButtonState createState() => new _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton>
    with SingleTickerProviderStateMixin {
  Animation<double> _heartAnimation;
  AnimationController _heartAnimationController;
  Color _heartColor = Colors.grey[400];
  bool favorite = false;
  int fav_id;
  static const int _kHeartAnimationDuration = 400;
  FavoriteService favservice = new FavoriteService();
  Like likeFunctions = new Like();

  @override
  bool get wantKeepAlive => true;

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
    var res =
        await likeFunctions.isliked(widget.user.id, widget.offer.objectId);

    if (!this.mounted) return;
    print("--------");
    print(res);
    setState(() {
      widget.offer.didd = 1;
      widget.offer.liked = res;
    });
  }

  toggletar() async {
    setState(() {
      widget.offer.wawitlike = true;
    });
    var res = await likeFunctions.like(widget.user.id, widget.offer.objectId);
    if (res == false) return;
    try {
      setState(() {
        widget.offer.liked = res["isLiked"];

        /// widget.offer.po = widget.offer.likes_post;
        widget.offer.wawitlike = false;
        widget.func_update_comment(widget.offer.liked ? 1 : -1);
      });
    } catch (e) {
      e.toString();
    }

    //  return {"numberlikes": numberlikes + 1, "isLiked": true};
  }

  @override
  void initState() {
    super.initState();
    _configureAnimation();
    if (widget.offer.didd == 0) isliked();

    //verify_fav();
  }

  /*@override
  void dispose() {
    _heartAnimationController.dispose();
    super.dispose();
  }
*/
  String id;

  toggle() async {
    Scaffold.of(context)
        .showSnackBar(new SnackBar(content: new Text("Suppriméé")));
  }

  @override
  Widget build(BuildContext context) {
    /*
     ? new Image.asset("images/hand.png", width: 22.0, height: 22.0)
            : new Image.asset("images/handn.png", width: 22.0, height: 22.0))
     */
    final Widget child = new InkWell(
      //padding: new EdgeInsets.all(1.0),
      child: new Container(
          padding: EdgeInsets.only(bottom: 4.h),
          child: new ScaleTransition(
              scale: _heartAnimation,
              child: new Image.asset(
                  widget.offer.liked == true
                      ? "images/hand.png"
                      : "images/handn.png",
                  color: widget.offer.liked == true
                      ? Fonts.col_app_green
                      : Fonts.col_app_fonn,
                  width: 18.0.w,
                  height: 18.0.w))),

      onTap: (() {
        if (widget.offer.wawitlike == false) {
          toggletar();
        }
        _heartAnimationController.forward().whenComplete(() {
          _heartAnimationController.reverse();
        });
      }),
    );

    return new Row(
      children: <Widget>[
        child,
        widget.show == false
            ? GestureDetector(
                child: Text(" J'aime",
                    style: new TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Fonts.col_ap_fonn,
                        fontSize: 13.0.sp)),
                onTap: () {
                  if (widget.offer.wawitlike == false) {
                    toggletar();
                  }
                  _heartAnimationController.forward().whenComplete(() {
                    _heartAnimationController.reverse();
                  });
                })
            : new Text(
                widget.offer.likes_post.toString() == "null"
                    ? "  ( 0 )"
                    : "  ( " + widget.offer.likes_post.toString() + " )",
                style: new TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Fonts.col_ap_fonn,
                    fontSize: 13.0.sp),
              ),
        new Container(
          width: 2.0,
        ),
      ],
    );
  }
}
