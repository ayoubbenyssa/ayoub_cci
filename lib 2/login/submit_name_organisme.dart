/*import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mycgem/entreprise/list_entreprise.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/user/edit_my_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/login/login_w.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/validators.dart';
import 'package:mycgem/widgets/widgets.dart';

class SubmitNameOrganisme extends StatefulWidget {
  SubmitNameOrganisme(this.id, this.type,this.name,this.email, this.chng);

  String id;
  String type;
  String name;
  String email;
  var chng;


  bool show_myprofile = true;

  @override
  _InvitrefriendsState createState() => _InvitrefriendsState();
}

class _InvitrefriendsState extends State<SubmitNameOrganisme> {
  final _titrecontroller = new TextEditingController();
  final _namecontroller = new TextEditingController();
  final _contactcontroller = new TextEditingController();

  final _raisonc = new TextEditingController();
  FocusNode _focustitre = new FocusNode();

  final _organismecontroller = new TextEditingController();
  List<String> type_profile = [];
  List<String> type = [];
  FocusNode _focusraison = new FocusNode();
  FocusNode _focusname = new FocusNode();
  FocusNode _focuscontact = new FocusNode();

  FocusNode _focusorganise = new FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  String _authHint = '';
  ParseServer parse_s = new ParseServer();
  String id_organisme;

  var my_id = "";

  getId() async {
    SharedPreferences prefs = await SharedPreferences();
    my_id = prefs.getString("id");
  }

  bool yes_or = false;

  @override
  void initState() {
    getId();
  }

  sub() {
    print("jsjsjjs");
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
              new EditMyProfile(
                  /*com,*/
                  null,
                  null,
                  [], widget.chng),
        ));
  }

  update_user_entreprise(id,entreprise) async {
    String t = _titrecontroller.text;
    String ra = _raisonc.text;

    var js_org = {
      "entreprise": {
        "__type": "Pointer",
        "className": "partners",
        "objectId": '$id'
      },
      "titre": "$t",
      "raison": "$ra",
      "organisme": "$entreprise"
    };

    await parse_s.putparse('users/' + my_id, js_org);
  }

  create_entreprise(owner,name,contact,entreprise) async {
    var res = await parse_s.postparse('partners/', {
      "name": "$name",
      "email": "$contact",
      "type": "$owner",
      "active":0
    });
    id_organisme = res["objectId"];
    await update_user_entreprise(res["objectId"],entreprise);
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


  void _handleSubmitted_Entrepreneur() async {
    print(type_profile);


      setState(() {
        _authHint = "";
        _namecontroller.text = "   ";
        _contactcontroller.text = "    ";
      });


    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidate = true; // Start validating on every change.
      //showInSnackBar("Veuillez corriger les erreurs en rouge");
    }  else {
      print("jihad");
      setState(() {
        _authHint = "";
      });
      //form.save();
      Widgets.onLoading(context);

      await create_entreprise(widget.type,widget.name,widget.email,widget.name);


      gotoprofile();

      /*
         SharedPreferences prefs = await SharedPreferences();
           var my_id = prefs.getString("id");
         */

    }
  }

  void _handleSubmitted_entreprise() async {
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
        _authHint = "Choisissez l'entreprise !";
      });
    } else {
      print("jihad");
      setState(() {
        _authHint = "";
      });
      //form.save();
      Widgets.onLoading(context);
      if (type_profile.isNotEmpty) {
        await  update_user_entreprise(type_profile[0],type_profile[1]);
      } else {
        await create_entreprise(widget.type,_namecontroller.text,_contactcontroller.text,_namecontroller.text);
      }

      gotoprofile();

      /*
         SharedPreferences prefs = await SharedPreferences();
           var my_id = prefs.getString("id");
         */

    }
  }

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
        _authHint = "Choisissez l'entreprise !";
      });
    } else {
      print("jihad");
      setState(() {
        _authHint = "";
      });
      //form.save();
      Widgets.onLoading(context);
      if (type_profile.isNotEmpty) {
      await  update_user_entreprise(type_profile[0],type_profile[1]);
      } else {
        await create_entreprise(widget.type,_namecontroller.text,_contactcontroller.text,_namecontroller.text);
      }

      gotoprofile();

      /*
         SharedPreferences prefs = await SharedPreferences();
           var my_id = prefs.getString("id");
         */

    }
  }

  Widget tpe_profile() => widget.type == "Entrepreneur"?Container():new InkWell(
      child: new Container(
          margin: EdgeInsets.only(left: 12.0, right: 12.0),
          decoration: new BoxDecoration(
            color: const Color(0xffeff2f7),
            gradient: new LinearGradient(
                begin: FractionalOffset.bottomCenter,
                end: FractionalOffset.topCenter,
                colors: [
                  Colors.white,
                  Colors.grey[100],
                ]),
            borderRadius: new BorderRadius.circular(4.0),
            boxShadow: <BoxShadow>[
              new BoxShadow(
                spreadRadius: 0.5,
                color: Colors.grey[400],
                blurRadius: 0.5,
                offset: new Offset(0.0, 1.0),
                // color: const Color(0xffedd9ac)
              ),
            ],
          ),
          height: 40.0,
          child: new Row(children: <Widget>[
            new Container(width: 8.0),
            new Container(
                child: new Text(
                    type_profile.toString() != "[]" &&
                            type_profile.toString() != "null"
                        ? type_profile[1].toString()
                        : LinkomTexts.of(context).cent(),
                    style: new TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600]))),
            new Container(
              width: 4.0,
            ),
            new Container(
              width: 8.0,
            ),
            new Expanded(child: new Container()),
            new Icon(
              Icons.arrow_drop_down,
              color: Fonts.col_app_fon,
            )
          ])),
      onTap: () {
        goto_types();
      });

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

  @override
  Widget build(BuildContext context) {
    Validators val = new Validators(context: context);

    Widget organisme = new Container(
        margin: EdgeInsets.only(left: 12.0, right: 12.0),
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0)),
        child: Widgets.textfield(
            widget?.type == "Entreprise" ? "ICE" : "ICE/RNAE",
            _focusorganise,
            "",
            _organismecontroller,
            TextInputType.text,
            val.validateorganisme));

    Widget titre = new Container(
        margin: EdgeInsets.only(left: 12.0, right: 12.0),
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0)),
        child: Widgets.textfield("Votre titre / Fonction", _focustitre, "",
            _titrecontroller, TextInputType.text, val.validatetitre));

    Widget company = new Container(
        margin: EdgeInsets.only(left: 12.0, right: 12.0),
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0)),
        child: Widgets.textfield("Le nom de l'entreprise", _focusname, "",
            _namecontroller, TextInputType.text, val.validaten));

    Widget contact = new Container(
        margin: EdgeInsets.only(left: 12.0, right: 12.0),
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0)),
        child: Widgets.textfield("Email de l'entreprise", _focuscontact, "",
            _contactcontroller, TextInputType.emailAddress, val.validatecont));

    var style = new TextStyle(
        color: const Color(0xffeff2f7),
        fontSize: 20.0,
        fontWeight: FontWeight.w500);
    var clr = Colors.blue[600];

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
                  if(widget.type== "Entrepreneur")
                    {
                      _handleSubmitted_Entrepreneur();
                    }
                  else
                  _handleSubmitted();
                },
                child: new Text(LinkomTexts.of(context).confirm(), style: style))));

    return Scaffold(
        appBar: new AppBar(
          iconTheme: IconThemeData(color: Fonts.col_app_fon),
          backgroundColor: Fonts.col_app_shadow,
          title: new Text(
            "Informations professionnelles",
            style: TextStyle(color: Fonts.col_app_fon),
          ),
          elevation: 0.0,
        ),
        body: new Container(
            decoration: new BoxDecoration(
                color: Colors.grey[300],
               /* image: new DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(
                        Colors.white.withOpacity(0.3), BlendMode.dstATop),
                    image: new AssetImage("images/back.jpg"))*/),
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
                          top: 100.0, left: 18.0, right: 18.0, bottom: 18.0),
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
                                        new Container(height: 18.0),
                                        new Center(
                                            child: Widgets.subtitle5(
                                                Fonts.col_app_fonn,
                                                widget.type.toString())),
                                        new Container(height: 32.0),
                                        hintText(),
                                        titre,
                                        Container(
                                          height: 12.0,
                                        ),

                                        Container(
                                          height: 12.0,
                                        ),
                                        tpe_profile(),
                                        Container(
                                          height: 12.0,
                                        ),
                                        widget.type == "Entrepreneur"?Container():  Container(
                                            padding: EdgeInsets.only(
                                                left: 16.0, right: 16.0),
                                            child: RichText(
                                                textAlign: TextAlign.justify,
                                                text: new TextSpan(
                                                  text: "",
                                                  children: <TextSpan>[
                                                    new TextSpan(
                                                      text:
                                                          "Si vous n'avez pas trouvé votre entreprise sur la liste,  ",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[600],
                                                          fontSize: 16),
                                                    ),
                                                    new TextSpan(
                                                        text: //(dans une entreprise déjà inscrite au niveau de la plateforme)
                                                            "cliquez ici pour l'ajouter  ",
                                                        recognizer:
                                                            new TapGestureRecognizer()
                                                              ..onTap = () {
                                                                sub();
                                                              },
                                                        style: new TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            color: Colors.blue,
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500))
                                                  ],
                                                ))),
                                        new Container(
                                          height: 12.0,
                                        ),
                                        yes_or ? company : Container(),
                                        yes_or
                                            ? new Container(
                                                height: 12.0,
                                              )
                                            : Container(),
                                        yes_or ? contact : Container(),
                                        yes_or
                                            ? new Container(
                                                height: 24.0,
                                              )
                                            : Container(),
                                        btn_log,
                                        new Container(
                                          height: 24.0,
                                        ),
                                      ])))))
                ])
              ])
            ])));
  }
}
*/