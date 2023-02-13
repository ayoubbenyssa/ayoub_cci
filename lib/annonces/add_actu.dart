import 'dart:async';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/models/link1.dart';
import 'package:mycgem/models/offers.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/app_services.dart';
import 'package:mycgem/services/partners_list.dart';
import 'package:mycgem/services/routes.dart';
import 'package:mycgem/services/validators.dart';
import 'package:mycgem/services/youtube_service.dart';
import 'package:mycgem/sondage/add_vote.dart';
import 'package:mycgem/widgets/app_appbar.dart';
import 'package:mycgem/widgets/fixdropdown.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:flutter/services.dart';

const kGoogleApiKey = "AIzaSyDCB1z3cOQuIaf9LxLI6adVYjsSJC5TpDU";

class AddAnnonceACtu_Event extends StatefulWidget {
  AddAnnonceACtu_Event(this.user, this.auth, this.sign, this.list_partner,
      this.selectedValue, this.chng,
      {this.an});

  User user;
  String selectedValue = "";
  var auth;
  var sign;
  Offers an;
  List list_partner;
  var chng;

  @override
  _AddAnnonceState createState() => _AddAnnonceState();
}

class _AddAnnonceState extends State<AddAnnonceACtu_Event> {
  Link1 link1 = new Link1();

  String _platformVersion;
  final TextEditingController _link = new TextEditingController();

  // String selectedValue = "";
  ParseServer parse_s = new ParseServer();
  List<String> images = new List<String>();
  final _titlectrl = new TextEditingController();
  final _descctrl = new TextEditingController();
  final _descctrl1 = new TextEditingController();
  int active = 0;

  FocusNode _descfocus = new FocusNode();
  FocusNode _descfocus1 = new FocusNode();
  String ta = "";
  final _adrctrl = new TextEditingController();
  FocusNode _titlefocus = new FocusNode();
  FocusNode _adrfocus = new FocusNode();
  var da1, d2 = "";
  GetLinkData getlink = new GetLinkData();
  bool _isComposing1 = false;
  bool _isComposing2 = false;
  DateTime startdate, endDate;

  bool uploading = false;
  var im = "";
  var lo = false;
  var error = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool _autovalidate = false;
  List<String> items = new List<String>();

  bool isLoading = false;
  String errorMessage;

  AppServices appservices = AppServices();

  save_image(image) async {
    setState(() {
      uploading = true;
      lo = false;
      _isComposing1 = true;
    });

    int timestamp = new DateTime.now().millisecondsSinceEpoch;
    var photo =
        await appservices.uploadparse("/files/image.jpg", image, "image");

    setState(() {
      images.add(photo.toString().replaceAll("http:", "https:"));
      im = photo.toString().replaceAll("http:", "https:");
      error = "";
      uploading = false;
      lo = true;
    });
  }

/*
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
  }*/

  get_an() {
    if (widget.an.toString() != "null") {
      setState(() {
        for (String i in widget.an.pic) {
          images.add(i);
          _titlectrl.text = widget.an.title;
          da1 = widget.an.createdAt;
          im = widget.an.pic[0];
          widget.selectedValue = widget.an.type;
          _adrctrl.text = widget.an.address;
          _descctrl.text = widget.an.description;
        }
      });
    }
  }

  @override
  initState() {
    super.initState();

    get_an();
  }

  showd1() async {
    DateTime a = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime.now().subtract(new Duration(days: 30)),
      lastDate: new DateTime.now().add(new Duration(days: 30)),
    );

    setState(() {
      da1 = a.toString().split(" ")[0];

      endDate = a;
      error = "";
    });
  }

  showd2() async {
    var a = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime.now().subtract(new Duration(days: 30)),
      lastDate: new DateTime.now().add(new Duration(days: 30)),
    );

    setState(() {
      d2 = a.toString().split(" ")[0];
      startdate = a;
      error = "";
    });
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
        builder: (BuildContext context) =>new Dialog(
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
        error = "S'il vous plait choisir le type d'annonce";
      });
    } else {
      onLoading(context);

      var js;

      List list_commissions = [];
      List list_regions = [];
      List list_federations = [];
      String region_id="";
      String federation_id="";

      switch (widget.user.org_type) {
        case 'region':
          list_regions = ["${widget.user.org_id}"];
          widget.selectedValue =
              widget.selectedValue == "Actualité" ? "news" : "event";
          region_id= widget.user.org_id;
          break;
        case 'commission':
          list_regions = ["${widget.user.org_id}"];
          widget.selectedValue =
              widget.selectedValue == "Actualité" ? "news" : "event";
          break;
        case 'federation':
          list_regions = ["${widget.user.org_id}"];
          widget.selectedValue =
              widget.selectedValue == "Actualité" ? "news" : "event";
          federation_id= widget.user.org_id;
          break;
        default:
          widget.selectedValue =
              widget.selectedValue == "Actualité" ? "news_user" : "event_user";
          break;
      }

      if (widget.selectedValue.contains("news"))
        js = {
          "name": _titlectrl.text,
          "active": 1,
          "summary": _descctrl1.text,
          "federations": list_federations,
          "commissions": list_commissions,
          "regions": list_regions,
          "region_id": region_id,
           "federation_id": federation_id,
          "description": _descctrl.text,
          "time_an": da1,
          "image": im,
          "pictures": images,
          "type": widget.selectedValue,
          "address": _adrctrl.text,
          "membre": {
            "__type": "Pointer",
            "className": "membres",
            "objectId": widget.user.entreprise.objectId
          },
          "author": {
            "__type": "Pointer",
            "className": "users",
            "objectId": widget.user.id
          },
          /*"membre": {
            "__type": "Pointer",
            "className": "membres",
            "objectId": widget.user.entreprise.objectId
          },*/
          "raja": true,
          "items": items.toString() == "[]" ? null : items
        };
      else
        js = {
          "name": _titlectrl.text,
          "active": 1,
          "summary": _descctrl1.text,
          "startDate": startdate.toUtc().millisecondsSinceEpoch,
          "eventDate": startdate.toUtc().millisecondsSinceEpoch,
          "endDate": endDate.toUtc().millisecondsSinceEpoch,
          "activatedDate": endDate.toUtc().millisecondsSinceEpoch,
          "time": ta.toString(),
          "federation_id": federation_id,
          "region_id": region_id,
          "federations": list_federations,
          "commissions": list_commissions,
          "regions": list_regions,
          "description": _descctrl.text,
          "time_an": da1,
          "image": im,
          "author": {
            "__type": "Pointer",
            "className": "users",
            "objectId": widget.user.id
          },
          "membre": {
            "__type": "Pointer",
            "className": "membres",
            "objectId": widget.user.entreprise.objectId
          },
          "pictures": images,
          "type": widget.selectedValue,
          "address": _adrctrl.text,
         /* "membre": {
            "__type": "Pointer",
            "className": "membres",
            "objectId": widget.user.entreprise.objectId
          },*/
          "raja": true,
          "items": items.toString() == "[]" ? null : items
        };

      if (widget.an.toString() == "null") {
        print(js);
        var a = await parse_s.postparse('offers', js);

        print(js);

        Routes.goto_home(
            context, null, null, widget.user, [], true, null, widget.chng);
      } else {
        widget.an.description = _descctrl.text;
        widget.an.address = _adrctrl.text;
        widget.an.pic = images;
        widget.an.title = _titlectrl.text;
        await parse_s.putparse('offers/' + widget.an.objectId, js);
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
                ))));

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
                          backgroundColor: Fonts.col_gr,
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

                    /*GetLinkData.getLink(_link.text).then((vall) {
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
                          _descctrl.text = vall['description'];

                          items.add(link1.url);
                          items.add(link1.image);
                          items.add(link1.title);
                          items.add(link1.description);
                        });
                      }
                    });*/
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

    Widget link = Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border.all(color: Fonts.col_cl, width: 1.6),
          borderRadius: new BorderRadius.circular(2.0),
        ),
        child: new FlatButton(
          padding: EdgeInsets.only(top: 12, bottom: 12, left: 8, right: 8),

          /*
        jiya
         */
          child: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Text(
                    "Lien:",
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
                  new InkWell(
                      onTap: () {
                        addLinkdialog();
                        // open_bottomsheet();
                      },
                      child: new Image.asset(
                        "images/link.png",
                        width: 20,
                        height: 20,
                      ))
                ],
              ),
            ],
          ),
          onPressed: () {
            addLinkdialog();
          },
        ));

    Widget start_date = Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border.all(color: Fonts.col_cl, width: 1.6),
          borderRadius: new BorderRadius.circular(8.0),
        ),
        child: new FlatButton(
          padding: EdgeInsets.only(top: 12, bottom: 12, left: 8, right: 8),
          child: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Container(
                    width: 8.0,
                  ),
                  new Text(
                    "Date d'activation:",
                    style: new TextStyle(color: Colors.grey[600]),
                  ),
                  new Container(
                    width: 12.0,
                  ),
                  Text(da1 == null ? "" : da1),
                  new Expanded(child: new Container()),
                  new Image.asset(
                    "images/cal.png",
                    color: Fonts.col_app_green,
                    width: 24,
                    height: 24,
                  ),
                ],
              ),
            ],
          ),
          onPressed: () {
            showd1();
          },
        ));

    showt() async {
      TimeOfDay a = await showTimePicker(
        initialTime: new TimeOfDay.now(),
        context: context,
      );

      setState(() {
        ta = a.format(context);
        error = "";
      });
    }

    Widget hour_widget = Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border.all(color: Fonts.col_cl, width: 1.6),
          borderRadius: new BorderRadius.circular(8.0),
        ),
        child: new FlatButton(
          padding: EdgeInsets.only(top: 12, bottom: 12, left: 8, right: 8),
          child: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Container(
                    width: 8.0,
                  ),
                  new Text(
                    "L'heure de l'évènement:",
                    style: new TextStyle(color: Colors.grey[600]),
                  ),
                  new Container(
                    width: 12.0,
                  ),
                  Text(ta == null ? "" : ta),

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
                  new Image.asset(
                    "images/cal.png",
                    color: Fonts.col_app_green,
                    width: 24,
                    height: 24,
                  ),
                ],
              ),
            ],
          ),
          onPressed: () {
            showt();
          },
        ));

    Widget endDate = Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border.all(color: Fonts.col_cl, width: 1.6),
          borderRadius: new BorderRadius.circular(8.0),
        ),
        child: new FlatButton(
          padding: EdgeInsets.only(top: 12, bottom: 12, left: 8, right: 8),
          child: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Container(
                    width: 8.0,
                  ),
                  new Text(
                    "Date d'évènement:",
                    style: new TextStyle(color: Colors.grey[600]),
                  ),
                  new Container(
                    width: 12.0,
                  ),
                  Text(d2 == null ? "" : d2),

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
                  new Image.asset(
                    "images/cal.png",
                    color: Fonts.col_app_green,
                    width: 24,
                    height: 24,
                  ),
                ],
              ),
            ],
          ),
          onPressed: () {
            showd2();
          },
        ));

    Widget pht = Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border.all(color: Fonts.col_cl, width: 1.6),
          borderRadius: new BorderRadius.circular(2.0),
        ),
        child: new FlatButton(
          padding: EdgeInsets.only(top: 12, bottom: 12, left: 8, right: 8),
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
                  new Image.asset(
                    "images/img.png",
                    width: 24,
                    height: 24,
                    color: Fonts.col_app_green,
                  ),
                ],
              ),
            ],
          ),
          onPressed: () {
            open_bottomsheet();
          },
        ));

    Widget title = Widgets.textfield_dec(
        widget.selectedValue == "Général" ? "Exprimez vous" : "Titre",
        _titlefocus,
        "",
        _titlectrl,
        TextInputType.text,
        val.titrre);

    Widget b_desc = widget.selectedValue == "Actualité" ||
            widget.selectedValue == "Événement"
        ? Widgets.textfield_des("Brève description", _descfocus1, "",
            _descctrl1, TextInputType.text, val.descc)
        : Container();

    Widget desc = widget.selectedValue == "Général"
        ? Container()
        : Widgets.textfield_des("Description", _descfocus, "", _descctrl,
            TextInputType.text, val.descc);

    Widget adrr = widget.selectedValue == "Général" ||
            widget.selectedValue == "Actualité"
        ? Container()
        : Widgets.textfield_dec(
            "Adresse", _adrfocus, "", _adrctrl, TextInputType.text, val.addre);

    return widget.selectedValue == "Sondage"
        ? new AddVote(widget.user, [])
        : Scaffold(
            backgroundColor: Colors.white,
            key: _scaffoldKey,
            appBar: new MyCgemBarApp(///
                "Publier > ${widget.selectedValue}",
              actionswidget: Container(),

            ),
            bottomNavigationBar: btn_log,
            body: new Form(
              key: _formKey,
              autovalidate: _autovalidate,

              //onWillPop: _warnUserAboutInvalidData,
              child: new ListView(
                padding: new EdgeInsets.all(16.0),
                children: <Widget>[
                  new Container(height: 16.0),
                  title,
                  new Container(height: 8.0),
                  adrr,
                  widget.selectedValue == "Général"
                      ? Container()
                      : new Container(height: 8.0),
                  widget.selectedValue == "Événement"
                      ? start_date
                      : Container(),
                  widget.selectedValue == "Événement"
                      ? Container(
                          height: 16,
                        )
                      : Container(),
                  widget.selectedValue == "Événement" ? endDate : Container(),
                  widget.selectedValue == "Événement"
                      ? Container(
                          height: 16,
                        )
                      : Container(),
                  widget.selectedValue == "Événement"
                      ? hour_widget
                      : Container(),
                  widget.selectedValue == "Événement"
                      ? Container(
                          height: 16,
                        )
                      : Container(),
                  b_desc,
                  Container(
                    height: 16,
                  ),
                  desc,
                  widget.selectedValue == "Général"
                      ? Container()
                      : new Container(height: 16.0),
                  _isComposing2 ? Container() : pht,
                  getpictues(),
                  new Container(height: 16.0),
                  new Center(
                    child: new Text(
                      error,
                      style: new TextStyle(
                          color: Colors.red[900], fontWeight: FontWeight.bold),
                    ),
                  ),
                  new Container(height: 16.0),
                ],
              ),
            ));
  }
}
