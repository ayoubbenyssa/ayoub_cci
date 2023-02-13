import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:html_editor/html_editor.dart';

import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/link1.dart';
import 'package:mycgem/models/offers.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/validators.dart';
import 'package:mycgem/services/youtube_service.dart';
import 'package:mycgem/sondage/add_vote.dart';
import 'package:mycgem/widgets/app_appbar.dart';
import 'package:mycgem/widgets/fixdropdown.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class AddAnnonceOpp extends StatefulWidget {
  AddAnnonceOpp(
      this.user, this.auth, this.sign, this.list_partner, this.selectedValue,
      {this.an});

  User user;
  String selectedValue = "";
  var auth;
  var sign;
  Offers an;
  List list_partner;

  @override
  _AddAnnonceState createState() => _AddAnnonceState();
}

class _AddAnnonceState extends State<AddAnnonceOpp> {
  List<String> _list = [
    "Appel à manifestation d'intérêt",
    "Proposition de produits / Services",
    // "Appel d'offres",
    //"Consultation",

    //  "Recherche collaboration",
    //"proposition de service",
    ///"Autre"
  ];
  Link1 link1 = new Link1();
  GlobalKey<HtmlEditorState> keyEditor = GlobalKey();

  static sendCustomNotif(message, id) async {
    var res = await http.post(
        "https://us-central1-cgembusiness-5e7e3.cloudfunctions.net/sendCustomNotificationToUser1_publications",
        body: {
          "message": message,
          "pub_id": id,
          "type": "opportunite"
          // "token":"fc5hXpoZSf6QylLCjl2r5V:APA91bH2FHVuFqVUrnvkO6DSf0SjOyOFk7ixstPGs-iVZ7-DtEBUf7NIxxTsYVpIvl9kCHNl6P6LhS4sQxlBtHGQlnmFK4Ak89S6L9qS3KvUB3PlHq_nNAaCTMo2D7-nWRM_4x1gaAH6",
        });
    return res.body;
  }

  String _platformVersion;
  final TextEditingController _link = new TextEditingController();

  // String selectedValue = "";
  ParseServer parse_s = new ParseServer();
  List<String> images = [];
  final _titlectrl = new TextEditingController();
  final _cautionctrl = new TextEditingController();
  final _budgetctrl = new TextEditingController();

  ///final _descctrl = new TextEditingController();
  final _adrctrl = new TextEditingController();
  FocusNode _titlefocus = new FocusNode();
  FocusNode _descfocus = new FocusNode();

  FocusNode _cautfocus = new FocusNode();
  FocusNode _budgetfocus = new FocusNode();

  FocusNode _adrfocus = new FocusNode();
  var da = "";
  DateTime date_vam = DateTime.now();
  GetLinkData getlink = new GetLinkData();
  bool _isComposing1 = false;
  bool _isComposing2 = false;
  bool val1 = false;
  String type = "";
  bool val2 = false;
  bool uploading = false;
  var im = "";
  var lo = false;
  var error = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool _autovalidate = false;
  List<String> items = new List<String>();

  save_image(image) async {
    setState(() {
      uploading = true;
      lo = false;
      _isComposing1 = true;
    });

    int timestamp = new DateTime.now().millisecondsSinceEpoch;
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child("profile/img_" + timestamp.toString() + ".jpg");
    StorageUploadTask uploadTask = storageReference.put(image);
    await storageReference.put(image).onComplete.then((val) {
      val.ref.getDownloadURL().then((val) {
        //if (!mounted) return;

        setState(() {
          images.add(val.toString());
          im = val.toString();
          error = "";
          uploading = false;
          lo = true;
        });
      });
    });
  }

  get_an() {
    if (widget.an.toString() != "null") {
      setState(() {
        for (String i in widget.an.pic) {
          images.add(i);
          _titlectrl.text = widget.an.title;
          da = widget.an.createdAt;
          im = widget.an.pic[0];
          widget.selectedValue = widget.an.type;
          _adrctrl.text = widget.an.address;
          keyEditor.currentState.text = widget.an.description;
        }
      });
    }
  }

  @override
  initState() {
    super.initState();
    _adrctrl.text = widget.user.community;

    get_an();
  }

  String selectedValue = "";

  Widget drop_down() => new Container(
      color: Fonts.col_app_shadow,
      width: 700.0,
      height: 60.0,
      child: Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.only(left: 16.0, right: 8.0),
          decoration: new BoxDecoration(
            color: Fonts.col_app_shadow,
            border: new Border.all(color: Fonts.col_app_shadow, width: 1.0),
            borderRadius: new BorderRadius.circular(2.0),
          ),
          child: new FixDropDown(
              iconSize: 32.0,
              isDense: false,
              items: _list.map((String value) {
                return new FixDropdownMenuItem(
                  value: value,
                  child: new Text(
                    value.toString(),
                    maxLines: 2,
                    softWrap: true,
                    style: TextStyle(color: Fonts.col_app_fonn),
                  ),
                );
              }).toList(),
              hint: new Text(
                selectedValue != "" ? selectedValue : "Type d'opportunité",
                maxLines: 1,
                softWrap: true,
                style: new TextStyle(color: Fonts.col_app_fonn),
              ),
              onChanged: (String value) {
                setState(() {
                  selectedValue = value;
                });
              })));

  showd() async {
    DateTime a = await showDatePicker(
      context: context,
      locale: Locale("fr"),
      helpText: "Choisir une date",
      initialDate: new DateTime.now(),
      firstDate: new DateTime.now().subtract(new Duration(days: 30)),
      lastDate: new DateTime.now().add(new Duration(days: 30)),
    );

    if (a != null) {
      setState(() {
        da = a.toString().split(" ")[0];
        error = "";
        date_vam = a;
      });
    }
  }

  gallery() async {
    Navigator.pop(context);
    //

    var platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      var fi = await ImagePicker.pickImage(source: ImageSource.gallery);

      //

      setState(() {
        File fil = fi;
        _cropImage(fil);
      });
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
    save_image(compressedFile);
  }

  ///image
  _handleCameraButtonPressed() async {
    Navigator.of(context).pop(true);
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    _cropImage(image);
  }

  void onLoading(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => new Dialog(
          child: new Container(
            padding: new EdgeInsets.all(16.0),
            width: 40.0,
            color: Colors.transparent,
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                new RefreshProgressIndicator(),
                new Container(height: 8.0),
                new Text(
                  "En cours ..",
                  style: new TextStyle(
                    color: Fonts.col_app_fonn,
                  ),
                ),
              ],
            ),
          ),
        ));

    // Navigator.pop(context); //pop dialog
    //  _handleSubmitted();
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(""),
          content: new Text(
              "Votre annonce est en cours de vérification par notre équipe, vous serez alerté par mail une fois publiée!"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
          ],
        );
      },
    );
  }

  confirm() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidate = true;
    } // Start validating on every change.
    /* } else if (im == "") {
      setState(() {
        error = "S'il vous plait choisir une photo";
      });
    }*/
    else if (widget.selectedValue == "") {
      setState(() {
        error = "Choisir le type d'opportunité";
      });
    } else {
      onLoading(context);

      /* int active = 0;
      var a = await parse_s.getparse("shared");
      if(a["results"][0]["value"] == true )
        {
            active =1;
        }*/

      String text = await keyEditor.currentState.getText();
      var js = {
        "name": _titlectrl.text,
        "description": text,
        "budget": _budgetctrl.text,
        "pictures": images,
        "startDate": date_vam.millisecondsSinceEpoch,
        "activateDate": date_vam.millisecondsSinceEpoch,
        "type_op": "${widget.selectedValue}",
        "type": "opportunite",
        "active": 1,

        "author": {
          "__type": "Pointer",
          "className": "users",
          "objectId": widget.user.id
        },

        "membre": {
          "__type": "Pointer",
          "className": "membres",
          "objectId": widget.user.entreprise.objectId
        }
        //  "raja": true,
        // "items": items.toString() == "[]" ? null : items
      };

      if (widget.an.toString() == "null") {
        var a = await parse_s.postparse('offers', js);
        print(a);

        sendCustomNotif(_titlectrl.text, a["objectId"]);

        //  Navigator.of(context, rootNavigator: true).pop('dialog');

        //_showDialog();

        new Timer(new Duration(seconds: 1), () {
          Navigator.pop(context);
          Navigator.pop(context);
        });

        /*  Routes.goto_home(context, widget.auth, widget.sign, widget.user,
            widget.analytics, widget.observer,widget.list_partner);*/
      } else {
        widget.an.description = await keyEditor.currentState.getText();
        widget.an.address = _adrctrl.text;
        widget.an.pic = images;
        widget.an.title = _titlectrl.text;
        await parse_s.putparse('offers/' + widget.an.objectId, js);
        //  Navigator.of(context, rootNavigator: true).pop('dialog');
        Navigator.pop(context);
      }
    }
  }

  var textcat = new TextStyle(color: Colors.grey[700], fontSize: 12.0);

  getLinWidget() {
    if (items.length == 1) {
      return new GestureDetector(
          onTap: () {
            // _launched = _launch(post.link);
          },
          child: new Text(link1.url,
              style: new TextStyle(
                  wordSpacing: 1.0,
                  color: Colors.blue[700],
                  fontSize: 15.0,
                  fontWeight: FontWeight.w900)));
    } else {
      return new GestureDetector(
          onTap: () {
            //  _launched = _launch(items[0]);
          },
          child: new Container(
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    /* new Container(
                    padding: new EdgeInsets.only(left: 16.0, bottom: 8.0),
                    child: new Text(link1.title.toString(),
                        style: new TextStyle(color: Colors.grey[700]))),*/
                    new SizedBox(
                        height: 200.0,
                        child: new Stack(
                          children: <Widget>[
                            new Positioned.fill(
                              child: new Image.network(
                                link1.image.toString(),
                                fit: BoxFit.cover,
                              ),
                            )
                          ],
                        )),
                    new Container(
                        color: Colors.grey[200],
                        padding:
                        new EdgeInsets.only(left: 16.0, bottom: 8.0, top: 8.0),
                        child:
                        new Text(link1.description.toString(), style: textcat)),
                    new Container(
                        width: 5000.0,
                        color: Colors.grey[200],
                        padding: new EdgeInsets.only(left: 16.0, bottom: 8.0),
                        child: new Text(link1.url.toString(),
                            style: new TextStyle(
                                color: Colors.grey[500], fontSize: 11.0)))
                  ])));
    }
  }

  open_bottomsheet() {
    showModalBottomSheet<bool>(
        context: context,
        builder: (BuildContext context) {
          return new Container(
              height: 112.0,
              child: new Container(
                // padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                  child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new ListTile(
                            onTap: _handleCameraButtonPressed,
                            title: new Text("Prendre une photo")),
                        new ListTile(
                            onTap: gallery,
                            title: new Text("Photo depuis la galerie")),
                      ])));
        });
  }

  @override
  Widget build(BuildContext context) {
    Validators val = new Validators(context: context);
    var style = new TextStyle(
        color: const Color(0xffeff2f7),
        fontSize: ScreenUtil().setSp(15),
        fontWeight: FontWeight.w500);

    /* if(post.link != "")
    {
      print(items.length);
      if(items.length == 1)
      {
        linkw =  new GestureDetector(
            onTap: () {
              _launched = _launch(post.link);

            },
            child:new Text(post.link, style: new TextStyle(wordSpacing: 1.0 ,color: Colors.blue[700],
                fontSize: 15.0,
                fontWeight: FontWeight.w900)));
      }
      else {
        linkw =  new GestureDetector(
            onTap: () {
              _launched = _launch(items[0]);

            },
            child:new Container(child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                      padding: new EdgeInsets.only(left: 16.0, bottom: 8.0),
                      child: new Text(link1.title.toString(),
                          style: new TextStyle(color: Colors.grey[700]))),
                  new SizedBox(
                      height: 200.0,
                      child: new Stack(
                        children: <Widget>[
                          new Positioned.fill(
                            child: new Image.network(
                              link1.image.toString(),
                              fit: BoxFit.cover,
                            ),
                          )
                        ],
                      )),
                  new Container(color: Colors.grey[200],
                      padding: new EdgeInsets.only(
                          left: 16.0, bottom: 8.0, top: 8.0),
                      child: new Text(
                          link1.description.toString(), style: textcat)),
                  new Container(width: 5000.0,
                      color: Colors.grey[200],
                      padding: new EdgeInsets.only(left: 16.0, bottom: 8.0),
                      child: new Text(link1.url.toString(),
                          style: new TextStyle(
                              color: Colors.grey[500], fontSize: 11.0)))

                ])));
      }
    }*/

    Widget date_d = new InkWell(
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Container(
                width: 8.0,
              ),
              new Text(
                "Valable jusqu'à :",
                style: new TextStyle(color: Colors.grey[600]),
              ),
              new Container(
                width: 12.0,
              ),
              new Text(da == "" ? "" : da),
              new Expanded(child: new Container()),
              new Icon(Icons.arrow_drop_down)
            ],
          ),
          new Container(height: 12.0),
          new Container(
            height: 1.2,
            width: 1000.0,
            color: Colors.grey,
          )
        ],
      ),
      onTap: () {
        showd();
      },
    );

    Widget btn_log = new Container(
        height: 52.0,
        padding: new EdgeInsets.only(left: 36.0, right: 36.0, bottom: 6),
        child: new Material(
            elevation: 1.0,
            borderRadius: new BorderRadius.circular(8.0),
            color: Fonts.col_app_fon,

            /*decoration: new BoxDecoration(
            border: new Border.all(color: const Color(0xffeff2f7), width: 1.5),
            borderRadius: new BorderRadius.circular(6.0)),*/
            child: new MaterialButton(
              // color:  const Color(0xffa3bbf1),
                onPressed: () {
                  confirm();
                },
                child: new MaterialButton(
                  // color:  const Color(0xffa3bbf1),
                    onPressed: () {
                      confirm();
                    },
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                          width: 8.0,
                        ),
                        //  new Container(height: 36.0,color: Colors.white,width: 1.5,),
                        new Container(
                          width: 8.0,
                        ),
                        new Text("CRÉER   ", style: style)
                      ],
                    )))));

    List<Widget> widgets() {
      return images
          .map((String file) => new Stack(children: <Widget>[
        new Container(
            padding: new EdgeInsets.all(4.0),
            width: 90.0,
            height: 90.0,
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
                if (images.length == 0) {
                  setState(() {
                    _isComposing1 = false;
                  });
                }
              },
            ))
      ]))
          .toList();
    }

    getpictues() {
      return im == ""
          ? new Container()
          : new Container(
          height: 100.0,
          child: new ListView(
              scrollDirection: Axis.horizontal, children: widgets()));
    }

    addLinkdialog() async {
      return await showDialog<bool>(
        context: context,
        builder: (BuildContext context) => new AlertDialog(
          title: const Text('Ajouter un lien '),
          content: new Container(
              height: 80.0,
              child: new Column(children: <Widget>[
                new TextFormField(
                    controller: _link,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                      hintText: 'Coller ici  comme http://www.google.com',
                      labelText: 'Coller lien:',
                    ))
              ])),
          actions: <Widget>[
            new FlatButton(
              child: const Text('OK'),
              onPressed: () {
                setState(() {
                  _isComposing2 = true;
                });

                GetLinkData.getLink(_link.text).then((vall) {
                  if (vall.length == 0) {
                    items = [];
                    setState(() {
                      // post.link = _link.text;
                      items.add(_link.text + ",");
                    });
                  } else {
                    setState(() {
                      items = [];
                      // post.type = "4";
                      // post.link = _link.text;
                      link1.title = vall['title'];
                      link1.image = vall['image'];
                      link1.url = vall['url'];
                      link1.description = vall['description'];

                      _titlectrl.text = vall['title'];
                      keyEditor.currentState.text = vall['description'];

                      items.add(link1.url);
                      items.add(link1.image);
                      items.add(link1.title);
                      items.add(link1.description);
                    });
                  }
                });
                Navigator.of(context).pop(false);
              },
            ),
            new FlatButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        ),
      ) ??
          false;
    }

    Widget link = new InkWell(
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Container(
                width: 8.0,
              ),
              new Text(
                "Vidéo:",
                style: new TextStyle(color: Colors.grey[600]),
              ),
              new Container(
                width: 12.0,
              ),
              uploading ? new RefreshProgressIndicator() : new Container(),

              /*new Container(
                      color: Colors.grey,
                      width: 70.0,
                      height: 70.0,
                      child: new Image.network(
                        im,
                        width: 70.0,
                        height: 70.0,
                        fit: BoxFit.cover,
                      ),
                    )*/

              new Expanded(child: new Container()),
              new FlatButton(
                onPressed: () {
                  addLinkdialog();
                  // open_bottomsheet();
                },
                child: new Text(
                  "AJOUTER UN LIEN",
                  style: new TextStyle(
                    color: const Color(0xffff374e),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          new Container(
            height: 1.2,
            width: 1000.0,
            color: Colors.grey,
          ),
        ],
      ),
      onTap: () {},
    );

    Widget pht = new InkWell(
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Container(
                width: 8.0,
              ),
              new Text(
                "Photo:",
                style: new TextStyle(color: Colors.grey[600]),
              ),
              new Container(
                width: 12.0,
              ),
              uploading ? new RefreshProgressIndicator() : new Container(),

              /*new Container(
                      color: Colors.grey,
                      width: 70.0,
                      height: 70.0,
                      child: new Image.network(
                        im,
                        width: 70.0,
                        height: 70.0,
                        fit: BoxFit.cover,
                      ),
                    )*/

              new Expanded(child: new Container()),
              new FlatButton(
                onPressed: () {
                  open_bottomsheet();
                },
                child: new Text(
                  "AJOUTER UNE PHOTO",
                  style: new TextStyle(
                    color: const Color(0xffff374e),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          new Container(
            height: 1.2,
            width: 1000.0,
            color: Colors.grey,
          ),
        ],
      ),
      onTap: () {},
    );

    Widget drop_down = new Container(
        color: Fonts.col_app_shadow,
        width: 700.0,
        height: 60.0,
        child: Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.only(left: 16.0, right: 8.0),
            decoration: new BoxDecoration(
              color: Fonts.col_app_shadow,
              border: new Border.all(color: Fonts.col_grey, width: 1.0),
              borderRadius: new BorderRadius.circular(6.0),
            ),
            child: new FixDropDown(
                iconSize: 32.0,
                isDense: false,
                items: _list.map((String value) {
                  return new FixDropdownMenuItem(
                    value: value,
                    child: new Text(
                      value,
                      maxLines: 2,
                      softWrap: true,
                    ),
                  );
                }).toList(),
                hint: new Text(
                  widget.selectedValue != "" ? widget.selectedValue : "Type",
                  maxLines: 1,
                  softWrap: true,
                  style: new TextStyle(color: Colors.grey[900]),
                ),
                onChanged: (String value) {
                  setState(() {
                    widget.selectedValue = value;
                    error = "";
                  });
                })));

    Widget title = Widgets.textfield_dec(
        widget.selectedValue == "Général" ? "Exprimez vous" : "Titre",
        _titlefocus,
        "",
        _titlectrl,
        TextInputType.text,
        val.titrre);

    /* Widget caution = Widgets.textfield_dec(
         "Caution",
        _cautfocus,
        "",
        _cautionctrl,
        TextInputType.number,
        val.caut);*/

    Widget budget = Widgets.textfield_dec("Budget estimatif", _budgetfocus, "",
        _budgetctrl, TextInputType.number, val.bud);

    /* Widget desc = widget.selectedValue == "Général"
        ? Container()
        : Widgets.textfield_des("Description", _descfocus, "", _descctrl,
            TextInputType.text, val.descc);*/

    Widget desc = new Container(
        height: 280.h,
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[300], width: 1.0),
            borderRadius: new BorderRadius.circular(12.0)),
        child: HtmlEditor(
          hint: "Description ",
          //value: "text content initial, if any",
          key: keyEditor,
          height: 280.h,
        ));

    Widget adrr = widget.selectedValue == "Général"
        ? Container()
        : Widgets.textfield_dec(
        "Adresse", _adrfocus, "", _adrctrl, TextInputType.text, val.addre);

    return widget.selectedValue == "Sondage"
        ? new AddVote(widget.user, [])
        : Scaffold(
        key: _scaffoldKey,
        appBar: MyCgemBarApp(
          "Publier une opportunité d'affaires",
          actionswidget: Container(),
        ),
        body: new Form(
            key: _formKey,
            autovalidate: _autovalidate,
            //onWillPop: _warnUserAboutInvalidData,
            child: new Column(children: <Widget>[
              Container(
                height: 16,
              ),
              drop_down,
              new Expanded(
                child: new ListView(
                  padding: new EdgeInsets.all(6.0),
                  children: <Widget>[
                    title,
                    Container(
                      height: 28,
                    ),
                    date_d,
                    new Container(height: 16.0),
                    desc,
                    widget.selectedValue == "Général"
                        ? Container()
                        : new Container(height: 24.0),
                    _isComposing2 ? Container() : pht,
                    budget,
                    new Container(height: 16.0),
                    getpictues(),
                    /* _isComposing1
                            ? Container()
                            : widget.selectedValue == "Général"
                                ? link
                                : Container(),
                        link1.description.toString() == "null"
                            ? Container()
                            : getLinWidget(),
                        new Center(
                          child: new Text(
                            error,
                            style: new TextStyle(
                                color: Colors.red[900],
                                fontWeight: FontWeight.bold),
                          ),
                        ),*/
                    new Container(height: 16.0),
                    Center(
                        child: Text(
                          error,
                          style: TextStyle(color: Colors.red[700]),
                        )),
                    Container(height: 10),
                    btn_log
                  ],
                ),
              )
            ])));
  }
}
