import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/login/login_entreprise.dart';
import 'package:mycgem/login/login_w.dart';
import 'package:mycgem/models/membre.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/email_verify_services.dart';
import 'package:mycgem/services/routes.dart';
import 'package:mycgem/services/send_email_service.dart';
import 'package:mycgem/services/validators.dart';
import 'package:mycgem/widgets/custom_widgets/primary_button.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:random_string/random_string.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Email_Verify extends StatefulWidget {
  Email_Verify(this.chng);

  var chng;

  @override
  _Email_VerifyState createState() => _Email_VerifyState();
}

class _Email_VerifyState extends State<Email_Verify> {
  final _contactcontroller = new TextEditingController();
  FocusNode _focuscontact = new FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool _autovalidate = false;
  String _authHint = "";
  bool load = false;
  String code = "";
  final _textController = new TextEditingController();
  User contact;

  void change(Membre cc) {
    setState(() {
      contact.entreprise = cc;
    });
  }

  send_code(User contact) async {
    setState(() {
      load = true;
    });

    print("yess");
    code = randomNumeric(8);

    print(code);
    /**
     *
        Nous vous prions de bien vouloir saisir
        le"code de vérification " + code pour confirmer votre inscription à MyCGEM, l'application 100% dédiée à la communauté des affaires.
     */
    await EmailService.sendCustomMail3(
        _contactcontroller.text,
        "Code de vérification CCIS Connect",
        """Bonjour ${contact?.civilite == "M." ? "Monsieur " : contact?.civilite == "Mme" ? "Madame " : ""}${contact.fullname.toUpperCase()},<br><br>
            
        Nous vous prions de bien vouloir saisir le code de vérification $code pour confirmer votre inscription à MyCGEM, l'application 100% dédiée à la communauté des affaires.<br><br>
        Cordialement,<br>
        L'équipe MyCGEM<br>
        
         """);
    setState(() {
      load = false;

      _authHint = "";
    });

    contact.new_membre = false;

    _showDialog(contact, email: _contactcontroller.text);
    /*_showDialog(
        "Nous avons envoyé un code de vérificaton à ce compte " +
            email.toString().substring(0, 4) +
            "*************@" +
            email.split("@")[1] +
            " , veuillez entrer le "
                "code de vérification ici ! ",
        contact,
        email: email,
        id: id);*/
  }

  show_list(List<Membre> list) async {
    await await showDialog<bool>(
        context: context,
        builder: (BuildContext context) => new AlertDialog(
              title: Text(""),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              actions: <Widget>[
                FlatButton(
                  child: const Text('Annuler'),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).accentColor,
                  onPressed: () {
                    Navigator.pop(context);
                    //widget.onCancel();
                  },
                ),
                FlatButton(
                  child: const Text('Choisir'),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).accentColor,
                  onPressed: () {
                    print("yess");
                    var js_org = {
                      "membre": {
                        "__type": "Pointer",
                        "className": "membres",
                        "objectId": '${contact.entreprise.objectId}'
                      }
                    };

                    parse_s.putparse('users/' + contact.id, js_org);

                    send_code(contact);
                    Navigator.pop(context);
                  },
                ),
              ],
              content: ListEnt(list, change),
            ));
  }

  _showDialog(User contact, {email}) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) => new AlertDialog(
        contentPadding: const EdgeInsets.all(24.0),
        content: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Afin de vérifier votre appartenance à ${contact.entreprise.name},  "
                          "un email de validation a été envoyé à votre administrateur de compte sur le mail " +
                      _contactcontroller.text.toString().substring(0, 4) +
                      "*************@" +
                      _contactcontroller.text.split("@")[1] +
                      ". sa validation est "
                          "nécessaire avant que vous puissiez rejoindre la communauté CCIS!",
                  textAlign: TextAlign.justify,
                  style: new TextStyle(
                      height: 1.2,
                      fontSize: 16.5,
                      fontWeight: FontWeight.w700,
                      color: Fonts.col_ap_fonn),
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
                        decoration: new InputDecoration(
                            hintText: "Entrer le code de vérification"),
                      ),
                    )
                  ],
                ),
              ],
            )),
        actions: <Widget>[
          new Container(
              padding: EdgeInsets.only(top: 42.h),
              child: new Material(
                  elevation: 12.0,
                  shadowColor: clr,
                  borderRadius: new BorderRadius.circular(12.0),
                  color: clr,
                  child: new MaterialButton(
                      child: new Text(
                        "Vérification",
                        style: style,
                      ),
                      onPressed: () async {
                        if (code == _textController.text) {
                          Navigator.pop(context);
                          setState(() {
                            _authHint = "Votre compte a été vérifié";
                          });

                          try {
                            contact.email = email;
                            Routes.goto(context, "register", null, null, [],
                                null, widget.chng,
                                id_ent: contact.entreprise.objectId,
                                contact: contact);

                            /* */
                          } catch (e) {
                            Navigator.pop(context);
                            print('Error: $e');
                          }
                        } else {
                          // Navigator.pop(context);

                          _scaffoldKey.currentState.showSnackBar(new SnackBar(
                            content: new Text("Code incorrect!"),
                          ));
                        }
                      }))),
        ],
      ),
    );
  }

  getcontactbyemail(email) async {
    setState(() {
      load = true;
    });
    dynamic result = await EmailverifyServices.get_contact_by_email(email);
    if (!this.mounted) return;

    if (result == "No internet" || result == "error") return;

    if (result.length > 0) {
      contact = new User.fromMap(result[0]);

      List<Membre> result_membres =
          await EmailverifyServices.get_members_by_email(email);
      if (!this.mounted) return;
      print("jijiyaya");

      if (result_membres.length > 0) {
        print("jijiyaya");
        print(result_membres.length);

        show_list(result_membres);
      } else {
        send_code(contact);
      }

      //
      setState(() => load = false);
    } else {
      setState(() {
        load = false;
      });
      Navigator.push(context,
          new MaterialPageRoute(builder: (BuildContext context) {
        return LoginEntreprise(widget.chng, _contactcontroller.text);
      }));
    }
  }

  /**
   *
      Container(
      padding: EdgeInsets.only(
      left: 16.0, right: 16.0),
      child: RichText(
      textAlign:
      TextAlign.justify,
      text: new TextSpan(
      text: "",
      children: <TextSpan>[
      new TextSpan(
      text:
      "Si vous n'avez pas trouvé votre organisme sur la liste, ",
      style: TextStyle(
      color: Colors
      .grey[600],
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
      color:
      Colors.blue,
      fontSize: 16.0,
      fontWeight:
      FontWeight
      .w500))
      ],
      ))),
   */

  ParseServer parse_s = new ParseServer();

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

  void _handleSubmitted() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidate = true; // Start validating on every change.
      //showInSnackBar("Veuillez corriger les erreurs en rouge");
    } else {
      setState(() {
        _authHint = "";
      });
      String emaill = _contactcontroller.text
          .toString()
          .toLowerCase()
          .replaceAll(new RegExp(r"\s+"), "");

      print(emaill);
      var a = await parse_s
          .getparse('users?where={"email":"${emaill}","active":1}');

      print(a);

      if (a == "error" || a == "No") return;
      setState(() {
        load = false;
      });

      print(a["results"]);
      if (a["results"].length > 0) {
        alert_login();
      } else {
        getcontactbyemail(_contactcontroller.text);
      }
    }
  }

  var style = new TextStyle(
      color: const Color(0xffeff2f7),
      fontSize: 20.0,
      fontWeight: FontWeight.w500);
  var clr = Fonts.col_app_fon;

  @override
  Widget build(BuildContext context) {
    Validators val = new Validators(context: context);

    Widget btn_log = Container(
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
                onPressed: () {
                  _handleSubmitted();
                },
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  load
                      ? Container(
                          width: 20,
                          height: 20,

                          // padding: EdgeInsets.all(8),
                          child: CircularProgressIndicator(
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.white),
                          ))
                      : Container(),
                  load
                      ? Container(
                          width: 12,
                        )
                      : Container(),
                  new Text("Enregistrer".toUpperCase(), style: style)
                ]))))*/
        ;

    Widget contact = Widgets.textfield("Email", _focuscontact, "",
        _contactcontroller, TextInputType.emailAddress, val.validateEmail);

    Widget hintText() {
      return _authHint == ""
          ? new Container()
          : new Container(
              //height: 80.0,
              padding: const EdgeInsets.all(32.0),
              child: new Text(_authHint,
                  key: new Key('hint'),
                  style: new TextStyle(
                      height: 1.2,
                      fontSize: 16.5,
                      fontWeight: FontWeight.w700,
                      color: Fonts.col_ap_fonn),
                  textAlign: TextAlign.justify));
    }

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
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 36.w),
                        child: new Material(
                            elevation: 1,
                            borderRadius: new BorderRadius.circular(16.0),
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Form(
                                  key: _formKey,
                                  autovalidate: _autovalidate,
                                  child: Column(
                                    children: [
                                      new Container(height: 46.0.h),
                                      Widgets.subtitle5(Fonts.col_app_fonn,
                                          "Saisissez votre adresse e-mail professionnel"),
                                      new Container(height: 16.0),
                                      Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.w),
                                          child: contact),
                                      Container(
                                        height: 8,
                                      ),
                                      hintText(),
                                      Container(
                                        height: 16,
                                      ),
                                      btn_log,
                                      Container(
                                        height: 12.h,
                                      )
                                    ],
                                  )),
                            )),
                      ),
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

                    ],
                  )),

              Expanded(
                child: Container(),
              ),
              Center(
                child: Container(
                    width: 258.w,
                    child: Image.asset("assets/images/logo_bk.png")),
              ),
              Container(
                height: 56.h,
              )
            ])));
  }
}

class ListEnt extends StatefulWidget {
  ListEnt(this.list, this.change);

  List<Membre> list;
  var change;

  @override
  _ListEntState createState() => _ListEntState();
}

class _ListEntState extends State<ListEnt> {
  int _selected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Divider(),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.4,
              ),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RadioListTile(
                        title: Text(widget.list[index].name),
                        value: index,
                        groupValue: _selected,
                        onChanged: (value) {
                          setState(() {
                            _selected = index;
                            widget.change(widget.list[index]);
                          });
                        });
                  }),
            ),
            Divider(),
            TextField(
              autofocus: false,
              maxLines: 1,
              style: TextStyle(fontSize: 18),
              decoration: new InputDecoration(
                border: InputBorder.none,
                hintText: "",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
