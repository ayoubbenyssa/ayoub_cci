import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/messenger/user_widget_me.dart';
import 'package:mycgem/models/chatmessage.dart';
import 'package:mycgem/models/conversation.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/app_services.dart';
import 'package:mycgem/services/chat_services.dart';
import 'package:mycgem/services/conversation_services.dart';
import 'package:mycgem/services/location_services.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:flutter/services.dart';



class StreamMessages extends StatefulWidget {
  StreamMessages(this.user_me, this.user_other,this.conversation_id,this.chng);

  User user_me;
  User user_other;
  String conversation_id;
  var chng;



  @override
  _StreamMessagesState createState() => _StreamMessagesState();
}

class _StreamMessagesState extends State<StreamMessages> {
  List list = new List();
  String my_name;
  bool uploading = false;
  var im = "";
  var lo = false;
  var error = "";
  List<String> images = new List<String>();
  bool show_textfield = true;
  bool _isComposing = false;
  final TextEditingController _textController = new TextEditingController();
  bool _isRecording = false;

  //FlutterSound flutterSound;

  SliverPersistentHeaderDelegate delegate;
  List listWidget = new List();
  ScrollController scrollController = new ScrollController();
  bool isLoading = true;
  int skip = 0;
  var count = 0;
  var count2 = 0;
  List<ChatMessage> list_messages = new List<ChatMessage>();
  var noPost = "";
  ParseServer parse_s = new ParseServer();

  getLIst() async {
    var a = await MessagesServices.getListMessages(
        widget.user_me.id, widget.user_other.id, skip);


    print('&&&&&&&');
    print(a);
    return a["results"];
  }

  showwidgets(List<ChatMessage> result) {
    //if (skip == 0) count = result.length ;

    print("jdopjdopjopdjpdo");

    print(result);
    if (result.toString() == []) {
      setState(() {
        noPost = "No Messages found";
      });
    } else {
      //for (var item= result.length-1 ;item>=0 ;item--) {

      for (var i = 0; i < result.length; i++) {
        count2++;

        listWidget.insert(
            0,
            new UserWidgetMessage(
                result[i], widget.user_me.id,widget.chng));
      }

      setState(() => skip += 60);
    }
  }

  getdata() async {
    scrollController.addListener(() {
      if (scrollController.offset <=
              scrollController.position.minScrollExtent &&
          !scrollController.position.outOfRange) {
        print(
            "yayashuhsuhsush_________________________________________________________________________________________");

        print(count);
        print(count2);
        streampost(count2);
      }
    });
    streampost(skip);
  }

  errorrequest(text) {
    var errorWithYourRequest = "Error";
    if (text == "nointernet")
      errorWithYourRequest =
          "Vérifier votre connexion internet!";
    Scaffold.of(context).showSnackBar(new SnackBar(
      duration: new Duration(seconds: 5),
      content: new Text(errorWithYourRequest,
          style: new TextStyle(color: Colors.red[900])),
      action: new SnackBarAction(
          label: "try again",
          onPressed: () {
            streampost(skip);
          }),
    ));
  }

  streampost(skipp) async {
    if (skipp == 0) listWidget = new List();
    list_messages = await getLIst();

    print("hidi88!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    if (!this.mounted) return;

    try {
      setState(() => isLoading = false);
    } catch (e) {
      e.toString();
    }
    if (list_messages == "nointernet" || list_messages == "error")
      errorrequest(list_messages);
    else if (list_messages == "empty" || list_messages == "nomoreresults")
      noPosts(list_messages);
    else
      showwidgets(list_messages);
  }

  initData() async {
    print(
        "huihuiduhudihduihduidhduigdiudgdiugdiudgiudgduigdiudgudgidgdigiudgdiugdigidgddgdydgydgdy");


    // Check server is healthy and live - Debug is on in this instance so check logs for result
    //final ParseResponse response = await Parse().healthCheck();
    // if (response.success) {


    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject('Message'));

    print(query);

    LiveQuery liveQuery = LiveQuery();

    await liveQuery.subscribe(query);

    if (!this.mounted) return;

    liveQuery.on(LiveQueryEvent.create, (value) {


      print("jojojoo");
      //print((value as ParseObject).get('text'),);



   //  parse_s.get('conversation?where={"objectId":""}+widget.conversation_id);

      if(widget.conversation_id.toString() != "null")
        {

        /*  parse_s.putparse("conversation/"+widget.conversation_id, {
            "lastmessage": (value as ParseObject).get('text'),
            "last_time": new DateTime.now().millisecondsSinceEpoch/*new DateTime.now().toString()*/,
          });*/

         /* if(widget.user_me.id == (value as ParseObject).get('id_send') )
          {
            parse_s.putparse("Notification/"+widget.user_other.not_id, {
              "not_msg":1
            });
          }*/

          print("ddd");

        }


      print("------------------------------");
      print(value);
      ChatMessage msg =
          ChatMessage.fromParseObject(value, widget.user_me,other:widget.user_other);


       /*parse_s.putparse("Notification/blDnI8c2KG", {
         "not_msg":1
       });*/

      if (this.mounted) {
        setState(() {
          listWidget.add(new UserWidgetMessage(
              msg, widget.user_me.id, widget.chng));
        });

          scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }

    });


  }

  /* User user_me;
  User user_other;

  Future<User> GetUserInfo(id) async {
    var response = await parse_s.getparse('users?where={"objectId":"$id"}');
    return new User.fromMap(response["results"][0]);
  }*/

  initAll() async {
    //user_me = await GetUserInfo("cOe8BLm80I");
    //user_other = await GetUserInfo("BktMA4Kcbi");

    //if(widget.conversation_id.toString() == "null")
    //{
      await verify_cov_id_exist();
    //}
    await initData();
    await getdata();

    new Timer(new Duration(seconds: 1), () {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  verify_cov_id_exist() async {
    

        Conversation a = await ConversationServices.get_conv(widget.user_other.id, widget.user_me.id);

        print(
            "------------666666666666----------------------------------------------------");


        if(a.toString() != "null")
          {
            widget.conversation_id = a.objectId;

          }


  }
  @override
  void initState() {
    super.initState();


    initAll();
  }

  noPosts(type) {
    try {
      if (type == "nomoreresults")
        setState(() => noPost = "Il n y a aucun autre post");
      else
        setState(() => noPost = "Aucun post trouvé");
    } catch (e) {
      e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    /**
        insert widget
     */

    Widget buildBody(BuildContext context) {
      Widget loading = new SliverToBoxAdapter(
          child: new Center(
              child: Padding(
                  padding: EdgeInsets.only(top: 32),
                  child: Center(
                    child: Widgets.load(),
                  ))));
      Widget bottom = new SliverToBoxAdapter(
          child: new Center(
              child: new Container(
                  padding: const EdgeInsets.only(
                      top: 85.0, left: 16.0, right: 16.0, bottom: 16.0),
                  child: new Text(noPost))));
      Widget silverheader =
          new SliverToBoxAdapter(child: Container(width: 0.0, height: 0.0));

      Widget listposts = new SliverList(
          delegate:
              new SliverChildListDelegate(new List<Widget>.from(listWidget)));

      Widget scrollview =
          new CustomScrollView(controller: scrollController, slivers: [
        silverheader,
        // widget.silver == null ? new SliverToBoxAdapter() : widget.silver,
        isLoading ? loading : listposts,
        bottom,
      ]);
      return scrollview;
    }

    Widget insert_widget = Column(children: [
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
            Container(
              width: 8.0,
            ),
            show_textfield
                ? new Container(
                    width: MediaQuery.of(context).size.width * 0.82,
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: new Material(
                        elevation: 4.0,
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(12.0)),
                        child: Row(
                          children: <Widget>[
                            new Container(
                                width: MediaQuery.of(context).size.width * 0.54,
                                padding: new EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                child: new TextField(
                                  textInputAction: TextInputAction.done,
                                  controller: _textController,
                                  maxLines: ((_textController.text.length / 25)
                                              .round() <
                                          6)
                                      ? ((_textController.text.length / 25)
                                              .round() +
                                          1)
                                      : 6,
                                  keyboardType: TextInputType.multiline,
                                  // onSubmitted: _isComposing ? _handleMessageSubmit(_textController.text) : null,
                                  decoration: new InputDecoration.collapsed(
                                      hintText: "Ecrire votre texte ici",
                                      hintStyle: new TextStyle(
                                          fontSize: 17.0, color: Colors.grey)),
                                  onChanged: (String text) {
                                    try {
                                      setState(
                                          () => _isComposing = text.length > 0);
                                    } catch (e) {}
                                  },

                                  // See GitHub Issue https://github.com/flutter/flutter/issues/10006
                                )),
                            Container(
                              width: 4.0,
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            new Container(
                              child: new IconButton(
                                icon: new Image.asset(
                                  "images/send.png",
                                  width: 26.0,
                                  height: 26.0,
                                  color: Colors.blue[700],
                                ),
                                color: Theme.of(context).accentColor,
                                onPressed: _isComposing
                                    ? () => _handleMessageSubmit(
                                        _textController.text)
                                    : null,
                              ),
                            )
                          ],
                        )))
                : new Container()
          ])
    ]);

    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          title: Row(
            children: <Widget>[
              new ClipOval(
                  child: new Container(
                      width: 36.0,
                      height: 36.0,
                      child: new Image.network(
                        widget.user_other.image,
                        fit: BoxFit.cover,
                      ))),
              Container(
                width: 6,
              ),
              Text(
                widget.user_other.firstname + " " + widget.user_other.fullname,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
        /*  floatingActionButton: FloatingActionButton(
          onPressed: () async {
            /*
                  "author": {"__type": "Pointer", "className": "users", "objectId": idauthor},

           */

            var res = await parse_s.postparse('Message/', {
              "key": "cOe8BLm80I" + "_" + "BktMA4Kcbi",
              "author": {
                "__type": "Pointer",
                "className": "users",
                "objectId": "cOe8BLm80I"
              },
              "text": "helloooo"
            });
          },
          child: Icon(Icons.add),
        ),*/
        body: Container(
            decoration: new BoxDecoration(
              color: Colors.grey[50],
            ),
            /* image: new DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(
                        Colors.grey[200].withOpacity(0.05), BlendMode.dstATop),
                    image: new AssetImage("images/bck.jpg"))),*/
            child: Column(
              children: <Widget>[
                Flexible(
                  child: new Builder(builder: buildBody),
                ),
                insert_widget
              ],
            )));
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
                          title: new Text("Gallerie",
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

  ///image
  _handleCameraButtonPressed() async {
    Navigator.of(context).pop(true);
    images = [];

    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    await _cropImage(image);
    _sendMessage(imageUrl: images, text: "text");
  }

  gallery() async {
    Navigator.pop(context);
    images = [];
    var platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await ImagePicker.pickImage(source: ImageSource.gallery);

        File fil =platformVersion;
        await _cropImage(fil);


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

  AppServices appservices = AppServices();

  save_image(File image, ext) async {
    setState(() {
      uploading = true;
      lo = false;
    });

    var photo =
        await appservices.uploadparse("files/image.jpg", image, "image");

    setState(() {
      images.add(photo.toString());
      print(photo.toString());
      im = photo.toString();
      error = "";
      uploading = false;
      lo = true;
    });

    return true;
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

    if (lat.toString() != "null") {
      lastmsg = "location";
      text = "";
    }
    if (text != null) {
      lastmsg = text;
    }

    //widget.user_me.id, widget.user_other.id
    var res = await parse_s.postparse('Message/', {
      "key": widget.user_me.id + "_" + widget.user_other.id,
      "id_send": widget.user_me.id,
      "lat":lat,
      "lng":lng,
      "image": images,
      "author": {
        "__type": "Pointer",
        "className": "users",
        "objectId": widget.user_me.id
      },
      "text": text
    });

  }

  _handleMessageSubmit(String text) async {
    _textController.clear();
    try {
      setState(() => _isComposing = false);
    } catch (e) {}

    _sendMessage(text: text);
  }

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
}
