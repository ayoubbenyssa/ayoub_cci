import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mycgem/communities/list_regions.dart';
import 'package:mycgem/communities/ville_list.dart';
import 'package:mycgem/entreprise/list_entreprise.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/login/federation/federation_choices.dart';
import 'package:mycgem/login/pays_list.dart';
import 'package:mycgem/login/ss_region/ss_region.dart';
import 'package:mycgem/models/commission.dart';
import 'package:mycgem/models/sector.dart';
import 'package:mycgem/services/sector_services.dart';
import 'package:mycgem/user/edit_my_profile.dart';
import 'package:mycgem/widgets/custom_widgets/primary_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/login/login_w.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/validators.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:flutter/services.dart';
import 'commissions/commissions_choices.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EntrepriseForm extends StatefulWidget {
  EntrepriseForm(this.id, this.type, this.chng, this.id_ent);

  String id;
  String type;
  var chng;
  String id_ent;

  bool show_myprofile = true;

  @override
  _EntrepriseFormState createState() => _EntrepriseFormState();
}

class _EntrepriseFormState extends State<EntrepriseForm> {
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
  final _desccontroller = new TextEditingController();
  final _contactcontroller = new TextEditingController();
  bool uploading = false;
  List<Sector> _list = [];

  var im =
      "https://res.cloudinary.com/dgxctjlpx/image/upload/v1565012657/placeholder_2_seeta8.png";
  var lo = false;
  var error = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool _autovalidate = false;
  List<String> items = new List<String>();
  String selectedValue1 = "";

  final _raisonc = new TextEditingController();
  FocusNode _focustitre = new FocusNode();
  FocusNode _focusnb = new FocusNode();

  FocusNode _focusdesc = new FocusNode();
  final _nbcontroller = new TextEditingController();

  final _organismecontroller = new TextEditingController();
  List<String> type_profile = [];
  List<String> type = [];
  FocusNode _focusraison = new FocusNode();
  FocusNode _focusname = new FocusNode();
  FocusNode _focuscontact = new FocusNode();

  FocusNode _focusorganise = new FocusNode();
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

  @override
  void initState() {
    getId();

    getSectors();
    verify_entreprise();
  }

  sub() {
    setState(() {
      yes_or = true;
    });
  }

  gotoprofile() {
    Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
              //new HomePage(widget.auth,widget.sign)
              new EditMyProfile(null, null, [], widget.chng, null),
        ));
  }

  update_user_entreprise(id, entreprise) async {
    String t = _titrecontroller.text;
    String ra = _raisonc.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("ent", "true");

    String reg = _capontroller.text;
    var js_org = {
      "membre": {
        "__type": "Pointer",
        "className": "membres",
        "objectId": '$id'
      },
      "ss_region": ss_id,
      "ent": false,
      "titre": "$t",
      "raison": "$ra",
      "organisme": "$entreprise",
      "region": "$reg",

      ///"civilite": widget.con
    };

    await parse_s.putparse('users/' + my_id, js_org);
  }

  create_entreprise(owner, name, contact, entreprise) async {
    var res = await parse_s.putparse('membres/' + widget.id_ent, {
      "username": "$name",
      // "email": "$contact",
      "type": "$owner",

      ///  "active": 0,
      "ville_id": "$ville_id",
      "address": "${_adrcontroller.text}",

      ///  "region_id": tt[0],
      "author_id": widget.id,
      "description": _desccontroller.text,
      "imageUrl": im.toString(),
      "ville": {
        "__type": "Pointer",
        "className": "ville",
        "objectId": ville_id
      },
      "ville_externe": _vicontroller.text,
      "pays": _pacontroller.text,
      "password": "123456",
      "month": new DateTime.now().month.toString(),
      "year": new DateTime.now().year.toString()
    });

    print(res);

    id_organisme = id_entreprise;

    await update_user_entreprise(id_organisme, entreprise);
    //Navigator.pop(context);
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
                      new Text(
                          "Il existe deja un organisme du meme nom, voulez vous rejoindre cet organisme, ou créer un "
                          "autre ?"),
                      RaisedButton(
                        onPressed: () async {
                          gotoprofile();
                        },
                        child: Text("Rejoindre " + _organismecontroller.text),
                      ),
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

  void _handleSubmitted_entreprise() async {
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
        _authHint = "Choisissez l'organisme !";
      });
    } else if (ville_id == "") {
      setState(() {
        _authHint = "Choisissez la ville !";
      });
    } else if (_pacontroller.text == "") {
      setState(() {
        _authHint = "Choisissez le pays !";
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
    print("<3");

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
    print("<3");

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

  verify_entreprise() async {
    setState(() {
      _authHint = "";
    });
    String name = widget.id_ent;

    var a = await parse_s.getparse('membres?where={"objectId":"$name"}');

    if (a["results"].length > 0) {
      print("---------------------------------");
      print(a["results"]);
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
        _namecontroller.text = a["results"][0]["rs"];
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
  }

  @override
  Widget build(BuildContext context) {
    Validators val = new Validators(context: context);

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
              print("dyeyye");
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

          print("dyeyye");
          // Navigator.pop(widget.context);
          List vi = await Navigator.push(context,
              new MaterialPageRoute(builder: (BuildContext context) {
            return new PaysLIst();
          }));

          print(type);
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

/*new Container(
        width: MediaQuery.of(context).size.width * 0.41,
        margin: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0)),
        child: Widgets.textfield0(
            "Pays", _focuspa, "", _pacontroller, TextInputType.text))*/
    ;

    /* Widget titre = new Container(
        margin: EdgeInsets.only(left: 12.0, right: 12.0),
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0)),
        child:  Widgets.textfield("Fonction", _focustitre, "",
            _titrecontroller, TextInputType.text, val.validatetitre));
*/

    Widget company =  AbsorbPointer(
            absorbing: true,
            //To disable from touch use false while **true** for otherwise
            child: Widgets.textfield("Raison sociale", _focusname, "",
                _namecontroller, TextInputType.text, val.validaten));

    Widget address =  Widgets.textfield("Addresse", _focusadr, "", _adrcontroller,
            TextInputType.text, val.validateAddress);

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
              /*new FlatButton(
                onPressed: () {
                  open_bottomsheet();
                },
                child: new Text(
                  "AJOUTER LE LOGO",
                  style: new TextStyle(
                    color: const Color(0xffff374e),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )*/
            ],
          ),
        ],
      ),
      onTap: () {},
    );

    Widget contact = new Container(
        margin: EdgeInsets.only(left: 12.0, right: 12.0),
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0)),
        child: Widgets.textfield("Email", _focuscontact, "", _contactcontroller,
            TextInputType.emailAddress, val.validatecont));

    var style = new TextStyle(
        color: const Color(0xffeff2f7),
        fontSize: 20.0,
        fontWeight: FontWeight.w500);
    var clr = Fonts.col_app_fon;

    Widget btn_log =  Container(
        width: 160.w,
        child: PrimaryButton(
          onTap: () {
            _handleSubmitted();
          },
          icon: "",
          disabledColor: Fonts.col_grey,
          fonsize: 15.5,
          prefix: Container(),
          color: Fonts.col_app,
          isLoading: false,
          text: "Enregistrer",
        ))/*new Padding(
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
                  //verify_entreprise();
                },
                child: new Text("Enregistrer".toUpperCase(), style: style))))*/;

    return Scaffold(
        backgroundColor: Colors.white,
        /* appBar: new AppBar(
          iconTheme: IconThemeData(color: Fonts.col_app_fon),
          backgroundColor: Fonts.col_app_shadow,
          title: new Text(
            "Confirmer vos informations",
            style: TextStyle(color: Fonts.col_app_fon),
          ),
          elevation: 0.0,
        ),*/
        body: new Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/images/background.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(children: <Widget>[
              Container(
                height: 80.h,
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.clear,
                      size: 32,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Container(
                height: 40.h,
              ),
              Stack(children: [
                new Padding(
                    padding: new EdgeInsets.only(
                        top: 40.0.h, left: 18.0, right: 18.0, bottom: 12.0),
                    child: new Material(
                        elevation: 1,
                        borderRadius: new BorderRadius.circular(16.0),
                        color: Colors.white,
                        child: new Form(
                            key: _formKey,
                            autovalidate: _autovalidate,
                            //onWillPop: _warnUserAboutInvalidData,
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal :16.0.w),
                              child: new Column(
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    new Container(height: 12.0),
                                    /*new Center(
                                              child: Widgets.subtitle5(
                                                  Fonts.col_app_fonn,
                                                  widget.type.toString())),*/
                                    new Container(height: 12.0),
                                    hintText(),
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

                                    /// titre,
                                    Container(
                                      height: 12.0,
                                    ),
                                //    pht,
                                    Container(
                                      height: 12.0,
                                    ),
                                    im == ""
                                        ? Container()
                                        : new Stack(children: <Widget>[
                                            new Container(
                                                padding: new EdgeInsets.all(4.0),
                                                width: 70.0,
                                                height: 70.0,
                                                child: new Material(
                                                    borderRadius:
                                                        new BorderRadius.circular(
                                                            12.0),
                                                    shadowColor: Colors.white,
                                                    elevation: 3.0,
                                                    child: new Image.network(
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
                                                          const Color(0xffff374e),
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

                                    ///coomissions_widget(),
                                    ///coomissions_feds(),
                                    ///   region(),

                                    address,
                                    new Container(
                                      height: 12.0,
                                    ),
                                    btn_log,
                                    new Container(
                                      height: 8.0,
                                    ),
                                  ]),
                            )))),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      width: 78.w,
                      height: 78.w,
                      child: Image.asset(
                        "assets/images/logo2.png",
                        width: 78.w,
                      )),
                ),
              ]),
              Expanded(child: Container(),),
              Center(child: Container(

                  width: 258.w,
                  child: Image.asset("assets/images/logo_bk.png")),),
              Container(height: 56.h,)

            ])));
  }
}
