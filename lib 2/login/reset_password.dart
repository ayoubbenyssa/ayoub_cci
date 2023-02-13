import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/login/login_w.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/validators.dart';
import 'package:mycgem/widgets/widgets.dart';

class Reset_Password extends StatefulWidget {
  Reset_Password(this.auth,this.onsign);
  var auth;
  var onsign;


  @override
  _Reset_PasswordState createState() => _Reset_PasswordState();
}

class _Reset_PasswordState extends State<Reset_Password> {


  Future<int> GetUserInfo(email) async {
    var response = await parse_s.getparse('users?where={"email":"$email","raja":true}&include=fonction');
    return(response["results"].length);

  }


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool _autovalidate = false;
  FocusNode _focusemail = new FocusNode();
  final _emailcontroller = new TextEditingController();
  String emailt="";
  String _authHint ="";
  ParseServer parse_s = new ParseServer();






  var style = new TextStyle(
      color: const Color(0xffeff2f7),
      fontSize: 14.0,
      fontWeight: FontWeight.w600);



  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  _onSubmit(message) {
    if (message.isNotEmpty) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text('Alert')),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children : <Widget>[
                Expanded(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,

                    ),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();

                  })
            ],
          );
        },
      );
    }
  }


  void _handleSubmitted() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidate = true; // Start validating on every change.
      showInSnackBar("Veuillez corriger les erreurs en rouge");
    } else {

    String em = _emailcontroller.text.toLowerCase();
      var response = await parse_s.getparse('users?where={"email":"$em"}&include=fonction');
      if (!this.mounted) return;

     if(response["results"].length == 0)
       {
         showInSnackBar("Vous n'êtes pas un membre! veillez s'inscrire");

         setState(() {
           _authHint = "Vous n'êtes pas un membre! veillez s'inscrire " ;
         });
       }

       else {

         FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
         var a =   _firebaseAuth.sendPasswordResetEmail(
           email: _emailcontroller.text,
         );


         _onSubmit("Un email a été envoyé à l'adresse  $em pour réintialiser votre mot de passe. ");


     }




      setState(() {
        _authHint = '';
      });


    }
  }
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    Validators val = new Validators(context: context);

    Widget email = new Container(
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey, width: 1.0),
            borderRadius: new BorderRadius.circular(12.0)),
        child: Widgets.textfield("Email", _focusemail, emailt,
            _emailcontroller, TextInputType.emailAddress, val.validateEmail));


    return new Scaffold(
        key: _scaffoldKey,
        body: new Center(
            child: new Container(
                decoration: new BoxDecoration(
                    /*image: new DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.white.withOpacity(0.3), BlendMode.dstATop),
                        image: new AssetImage("images/back.jpg"))*/),
                child: new Stack(fit: StackFit.expand, children: <Widget>[
                  ListView(children: <Widget>[
                    new Container(
                        height: 700.0,
                        child: new LoginBackground(Widgets.kitGradients))
                  ]),
                  ListView(children: <Widget>[
                    Row(children: <Widget>[ IconButton(icon: Icon(Icons.close),color: Colors.white,
                        onPressed: (){
                          Navigator.pop(context);
                        })]),
                    Column(children: <Widget>[
                      new Padding(
                          padding: new EdgeInsets.only(
                              top: 52.0, left: 18.0, right: 18.0, bottom: 18.0),
                          child: SizedBox(
                              width: deviceSize.width * 0.98,
                              child: new Material(
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
                                                    child: Widgets.subtitle3(
                                                        Fonts.col_app_fon)),
                                                new Container(
                                                  height: 24.0,
                                                ),
                                                email,
                                                new Container(height: 24.0,),
                                         _authHint.toString()==""?new Container():new Center(child: new Text(_authHint.toString())),
                                         new Container(
                                          height: 40.0,
                                         // padding: new EdgeInsets.only(left: 6.0, right: 6.0),
                                          child: new Material(
                                              elevation: 2.0,
                                              shadowColor: Fonts.col_app_fonn,
                                              borderRadius: new BorderRadius.circular(8.0),
                                              color: Fonts.col_app_fonn,
                                              /*decoration: new BoxDecoration(
            border: new Border.all(color: const Color(0xffeff2f7), width: 1.5),
            borderRadius: new BorderRadius.circular(6.0)),*/
                                              child: new MaterialButton(
                                                // color:  const Color(0xffa3bbf1),
                                                  onPressed: () {
                                                    _handleSubmitted();
                                                  },
                                                  child: new Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[

                                                      new Container(width: 8.0,),
                                                      //  new Container(height: 36.0,color: Colors.white,width: 1.5,),
                                                      new Container(width: 8.0,),
                                                      new Text("Envoyer   ", style: style)
                                                    ],) )))

                                              ]))))))
                    ])
                  ])
                ]))));
  }
}
