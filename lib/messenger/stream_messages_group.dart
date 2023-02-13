import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:mycgem/chat12/group_chat.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/messenger/add_annonce_group.dart';
import 'package:mycgem/messenger/user_widget_me.dart';
import 'package:mycgem/models/chatmessage.dart';
import 'package:mycgem/models/conversation_g.dart';
import 'package:mycgem/models/offers.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/app_services.dart';
import 'package:mycgem/services/chat_services.dart';
import 'package:mycgem/services/location_services.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as clientHttp;
import 'package:percent_indicator/circular_percent_indicator.dart';

class StreamMessagesGroup extends StatefulWidget {
  StreamMessagesGroup(this.user_me, this.conversation, this.chng);

  User user_me;
  Conversationg conversation;
  var chng;

  @override
  _StreamMessagesState createState() => _StreamMessagesState();
}

class _StreamMessagesState extends State<StreamMessagesGroup> {
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
  List<String> tokens = [];

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
    var a = await MessagesServices.getListMessagesGroupes(
        widget.conversation.title, skip);
    print(a["results"]);
    return a["results"];
  }

  showwidgets(List<ChatMessage> result) {
    //if (skip == 0) count = result.length ;

    print("jdopjdopjopdjpdo");
    print(result);
    if (result.toString() == "null") {
      setState(() {
        noPost = "No Messages found";
      });
    } else {
      //for (var item= result.length-1 ;item>=0 ;item--) {

      for (var i = 0; i < result.length; i++) {
        count2++;

        listWidget.insert(0,
            new UserWidgetMessage(result[i], widget.user_me.id, widget.chng));
      }

      setState(() => skip += 60);
    }
  }

  String progress = "";
  String progress_res = "";

  setProgress(progress) {
    setState(() {
      progress_res = progress;
    });
  }

  getdata() async {
    scrollController.addListener(() {
      if (scrollController.offset <=
              scrollController.position.minScrollExtent &&
          !scrollController.position.outOfRange) {
        streampost(count2);
      }
    });
    streampost(skip);
  }

  errorrequest(text) {
    var errorWithYourRequest = "Error";
    if (text == "nointernet")
      errorWithYourRequest = "Vérifier votre connexion internet!";
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
    // Check server is healthy and live - Debug is on in this instance so check logs for result
    //final ParseResponse response = await Parse().healthCheck();
    // if (response.success) {

    //.includeObject(["post"])

    print(widget.conversation.title);

    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject('Group'))
          ..whereEqualTo("title", widget.conversation.title);
    LiveQuery liveQuery = LiveQuery();

    await liveQuery.subscribe(query);

    if (!this.mounted) return;

    liveQuery.on(LiveQueryEvent.create, (value) {
      User sender = widget.conversation.members
          .firstWhere((r) => r.id == (value as ParseObject).get('id_send'));

      print(123);
      print((value as ParseObject).get('type'));

      if ((value as ParseObject).get('type') == "sondage") {
        var id = (value as ParseObject).get('objectId');

        print(id);

        parse_s
            .getparse('Group?where={"objectId":"$id"}&include=options')
            .then((of) {
          print("kdkkdkkdkkd");
          print(of["results"][0]);

          Offers off = Offers.fromMap(of["results"][0]);
          /*
             Offers(
                                        objectId: widget.msg.objectId,

                                          author1: widget.msg.user_owner,
                                          title: widget.msg.post_title1,
                                          create: DateTime.parse( widget.msg.createdAt ),
                                          pic: widget.msg.post_pic,
                                          type: widget.msg.post_type,
                                          options: widget.msg.options

                                      ),
            */
          ChatMessage msg =
              ChatMessage.fromParseObject1(value, sender, options: off.options);
          listWidget
              .add(new UserWidgetMessage(msg, widget.user_me.id, widget.chng));
        });
      } else {
        ChatMessage msg = ChatMessage.fromParseObject1(value, sender);

        setState(() {
          listWidget
              .add(new UserWidgetMessage(msg, widget.user_me.id, widget.chng));
        });

        if (widget.conversation.objectId != null) {
          parse_s.putparse("conversation_g/" + widget.conversation.objectId, {
            "lastmessage": (value as ParseObject).get('text'),
            "last_time": new DateTime.now()
                .millisecondsSinceEpoch /*new DateTime.now().toString()*/,
          });
        }
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }

      /* setState(() {
           list_messages.add(msg);
        });*/
    });

    // } else {
    // print('Server health check failed');
    //}
  }

  /* User user_me;
  User user_other;

  Future<User> GetUserInfo(id) async {
    var response = await parse_s.getparse('users?where={"objectId":"$id"}');
    return new User.fromMap(response["results"][0]);
  }*/
  /*parse_s.putparse("conversation_g/" + widget.conversation.objectId, {
        "lastmessage": (value as ParseObject).get('text'),
        "last_time": new DateTime.now()
            .millisecondsSinceEpoch /*new DateTime.now().toString()*/,
      });*/
/*
      parse_s.putparse("not_msg/" + widget.conversation.objectId, {
        "lastmessage": (value as ParseObject).get('text'),
        "last_time": new DateTime.now()
            .millisecondsSinceEpoch /*new DateTime.now().toString()*/,
      });*/

  initAll() async {
    //user_me = await GetUserInfo("cOe8BLm80I");
    //user_other = await GetUserInfo("BktMA4Kcbi");

    //if(widget.conversation_id.toString() == "null")
    //{
    // await verify_cov_id_exist();
    //}
    await initData();
    await getdata();

    new Timer(new Duration(seconds: 1), () {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  /* verify_cov_id_exist() async {
    Conversation a = await ConversationServices.get_conv(widget.user_other.id, widget.user_me.id);
    print(
        "------------666666666666----------------------------------------------------");
    print( a.objectId        );

    widget.conversation_id = a.objectId;

  }*/

  @override
  void initState() {
    super.initState();

    initAll();
    for (User user in widget.conversation.members) {
      if (user.token != "" && user.token != null) {
        tokens.add(user.token);
      }
    }
  }

  noPosts(type) {
    try {
      if (type == "nomoreresults")
        setState(() => noPost = "Il n y a aucun autre post");
      else
        setState(() => noPost = LinkomTexts.of(context).aucun());
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

      uploading1
          ? new CircularPercentIndicator(
              radius: 60.0,
              // animation: true,
              lineWidth: 5.0,
              percent: double.parse(progress_res == ""
                      ? "0"
                      : progress_res.split("%")[0].toString()) /
                  100,
              center: new Text(progress_res.toString()),
              progressColor: Fonts.col_app_fonn,
            )
          : Container(),

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
          iconTheme: IconThemeData(color: Fonts.col_app_fonn),
          backgroundColor: Fonts.col_app_shadow,
          titleSpacing: 0.0,
          title: Row(
            children: <Widget>[
              new ClipOval(
                  child: new Container(
                      width: 36.0,
                      height: 36.0,
                      child: new Image.network(
                        widget.conversation.logo,
                        fit: BoxFit.cover,
                      ))),
              Container(
                width: 8,
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.52,
                  child: Text(
                    widget.conversation.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 13.0,
                        color: Fonts.col_app_fonn,
                        fontWeight: FontWeight.w700),
                  ))
            ],
          ),
          actions: <Widget>[
            FlatButton(
              color: Colors.blue,
              child: Icon(Icons.people, color: Colors.white),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new ChatGroupUsers(
                            widget.conversation.members,
                            widget.user_me,
                            [],
                            null,
                            widget.conversation,
                            getLIst,
                            widget.chng)));
              },
            )
          ],
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

  ParseServer ps = new ParseServer();
  bool uploading1 = false;
  Offers off;

  save_file(File file, ext) async {
    setState(() {
      uploading1 = true;
      lo = false;
    });

    List<String> va = await ps.fileUpload(file, progress, setProgress, ext);

    //if (!mounted) return;
    _sendMessage(file: va[1], docname: va[0], text: "");

    setState(() {
      /// images.add(va.toString());

      ///im = va.toString();
      error = "";
      uploading1 = false;
      lo = true;
    });

    return true;
  }

  String _fileName = '...';
  String _path = '...';
  String _extension;
  bool _hasValidMime = false;

 /* _pickDocument() async {
    // Navigator.of(context).pop(true);

    print(";dm;m;dmd");
    String result;
    try {
      setState(() {
        // _path = '-';
        //  _pickFileInProgress = true;
      });

      /* FlutterDocumentPickerParams params = FlutterDocumentPickerParams(
          allowedFileExtensions: null,
          allowedUtiTypes: null,
          allowedMimeTypes:
              'application/pdf text/plain application/msword  application/vnd.ms-excel application/vnd.openxmlformats-officedocument.spreadsheetml.sheet '
                      'application/vnd.ms-powerpoint application/vnd.openxmlformats-officedocument.presentationml.presentation'
                      ' application/vnd.openxmlformats-officedocument.wordprocessingml.document application/vnd.openxmlformats-officedocument.wordprocessingml.template'
                  .split(' ')
                  .where((x) => x.isNotEmpty)
                  .toList(),
        );*/

      // result = await FlutterDocumentPicker.openDocument(params: params);
      final FileInfo info = await FlutterDocumentPicker.show();
      result = info?.toString();
      String type = info.uri.split('.').last;

      print(info.uri);
      save_file(new File(info.uri), type);
    } catch (e) {
      print(e);
      result = 'Error: $e';
    } finally {}

    setState(() {
      //  _path = result;
    });
  }

  */

  _pickDocument() async {
    Navigator.of(context).pop(true);

    String result;
    try {
      setState(() {
        _path = '-';
        //  _pickFileInProgress = true;
      });
      FlutterDocumentPickerParams params = FlutterDocumentPickerParams(
        allowedFileExtensions: null,
        allowedUtiTypes: null,
        allowedMimeTypes:
            'application/pdf text/plain application/msword  application/vnd.ms-excel application/vnd.openxmlformats-officedocument.spreadsheetml.sheet '
                    'application/vnd.ms-powerpoint application/vnd.openxmlformats-officedocument.presentationml.presentation'
                    ' application/vnd.openxmlformats-officedocument.wordprocessingml.document application/vnd.openxmlformats-officedocument.wordprocessingml.template'
                .split(' ')
                .where((x) => x.isNotEmpty)
                .toList(),
      );

      result = await FlutterDocumentPicker.openDocument(params: params);
      String type = result.toString().split('.').last;

      save_file(new File(result), type);
    } catch (e) {
      result = 'Error: $e';
    } finally {}

    setState(() {
      _path = result;
    });
  }



  //bottom sheet
  open_bottomsheet() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) =>  new Dialog(
            child: new Container(
                height: 250.0,
                child: new Container(
                    // padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                    child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                      new ListTile(
                          dense: true,
                          leading: new Image.asset(
                            "images/pp.png",
                            width: 28.0,
                            color: Colors.blue[700],
                            height: 28.0,
                          ),
                          onTap: () async {
                            //_pickDocument();
                            Navigator.pop(context);

                            var res = await Navigator.push(
                              context,
                              new PageRouteBuilder(
                                pageBuilder: (BuildContext context,
                                    Animation<double> _, Animation<double> __) {
                                  return new AddAnnonceGroup(
                                      widget.user_me,
                                      null,
                                      null,
                                      [],
                                      widget.conversation.title);
                                },
                              ),
                            );

                            new Timer(new Duration(seconds: 1), () {
                              scrollController.jumpTo(scrollController.position.maxScrollExtent);
                            });

                            var ab = await clientHttp.post(
                                "https://us-central1-cgembusiness-5e7e3.cloudfunctions.net/sendCustomNotificationToGroupeMessage",
                                body: {
                                  "keys": json.encode(tokens),
                                  "message": widget.conversation.title,
                                  "us": widget.user_me.fullname + " " + widget.user_me.firstname
                                });

                            String id_post = res;
                            // _sendMessage(post: id_post);

                            //  if(!this.mounted) return;
                          },
                          title: new Text("Publication",
                              style: TextStyle(
                                fontSize: 16.0,
                              ))),
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
                            "images/link.png",
                            width: 28.0,
                            color: Colors.blue[700],
                            height: 28.0,
                          ),
                          onTap: () {
                            _pickDocument();
                          },
                          title: new Text("Document",
                              style: TextStyle(
                                fontSize: 16.0,
                              ))),
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
      if (Platform.isIOS) {
        File fil = await ImagePicker.pickImage(source: ImageSource.gallery);
        await _cropImage(fil);
      } else {
        platformVersion = await ImagePicker.pickImage(source: ImageSource.gallery);

        File fil =platformVersion;
        await _cropImage(fil);
      }

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
      address,
      post}) async {
    try {
      setState(() {
        show_textfield = true;
      });
    } catch (e) {}

    var lastmsg = "";

    if (post.toString() != "null") {
      lastmsg = "post";
      text = "";
    }

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
    var res = await parse_s.postparse('Group/', {
      "id_send": widget.user_me.id,
      "title": widget.conversation.title,
      "lat": lat,
      "lng": lng,
      'file': file,
      'docname': docname,
      "image": images,
      "author": {
        "__type": "Pointer",
        "className": "users",
        "objectId": widget.user_me.id
      },
      "text": text
    });

    var ab = await clientHttp.post(
        "https://us-central1-cgembusiness-5e7e3.cloudfunctions.net/sendCustomNotificationToGroupeMessage",
        body: {
          "keys": json.encode(tokens),
          "message": widget.conversation.title,
          "us": widget.user_me.fullname + " " + widget.user_me.firstname
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
