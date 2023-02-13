import 'package:flutter/material.dart';
import 'package:mycgem/home/home.dart';
import 'package:mycgem/login/login.dart';
import 'package:mycgem/login/register.dart';
import 'package:mycgem/login/reset_password.dart';
import 'package:mycgem/widgets/bottom_menu.dart';

class Routes {
  static goto(context, go, auth, onSignedIn, list_partner, analytics, chng,
      {id_ent, contact}) {
    var res;
    if (go == "register")
      res = new Register(list_partner, analytics, chng, id_ent, contact);
    else if (go == "login") {
      res = new Login(auth, onSignedIn, list_partner, analytics, chng);
    } else if (go == "reset") {
      res = new Reset_Password(auth, onSignedIn);
    }
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return res;
    }));
  }

  static goto_home(
      context, auth, sign, user, list_partner, show, analytics, chng) {
    Navigator.pushReplacement(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new BottomNavigation(
          auth, sign, user, list_partner, show, analytics, chng);
    }));
  }

  static go_com(context, auth, sign, list_partner, analytics
      /*,show,id_user*/) {}

  static go_inactive(
    context,
    com,
    auth,
    sign,
    list_partner,
    analytics,
  ) {}

  static go_login(context, auth, sign, list_partner, analytics, chng) {
    Navigator.pushReplacement(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new Login(auth, sign, list_partner, analytics, chng);
    }));
  }
}
