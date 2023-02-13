import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mycgem/cards/details_parc.dart';
import 'package:mycgem/cards/opp_card.dart';
import 'package:mycgem/models/offers.dart';
import 'package:mycgem/services/location_services.dart';
import 'package:mycgem/slides2/homeslides.dart';
import 'package:mycgem/widgets/no_wifi.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mycgem/chat/chatscreen.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/func/users_info.dart';
import 'package:mycgem/login/login.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/auth.dart';
import 'package:mycgem/notifications/invite_view_user.dart';
import 'package:mycgem/widgets/bottom_menu.dart';
import 'package:http/http.dart' as clientHttp;
import 'package:http/http.dart' as http;

class RootPage extends StatefulWidget {
  RootPage(this.onLocaleChange, {this.sign, this.analytics, this.observer});

  var sign;
  var analytics;
  var observer;
  var onLocaleChange;

  @override
  State<StatefulWidget> createState() => _RootPageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;
  BaseAuth auth = Auth();
  String _searchText = "";

  int actif = 0;
  String com_id = "";
  String com_name = "";
  Usernfo user_info = new Usernfo();
  User user_me = new User();
  ParseServer parse_s = new ParseServer();

  //List list_partner;
  bool wait = true;
  int state = 0;
  List list_partners;
  final Connectivity _connectivity = new Connectivity();

  bool connect = true;
  bool reload = false;
  bool load = true;

  getUserInfo(id, show) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await parse_s.getparse(
        'users?where={"id1":"$id"}&include=membre_user&include=commissions&include=membre_user.federation&include=membre_user.region,membre_user.ville&include=fonction');
    if (!this.mounted) return;

    if (response == "No")
      setState(() {
        connect = false;
      });
    else
      setState(() {
        connect = true;

        if (response["results"].length > 0) {
          user_me = new User.fromMap(response["results"][0]);

          if (user_me.notif_user == true) {
            // _firebaseMessaging.subscribeToTopic(user_me.auth_id);
            OneSignal.shared.sendTag("userId", user_me.auth_id);
          }
          if (user_me.val_notif_opp == true) {
            OneSignal.shared.sendTag("opportunite", "opportunite");
          }
          if (user_me.val_notif_pub == true) {
            OneSignal.shared.sendTag("publication", "publication");
          }
          if (show == true) {
            prefs.setString("user", json.encode(response["results"][0]));
          }
        }
      });
  }

  not() {}

  //    permissions();

  receivenotification(message) async {
    String my_id = await auth.currentUser();
    // FlutterAppBadger.removeBadge();

    print(message);

    await getUserInfo(my_id, false);

    if (my_id != null) {
      if (message["keyy"] == "msg") {
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) {
          return new ChatScreen(
              message["my_key"].split("_")[1],
              message["my_key"].split("_")[0],
              list_partners,
              false,
              auth,
              widget.analytics,
              widget.onLocaleChange,
              user: user_me);
        }));
      } else if (message["keyy"] == "pub") {
        String idpost = message["pub_id"];
        var gMessagesDbRef3 =
            FirebaseDatabase.instance.reference().child("count_notifications");
        gMessagesDbRef3.update({user_me.auth_id: 0});
        var a = await parse_s.getparse(
            'offers?where={"objectId": "$idpost"}&include=author&include=membre');
        Offers off = Offers.fromMap(a['results'][0]);

        if (message["type"] == "opportunite") {
         /* Firestore.instance
              .collection('user_notifications')
              .document(user_me.auth_id)
              .collection("Notifications")
              .document( posts[index].notif_id )
              .updateData({"read": true});*/

          Navigator.push(context,
              new MaterialPageRoute(builder: (BuildContext context) {
            return new OppCard(
                off, user_me, 0.0, 0.0, context, true, widget.onLocaleChange);
          }));
        } else {
          Navigator.push(context,
              new MaterialPageRoute(builder: (BuildContext context) {
            return new DetailsParc(off, user_me, off.type, [], null,
                widget.analytics, widget.onLocaleChange, 0.0, 0.0);
          }));
        }
      } else if (message["keyy"] == "connect") {
        //posts[index].auth_id, posts[index].notif_id,id,widget.user_me,
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) {
          return new Invite_view(
              message["sent_id"],
              message["id_notification"],
              my_id,
              user_me,
              true,
              not,
              auth,
              widget.sign,
              list_partners,
              null,
              null,
              widget.analytics,
              widget.onLocaleChange);
        }));
      } else if (message["keyy"] == "accept") {
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) {
          return new Invite_view(
              message["sent_id"],
              message["id_notification"],
              my_id,
              user_me,
              false,
              not,
              auth,
              widget.sign,
              list_partners,
              null,
              null,
              widget.analytics,
              widget.onLocaleChange);
        }));
      } else if (message["keyy"] == "group") {
        Navigator.pushReplacement(context,
            new MaterialPageRoute(builder: (BuildContext context) {
          return new BottomNavigation(auth, _signedIn, user_me, list_partners,
              true, widget.analytics, widget.onLocaleChange,
              animate1: true);
        }));
      }
    }
    //});
  }

  Future<String> _fcmSetupAndGetToken() async {
    ///jijiji

    /*  SharedPreferences prefs = await SharedPreferences.getInstance();
    return await _firebaseMessaging.getToken().then((token) {
      prefs.setString("token", token);
    });*/
  }

  get_info(id) async {
    //String my_id = await widget.auth.currentUser();
    // await  getUserInfo(my_id);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await getUserInfo(id, true);

    setState(() {
      connect = true;
      list_partners = [];
    });

    setState(() {
      wait = false;
    });

    if (prefs.getString("Slides").toString() == "null") {
      setState(() {
        state = -1;
      });
    }

    /* else if (prefs.getString("ent").toString() == "true") {

      setState(() {
        wait = false;
        state = 5;
      });
    }*/
    else if (prefs.getString('user').toString() != "null") {
      //await  verify_gps();

      setState(() {
        wait = true;
      });
      if (id != null) {
        await getUserInfo(id, true);
      }
      // user_me = new User.fromMap(json.decode(prefs.getString("user")));

      if (user_me.active == 0) {
        setState(() {
          wait = false;
          state = 3;
        });
      } else {
        setState(() {
          wait = false;
          state = 1;
        });
      }
    } else {
      setState(() {
        state = 3;
      });
    }
  }

  bool gps_exist = true;

  verify_gps() async {
    //await permissions();

    bool gps_op = await Location_service.verify_location();
    if (gps_op)
      setState(() {
        gps_exist = true;
      });
    else {
      setState(() {
        gps_exist = false;
      });
      /* Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (BuildContext context) => new NoGps(verify_gps, null),
          ));*/
    }
  }

  /*Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    get_count();
    // Or do other work.
  }*/

/*  get_count() async {
    FirebaseUser my_id = await FirebaseAuth.instance.currentUser();

    print("jijiya");
    print(my_id.uid);
    if(my_id != null)
    FirebaseDatabase.instance
        .reference()
        .child("count_notifications/" + my_id.uid)
        .onValue
        .listen((val) {
      var d = val.snapshot.value;
      print("receeeeeived");
      print(d.toString());
      if (d != null) FlutterAppBadger.updateBadgeCount(d);
    });
  }
*/
  Future<void> firebaseMessagingBackgroundHandler(message) async {
    print("Handling a background message");
  }

  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  init() async {
    await OneSignal.shared.setAppId("4bc8d769-4249-469a-a66a-6b741ead8414");
    /* await OneSignal.shared.promptUserForPushNotificationPermission(
      fallbackToSettings: true,

    );*/

    /// Get the Onesignal userId and update that into the firebase.
    /// So, that it can be used to send Notifications to users later.̥
    final status = await OneSignal.shared.getDeviceState();
    final String osUserID = status?.userId;
    // We will update this once he logged in and goes to dashboard.
    ////updateUserProfile(osUserID);
    // Store it into shared prefs, So that later we can use it.

    print("--------------tooooken-----------------------------");
    print(osUserID);
    // OneSignal.shared.sendTag("tag1", "publication");

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      // This will be called whenever a notification is opened.

      print("ressssssult");
      print(result.notification.additionalData);
      receivenotification(result.notification.additionalData);
    });

    // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission

    /*  _firebaseMessaging.subscribeToTopic('publication1');

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");

        new Timer(new Duration(seconds: 6), ()
        {
          get_count();
        });

         receivenotification(message);
      },
      //  onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        get_count();
//    FlutterAppBadger.removeBadge();
        receivenotification(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        get_count();

        receivenotification(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));

    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });*/

    _fcmSetupAndGetToken();

    auth.currentUser().then((userId) {
      print("isjsijsijsisjsiodsjiodjihdio");

      get_info(userId);

      if (userId == null) {
        setState(() {
          authStatus = AuthStatus.notSignedIn;
        });
      } else {
        setState(() {
          authStatus = AuthStatus.signedIn;
        });

        // conditions();
      }
    });
  }

  reload_page() {
    setState(() {
      load = false;
    });

    print(
        "-------------------------------------------------------------------------------------------");
    new Timer(new Duration(seconds: 2), () {
      setState(() {
        load = true;
      });
    });
  }

  initState() {
    super.initState();

    init();
    // aaaaaaaaa();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _signedIn() {
    authStatus = AuthStatus.signedIn;
  }

  void _signedOut() {
    authStatus = AuthStatus.notSignedIn;
  }

  got(chng) {
    switch (state) {
      case -1:
        return new Homeslides(widget.onLocaleChange);
      case 1:
        return new BottomNavigation(auth, _signedIn, user_me, list_partners,
            true, widget.analytics, widget.onLocaleChange);
        break;

      case 3:
        return new Login(
            auth, _signedIn, list_partners, widget.analytics, chng);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return !connect
        ? NoWifi(init, true)
        : wait
            ? Scaffold(backgroundColor: Colors.grey[100], body: Widgets.load())
            : got(widget.onLocaleChange);
  }
}
