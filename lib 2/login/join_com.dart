import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/login/login_w.dart';
import 'package:mycgem/models/commission.dart';

import 'package:mycgem/models/user.dart';
import 'package:mycgem/pages/conditions.dart';
import 'package:mycgem/pages/politique.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/auth.dart';
import 'package:mycgem/services/block.dart';

import 'package:mycgem/services/send_email_service.dart';
import 'package:mycgem/services/validators.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

class JoinCom extends StatefulWidget {
  JoinCom(this.user, this.com);

  User user;
  Commission com;

  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<JoinCom> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  FocusNode _focuspassword = new FocusNode();
  FocusNode _focusemail = new FocusNode();
  FocusNode _focusname = new FocusNode();
  FocusNode _focustitre = new FocusNode();
  FocusNode _focusorganise = new FocusNode();
  FocusNode _focuspre = new FocusNode();
  FocusNode _focusdesc = new FocusNode();

  FocusNode _focusphone = new FocusNode();
  FocusNode _focusconfirm = new FocusNode();
  final _confirmcontroller = new TextEditingController();
  bool _isChecked = false;
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      new GlobalKey<FormFieldState<String>>();
  String _authHint = '';
  final _passcontroller = new TextEditingController();
  final _desccontroller = new TextEditingController();
  bool val1 = false;
  String type = "";
  bool val2 = false;
  final _titrecontroller = new TextEditingController();
  final _organismecontroller = new TextEditingController();

  final _emailcontroller = new TextEditingController();
  final _namecontroller = new TextEditingController();
  final _precontroller = new TextEditingController();
  final _phonecontroller = new TextEditingController();
  BaseAuth auth;
  VoidCallback onSignedIn;

  User user = new User();
  var deviceSize;
  var clr = Colors.grey[600];
  var part;
  String rep = "";
  final _textController = new TextEditingController();

  bool verify = false;
  bool load = false;

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
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
                      "En cours .. ",
                      style: new TextStyle(
                        color: Fonts.col_app,
                      ),
                    ),
                  ],
                ),
              ),
            ));

    // Navigator.pop(context); //pop dialog
    //  _handleSubmitted();
  }

  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length <= 0)
      return "Siil vous plait entrz le numéro de téléphonne";
    else if (value.length != 10 && value.length != 12)
      return 'Le numéro de téléphone n est pas valid';
    else if (value[0] != "0" && value[0] != "+")
      return 'Le numéro de téléphone n est pas valid';

    return null;
  }

  void _handleSubmitted() async {
    print(_isChecked);

    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidate = true; // Start validating on every change.
      showInSnackBar("Veuillez corriger les erreurs en rouge");
    } else {
      print("jihad");
      //form.save();
      onLoading(context);
      String username = _namecontroller.text;
      String lastname = _precontroller.text;
      String titlr = _titrecontroller.text;
      String org = _organismecontroller.text;
      String em = _emailcontroller.text;
      String phone = _phonecontroller.text;

      print(widget.com.chef.toString());
      var desc = _desccontroller.text;

      await EmailService.sendCustomMail(
          widget.com.chef.toString(),
          "Demande de rejoindre la commission:" + widget.com.name,
          ""
          "<html><body>"
          "<ul><li>Nom: $lastname</li></ul>"
          "<ul><li>Prénom: $username</li></ul>"
          "<ul><li>Titre: $titlr</li></ul>"
          "<ul><li>Organisme: $org</li></ul>"
          "<ul><li>Email: $em</li></ul>"
          "<ul><li>Téléphone: $phone</li></ul>"
          "<ul><li>Objectifs: $desc</li></ul>"
          "<ul><li>Membre: $type</li></ul>"
          "</body></html> ");
      Navigator.pop(context);
      //Navigator.pop(context);

      _scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: new Text(
              "Votre demande sera transmise au représentant de la commission " +
                  widget.com.name +
                  ".")));
    }
  }

  Validators val = new Validators();

  ParseServer parse_s = new ParseServer();
  String code = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _namecontroller.text = widget.user.fullname;
    _precontroller.text = widget.user.firstname;
    _phonecontroller.text = widget.user.phone;
    // _titrecontroller.text=widget.user.titre; //here jiji
    _organismecontroller.text = widget.user.organisme;
    _emailcontroller.text = widget.user.email;
    _organismecontroller.text = widget.user.organisme;
  }

  @override
  Widget build(BuildContext context) {
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

    Widget obj = new Container(
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[300], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0)),
        child: Widgets.textfield_des1("Vos centres d’intérêt:", _focusdesc, "",
            _desccontroller, TextInputType.text, val.validatedesc));

    Widget commiss_widget = new Container(
        child: ExpansionTile(
            initiallyExpanded: true,
            //backgroundColor: Colors.grey[100],
            title: new Container(
                // color: Colors.grey[100],
                child: new Row(
              children: <Widget>[
                new Container(
                  width: 12.0,
                ),
                new Row(children: <Widget>[
                  new Container(
                      child: new Text(
                    "Êtes vous membre de la CGEM: ",
                    style: new TextStyle(fontSize: 15.0),
                  )),
                  new Container(width: 12.0),
                ]),
              ],
            )),
            children: [
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text("Oui"),
              new Checkbox(
                value: val1,
                onChanged: (bool value) {
                  setState(() {
                    val1 = value;
                    val2 = !value;
                    type = "Oui";
                  });
                },
              ),
              new Container(width: 16.0),
              new Text("Non"),
              new Checkbox(
                value: val2,
                onChanged: (bool value) {
                  setState(() {
                    val2 = value;
                    val1 = !value;
                    type = "Non";
                  });
                },
              )
            ],
          ),
        ]));

    Widget email = new Container(
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0)),
        child: Widgets.textfield("Email", _focusemail, user.email,
            _emailcontroller, TextInputType.emailAddress, val.validateEmail));

    Widget Nom = new Container(
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0)),
        child: Widgets.textfield("Nom", _focusname, user.fullname,
            _namecontroller, TextInputType.text, val.validatename));

    Widget prenom = new Container(
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0)),
        child: Widgets.textfield("Prénom", _focuspre, user.prenom,
            _precontroller, TextInputType.text, val.validatename));

    Widget phone = new Container(
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0)),
        child: Widgets.textfield0("GSM ( 06 ** ** ** **)", _focusphone,
            user.phone, _phonecontroller, TextInputType.phone));

    Widget organisme = new Container(
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0)),
        child: Widgets.textfield("Organisme", _focusorganise, user.organisme,
            _organismecontroller, TextInputType.text, val.validateorganisme));

    Widget titre = new Container(
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0)),
        child: Widgets.textfield("Fonction", _focustitre, "", _titrecontroller,
            TextInputType.text, val.validatetitre));

    Widget password = new Container(
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0)),
        child: new TextFormField(
            style: new TextStyle(fontSize: 15.0, color: Colors.black),
            focusNode: _focuspassword,
            obscureText: true,
            controller: _passcontroller,
            validator: val.validatePassword1,
            key: _passwordFieldKey,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: new EdgeInsets.all(8.0),
              hintText: "Mot de passe",
              hintStyle: new TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
            onFieldSubmitted: (String value) {
              setState(() {
                user.password = value;
              });
            }));

    String _validatePassword2(String value) {
      final FormFieldState<String> passwordField =
          _passwordFieldKey.currentState;
      if (passwordField.value == null || passwordField.value.isEmpty)
        return "Les mots de passe saisis ne correspondent pas";
      if (passwordField.value != value)
        return "Les mots de passe saisis ne correspondent pas";
      return null;
    }

    Widget confirmpassword = Widgets.textfield(
        "Confirmer le mot de passe",
        _focusconfirm,
        user.confirm,
        _confirmcontroller,
        TextInputType.text,
        _validatePassword2,
        obscure: true);

    var style = new TextStyle(
        color: const Color(0xffeff2f7),
        fontSize: 20.0,
        fontWeight: FontWeight.w500);

    Widget btn_log = new Padding(
        padding: new EdgeInsets.only(left: 36.0, right: 36.0),
        child: new Material(
            elevation: 12.0,
            shadowColor: Fonts.col_app,
            borderRadius: new BorderRadius.circular(12.0),
            color: Fonts.col_app,

            /*decoration: new BoxDecoration(
            border: new Border.all(color: const Color(0xffeff2f7), width: 1.5),
            borderRadius: new BorderRadius.circular(6.0)),*/
            child: new MaterialButton(
                // color:  const Color(0xffa3bbf1),
                onPressed: () {
                  _handleSubmitted();
                },
                child: new Text("Envoyer la demande", style: style))));
    deviceSize = MediaQuery.of(context).size;

    return new Scaffold(
        key: _scaffoldKey,
        body: new Center(
            child: new Container(
                decoration: new BoxDecoration(
                  color: Colors.grey[300],
                  /* image: new DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.white.withOpacity(0.7), BlendMode.dstATop),
                        image: new AssetImage("images/back.jpg"))*/
                ),
                child: new Stack(fit: StackFit.expand, children: <Widget>[
                  ListView(children: <Widget>[
                    new Container(
                        height: 700.0,
                        child: new LoginBackground(Widgets.kitGradients1))
                  ]),
                  ListView(children: <Widget>[
                    Row(children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.close),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ]),
                    Column(children: <Widget>[
                      new Padding(
                          padding: new EdgeInsets.only(
                              top: 42.0, left: 18.0, right: 18.0, bottom: 18.0),
                          child: SizedBox(
                              width: deviceSize.width * 0.98,
                              child: new Material(
                                  color: Colors.white.withOpacity(0.9),
                                  elevation: 20.0,
                                  borderRadius: new BorderRadius.circular(12.0),
                                  shadowColor: Fonts.col_app,
                                  child: new Form(
                                      key: _formKey,
                                      autovalidate: _autovalidate,
                                      //onWillPop: _warnUserAboutInvalidData,
                                      child: new Container(
                                          padding: new EdgeInsets.all(12.0),
                                          child: new Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                new Container(height: 8.0),
                                                new Center(
                                                    child: Widgets.subtitle33(
                                                        Fonts.col_app_fon,
                                                        widget.com.name)),
                                                new Container(height: 18.0),
                                                Nom,
                                                new Container(height: 8.0),
                                                prenom,
                                                new Container(height: 8.0),
                                                phone,
                                                new Container(height: 8.0),
                                                new Container(
                                                  height: 8.0,
                                                ),
                                                email,
                                                new Container(
                                                  height: 8.0,
                                                ),
                                                titre,
                                                new Container(
                                                  height: 8.0,
                                                ),
                                                organisme,
                                                new Container(
                                                  height: 8.0,
                                                ),
                                                obj,
                                                new Container(
                                                  height: 8.0,
                                                ),
                                                commiss_widget,
                                                new Container(
                                                  height: 8.0,
                                                ),
                                                btn_log,
                                                new Container(height: 8.0),
                                              ]))))))
                    ])
                  ])
                ]))));
  }
}
