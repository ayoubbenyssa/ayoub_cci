import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/login/login_w.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/validators.dart';
import 'package:mycgem/user/edit_my_profile.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:flutter/services.dart';

/***
    class Details_organisme extends StatefulWidget {
    Details_organisme(this.auth, this.sign, this.list_partner,
    this.name_organisme, this.id_organisme, this.analytics, this.chng);

    var auth;
    var sign;
    var analytics;
    var chng;

    bool show_myprofile = true;

    List list_partner;
    var id_organisme;
    var name_organisme;

    @override
    _Details_organismeState createState() => _Details_organismeState();
    }

    class _Details_organismeState extends State<Details_organisme> {
    final _organismecontroller = new TextEditingController();
    final _descccontroller = new TextEditingController();
    final _desccontroller = new TextEditingController();
    final _facecontroller = new TextEditingController();
    final _linkcontroller = new TextEditingController();
    final _addrcontroller = new TextEditingController();
    final _sitecontroller = new TextEditingController();

    FocusNode _focusorganise = new FocusNode();
    FocusNode _focusdescc = new FocusNode();
    FocusNode _focusdesc = new FocusNode();
    FocusNode _focusface = new FocusNode();
    FocusNode _focuslink = new FocusNode();
    FocusNode _focussite = new FocusNode();
    FocusNode _focusaddr = new FocusNode();

    String type_profile = "";
    String type = "";
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    final _formKey = GlobalKey<FormState>();
    bool _autovalidate = false;
    String _authHint = '';
    ParseServer parse_s = new ParseServer();

    @override
    void initState() {
    _organismecontroller.text = widget.name_organisme;

    super.initState();
    }

    bool uploading = false;
    var im = "";
    var lo = false;
    var error = "";

    gotoprofile() {
    Navigator.pushReplacement(
    context,
    new MaterialPageRoute(
    builder: (BuildContext context) =>
    //new HomePage(widget.auth,widget.sign)
    new EditMyProfile(
    /*com,*/
    widget.auth,
    widget.sign,
    widget.list_partner,
    widget.chng,true),
    ));
    }

    void _handleSubmitted() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
    _autovalidate = true; // Start validating on every change.
    } else {
    print("jihad");
    //form.save();
    Widgets.onLoading(context);
    try {
    var js = {
    "name": _organismecontroller.text,
    "linkedin": _linkcontroller.text,
    "facebook": _facecontroller.text,
    "descc": _descccontroller.text,
    "description": _desccontroller.text,
    "address": _addrcontroller.text,
    "logo": im,
    "site": _sitecontroller.text,
    "status": 1
    };

    await parse_s.putparse("organisme/" + widget.id_organisme, js);
    //Communities

    Navigator.pop(context);
    gotoprofile();

    //widget.onSignedIn();
    } catch (e) {
    Navigator.pop(context);
    print('Error: $e');
    setState(() {
    _authHint = '${e.message.toString()}';
    });
    print(e);
    }
    }
    }

    save_image(image) async {
    setState(() {
    uploading = true;
    lo = false;
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
    im = val.toString();
    error = "";
    uploading = false;
    lo = true;
    });
    });
    });
    }

    gallery() async {
    Navigator.pop(context);
    var platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
    File fil = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
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

    @override
    Widget build(BuildContext context) {
    Validators val = new Validators(context: context);

    var style = new TextStyle(
    color: Fonts.col_app_fon, fontSize: 20.0, fontWeight: FontWeight.w500);
    var clr = Fonts.col_app;

    Widget btn_log = new Padding(
    padding: new EdgeInsets.only(left: 36.0, right: 36.0),
    child: new Material(
    elevation: 12.0,
    shadowColor: clr,
    borderRadius: new BorderRadius.circular(12.0),
    color: clr,
    child: new MaterialButton(
    // color:  const Color(0xffa3bbf1),
    onPressed: () {
    _handleSubmitted();
    },
    child: new Text("Enregistrer".toUpperCase(), style: style))));

    Widget organisme = new Container(
    margin: EdgeInsets.only(left: 12.0, right: 12.0),
    decoration: new BoxDecoration(
    border: new Border.all(color: Colors.grey, width: 1.0),
    borderRadius: new BorderRadius.circular(6.0)),
    child: Widgets.textfield0("Organisme", _focusorganise, "",
    _organismecontroller, TextInputType.text));

    Widget descc = new Container(
    margin: EdgeInsets.only(left: 12.0, right: 12.0),
    decoration: new BoxDecoration(
    border: new Border.all(color: Colors.grey, width: 1.0),
    borderRadius: new BorderRadius.circular(6.0)),
    child: Widgets.textfield("Description courte", _focusdescc, "",
    _descccontroller, TextInputType.text, val.validatedesc));

    Widget desc = new Container(
    margin: EdgeInsets.only(left: 12.0, right: 12.0),
    decoration: new BoxDecoration(
    border: new Border.all(color: Colors.grey, width: 1.0),
    borderRadius: new BorderRadius.circular(6.0)),
    child: Widgets.textfield0("Description", _focusdesc, "",
    _desccontroller, TextInputType.text));

    Widget lien = new Container(
    margin: EdgeInsets.only(left: 12.0, right: 12.0),
    decoration: new BoxDecoration(
    border: new Border.all(color: Colors.grey, width: 1.0),
    borderRadius: new BorderRadius.circular(6.0)),
    child: Widgets.textfield0(
    "Site web", _focussite, "", _sitecontroller, TextInputType.text));

    Widget address = new Container(
    margin: EdgeInsets.only(left: 12.0, right: 12.0),
    decoration: new BoxDecoration(
    border: new Border.all(color: Colors.grey, width: 1.0),
    borderRadius: new BorderRadius.circular(6.0)),
    child: Widgets.textfield0(
    "Adresse:", _focusaddr, "", _addrcontroller, TextInputType.text));

    Widget link = new Container(
    margin: EdgeInsets.only(left: 12.0, right: 12.0),
    decoration: new BoxDecoration(
    border: new Border.all(color: Colors.grey, width: 1.0),
    borderRadius: new BorderRadius.circular(6.0)),
    child: Widgets.textfield0("Page linkedin", _focuslink, "",
    _linkcontroller, TextInputType.text));

    Widget face = new Container(
    margin: EdgeInsets.only(left: 12.0, right: 12.0),
    decoration: new BoxDecoration(
    border: new Border.all(color: Colors.grey, width: 1.0),
    borderRadius: new BorderRadius.circular(6.0)),
    child: Widgets.textfield0("Page facebook", _focusface, "",
    _facecontroller, TextInputType.text));

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
    title: new Text("Photo depuis la gallerie")),
    ])));
    });
    }

    Widget pht = new InkWell(
    child: new Column(
    children: <Widget>[
    new Container(
    margin: EdgeInsets.only(left: 16.0, right: 16.0),
    height: 1.2,
    width: 1000.0,
    color: Colors.grey,
    ),
    new Row(
    children: <Widget>[
    new Container(
    width: 12.0,
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
    fontSize: 13.0,
    color: const Color(0xffff374e),
    fontWeight: FontWeight.bold,
    ),
    ),
    )
    ],
    ),
    new Container(
    margin: EdgeInsets.only(left: 16.0, right: 16.0),
    height: 1.2,
    width: 1000.0,
    color: Colors.grey,
    ),
    ],
    ),
    onTap: () {},
    );

    return Scaffold(
    appBar: new PreferredSize(
    child: new Container(
    padding:
    new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    child: new Padding(
    padding:
    const EdgeInsets.only(left: 30.0, top: 20.0, bottom: 20.0),
    child: Row(
    children: <Widget>[
    InkWell(
    //padding: EdgeInsets.all(0.0),
    child: Container(
    padding: EdgeInsets.only(right: 8.0),
    child: Icon(
    Icons.arrow_back,
    color: Colors.white,
    )),
    onTap: () {
    Navigator.of(context).pop(true);
    }),
    new Text(
    LinkomTexts.of(context).details(),
    style: new TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    color: Colors.white),
    ),
    ],
    )),
    decoration: new BoxDecoration(
    gradient: new LinearGradient(
    colors: [Colors.blue[300], Colors.blueGrey[200]])),
    ),
    preferredSize: new Size(MediaQuery.of(context).size.width, 150.0),
    ),
    body: new Container(
    decoration: new BoxDecoration(
    color: Colors.grey[300],
    /*image: new DecorationImage(
    fit: BoxFit.cover,
    colorFilter: new ColorFilter.mode(
    Colors.white.withOpacity(0.3), BlendMode.dstATop),
    image: new AssetImage("images/back.jpg"))*/),
    child: new Stack(fit: StackFit.expand, children: <Widget>[
    ListView(children: <Widget>[
    new Container(
    height: 620.0,
    child: new LoginBackground(Widgets.kitGradients))
    ]),
    ListView(children: <Widget>[
    Column(children: <Widget>[
    new Padding(
    padding: new EdgeInsets.only(
    top: 60.0, left: 18.0, right: 18.0, bottom: 12.0),
    child: SizedBox(
    //width: deviceSize.width * 0.98,
    child: new Material(
    elevation: 20.0,
    borderRadius: new BorderRadius.circular(6.0),
    shadowColor: Fonts.col_app,
    child: new Form(
    key: _formKey,
    autovalidate: _autovalidate,
    //onWillPop: _warnUserAboutInvalidData,
    child: new Card(
    child: new Column(
    //mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment:
    CrossAxisAlignment.center,
    children: <Widget>[
    new Container(height: 12.0),
    new Center(
    child: Widgets.subtitle(
    Fonts.col_app_fonn)),
    new Container(height: 24.0),
    organisme,
    Container(
    height: 8.0,
    ),
    descc,
    Container(
    height: 8.0,
    ),

    pht,
    im == ""
    ? Container()
    : new Stack(children: <Widget>[
    new Container(
    padding:
    new EdgeInsets.all(4.0),
    width: 90.0,
    height: 90.0,
    child: new Material(
    borderRadius:
    new BorderRadius
    .circular(12.0),
    shadowColor:
    Colors.white,
    elevation: 3.0,
    child:
    new Image.network(
    im,
    fit: BoxFit.cover,
    ))),
    new Positioned(
    top: 0.0,
    right: 2.0,
    child: new InkWell(
    child: new CircleAvatar(
    radius: 10.0,
    backgroundColor:
    const Color(
    0xffff374e),
    child: new Center(
    child: new Icon(
    Icons.close,
    size: 18.0,
    color: Colors.white,
    ))),
    onTap: () {
    setState(() {
    im = "";
    });
    },
    ))
    ]),
    Container(
    height: 8.0,
    ),
    desc,
    Container(
    height: 8.0,
    ),
    lien,
    Container(
    height: 8.0,
    ),
    address,
    Container(
    height: 8.0,
    ),
    face,
    Container(
    height: 8.0,
    ),
    link,
    Container(
    height: 8.0,
    ),
    //  new Image.asset("images/share.png",color: Colors.grey,width: 200.0,height: 200.0,),
    // new Text("Partagez Union avec vos amis ....",textAlign:TextAlign.center,style: new TextStyle(color: Fonts.col_app,fontWeight: FontWeight.w600,fontSize: 17.0,),),
    new Container(
    height: 8.0,
    ),
    btn_log,
    new Container(
    height: 8.0,
    ),
    ]))))))
    ])
    ])
    ])));
    }
    }

 */
