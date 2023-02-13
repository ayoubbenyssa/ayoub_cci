import 'package:flutter/material.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/validators.dart';
import 'package:mycgem/widgets/widgets.dart';

class PhoneWidget extends StatefulWidget {
  PhoneWidget(this.user);

  User user;

  @override
  _InfoUser1State createState() => _InfoUser1State();
}

class _InfoUser1State extends State<PhoneWidget> {
  final _bioctrl = new TextEditingController();
  FocusNode _biofocus = new FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool _autovalidate = false;
  ParseServer parse_s = new ParseServer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _bioctrl.text = widget.user.phone;
  }

  @override
  Widget build(BuildContext context) {
    Validators val = new Validators(context: context);

    Widget bio = Widgets.textfield(
        "Entrez votre numéro de téléphone",
        _biofocus,
        widget.user.bio,
        _bioctrl,
        TextInputType.phone,
        val.validatephonenumber);

    return new WillPopScope(
        onWillPop: () {

            Navigator.pop(context, widget.user);
        },
        child: Scaffold(
            appBar: new AppBar(
              title: new Text("Numéro de téléphone"),
              actions: <Widget>[
                new IconButton(
                    icon: new Icon(Icons.check),
                    onPressed: () async {

                      final FormState form = _formKey.currentState;
                      if (!form.validate()) {
                        _autovalidate = true;
                      } // Start validating on every change.
                      else {
                        widget.user.phone = _bioctrl.text;
                        var js = {"phone": widget.user.phone};

                        await parse_s.putparse("users/" + widget.user.id, js);
                        Navigator.pop(context, widget.user);
                      }
                    })
              ],
            ),
            body: new Form(
                key: _formKey,
                autovalidate: _autovalidate,
                //onWillPop: _warnUserAboutInvalidData,
                child: Center(
                  child: new ListView(
                    padding: new EdgeInsets.all(16.0),
                    children: <Widget>[
                      new Container(
                        height: 16.0,
                      ),
                      bio
                    ],
                  ),
                ))));
  }
}
