import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/login/create_new_entreprise.dart';
import 'package:mycgem/models/membre.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/contacts_services.dart';
import 'package:mycgem/services/routes.dart';
import 'package:mycgem/services/send_email_service.dart';
import 'package:mycgem/user/edit_my_profile.dart';
import 'package:mycgem/widgets/custom_widgets/primary_button.dart';
import 'package:random_string/random_string.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/login/login_w.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/validators.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'list_entreprise_inscription.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginEntreprise extends StatefulWidget {
  LoginEntreprise(this.chng, this.email);

  var chng;
  String email;

  bool show_myprofile = true;

  @override
  _InvitrefriendsState createState() => _InvitrefriendsState();
}

class _InvitrefriendsState extends State<LoginEntreprise> {
  final _titrecontroller = new TextEditingController();
  final _namecontroller = new TextEditingController();
  final _contactcontroller = new TextEditingController();

  final _raisonc = new TextEditingController();
  FocusNode _focustitre = new FocusNode();

  final _organismecontroller = new TextEditingController();
  Membre type_profile;

  Membre type;
  FocusNode _focusraison = new FocusNode();
  FocusNode _focusname = new FocusNode();
  FocusNode _focuscontact = new FocusNode();
  String email = "";
  String id = "";
  FocusNode _focusorganise = new FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  String _authHint = '';
  ParseServer parse_s = new ParseServer();
  String id_organisme;

  ///User contactt;

  ///List<Contact> contacts = [];
  String choice_email = "";

  var my_id = "";

  getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    my_id = prefs.getString("id");
  }

  bool yes_or = false;


  sub() {
    Navigator.pushReplacement(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new CreateNewEntrepriseForm(widget.email, id, widget.chng);
    }));
  }

  /* gotoprofile() {
    Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) =>
              //new HomePage(widget.auth,widget.sign)
              new EditMyProfile(
                  /*com,*/
                  null,
                  null,
                  [],
                  widget.chng,
                  true),
        ));
  }*/

  /*update_user_entreprise(id, entreprise) async {
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
  }*/

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

  Widget tpe_profile() => new InkWell(
      child: new Container(
          margin: EdgeInsets.only(left: 1.0, right: 12.0),
          decoration: new BoxDecoration(
              color: Fonts.col_app_shadow,
              borderRadius: new BorderRadius.circular(24.0)),
          height: 40.0,
          child: new Row(children: <Widget>[
            new Container(width: 16.0),
            new Container(
                child: new Text(
                    type_profile.toString() != "null"
                        ? type_profile.name.toString()
                        : LinkomTexts.of(context).cent(),
                    style: new TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        color: Fonts.col_grey2))),
            new Container(
              width: 4.0,
            ),
            new Container(
              width: 8.0,
            ),
            new Expanded(child: new Container()),
            new SvgPicture.asset(
              "assets/icons/arrow_b.svg",
            ),
            new Container(
              width: 16.0,
            ),
          ])),
      onTap: () {
        goto_types();
      });

  String code = "";

  bool load = false;
  bool verify = false;
  String rep = "";
  final _textController = new TextEditingController();

  _showDialog(text, User contact, {email, id}) async {
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
                verify == true || verify2 == true
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
              child: new Text(
                  verify == true || verify2 == true ? "Vérification" : 'Ok'),
              onPressed: () async {
                if (verify == true || verify2 == true) {
                  if (code == _textController.text) {
                    Navigator.pop(context);
                    setState(() {
                      rep = "Votre compte a été vérifié";
                    });

                    try {
                      /*await RegisterService.insert_user(
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
                          part: part,
                          phone: _phonecontroller.text,
                          resp: type);
                      //Communities*/

                      /***
                       * jiya
                       */
                      /*  Navigator.pushReplacement(context,
              new MaterialPageRoute(builder: (BuildContext context) {
                return new Communities(widget.auth, widget.onSignedIn,
                    widget.list_partner,widget.analytics);
              }));*/

                      //widget.onSignedIn();

                      print('gooooooooooooooooooooooooo');
                      print(email);
                      contact.email = email;
                      contact.new_membre = false;
                      Routes.goto(context, "register", null, null, [], null,
                          widget.chng,
                          id_ent: id, contact: contact);

                      /* */
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

  onchanged(emai) {
    email = emai;
  }

  alert_login() {
    Alert(
        context: context,
        title: "",
        content: Column(
          children: <Widget>[
            Text("Cet email est déja utilisé par un autre compte ! "),
            Container(
              height: 16,
            ),
            new InkWell(
                onTap: () {
                  Routes.goto(
                    context,
                    "reset",
                    null,
                    null,
                    [],
                    null,
                    widget.chng,
                  );
                },
                child: new Row(
                  children: <Widget>[
                    new Expanded(child: new Container()),
                    new Text(
                      LinkomTexts.of(context).forgot_pass(),
                      style: new TextStyle(
                          color: Colors.grey[700],
                          decoration: TextDecoration.underline),
                    )
                  ],
                )),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(
              "LOGIN",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  send_code(User contact) async {
    setState(() {
      load = true;
    });

    print("yess");
    print(code);

    await EmailService.sendCustomMail(
        email,
        "Code de vérification",
        ""
                "Code de vérification " +
            code);
    setState(() {
      load = false;
    });

    _showDialog(
        "Nous avons envoyé un code de vérificaton à ce compte " +
            email.toString().substring(0, 4) +
            "*************@" +
            email.split("@")[1] +
            " , veuillez entrer le "
                "code de vérification ici ! ",
        contact,
        email: email,
        id: id);
  }

  dialogContent(BuildContext context, User contact) async {
    return await showDialog(
        builder: (BuildContext context) => Container(
            height: 300,
            margin: EdgeInsets.only(top: 50.0, bottom: 50.0),
            alignment: Alignment.center,
            child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                elevation: 25.0,
                backgroundColor: Colors.white,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(5.0),
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.close,
                          color: Colors.grey,
                          size: 20.0,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                        color: Colors.white,
                        child: Text(
                            'Vous voulez recevoir votre code sur quelle adresse ?',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Container(
                        height: 32,
                      ),
                      Expanded(
                        child: new MyDialogContent(contact.emails,
                            onchanged: onchanged), //Custom ListView
                      ),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: FlatButton(
                          color: Fonts.col_app_fon,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                            ),
                          ),
                          onPressed: () async {
                            print(email);

                            Navigator.pop(context);

                            var a = await parse_s.getparse(
                                'users?where={"email":"$email"}&include=fonction');

                            if (a == "error" || a == "No") return;
                            setState(() {
                              load = false;
                            });

                            if (a["results"].length > 0) {
                              alert_login();
                            } else {
                              send_code(contact);
                            }
                          },
                          //color: AppColors.dialogTitleColor,
                          textColor: Colors.black,
                          child: Text(
                            "Envoyer le code",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w800),
                            // fontWeight: FontWeight.bold,
                            //fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ))));
  }

  void _handleSubmitted(id, User contact) async {
    code = randomNumeric(8);

    if (contact.emails.length == 0) {
      email = contact.emails[0];
      send_code(contact);
    } else if (contact.emails.length == 1) {
      email = contact.emails[0];
      send_code(contact);
    } else {
      dialogContent(context, contact);
    }

    /* */
  }

  bool verify2 = false;

  goto_types() async {
    setState(() {
      verify = false;
      verify2 = false;
      _authHint = "";
    });
    // Navigator.pop(widget.context);
    type = await showModalBottomSheet<Membre>(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (BuildContext context) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.84,
              child: new EntreproseListInscription(widget.email));
        });
    /*Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return new EntreproseListInscription(widget.email);
    }));*/
    setState(() {
      type_profile = type;
    });

    /* contacts =
        await Contacts_services.get_list_contacts_by_id_membre(type.objectId);
    setState(() {
      type_profile = type;
      print(contacts.length);

      if (contacts.length == 0) {
        setState(() {
          _authHint = "Aucun représentant trouvé !";
        });
      } else if (contacts.length == 1) {
        setState(() {
          verify2 = true;
          email = contacts[0].email;
          contactt = contacts[0];
          id = type_profile.objectId;
        });
      } else {
        email = contacts[0].email;
        id = type_profile.objectId;
        contactt = contacts[0];

        setState(() {
          verify = true;
        });
      }
    });*/
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getId();

    _contactcontroller.text = widget.email;
  }


  @override
  Widget build(BuildContext context) {
    Validators val = new Validators(context: context);

    /*  Widget organisme = new Container(
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
            val.validateorganisme));*/

    gooo() async {
      email = widget.email;
      var a = await parse_s.getparse('users?where={"email":"$email"}');

      if (a == "error" || a == "No") return;
      setState(() {
        load = false;
      });

      if (a["results"].length > 0) {
        alert_login();
      } else {
        ///  _handleSubmitted(id, contactt);
        ///  contact.new_membre= null;

        /// contact.email = email;
        Routes.goto(context, "register", null, null, [], null, widget.chng,
            id_ent: type_profile.objectId,
            contact: User(
                id: "",
                new_membre: false,
                //  na: "",
                email: widget.email,
                // titre: "", //here jiji
                entreprise: type_profile));
      }
    }

    var style = new TextStyle(
        color: const Color(0xffeff2f7),
        fontSize: 20.0,
        fontWeight: FontWeight.w500);
    var clr = Fonts.col_app_fon;

    Widget btn_log = Container(
            width: 160.w,
            child: PrimaryButton(
              onTap: () {
                gooo();
              },
              icon: "",
              disabledColor: Fonts.col_grey,
              fonsize: 15.5,
              prefix: Container(),
              color: Fonts.col_app,
              isLoading: load,
              text: "Confirmer",
            )) /*new Padding(
        padding: new EdgeInsets.only(left: 36.0, right: 36.0),
        child: new Material(
            elevation: 12.0,
            shadowColor: clr,
            borderRadius: new BorderRadius.circular(12.0),
            color: clr,
            child: new MaterialButton(
                // color:  const Color(0xffa3bbf1),
                onPressed: () async {
                  print(email);

                  gooo();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    load
                        ? new Container(
                            width: 26.0,
                            height: 26.0,
                            child: new CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                              strokeWidth: 2.0,
                            ))
                        : new Container(),
                    load
                        ? Container(
                            width: 8,
                          )
                        : Container(),
                    Container(),
                    new Text(LinkomTexts.of(context).confirm(), style: style)
                  ],
                ))))*/
        ;

    return Scaffold(
        key: _scaffoldKey,
        body: new Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/images/background.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(children: <Widget>[
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
              new Padding(
                  padding: new EdgeInsets.only(
                      top: 104.0.h, left: 24.0.w, right: 24.0.w, bottom: 18.0),
                  child: Stack(children: [
                    Container(
                        padding: EdgeInsets.only(top: 36.w),
                        child: new Material(
                            elevation: 1,
                            borderRadius: new BorderRadius.circular(16.0),
                            color: Colors.white,
                            child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: new Form(
                                    key: _formKey,
                                    autovalidate: _autovalidate,
                                    //onWillPop: _warnUserAboutInvalidData,
                                    child: new Column(
                                        //mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          new Container(height: 46.0.h),
                                          new Center(
                                              child: Widgets.subtitle5(

                                                  Fonts.col_app_fonn,
                                                  "Choisir votre organisme")),
                                          new Container(height: 12.0),
                                          hintText(),
                                          //   titre,
                                          Container(
                                            height: 12.0,
                                          ),

                                          tpe_profile(),
                                          Container(
                                            height: 12.0,
                                          ),

                                          Container(
                                            height: 12,
                                          ),
                                          type_profile.toString() != "null"
                                              ? Container()
                                              : yes_or == true
                                                  ? Container()
                                                  : yes_or == true
                                                      ? Container()
                                                      : Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 16.0,
                                                                  right: 16.0),
                                                          child: RichText(
                                                              textAlign:
                                                                  TextAlign
                                                                      .justify,
                                                              text:
                                                                  new TextSpan(
                                                                text: "",
                                                                children: <
                                                                    TextSpan>[
                                                                  new TextSpan(
                                                                    text:
                                                                        "Si vous n'avez pas trouvé votre organisme sur la liste, ",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "coffee",
                                                                        color: Fonts
                                                                            .col_grey2,
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                  new TextSpan(
                                                                      text: //(dans une entreprise déjà inscrite au niveau de la plateforme)
                                                                          "cliquez ici pour l'ajouter  ",
                                                                      recognizer:
                                                                          new TapGestureRecognizer()
                                                                            ..onTap =
                                                                                () {
                                                                              sub();
                                                                            },
                                                                      style: new TextStyle(
                                                                          fontFamily:
                                                                              "coffee",
                                                                          decoration: TextDecoration
                                                                              .underline,
                                                                          color: Fonts
                                                                              .col_gr,
                                                                          fontSize:
                                                                              16.0,
                                                                          fontWeight:
                                                                              FontWeight.w900))
                                                                ],
                                                              ))),

                                          Container(
                                            height: 16,
                                          ),
                                          btn_log,
                                          new Container(
                                            height: 24.0,
                                          ),
                                        ]))))),
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
                  ])),
              Expanded(child: Container(),),
              Center(child: Container(

                  width: 258.w,
                  child: Image.asset("assets/images/logo_bk.png")),),
              Container(height: 56.h,)
            ])));
  }
}

class MyDialogContent extends StatefulWidget {
  MyDialogContent(this.items, {this.onchanged});

  List<String> items;
  var onchanged;

  @override
  _MyDialogContentState createState() => new _MyDialogContentState();
}

class _MyDialogContentState extends State<MyDialogContent> {
  List<CustomRowModel> sampleData = new List<CustomRowModel>();

  @override
  void initState() {
    super.initState();

    for (String item in widget.items) {
      sampleData.add(CustomRowModel(title: item, selected: false));
    }
    /*sampleData.add(CustomRowModel(title: "Marathi", selected: false));
    sampleData.add(CustomRowModel(title: "English", selected: false));
    sampleData.add(CustomRowModel(title: "Hindi", selected: false));
    sampleData.add(CustomRowModel(title: "Kannada", selected: false));
    sampleData.add(CustomRowModel(title: "Telugu", selected: false));
    sampleData.add(CustomRowModel(title: "Gujarathi", selected: false);
        sampleData.add(CustomRowModel(title: "Rajsthani", selected: false);
    sampleData.add(CustomRowModel(title: "Punjabi", selected: false));*/
  }

  @override
  Widget build(BuildContext context) {
    return sampleData.length == 0
        ? Container()
        : Container(
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey,
              ),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: sampleData.length,
              itemBuilder: (BuildContext context, int index) {
                return new InkWell(
                  //highlightColor: Colors.red,
                  //splashColor: Colors.blueAccent,
                  onTap: () {
                    setState(() {
                      sampleData.forEach((element) => element.selected = false);
                      sampleData[index].selected = true;
                    });
                    widget.onchanged(sampleData[index].title);
                  },
                  child: new CustomRow(sampleData[index]),
                );
              },
            ),
          );
  }
}

class CustomRowModel {
  bool selected;
  String title;

  CustomRowModel({this.selected, this.title});
}

class CustomRow extends StatelessWidget {
  final CustomRowModel model;

  CustomRow(this.model);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0, right: 8.0, top: 3.0, bottom: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
// I have used my own CustomText class to customise TextWidget.
          Text(
            model.title,
          ),
          this.model.selected
              ? Icon(
                  Icons.radio_button_checked,
                  color: Fonts.col_app,
                )
              : Icon(Icons.radio_button_unchecked),
        ],
      ),
    );
  }
}
