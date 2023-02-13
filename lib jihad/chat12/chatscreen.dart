// Dart Imports
import 'dart:async';
import 'dart:io';
import 'package:flutter_sound/flutter_sound.dart';

// Package Imports
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:mycgem/chat/UserWidget.dart';
import 'package:mycgem/chat/chat_message.dart';
import 'package:mycgem/chat/database_messages.dart';
import 'package:mycgem/chat/message_data.dart';
import 'package:mycgem/chat12/chat_message.dart';
import 'package:mycgem/chat12/group_chat.dart';
import 'package:mycgem/models/chat.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/location_services.dart';
import 'package:mycgem/services/users_services.dart';
import 'package:mycgem/widgets/bottom_menu.dart';

class ChatScreen1 extends StatefulWidget {
  ChatScreen1(this.myid, this.idOther, this.list_partners, this.goto, this.auth,
      this.list_ids_users, this.name, this.id_key, this.analytics, this.chng,
      {this.user, this.reload, this.chat, Key key})
      : super(key: key);
  String idOther;
  String myid;
  var reload;
  User user;
  var list_partners;
  var goto;
  var auth;
  List<String> list_ids_users;
  var name;
  var key;
  var id_key;
  var analytics;
  var chat;
  var chng;

  @override
  _ChatScreenState createState() => new _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen1>
    with TickerProviderStateMixin {
  bool _isComposing = false;
  final TextEditingController _textController = new TextEditingController();

  bool show_textfield = true;
  Database database = new Database();
  DatabaseReference gMessagesDbRef;
  String idLast = "";
  bool vu = false;

  //DatabaseReference gMessagesDbRef2;
  DatabaseReference gMessagesDbRef3;
  bool isBlock = false;
  String document = "";
  User user_o;

  bool show = false;

  List list = new List();
  String my_name;
  bool uploading = false;
  var im = "";
  var lo = false;
  var error = "";
  List<String> images = new List<String>();
  FlutterSound flutterSound;

  bool getInfo = false;
  List<User> list_users_info = new List<User>();

  get_users_infos(a) async {
    widget.list_ids_users = a;

    list_users_info = await UserServices.get_users_list(widget.list_ids_users);
    if (!this.mounted) return;
    setState(() {
      getInfo = true;
    });
  }

  @override
  initState() {
    get_users_infos(widget.list_ids_users);

    flutterSound = new FlutterSound();
    flutterSound.setSubscriptionDuration(0.01);

    /*gMessagesDbRef2 = FirebaseDatabase.instance
        .reference()
        .child("room_medz_group");*/

    gMessagesDbRef = FirebaseDatabase.instance.reference().child(widget.name);

    super.initState();
  }

  /*

  micro
   */
  bool _isRecording = false;
  bool _isPlaying = false;
  StreamSubscription _recorderSubscription;
  StreamSubscription _playerSubscription;
  String _recorderTxt = '00:00:00';
  String _playerTxt = '00:00:00';
  String path = "";

  void startRecorder() async {
    try {
      path = await flutterSound.startRecorder();

      _recorderSubscription = flutterSound.onRecorderStateChanged.listen((e) {
        // print("jdjdjdjjdjdjdjdj");
        // print(e);

        DateTime date =
            new DateTime.fromMillisecondsSinceEpoch(e.currentPosition.toInt());
        String txt = DateFormat('mm:ss:SS', 'en_US').format(date);

        this.setState(() {
          this._recorderTxt = txt.substring(0, 8);
        });
      });

      this.setState(() {
        this._isRecording = true;
      });
    } catch (err) {
      print('startRecorder error: $err');
    }
  }

  void stopRecorder() async {
    try {
      String result = await flutterSound.stopRecorder();
      print('stopRecorder: $result');

      File file = new File(path);
      await save_audio(file);

      if (_recorderSubscription != null) {
        _recorderSubscription.cancel();
        _recorderSubscription = null;
      }

      this.setState(() {
        this._isRecording = false;
      });
    } catch (err) {
      print('stopRecorder error: $err');
    }
  }

  /*

  micro
   */

  save_image(File image, ext) async {
    setState(() {
      uploading = true;
      lo = false;
    });

    int timestamp = new DateTime.now().millisecondsSinceEpoch;
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child("profile/img_" + timestamp.toString() + ext);
    var val = await storageReference.put(image).onComplete;
    var va = await val.ref.getDownloadURL();
    //if (!mounted) return;

    setState(() {
      images.add(va.toString());
      im = va.toString();
      error = "";
      uploading = false;
      lo = true;
    });

    return true;
  }

  String audio_url = "";

  save_audio(File image) async {
    setState(() {
      uploading = true;
      lo = false;
    });

    int timestamp = new DateTime.now().millisecondsSinceEpoch;
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child("audio/img_" + timestamp.toString() + ".mp4");
    var val = await storageReference.put(image).onComplete;
    var va = await val.ref.getDownloadURL();
    //if (!mounted) return;
    await _sendMessage(audio: va.toString(), text: "text");

    setState(() {
      print(va.toString());
      audio_url = va.toString();

      error = "";
      uploading = false;
      lo = true;
    });

    return true;
  }

  gallery() async {
    Navigator.pop(context);
    images = [];
    var platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion =
          await ImagePicker.pickImage(source: ImageSource.gallery);

      await _cropImage(platformVersion);

      print("yessss");
      _sendMessage(imageUrl: images, text: "text");
    } on PlatformException {
//      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  Future _cropImage(image) async {
    File compressedFile =
        await FlutterNativeImage.compressImage(image.path, quality: 60);
    await save_image(compressedFile, ".jpg");
    return true;
  }

  ///image
  _handleCameraButtonPressed() async {
    Navigator.of(context).pop(true);
    images = [];

    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    await _cropImage(image);
    _sendMessage(imageUrl: images, text: "text");
  }

  //bottom sheet
  open_bottomsheet() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => new Dialog(
            child: new Container(
                height: 150.0,
                child: new Container(
                    // padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                    child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                      new ListTile(
                          dense: true,
                          leading: new Image.asset(
                            "images/camera.png",
                            width: 28.0,
                            height: 28.0,
                            color: Colors.blue[700],
                          ),
                          onTap: _handleCameraButtonPressed,
                          title: new Text(
                            "Camera",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          )),
                      Container(
                          height: 1.0, width: 1000.0, color: Colors.grey[200]),
                      new ListTile(
                          dense: true,
                          leading: new Image.asset(
                            "images/gal.png",
                            width: 28.0,
                            height: 28.0,
                            color: Colors.blue[700],
                          ),
                          onTap: gallery,
                          title: new Text("Galerie",
                              style: TextStyle(
                                fontSize: 16.0,
                              ))),
                      Container(
                          height: 1.0, width: 1000.0, color: Colors.grey[200]),
                      /* new ListTile(
                          dense: true,
                          leading: new Image.asset(
                            "images/lin.png",
                            width: 28.0,
                            height: 28.0,
                            color: Colors.blue[700],
                          ),
                          onTap: (){

                          },
                          title: new Text("Fichier",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                              ))),*/
                      Container(
                          height: 1.0, width: 1000.0, color: Colors.grey[200]),
                      new ListTile(
                          dense: true,
                          leading: new Image.asset(
                            "images/location.png",
                            width: 28.0,
                            height: 28.0,
                            color: Colors.blue[700],
                          ),
                          onTap: () {
                            getLocation();
                          },
                          title: new Text("Position",
                              style: TextStyle(
                                fontSize: 16.0,
                              ))),
                    ])))));
  }

  String _fileName = '...';
  String _path = '...';
  String _extension;
  bool _hasValidMime = false;

  var url = "";
  String addr = "";
  double lat, lng;
  String key = "AIzaSyCESijRK1ROlUvqjEEG6vtCyRoMjjClzpM";
  Map<dynamic, dynamic> result = new Map();

  /*
  map
   */

  var currentLocation = <String, double>{};
  var location = new Location();

  getLocation() async {
    Navigator.of(context).pop(true);
    try {
      currentLocation = await Location_service.getLocation();
      print(currentLocation);

      lat = currentLocation["latitude"];
      lng = currentLocation["longitude"];

      _sendMessage(text: "text", lat: lat, lng: lng);
    } on PlatformException {
      print("noooooo");

      setState(() {});
      // showInSnackBar("Veuillez activer votre GPS");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets() {
      return images
          .map((String file) => new Stack(children: <Widget>[
                new Container(
                    padding: new EdgeInsets.all(4.0),
                    width: 60.0,
                    height: 60.0,
                    child: new Material(
                        borderRadius: new BorderRadius.circular(12.0),
                        shadowColor: Colors.white,
                        elevation: 3.0,
                        child: new Image.network(
                          file,
                          fit: BoxFit.cover,
                        ))),
                new Positioned(
                    top: 0.0,
                    right: 2.0,
                    child: new InkWell(
                      child: new CircleAvatar(
                          radius: 10.0,
                          backgroundColor: const Color(0xffff374e),
                          child: new Center(
                              child: new Icon(
                            Icons.close,
                            size: 18.0,
                            color: Colors.white,
                          ))),
                      onTap: () {
                        setState(() {
                          images.remove(file);
                        });
                      },
                    ))
              ]))
          .toList();
    }

    getpictues() {
      return im == ""
          ? new Container()
          : new Container(
              // height: 100.0,
              child: new Row(
                  //scrollDirection: Axis.horizontal,
                  children: widgets()));
    }

    void showMenuSelection(String value) {
      if (value == "Delete") {
        //  deleteConversation();
      }
    }

    Widget menusubscribe = new PopupMenuButton<String>(
        onSelected: showMenuSelection,
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              new PopupMenuItem<String>(
                  value: "Delete",
                  child: new ListTile(
                      title: new Text(
                    "Supprimer la conversation",
                    style: TextStyle(color: Fonts.col_app),
                  )))
            ]);

    return WillPopScope(
        onWillPop: () {
          if (widget.goto) {
            print('ljljljl');
            Navigator.pushReplacement(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => new BottomNavigation(
                        widget.auth,
                        null,
                        widget.user,
                        widget.list_partners,
                        false,
                        null,
                        widget.chng,
                        animate: true)));
          } else
            Navigator.of(context).pop(true);
        },
        child: new Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: new AppBar(
                elevation: 1.0,
                iconTheme: new IconThemeData(color: Colors.grey[800]),
                title:
                    Text(widget.name, style: TextStyle(color: Fonts.col_app)),
                backgroundColor: Colors.grey[50],
                actions: [
                  IconButton(
                    onPressed: () {
                      /* Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                              new ChatGroupUsers(
                                  list_users_info,
                                  widget.user,
                                  widget.list_partners,
                                  widget.analytics,widget.chat)));*/
                    },
                    icon: Image.asset(
                      "images/people.png",
                      color: Fonts.col_app,
                    ),
                  )
                ]),
            body: new Container(
                decoration: new BoxDecoration(
                    color: Colors.blue[50],
                    image: new DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.blue[100].withOpacity(0.05),
                            BlendMode.dstATop),
                        image: new AssetImage("images/bck.jpg"))),
                child: new Stack(children: <Widget>[
                  //La list est ici
                  /*  new ListView(children: <Widget>[
              ]),*/
                  new Container(
                    padding: new EdgeInsets.only(bottom: 76.0),
                    //color: Fonts.backcolor,
                    child: getInfo
                        ? new FirebaseAnimatedList(
                            // defaultChild: new Center(child: new Text("..."),),
                            padding: new EdgeInsets.only(
                                top: 16.0, bottom: 16.0, left: 0.0, right: 0.0),
                            query: gMessagesDbRef,
                            sort: (a, b) => b.value['timestamp']
                                .compareTo(a.value['timestamp']),
                            reverse: true,
                            itemBuilder: (_, DataSnapshot snap,
                                Animation<double> animation, int a) {
                              return new ChatMessage1(
                                snapshot: Chat.fromDocument(snap),
                                list_users: list_users_info,
                                animation: animation,
                                user_me: widget.user,
                              );
                            },
                            duration: new Duration(milliseconds: 1000),
                          )
                        : Center(child: RefreshProgressIndicator()),
                  ),

                  Positioned(
                    bottom: 8.0,
                    left: 0.0,
                    child: Column(children: [
                      uploading ? new RefreshProgressIndicator() : Container(),
                      // getpictues(),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: 4.0,
                          ),
                          CircleAvatar(
                              backgroundColor: Colors.grey[100],
                              radius: 20.0,
                              child: new InkWell(
                                onTap: () {
                                  open_bottomsheet();
                                },
                                child: new Image.asset(
                                  "images/link.png",
                                  width: 26.0,
                                  height: 26.0,
                                  color: Colors.blue[700],
                                ),
                              )),
                          Container(
                            width: 4.0,
                          ),
                          GestureDetector(
                            onPanStart: (a) {
                              startRecorder();
                            },
                            onPanEnd: (b) {
                              stopRecorder();
                            },
                            child: CircleAvatar(
                                radius: _isRecording ? 32.0 : 22.0,
                                backgroundColor: Colors.grey[100],
                                child: new Image.asset(
                                  "images/micro.png",
                                  width: _isRecording ? 40.0 : 30.0,
                                  height: _isRecording ? 40.0 : 30.0,
                                  color: _isRecording
                                      ? Colors.green[500]
                                      : Colors.blue[700],
                                )),
                          ),
                          Container(
                            width: 8.0,
                          ),
                          show_textfield
                              ? new Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.70,
                                  child: new Material(
                                      elevation: 4.0,
                                      borderRadius: new BorderRadius.all(
                                          new Radius.circular(12.0)),
                                      child: Row(
                                        children: <Widget>[
                                          new Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.54,
                                              padding: new EdgeInsets.symmetric(
                                                  vertical: 10.0,
                                                  horizontal: 20.0),
                                              child: new TextField(
                                                textInputAction:
                                                    TextInputAction.done,
                                                controller: _textController,
                                                maxLines: ((_textController.text
                                                                    .length /
                                                                25)
                                                            .round() <
                                                        6)
                                                    ? ((_textController.text
                                                                    .length /
                                                                25)
                                                            .round() +
                                                        1)
                                                    : 6,
                                                keyboardType:
                                                    TextInputType.multiline,
                                                // onSubmitted: _isComposing ? _handleMessageSubmit(_textController.text) : null,
                                                decoration: new InputDecoration
                                                        .collapsed(
                                                    hintText: _isRecording
                                                        ? this._recorderTxt
                                                        : "Ecrire votre texte ici",
                                                    hintStyle: new TextStyle(
                                                        fontSize: 17.0,
                                                        color: Colors.grey)),
                                                onChanged: (String text) {
                                                  try {
                                                    setState(() =>
                                                        _isComposing =
                                                            text.length > 0);
                                                  } catch (e) {}
                                                },

                                                // See GitHub Issue https://github.com/flutter/flutter/issues/10006
                                              )),
                                          Container(
                                            width: 4.0,
                                          ),
                                          new Container(
                                            child: new IconButton(
                                              icon: new Image.asset(
                                                "images/send.png",
                                                width: 26.0,
                                                height: 26.0,
                                                color: Colors.blue[700],
                                              ),
                                              color:
                                                  Theme.of(context).accentColor,
                                              onPressed: _isComposing
                                                  ? () => _handleMessageSubmit(
                                                      _textController.text)
                                                  : null,
                                            ),
                                          )
                                        ],
                                      )),
                                )
                              : new Container(),
                        ],
                      )
                    ]),
                  )
                ]))));
  }

  _sendMessage(
      {String text,
      List<String> imageUrl,
      String audio,
      String file,
      docname,
      lat,
      lng,
      address}) async {
    try {
      setState(() {
        show_textfield = true;
      });
    } catch (e) {}

    var lastmsg = "";

    if (imageUrl.toString() != "null") {
      lastmsg = "image";
      text = "";
    }
    if (audio != null) {
      lastmsg = "audio";
      text = "";
    }
    if (document != null) {
      lastmsg = "document";
    }
    if (lat.toString() != "null" && lat.toString() != "0.0") {
      lastmsg = "location";
      text = "";
    }
    if (text != null) {
      lastmsg = text;
    }

    print("----------------------------------------------");
    print(imageUrl);

    print(lat);
    print(lng);

    gMessagesDbRef.push().set({
      'timestamp': ServerValue.timestamp,
      'messageText': text,
      'idUser': widget.user.auth_id,
      'imageUrl': imageUrl,
      'audio': audio,
      'file': file,
      'docname': docname,
      "lat": lat,
      "lng": lng,
      "latLng": lat.toString() + ';' + lng.toString(),
      "address": address
    });

    FirebaseDatabase.instance
        .reference()
        .child("room_medz_group")
        .child(widget.id_key)
        .update({
      'timestamp': ServerValue.timestamp,
      'lastMessage': "Hello this group is for ...",
      'last_person': widget.user.firstname,
    });

    /*  FirebaseDatabase.instance
        .reference()
        .child("room_medz_group")
        .child(getKey1())
        .set({
      "me": false,
      widget.idOther: true,
      "lastmessage": text,
      "key": getKey1(),
      "timestamp": ServerValue.timestamp /*new DateTime.now().toString()*/,
    });
£*/

    //Notifications
    /*var gMessagesDbRe =
        FirebaseDatabase.instance.reference().child("notif_new_msg");
    gMessagesDbRe.update({.auth_id: true});*/

    widget.reload();
  }

  _handleMessageSubmit(String text) async {
    _textController.clear();
    try {
      setState(() => _isComposing = false);
    } catch (e) {}

    _sendMessage(text: text);
  }

/*
 '$widget.myid': true,
 '$widget.idOther':true,
 */

}
