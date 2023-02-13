import 'dart:io';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mycgem/communities/list_regions.dart';
import 'package:mycgem/communities/ville_list.dart';
import 'package:mycgem/entreprise/list_entreprise.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/login/federation/federation_choices.dart';
import 'package:mycgem/login/pays_list.dart';
import 'package:mycgem/login/ss_region/ss_region.dart';
import 'package:mycgem/models/commission.dart';
import 'package:mycgem/models/membre.dart';
import 'package:mycgem/models/sector.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/routes.dart';
import 'package:mycgem/services/sector_services.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/login/login_w.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/validators.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:flutter/services.dart';

import 'commissions/commissions_choices.dart';

class EditOrganisme extends StatefulWidget {
  EditOrganisme(this.email, this.id, this.chng);

  String id;
  var chng;
  String email;

  bool show_myprofile = true;

  @override
  _EditOrganismeState createState() => _EditOrganismeState();
}

class _EditOrganismeState extends State<EditOrganisme>
    with SingleTickerProviderStateMixin {
  final _titrecontroller = new TextEditingController();
  final _adrcontroller = new TextEditingController();
  final _vicontroller = new TextEditingController();
  final _pacontroller = new TextEditingController();

  FocusNode _focusville = new FocusNode();

  FocusNode _focuspa = new FocusNode();

  final _chcontroller = new TextEditingController();
  final _capontroller = new TextEditingController();
  FocusNode _focusadr = new FocusNode();
  FocusNode _focuscap = new FocusNode();
  FocusNode _focusch = new FocusNode();
  String ss_region = "";
  String ss_region_id = "";
  final _namecontroller = new TextEditingController();
  final _nomcontroller = new TextEditingController();

  final _nameccontroller = new TextEditingController();
  String type_organisme = "";

  final _desccontroller = new TextEditingController();
  final _contactcontroller = new TextEditingController();
  bool uploading = false;
  List<Sector> _list = [];
  final _precontroller = new TextEditingController();
  FocusNode _focuspre = new FocusNode();
  FocusNode _focusnom = new FocusNode();
  String type_e = "";

  FocusNode _focusname = new FocusNode();
  var im = "";
  var lo = false;
  var error = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool _autovalidate = false;
  List<String> items = new List<String>();
  String selectedValue1 = "";
  bool val1 = false;
  String type_civil = "";
  bool val2 = false;
  final _raisonc = new TextEditingController();
  FocusNode _focustitre = new FocusNode();
  FocusNode _focusnb = new FocusNode();

  FocusNode _focusdesc = new FocusNode();
  final _nbcontroller = new TextEditingController();

  final _organismecontroller = new TextEditingController();
  List<String> type_profile = [];
  List<String> type = [];
  FocusNode _focusraison = new FocusNode();
  FocusNode _focuscontact = new FocusNode();
  final _textController = new TextEditingController();

  String _authHint = '';
  ParseServer parse_s = new ParseServer();
  String id_organisme;
  String _platformVersion;
  var my_id = "";
  List tt = [];
  String ville_id = "";

  getSectors() async {
    List<Sector> sect = await SectorsServices.get_list_sectors();
    setState(() {
      _list = sect;
    });
  }

  getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    my_id = prefs.getString("id");
  }

  bool yes_or = false;

  final List<Tab> tabs = <Tab>[
    new Tab(text: "Entreprise"),
    new Tab(text: "Association"),
    new Tab(text: "Partenaire"),
  ];

  TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getId();
    getSectors();

    setState(() {
      _contactcontroller.text = widget.email;
    });
    _tabController = new TabController(vsync: this, length: tabs.length);
  }

  sub() {
    setState(() {
      yes_or = true;
    });
  }

  String id_code;

  update_user_entreprise(id, entreprise) async {
    String t = _titrecontroller.text;
    String ra = _raisonc.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("ent", "true");

    String reg = _capontroller.text;
    var js_org = {
      "membre_user": {
        "__type": "Pointer",
        "className": "membres",
        "objectId": '$id'
      },
      "verify_code": verify_code,
      "civilite": type_civil,
      "confirm": false,
      "ent": false,
      "id_code": id_code,
      "titre": "$t",
      "raison": "$ra",
      "organisme": "$entreprise",
    };

    var a = await parse_s.putparse('users/' + my_id, js_org);

  }

  Widget hintText() {
    return _authHint == ""
        ? new Container()
        : new Container(
            //height: 80.0,
            padding: const EdgeInsets.all(32.0),
            child: new Text(_authHint,
                key: new Key('hint'),
                style: new TextStyle(fontSize: 14.0, color: Colors.red[700]),
                textAlign: TextAlign.center));
  }

  showAlert(context) async {
    return showDialog<String>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return new AlertDialog(
            actions: <Widget>[],
            content: new Container(
                width: 260.0,
                height: 200.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: const Color(0xFFFFFF),
                  borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
                ),
                child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 12.0,
                      ),
                      RaisedButton(
                        onPressed: () {
                          /* Navigator.pushReplacement(
                              context,
                              new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                //new HomePage(widget.auth,widget.sign)
                                new Details_organisme(
                                  /*com,*/
                                    widget.auth,
                                    widget.sign,
                                    widget.lat,
                                    widget.lng,
                                    widget.analytics,
                                    widget.observer,
                                    widget.list_partner,
                                    _organismecontroller.text,
                                    id_organisme),
                              ));*/
                        },
                        child: Text("Créer un organisme "),
                      )
                    ])),
          );
        });
  }

  save_image(image) async {
    setState(() {
      uploading = true;
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
        });
      });
    });
  }

  gallery() async {
    Navigator.pop(context);
    var platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      var fi = await ImagePicker.pickImage(source: ImageSource.gallery);
      if (!this.mounted) return;

      File fil;

      setState(() {
        fil = fi;
      });

      _cropImage(fil);
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

  create_entreprise(name, contact, entreprise) async {
    var js_membre = {
      "ice": _organismecontroller.text,
      "username": "$name",
      "address": _adrcontroller.text,
      "active": 0,
      "type_e": type_e,
      "doc": "$document",
      "confirm": false,
      "imageUrl": im == ""
          ? "https://res.cloudinary.com/dgxctjlpx/image/upload/v1565012657/placeholder_2_seeta8.png"
          : im.toString(),
      "password": "123456",
      "month": new DateTime.now().month.toString(),
      "year": new DateTime.now().year.toString(),
      "emails": [_contactcontroller.text],

      // "email": "$contact",
      "type": "$type_organisme",

      "ville_id": "$ville_id",
      "author_id": widget.id,
      "description": _desccontroller.text,

      "ville": {
        "__type": "Pointer",
        "className": "ville",
        "objectId": '$ville_id'
      },
      "pays": _pacontroller.text,
      "nb_emp": _nbcontroller.text,

      /// "chiffre": _chcontroller.text,
    };

    var res = await parse_s.postparse('membres/', js_membre);
    id_organisme = res["objectId"];
    await update_user_entreprise(id_organisme, entreprise);
    User ctc = new User(
        //id: "",
        new_membre: true,
        id: "",
        firstname: _precontroller.text,
        email: _contactcontroller.text,
        fullname: _nomcontroller.text,

        /// new_membre: true,
        prenom: _precontroller.text,
        // titre: _titrecontroller.text, //here jiji
        entreprise: Membre.fromMap(js_membre),
        organisme: _namecontroller.text);

    Navigator.pop(context);
    Routes.goto(context, "register", null, null, [], null, widget.chng,
        id_ent: id_organisme, contact: ctc);

    ///
    //
  }

  /*


  void _handleSubmitted() async {
    print(type_profile);

    if (type_profile.toString() != "[]" &&
        type_profile.toString() != "null" &&
        yes_or == true) {
      setState(() {
        _authHint = "";
        yes_or = false;
        _namecontroller.text = type_profile[1];
        _contactcontroller.text = "    ";
      });
    }

    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidate = true; // Start validating on every change.
      //showInSnackBar("Veuillez corriger les erreurs en rouge");
    } else if (type_profile.isEmpty) {
      setState(() {
        _authHint = "S'il vous plait choisissez l'entreprise !";
      });
    } else {
      print("jihad");
      setState(() {
        _authHint = "";
      });
      //form.save();
      Widgets.onLoading(context);
      if (type_profile.isNotEmpty) {
        await update_user_entreprise(type_profile[0], type_profile[1]);
      } else {
        await create_entreprise(widget.type, _namecontroller.text,
            _contactcontroller.text, _namecontroller.text);
      }

      gotoprofile();

      /*
         SharedPreferences prefs = await SharedPreferences();
           var my_id = prefs.getString("id");
         */

    }
  }

   */

  void _handleSubmitted() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidate = true;

// Start validating on every change.
      //showInSnackBar("Veuillez corriger les erreurs en rouge");
    } else if (document == "") {
      setState(() {
        _authHint = "Entrez le modèle J !";
      });
    } else {
      setState(() {
        _authHint = "";
      });
      //form.save();
      Widgets.onLoading(context);

      await create_entreprise(
          _namecontroller.text, _contactcontroller.text, _namecontroller.text);

      /*
         SharedPreferences prefs = await SharedPreferences();
           var my_id = prefs.getString("id");
         */

    }
  }

  Commission comms = null;
  Commission feds = null;

  goto_types() async {
    // Navigator.pop(widget.context);
    type = await Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new EntreproseList(null, null, widget.id);
    }));

    setState(() {
      type_profile = type;
    });
  }

  String commissions_names = "";

  goto_comm() async {
    String pr = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) =>
                //new HomePage(widget.auth,widget.sign)
                new CommissionsListChoice(
                  widget.id,
                  comm: [],
                ) /*Submit_type_profile(
                  /*com,*/
                  null,
                  null,
                  widget.list_partner,
                  */
            ));

    setState(() {
      commissions_names = pr;
      // id_spec = pr[0].id;
      // prfs1 = new Speciality(pr[0].id, pr[0].type, pr[0].Name);
    });
  }

  String fedrations_names = "";

  goto_feds() async {
    String pr = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) =>
                //new HomePage(widget.auth,widget.sign)
                new FederationListChoice(widget
                    .id) /*Submit_type_profile(
                  /*com,*/
                  null,
                  null,
                  widget.list_partner,
                  */
            ));

    setState(() {
      fedrations_names = pr;
    });
  }

  Widget coomissions_feds() => new InkWell(
      child: new Container(
          margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
          padding: EdgeInsets.only(left: 8, right: 4, top: 12, bottom: 12),
          decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0),
          ),
          child: new Row(children: <Widget>[
            new Container(width: 8.0),
            new Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: new Text(
                    fedrations_names.toString() == "" ||
                            fedrations_names.toString() == "null"
                        ? LinkomTexts.of(context).fed()
                        : fedrations_names.toString().toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: new TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[500]))),
            new Container(
              width: 4.0,
            ),
            new Container(
              width: 8.0,
            ),
            new Expanded(child: new Container()),
            new Image.asset(
              "images/arr.png",
              width: 20,
              height: 20,
            ),
            new Container(
              width: 8.0,
            ),
          ])),
      onTap: () async {
        goto_feds();
      });

  Widget coomissions_widget() => new InkWell(
      child: new Container(
          margin: EdgeInsets.all(12),
          padding: EdgeInsets.only(left: 8, right: 4, top: 12, bottom: 12),
          decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0),
          ),
          child: new Row(children: <Widget>[
            new Container(width: 8.0),
            new Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: new Text(
                    commissions_names.toString() == "" ||
                            commissions_names.toString() == "null"
                        ? LinkomTexts.of(context).commission()
                        : commissions_names.toString().toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: new TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[500]))),
            new Container(
              width: 4.0,
            ),
            new Container(
              width: 8.0,
            ),
            new Expanded(child: new Container()),
            new Image.asset(
              "images/arr.png",
              width: 20,
              height: 20,
            ),
            new Container(
              width: 8.0,
            ),
          ])),
      onTap: () async {
        goto_comm();
      });

  String ss_id = "";

  Widget ssregion() => new InkWell(
      child: new Container(
          margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
          padding: EdgeInsets.only(left: 8, right: 4, top: 12, bottom: 12),
          decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0),
          ),
          child: new Row(children: <Widget>[
            new Container(width: 8.0),
            new Container(
                child: new Text(
                    ss_region.toString() == "null" || ss_region.toString() == ""
                        ? "Sous région"
                        : ss_region.toUpperCase(),
                    style: new TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[500]))),
            new Container(
              width: 4.0,
            ),
            new Container(
              width: 8.0,
            ),
            new Expanded(child: new Container()),
            new Image.asset(
              "images/arr.png",
              width: 20,
              height: 20,
            ),
            new Container(
              width: 8.0,
            ),
          ])),
      onTap: () async {
        tt = await Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) {
          return new SSRegionsList();
        }));

        setState(() {
          ss_region = tt[1];
          ss_id = tt[0];
        });
      });

  Widget region() => new InkWell(
      child: new Container(
          margin: EdgeInsets.only(left: 12, right: 12),
          padding: EdgeInsets.only(left: 8, right: 4, top: 12, bottom: 12),
          decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0),
          ),
          child: new Row(children: <Widget>[
            new Container(width: 8.0),
            new Container(
                child: new Text(
                    _capontroller.text.toString() == "null" ||
                            _capontroller.text.toString() == ""
                        ? "Région"
                        : _capontroller.text.toUpperCase(),
                    style: new TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[500]))),
            new Container(
              width: 4.0,
            ),
            new Container(
              width: 8.0,
            ),
            new Expanded(child: new Container()),
            new Image.asset(
              "images/arr.png",
              width: 20,
              height: 20,
            ),
            new Container(
              width: 8.0,
            ),
          ])),
      onTap: () async {
        tt = await Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) {
          return new RegionsList(null, null, widget.id);
        }));

        setState(() {
          print("----");
          print(tt);
          ss_region_id = tt[0];
          _capontroller.text = tt[1];
          _vicontroller.text = "";

          print(ss_region_id);
        });
      });

  bool verify = false;
  String id_entreprise = "";

/*  verify_entreprise() async {
    setState(() {
      _authHint = "";
    });
    String name = widget.id_ent;

    var a = await parse_s.getparse('partners?where={"objectId":"$name"}');

    if (a["results"].length > 0) {
/*
"username": "$name",
      "email": "$contact",
      "type": "$owner",
      "active": 0,
      "author_id": widget.id,
      "description": _desccontroller.text,
      "imageUrl": im.toString(),
      "address": _adrcontroller.text,
      "ville": _vicontroller.text,
      "pays": _pacontroller.text,
      "ice": _organismecontroller.text,
      "nb_emp": _nbcontroller.text,
      "chiffre": _chcontroller.text,
 */
      setState(() {
        _authHint = "";
        verify = true;
        _adrcontroller.text = a["results"][0]["address"];
        _namecontroller.text = a["results"][0]["username"];
        _vicontroller.text = a["results"][0]["ville"];
        _pacontroller.text = a["results"][0]["pays"];
        _organismecontroller.text = a["results"][0]["ice"];
        _chcontroller.text = a["results"][0]["chiffre"];
        id_entreprise = a["results"][0]["objectId"];
        im = a["results"][0]["imageUrl"].toString() == "null"
            ? ""
            : a["results"][0]["imageUrl"];
      });
    } else {
      setState(() {
        verify = false;

        _authHint = "Cette entreprise n'existe pas dans la platforme!";
      });
    }
  }*/

  bool uploading1 = false;
  ParseServer ps = new ParseServer();
  String progress = "";
  String progress_res = "";
  String document = "";

  setProgress(progress) {
    setState(() {
      progress_res = progress;
    });

  }

  save_file(File file, ext) async {
    setState(() {
      uploading1 = true;
    });

    List<String> va = await ps.fileUpload(file, progress, setProgress, ext);

    //if (!mounted) return;
    ///  _sendMessage(file: va[1], docname: va[0], text: "file");

    setState(() {
      /// images.add(va.toString());
      print(va.toString());

      ///im = va.toString();
      error = "";
      uploading1 = false;
      document = va[1];
    });

    return true;
  }

  bool verify_code = false;

  goo() async {
    var a = await parse_s
        .getparse('code_partner?where={"code":"${_textController.text}"}');

    if (a["results"].length > 0) {
      if (a["results"][0]["code"] == _textController.text) {
        Navigator.pop(context);
        _scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: new Text("Code vérifié!"),
        ));

        setState(() {
          id_code = a["results"][0]["objectId"];
          verify_code = true;
        });
      }
    } else {
      Navigator.pop(context);

      _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text("Code incorrect!"),
      ));
    }
  }

  _showD() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) => new AlertDialog(
        contentPadding: const EdgeInsets.all(24.0),
        content: Container(
            height: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Entrer le code ici",
                  textAlign: TextAlign.justify,
                ),
                new Row(
                  children: <Widget>[
                    Container(
                      height: 16.0,
                    ),
                    new Expanded(
                      child: new TextFormField(
                        autofocus: true,
                        controller: _textController,
                        decoration:
                            new InputDecoration(hintText: 'Code partenaire '),
                      ),
                    )
                  ],
                ),
              ],
            )),
        actions: <Widget>[
          new FlatButton(
              child: new Text('Ok'),
              onPressed: () async {
                goo();
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Validators val = new Validators(context: context);

    Widget civility = new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
            width: 16,
            child: new Checkbox(
              activeColor: Fonts.col_app,
              value: val2,
              onChanged: (bool value) {
                setState(() {
                  val2 = value;
                  val1 = !value;
                  type_civil = "Mme";
                });
              },
            )),
        new Container(width: 8.0),
        new Text(
          "Mme",
          style: TextStyle(fontSize: ScreenUtil().setSp(14)),
        ),
        new Container(width: 24.0),
        Container(
            width: 16,
            child: new Checkbox(
              activeColor: Fonts.col_app,
              value: val1,
              onChanged: (bool value) {
                setState(() {
                  val1 = value;
                  val2 = !value;
                  type_civil = "M.";
                });
              },
            )),
        new Container(width: 8.0),
        new Text(
          "M.",
          style: TextStyle(fontSize: ScreenUtil().setSp(14)),
        ),
      ],
    );

    Widget Nom = new Container(
        margin: EdgeInsets.only(left: 12.0, right: 12.0),
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0)),
        child: Widgets.textfield("Nom", _focusnom, "", _nomcontroller,
            TextInputType.text, val.validatename));

    Widget prenom = new Container(
        margin: EdgeInsets.only(left: 12.0, right: 12.0),
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0)),
        child: Widgets.textfield("Prénom", _focuspre, "", _precontroller,
            TextInputType.text, val.validatename));

    /*Widget ice = new Container(
        margin: EdgeInsets.only(left: 12.0, right: 12.0),
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0)),
        child: Widgets.textfield0(
            widget?.type == "Entreprise"
                ? "N° de membre CGEM"
                : "N° de membre CGEM",
            _focusorganise,
            "",
            _organismecontroller,
            TextInputType.text));
*/

    Widget ville = _pacontroller.text != "Maroc"
        ? new Container(
            width: MediaQuery.of(context).size.width * 0.41,
            margin: EdgeInsets.only(left: 12.0),
            decoration: new BoxDecoration(
                border: new Border.all(color: Colors.grey[400], width: 1.0),
                borderRadius: new BorderRadius.circular(4.0)),
            child: Widgets.textfield0(
              "Ville",
              _focusville,
              "",
              _vicontroller,
              TextInputType.text,
            ))
        : GestureDetector(
            onTap: () async {
              setState(() {
                _authHint = "";
              });
              /*if (tt.length == 0)
                setState(() {
                  _authHint = "Choisir la région !";
                });
              else {*/
              // Navigator.pop(widget.context);
              List vi = await Navigator.push(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
                return new VilleLIst(ss_region_id, null, null);
              }));

              print(type);
              setState(() {
                _vicontroller.text = vi[1];
                ville_id = vi[0];
              });

              // nb_cap= await Navigator.push(context, route)
            },
            child: new Container(
                width: MediaQuery.of(context).size.width * 0.41,
                margin: EdgeInsets.only(left: 12.0),
                decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.grey[400], width: 1.0),
                    borderRadius: new BorderRadius.circular(4.0)),
                child: AbsorbPointer(
                    child: Widgets.textfield0(
                  "Ville",
                  _focusville,
                  "",
                  _vicontroller,
                  TextInputType.text,
                ))));

    Widget pays = GestureDetector(
        onTap: () async {
          setState(() {
            _authHint = "";
            _vicontroller.text = "";
          });

          // Navigator.pop(widget.context);
          List vi = await Navigator.push(context,
              new MaterialPageRoute(builder: (BuildContext context) {
            return new PaysLIst();
          }));

          setState(() {
            _pacontroller.text = vi[1];
            // ville_id = vi[0];
            /// _pacontroller.text="";
          });

          // nb_cap= await Navigator.push(context, route)
        },
        child: AbsorbPointer(
            child: new Container(
                width: MediaQuery.of(context).size.width * 0.41,
                margin: EdgeInsets.only(left: 12.0),
                decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.grey[400], width: 1.0),
                    borderRadius: new BorderRadius.circular(4.0)),
                child: Widgets.textfield0(
                  "Pays",
                  _focuspa,
                  "",
                  _pacontroller,
                  TextInputType.text,
                ))));

    Widget titre = new Container(
        margin: EdgeInsets.only(left: 12.0, right: 12.0),
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0)),
        child: Widgets.textfield("Fonction", _focustitre, "", _titrecontroller,
            TextInputType.text, val.validatetitre));

    Widget company = new Container(
        margin: EdgeInsets.only(left: 12.0, right: 12.0),
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0)),
        child: AbsorbPointer(
            absorbing: true,
            //To disable from touch use false while **true** for otherwise
            child: Widgets.textfield("Raison sociale", _focusname, "",
                _namecontroller, TextInputType.text, val.validaten)));

    Widget nom_complet = new Container(
        margin: EdgeInsets.only(left: 12.0, right: 12.0),
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0)),
        child: Widgets.textfield("Nom complet", _focusnb, "", _nameccontroller,
            TextInputType.text, val.validatename));

    Widget address = new Container(
        margin: EdgeInsets.only(left: 12.0, right: 12.0),
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0)),
        child: Widgets.textfield("Addresse", _focusadr, "", _adrcontroller,
            TextInputType.text, val.validateAddress));

    Widget desc = new Container(
        margin:
            EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0, top: 12.0),
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[300], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0)),
        child: Widgets.textfield_des1("Description", _focusdesc, "",
            _desccontroller, TextInputType.text, val.validatedesc));

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
                          title: new Text("Prendre le logo")),
                      new ListTile(
                          onTap: gallery,
                          title: new Text("Photo depuis la galerie")),
                    ])));
          });
    }

    Widget pht = new InkWell(
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Container(
                width: 12.0,
              ),
              new Text(
                "Ajouter le logo de votre organisme :",
                style: new TextStyle(color: Colors.grey[600], fontSize: 15.6),
              ),
              new Container(
                width: 12.0,
              ),
              uploading ? new RefreshProgressIndicator() : new Container(),
            ],
          ),
        ],
      ),
      onTap: () {},
    );

    Widget doc = new InkWell(
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Container(
                width: 12.0,
              ),
              new Text(
                "Ajouter le modèle J de votre entreprise :",
                style: new TextStyle(color: Colors.grey[600], fontSize: 15.6),
              ),
              new Container(
                width: 12.0,
              ),
            ],
          ),
          new Container(
            height: 12.0,
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: new Text(
                "(RC, document officiel prouvant l’existence de votre société ou équivalent)",
                style: new TextStyle(color: Colors.grey[500], fontSize: 13.6),
              )),
        ],
      ),
      onTap: () {},
    );

    _pickDocument() async {
      File result;
      try {
        result = await ImagePicker.pickImage(source: ImageSource.gallery);
        String type = result.path.toString().split('.').last;

        save_file(result, type);
      } catch (e) {} finally {}
    }

    Widget contact = new Container(
        margin: EdgeInsets.only(left: 12.0, right: 12.0),
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0)),
        child: Widgets.textfield("Email", _focuscontact, "", _contactcontroller,
            TextInputType.emailAddress, val.validateEmail));

    var style = new TextStyle(
        color: const Color(0xffeff2f7),
        fontSize: 20.0,
        fontWeight: FontWeight.w500);
    var clr = Fonts.col_app_fon;

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

    return Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          iconTheme: IconThemeData(color: Fonts.col_app_fon),
          backgroundColor: Fonts.col_app_shadow,
          title: new Text(
            "Votre organisme",
            style: TextStyle(color: Fonts.col_app_fon),
          ),
          elevation: 0.0,
        ),
        body: new Container(
            decoration: new BoxDecoration(
              color: Colors.grey[300],
              /*image: new DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(
                        Colors.white.withOpacity(0.3), BlendMode.dstATop),
                    image: new AssetImage("images/back.jpg"))*/
            ),
            child: new Stack(fit: StackFit.expand, children: <Widget>[
              ListView(children: <Widget>[
                new Container(
                    height: 700.0,
                    child: new LoginBackground(Widgets.kitGradients1))
              ]),
              ListView(children: <Widget>[
                Column(children: <Widget>[
                  new Padding(
                      padding: new EdgeInsets.only(
                          top: 20.0, left: 18.0, right: 18.0, bottom: 12.0),
                      child: SizedBox(
                          //width: deviceSize.width * 0.98,
                          child: new Material(
                              color: Colors.white.withOpacity(0.95),
                              elevation: 20.0,
                              borderRadius: new BorderRadius.circular(6.0),
                              shadowColor: Fonts.col_app,
                              child: new Form(
                                  key: _formKey,
                                  autovalidate: _autovalidate,
                                  //onWillPop: _warnUserAboutInvalidData,
                                  child: new Column(
                                      //mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        new Container(height: 12.0),
                                        /*new Center(
                                            child: Widgets.subtitle5(
                                                Fonts.col_app_fonn,
                                                widget.type.toString())),*/
                                        new Container(height: 12.0),

                                        /// nom_complet,

                                        Text(
                                          "Vous êtes: ",
                                          style: new TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 15.6),
                                        ),
                                        Container(
                                            height: 80,
                                            child: new TabBar(
                                              isScrollable: true,
                                              unselectedLabelColor: Colors.grey,
                                              labelColor: Colors.white,
                                              indicatorSize:
                                                  TabBarIndicatorSize.tab,
                                              indicator: new BubbleTabIndicator(
                                                indicatorHeight: 35.0,
                                                indicatorColor: Fonts.col_gr,
                                                tabBarIndicatorSize:
                                                    TabBarIndicatorSize.tab,
                                              ),
                                              tabs: tabs,
                                              onTap: (i) {
                                                setState(() {
                                                  if (i == 0)
                                                    type_e = "entreprise";
                                                  else if (i == 1)
                                                    type_e = "association";
                                                  else
                                                    type_e = "partenaire";
                                                });
                                                /* if (i == 2)
                                                  setState(() {
                                                    show = true;
                                                  });
                                                else
                                                  setState(() {
                                                    show = false;
                                                  });*/
                                              },
                                              controller: _tabController,
                                            )),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Civilité:",
                                              style: new TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 15.6),
                                            ),
                                            Container(
                                              width: 32,
                                            ),
                                            civility,
                                          ],
                                        ),
                                        new Container(height: 12.0),

                                        Nom,
                                        new Container(height: 12.0),

                                        prenom,
                                        new Container(height: 12.0),

                                        contact,
                                        new Container(height: 12.0),
                                        company,
                                        /* Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.40,
                                                child: FlatButton(
                                                  padding: EdgeInsets.all(0.0),
                                                  child: Text(
                                                    "Cliquer ici pour vérifier si le nom existe dans la platforme",
                                                    style: TextStyle(
                                                        color: Fonts.col_app,
                                                        fontSize: 12.0),
                                                  ),
                                                  onPressed: () {
                                                    verify_entreprise();
                                                  },
                                                ))*/

                                        Container(
                                          height: 12.0,
                                        ),
                                        /*ice,
                                        Container(
                                          height: 12.0,
                                        ),*/
                                        titre,
                                        Container(
                                          height: 12.0,
                                        ),
                                        pht,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            new FlatButton(
                                              onPressed: () {
                                                open_bottomsheet();
                                              },
                                              child: Row(
                                                children: [
                                                  new Text(
                                                    "AJOUTER LE LOGO",
                                                    style: new TextStyle(
                                                      color: Fonts.col_app,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 8,
                                                  ),
                                                  Icon(
                                                    Icons.add_circle_outline,
                                                    color: Fonts.col_app,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: 12.0,
                                        ),

                                        im == ""
                                            ? Container()
                                            : new Stack(children: <Widget>[
                                                new Container(
                                                    padding:
                                                        new EdgeInsets.all(4.0),
                                                    width: 70.0,
                                                    height: 70.0,
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

                                        ///  coomissions_widget(),
                                        /// coomissions_feds(),

                                        ///   region(),

                                        doc,

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            new FlatButton(
                                              onPressed: () {
                                                _pickDocument();
                                              },
                                              child: Row(
                                                children: [
                                                  new Text(
                                                    "AJOUTER LE MODÈLE J",
                                                    style: new TextStyle(
                                                      color: Fonts.col_app,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 8,
                                                  ),
                                                  Icon(
                                                    Icons.add_circle_outline,
                                                    color: Fonts.col_app,
                                                  ),
                                                  document != ""
                                                      ? Icon(
                                                          Icons.check,
                                                          color: Colors.green,
                                                        )
                                                      : Container()
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),

                                        uploading1
                                            ? new CircularPercentIndicator(
                                                radius: 60.0,
                                                // animation: true,
                                                lineWidth: 5.0,
                                                percent: double.parse(
                                                        progress_res == ""
                                                            ? "0"
                                                            : progress_res
                                                                .split("%")[0]
                                                                .toString()) /
                                                    100,
                                                center: new Text(
                                                    progress_res.toString()),
                                                progressColor:
                                                    Fonts.col_app_fonn,
                                              )
                                            : Container(),
                                        Row(
                                          children: <Widget>[
                                            pays,
                                            Container(
                                              width: 2,
                                            ),
                                            ville,
                                          ],
                                        ),
                                        new Container(
                                          height: 12.0,
                                        ),
                                        address,
                                        new Container(
                                          height: 12.0,
                                        ),
                                        verify_code == true
                                            ? Container()
                                            : Container(
                                                padding: EdgeInsets.only(
                                                    left: 18.0,
                                                    right: 18.0,
                                                    top: 12.0),
                                                child: RichText(
                                                    textAlign:
                                                        TextAlign.justify,
                                                    text: new TextSpan(
                                                      text: "",
                                                      children: <TextSpan>[
                                                        new TextSpan(
                                                          text:
                                                              "Avez-vous un code partenaire ? ",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[600],
                                                              fontSize: 16),
                                                        ),
                                                        new TextSpan(
                                                            text: //(dans une entreprise déjà inscrite au niveau de la plateforme)
                                                                "cliquez ici ",
                                                            recognizer:
                                                                new TapGestureRecognizer()
                                                                  ..onTap = () {
                                                                    print(
                                                                        "yesssss");

                                                                    _showD();
                                                                  },
                                                            style: new TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                                color:
                                                                    Colors.blue,
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500))
                                                      ],
                                                    ))),
                                        hintText(),

                                        new Container(
                                          height: 12.0,
                                        ),
                                        btn_log,
                                        new Container(
                                          height: 8.0,
                                        ),
                                      ])))))
                ])
              ])
            ])));
  }
}
