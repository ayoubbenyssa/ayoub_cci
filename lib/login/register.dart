import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycgem/entreprise/resp_list.dart' as prefix0;
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/login/list_fonctions.dart';
import 'package:mycgem/login/login_w.dart';
import 'package:mycgem/models/alphabets.dart';
import 'package:mycgem/models/fonction.dart';
import 'package:mycgem/models/membre.dart';
import 'package:mycgem/models/partner.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/pages/conditions.dart';
import 'package:mycgem/pages/politique.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/auth.dart';
import 'package:mycgem/services/block.dart';
import 'package:mycgem/services/login_services.dart';
import 'package:mycgem/services/send_email_service.dart';
import 'package:mycgem/services/validators.dart';
import 'package:mycgem/widgets/custom_widgets/primary_button.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

class Register extends StatefulWidget {
  Register(
      this.list_partner, this.analytics, this.chng, this.id_ent, this.contact);

  List list_partner;
  var analytics;
  var chng;
  String id_ent;
  User contact;

  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Register> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  FocusNode _focuspassword = new FocusNode();
  FocusNode _focusemail = new FocusNode();
  FocusNode _focusname = new FocusNode();
  FocusNode _focustitre = new FocusNode();
  FocusNode _focusorganise = new FocusNode();
  FocusNode _focuspre = new FocusNode();
  FocusNode _focusphone = new FocusNode();
  FocusNode _focusconfirm = new FocusNode();
  final _confirmcontroller = new TextEditingController();
  bool _isChecked = false;
  bool _isChecked1 = false;
  bool val1 = false;
  String type_civil = "";
  bool val2 = false;
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      new GlobalKey<FormFieldState<String>>();
  String _authHint = '';
  final _passcontroller = new TextEditingController();
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
    final regexp = RegExp(r'^[0|212|+212][0-9]{9}$');
    if (value.length <= 0)
      return "Entrez le numéro de téléphonne";
    else if (!regexp.hasMatch(value) || value.length > 10) {
      return 'Veuillez renseigner un numéro de téléphone valide selon le format 06xxxxxxxx';
    }
    return null;
  }

  void _handleSubmitted() async {
    if (_isChecked.toString() == "false") {
    } else {
      final FormState form = _formKey.currentState;
      if (!form.validate()) {
        _autovalidate = true; // Start validating on every change.
        showInSnackBar("Veuillez corriger les erreurs en rouge");
      } else {
        onLoading(context);
        try {
          //RegisterService.onLoading(context);
          AuthResult userId = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _emailcontroller.text.replaceAll(' ', ''),
                  password: _passcontroller.text);
          String alpha = _precontroller.text[0].toString().toLowerCase();
          /*await Block.insert_block(
              userId.user.uid, userId.user.uid, null, null);*/

          await RegisterService.insert_user(
              _precontroller.text,
              _namecontroller.text,
              _emailcontroller.text,
              context,
              userId.user.uid,
              Alphabets.list[0][alpha],
              _titrecontroller
                  .text /*widget.contact.objectId == '' ? widget.contact.fonction : ""*/,
              widget.contact.entreprise == null
                  ? ""
                  : widget.contact.entreprise
                      .name /* widget.contact.objectId == '' ? widget.contact.organisme : ""*/,
              null,
              null,
              widget.list_partner,
              widget.analytics,
              widget.chng,
              membre_new: widget.contact.new_membre,
              verify_code: widget.contact.verify_code,
              fonction: widget.contact.fonction,

              ///if the organisme is newly created
              verify: rep,
              contact_id: widget.contact== null?widget.id_ent: widget.contact.id,
              id_ent: widget.id_ent,
              phone: _phonecontroller.text,
              resp: type);
          //Communities

          /***
           * jiya
           */
          /*  Navigator.pushReplacement(context,
              new MaterialPageRoute(builder: (BuildContext context) {
                return new Communities(widget.auth, widget.onSignedIn,
                    widget.list_partner,widget.analytics);
              }));*/

          //widget.onSignedIn();
        } catch (e) {
          Navigator.pop(context);
          print('Error: $e');

          if (e.message.toString() ==
              "The email address is already in use by another account.") {
            setState(() {
              _authHint = "Cet email est déja utilisé par un autre compte";
            });
          }

          print(e.message.toString());
        }
      }
    }
  }

  _onChecked(value) {
    setState(() {
      _isChecked = value;
      print(_isChecked);
    });
    if (_isChecked.toString() == "false") {
      setState(() {
        clr = Colors.grey[600];
      });
    } else {
      setState(() {
        clr = Fonts.col_app_fon;
      });
    }

    if (value == true)
      setState(() {
        value = false;
      });
    else
      setState(() {
        value = true;
      });
  }

  bool ch = false;
  List type = [];

  Widget tpe_profile() => type == "Laquelle ??"
      ? Container()
      : new InkWell(
          child: new Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(bottom: 8),
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
              child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(width: 8.0),
                    new Container(
                        child: new Text(
                            type.toString() != "[]" && type.toString() != "null"
                                ? type[1].toString()
                                : "Choisir une responsabilté",
                            style: new TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600]))),
                    new Expanded(child: new Container()),
                    new Icon(
                      Icons.arrow_drop_down,
                      color: Fonts.col_app_fon,
                    )
                  ])),
          onTap: () {
            resp();
          });

  resp() async {
    // Navigator.pop(widget.context);
    type = await Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new prefix0.RespList(null, null);
    }));

    setState(() {
      type = type;

      print("99999");

      print(type);

      if (type.length == 2) {
        print(type[0]);
        print(type[1]);
      }
    });
  }

  _onChecked1(value) {
    setState(() {
      _isChecked1 = value;
    });
    if (_isChecked1.toString() == "false") {
      setState(() {
        ch = false;
      });
    } else {
      setState(() {
        ch = true;
      });
    }
  }

  check() => new Checkbox(
        activeColor: Colors.grey,
        value: _isChecked,
        onChanged: (bool value) {
          print(value);
          _onChecked(value);
        },
      );

  check1() => new Checkbox(
        activeColor: Colors.blue,
        value: _isChecked1,
        onChanged: (bool value) {
          print(value);
          _onChecked1(value);
        },
      );

  _showDialog(text, {result}) async {
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
                  text,
                  textAlign: TextAlign.justify,
                ),
                verify == true
                    ? new Row(
                        children: <Widget>[
                          Container(
                            height: 16.0,
                          ),
                          new Expanded(
                            child: new TextFormField(
                              autofocus: true,
                              controller: _textController,
                              decoration: new InputDecoration(
                                  hintText: 'Code de vérification'),
                            ),
                          )
                        ],
                      )
                    : Container(),
              ],
            )),
        actions: <Widget>[
          new FlatButton(
              child: new Text(verify == true ? "Vérification" : 'Ok'),
              onPressed: () async {
                if (verify == true) {
                  if (code == _textController.text) {
                    Navigator.pop(context);
                    setState(() {
                      rep = "Votre compte a été vérifié";
                    });

                    onLoading(context);
                    try {
                      //RegisterService.onLoading(context);
                      AuthResult userId = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: _emailcontroller.text,
                              password: _passcontroller.text);
                      String alpha =
                          _precontroller.text[0].toString().toLowerCase();
                      await Block.insert_block(
                          userId.user.uid, userId.user.uid, null, null);

                      print("--------------------------------------");
                      print(part);

                      await RegisterService.insert_user(
                          _precontroller.text,
                          _namecontroller.text,
                          _emailcontroller.text,
                          context,
                          userId.user.uid,
                          Alphabets.list[0][alpha],
                          "",
                          "",
                          null,
                          null,
                          widget.list_partner,
                          widget.analytics,
                          widget.chng,
                          verify: rep,
                          id_ent: part,
                          phone: _phonecontroller.text,
                          resp: type);
                      //Communities

                      /***
                       * jiya
                       */
                      /*  Navigator.pushReplacement(context,
              new MaterialPageRoute(builder: (BuildContext context) {
                return new Communities(widget.auth, widget.onSignedIn,
                    widget.list_partner,widget.analytics);
              }));*/

                      //widget.onSignedIn();
                    } catch (e) {
                      Navigator.pop(context);
                      print('Error: $e');

                      if (e.message.toString() ==
                          "The email address is already in use by another account.") {
                        setState(() {
                          _authHint =
                              "Cet email est déja utilisé par un autre compte";
                        });
                      }

                      print(e.message.toString());
                    }
                  } else {
                    // Navigator.pop(context);

                    _scaffoldKey.currentState.showSnackBar(new SnackBar(
                      content: new Text("Code incorrect!"),
                    ));
                  }
                } else {
                  Navigator.pop(context);
                }
              }),
        ],
      ),
    );
  }

  ParseServer parse_s = new ParseServer();
  String code = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _emailcontroller.text = widget.contact.email;

    _namecontroller.text = widget.contact.fullname.toString() == "null"
        ? ""
        : widget.contact.fullname.toString();
    _precontroller.text = widget.contact.firstname.toString() == "null"
        ? ""
        : widget.contact.firstname.toString();
    setState(() {
      _titrecontroller.text = widget.contact.entreprise.toString() == "null"
          ? ""
          : widget.contact.entreprise.fonction.toString();
    });

    if (widget.contact.civilite == "Mme") {
      setState(() {
        val2 = true;
        type_civil = "Mme";
      });
    } else if (widget.contact.civilite == "M.") {
      setState(() {
        val1 = true;
        type_civil = "M.";
      });
    }

    // _fir.text= widget.contact.name[1];
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

    Widget email = Widgets.textfield("Email", _focusemail, user.email,
        _emailcontroller, TextInputType.emailAddress, val.validateEmail);

    Widget Nom = Widgets.textfield("Nom", _focusname, user.fullname,
        _namecontroller, TextInputType.text, val.validatename);

    Widget prenom = Widgets.textfield("Prénom", _focuspre, user.prenom,
        _precontroller, TextInputType.text, val.validatename);

    /* Widget phone = new Container(
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0)),
        child: Widgets.textfield0("GSM ( 06 ** ** ** **)", _focusphone,
            user.phone, _phonecontroller, TextInputType.phone));
*/
    Widget organisme = Widgets.textfield(
        "Organisme",
        _focusorganise,
        user.organisme,
        _organismecontroller,
        TextInputType.text,
        val.validateorganisme);

    Widget titre = Widgets.textfield("Fonction", _focustitre, "",
        _titrecontroller, TextInputType.text, val.validatetitre);

    Widget password = new TextFormField(
        style: new TextStyle(fontSize: 15.0, color: Colors.black),
        focusNode: _focuspassword,
        obscureText: true,
        controller: _passcontroller,
        validator: val.validatePassword1,
        key: _passwordFieldKey,
        decoration: InputDecoration(
          // border: InputBorder.none,
          contentPadding: new EdgeInsets.all(8.0),
          hintText: "Mot de passe",
          errorMaxLines: 2,
          hintStyle: new TextStyle(
              fontSize: 15.0, fontWeight: FontWeight.w500, color: Colors.grey),
        ),
        onFieldSubmitted: (String value) {
          setState(() {
            user.password = value;
          });
        });

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

    Widget btn_log = Align(
            alignment: Alignment.center,
            child: Container(
                width: 160.w,
                child: PrimaryButton(
                  onTap: () {
                    _handleSubmitted();
                  },
                  icon: "",
                  disabledColor: Fonts.col_grey,
                  fonsize: 15.5.sp,
                  prefix: Container(),
                  color: Fonts.col_app_fon,
                  isLoading: false,
                  text: LinkomTexts.of(context).sve(),
                ))) /*new Padding(
        padding: new EdgeInsets.only(left: 36.0, right: 36.0, top: 12),
        child: new Material(
            elevation: 12.0,
            shadowColor: clr,
            borderRadius: new BorderRadius.circular(12.0),
            color: clr,

            /*decoration: new BoxDecoration(
            border: new Border.all(color: const Color(0xffeff2f7), width: 1.5),
            borderRadius: new BorderRadius.circular(6.0)),*/
            child: new MaterialButton(
                // color:  const Color(0xffa3bbf1),
                onPressed: () {
                  _handleSubmitted();
                },
                child: new Text(LinkomTexts.of(context).sve(), style: style))))*/
        ;
    deviceSize = MediaQuery.of(context).size;

    return new Scaffold(
        key: _scaffoldKey,
        body: new Container(
            decoration: new BoxDecoration(
                /*image: new DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.white.withOpacity(0.7), BlendMode.dstATop),
                        image: new AssetImage("images/back.jpg"))*/
                ),
            child: ListView(children: <Widget>[
              Row(children: <Widget>[
                IconButton(
                    icon: Icon(Icons.close),
                    color: Fonts.col_app_fon,
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ]),
              new Padding(
                  padding: new EdgeInsets.only(
                      left: 36.0.w, right: 36.0.w, bottom: 12.0),
                  child: new Form(
                      key: _formKey,
                      autovalidate: _autovalidate,
                      //onWillPop: _warnUserAboutInvalidData,
                      child: new Container(
                          padding: new EdgeInsets.all(12.0),
                          child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                      width: 78.w,
                                      height: 78.w,
                                      child: Image.asset(
                                        "assets/images/logo1.png",
                                        width: 78.w,
                                      )),
                                ),
                                new Container(
                                  height: ScreenUtil().setHeight(18),
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Créer un compte ',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: const Color(0xff218bb1),
                                        fontWeight: FontWeight.w700,
                                      ),
                                      softWrap: false,
                                    )),
                                /*  new Container(height: 8.0),
                                    new Center(
                                        child: Widgets.subtitle2(
                                            Fonts.col_app_fon)),*/
                                hintText(),
                                new Container(height: 18.0),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Civilité:",
                                      style: new TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 15.6),
                                    ),
                                    Expanded(child: Container()),
                                    civility,
                                    Expanded(child: Container()),
                                  ],
                                ),

                                Nom,
                                new Container(height: 8.0),
                                prenom,
                                new Container(height: 8.0),
                                //phone,
                                //new Container(height: 8.0),
                                /* Container(
                                                  child: Text(
                                                    "Mentionnez votre mail professionnel pour "
                                                    "activer automatiquement votre compte premium MyCGEM",
                                                    style: TextStyle(
                                                        color: Fonts.col_app),
                                                  ),
                                                ),*/

                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: email,
                                ),
                                /*Container(
                                                      width: 2,
                                                    ),
                                                    RaisedButton(
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      color: Fonts.col_app,
                                                      child: Row(
                                                        children: <Widget>[
                                                          Text(
                                                            "Vérifier",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          load
                                                              ? CircularProgressIndicator(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                )
                                                              : Container()
                                                        ],
                                                      ),
                                                      onPressed: () {
                                                        verifyy();
                                                      },
                                                    )*/
                                new Container(
                                  height: 8.0,
                                ),
                                _titrecontroller.text != ""
                                    ? AbsorbPointer(child: titre)
                                    : GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            _authHint = "";
                                          });

                                          print("dyeyye");
                                          Fonction vi =
                                              await Navigator.push(context,
                                                  new MaterialPageRoute(builder:
                                                      (BuildContext context) {
                                            return new ListFonctions();
                                          }));

                                          _titrecontroller.text = vi.name;
                                          widget.contact.fonction = vi;
                                        },
                                        child: AbsorbPointer(child: titre)),
                                new Container(
                                  height: 8.0,
                                ),
                                ch ? tpe_profile() : Container(),
                                password,
                                new Container(height: 8.0),
                                confirmpassword,
                                new Container(height: 8.0),
                                new Row(
                                  children: <Widget>[
                                    check(),
                                    new Container(
                                        width: 240.0,
                                        child: new RichText(
                                          text: new TextSpan(
                                            text: "J'accèpte les ",
                                            style: new TextStyle(
                                              color: Fonts.col_app_fon,
                                              fontFamily: 'coffee',
                                            ),
                                            children: <TextSpan>[
                                              new TextSpan(
                                                  recognizer: new TapGestureRecognizer()
                                                    ..onTap = () => Navigator.push(
                                                        context,
                                                        new MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                new Conditions())),
                                                  text:
                                                      "conditions d'utilisation",
                                                  style: new TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Fonts.col_app,
                                                    decoration: TextDecoration.underline,

                                                    fontFamily: 'coffee',
                                                  )),
                                              new TextSpan(text: ' et la '),
                                              new TextSpan(
                                                  recognizer: new TapGestureRecognizer()
                                                    ..onTap = () => Navigator.push(
                                                        context,
                                                        new MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                new Potique())),
                                                  text:
                                                      "politique de confidentialité",
                                                  style: new TextStyle(
                                                    decoration: TextDecoration.underline,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'coffee',
                                                      color: Fonts.col_app)),
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                                new Container(height: 12.0),

                                btn_log,
                                new Container(height: 12.0),
                              ]))))
            ])));
  }
}
