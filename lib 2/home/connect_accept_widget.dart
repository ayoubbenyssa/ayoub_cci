import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mycgem/chat/chatscreen.dart';
import 'package:mycgem/filter/connect_message.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/notifications/invite_view_user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/connect.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ConnectAcceptWidget extends StatefulWidget {
  ConnectAcceptWidget(this.user, this.user_me, this.chng);

  User user;
  User user_me;
  var chng;

  @override
  _ConnectAcceptWidgetState createState() => _ConnectAcceptWidgetState();
}

class _ConnectAcceptWidgetState extends State<ConnectAcceptWidget> {
  ParseServer parse_s = new ParseServer();

  bool click = true;
  var text = "Se connecter";

  contact(my_id, his_id) async {
    setState(() {
      click = true;
    });

    var response = await parse_s.getparse(
        'connect?where={"\$or":[{"key_id":{"\$eq":"$my_id"}},{"key_id":{"\$eq":"$his_id"}} ]}');
    var count = response["results"].length;

    if (!this.mounted) return null;

    setState(() {
      widget.user.wait = true;
    });
    if (count == 2) {
      text = "Message";
    } else if (count == 0) {
      text = "Se connecter";
    } else {
      var key_id = response["results"][0]["key_id"];
      if (key_id == my_id && response["results"][0]["accepted"] == false) {
        text = "Confirmer";
      } else {
        text = "Demande envoyée";
      }
    }

    return text;
  }

  connect() async {
    setState(() {
      widget.user.activate = false;
    });

    await Connect.inser_request(widget.user_me.id, widget.user.id, false);
    //String token = await _firebaseMessaging.getToken();

    /*  await Firestore.instance.collection('user_notifications')
        .document(widget.images[_currentIndex].auth_id).setData({
      "notif":true
    });*/

    await Firestore.instance
        .collection('user_notifications')
        .document(widget.user.auth_id)
        .collection("Notifications")
        .add({
      "id_user": widget.user_me.auth_id,
      "other_user": widget.user.auth_id,
      "time": new DateTime.now().millisecondsSinceEpoch,
      "accept": false,
      "read": false,
      "type": "connect"
    });

    setState(() {
      widget.user.cnt = "Demande envoyée";
    });
  }

  show_connect() async {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) =>
                new SenderPage(widget.user, widget.user_me, connect)));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var id = widget.user.id.toString() + "_" + widget.user_me.id;
    String my_id = widget.user_me.id + "_" + widget.user.id;
    contact(id, my_id).then((val) {
      setState(() {
        widget.user.cnt = val;
      });
    });
  }

  confirm() {

   /* Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new Invite_view(
          widget.user.auth_id,
          null,
          widget.user_me.auth_id,
          widget.user_me,
          true,
          false,
          null,
          null,
          [],
          widget.user,
          null,
          null,
          widget.chng);
    }));*/
  }

  gotochat() async {
    print("jdhdhdhdh");
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new ChatScreen(
        widget.user_me.auth_id,
        widget.user.auth_id,
        [],
        false,
        null,
        null,
        widget.chng,
        user: widget.user_me,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Color loginGradientStart = Colors.blue[100];
    Color loginGradientEnd = Fonts.col_app;

    return Container(
      width: width * 0.285,
      height: 32.0,
      margin: new EdgeInsets.only(bottom: 0.0,left: 0,right: 0),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),


            color:
              !widget.user.wait ? Colors.grey[400] : Fonts.col_app_fon,


      ),
      child: MaterialButton(
        padding: EdgeInsets.all(2),
          highlightColor: Colors.transparent,
          splashColor: !widget.user.wait ? Colors.grey[400] : loginGradientEnd,
          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Container(
            child: Text(
              widget.user.cnt,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: !widget.user.wait ? Colors.black : Colors.white,
                  fontSize: 10.5.sp),
            ),
          ),
          onPressed: () {
            if (widget.user.activate != false && widget.user.wait != false) {
              print(widget.user.cnt);
              if (widget.user.cnt == "Se connecter")
                show_connect();
              else if (widget.user.cnt == "Confirmer")
                confirm();
              else if (widget.user.cnt == "Message")
                gotochat();
              else
                return null;
            }
          }),
    );
  }
}
