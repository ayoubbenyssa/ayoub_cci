import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:intl/intl.dart';
import 'package:mycgem/services/app_services.dart';
import 'package:mycgem/services/send_email_service.dart';

class SenderPage extends StatefulWidget {
  SenderPage(this.user, this.user_me, this.connect_action, {Key key})
      : super(key: key);
  User user;
  User user_me;

  var connect_action;

  @override
  _EditorPageState createState() => _EditorPageState();
}

class _EditorPageState extends State<SenderPage> {
  String _subject = 'Objet';
  static const Color chipBackground = Color(0xFFEEF1F3);
  final _titrecontroller = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titrecontroller.text = "Bonjour je souhaite me connecter à vous.";
  }

  @override
  Widget build(BuildContext context) {
    //final EmailModel emailModel = Provider.of<EmailModel>(context);
    String fabIcon = 'assets/images/ic_edit.png';
    const Color nearlyWhite = Color(0xFFFEFEFE);

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          margin: const EdgeInsets.all(4),
          color: nearlyWhite,
          child: Material(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _subjectRow,
                  /* Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Demande envoyée !",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Fonts.col_app_green),
                      )),*/
                  Container(
                    height: 12,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Envoyer un message à " +
                            AppServices.capitalizeFirstofEach(
                                widget.user.firstname?.toLowerCase()) +
                            " " +
                            widget.user.fullname.toString().toUpperCase(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                  _spacer,
                  _senderAddressRow,
                  _spacer,
                  _recipientRow,
                  _spacer,
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextField(
                      controller: _titrecontroller,
                      minLines: 6,
                      maxLines: 20,
                      decoration:
                          InputDecoration.collapsed(hintText: 'Message'),
                      autofocus: false,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontSize: 16.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String getKey() => widget.user_me.auth_id + "_" + widget.user.auth_id;

  String getKey1() => widget.user.auth_id + "_" + widget.user_me.auth_id;

  static const Color spacer = Color(0xFFF2F2F2);

  static const Color lightText = Color(0xFF4A6572);

  Widget get _spacer {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(width: double.infinity, height: 1, color: spacer),
    );
  }

  Widget get _subjectRow {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
          Expanded(child: Text("", style: Theme.of(context).textTheme.title)),
          IconButton(
            onPressed: () {
              if (widget.user.active != 1) {
                EmailService.sendCustomMail3(
                    (widget.user.emails == null ||
                            widget.user.emails.toString() == "0")
                        ? widget.user.email
                        : widget.user.emails[0],
                    "Demande de connexion à CCIS Connect",
                    """Bonjour ${widget.user?.civilite == "M." ? "Monsieur " : widget.user?.civilite == "Mme" ? "Madame " : ""}${widget.user.fullname.toUpperCase()}, <br><br>


${AppServices.capitalizeFirstofEach(widget.user_me.firstname?.toLowerCase())} ${widget.user_me.fullname.toUpperCase()} souhaite rejoindre votre réseau sur MyCGEM, l'application 100% dédiée à la communauté des affaires. <br><br>


Cordialement,<br>
L'équipe MyCGEM
                     """);
              } else {
                _subject =
                    _subject == "Objet" ? _titrecontroller.text : _subject;
                DatabaseReference gMessagesDbRef2 = FirebaseDatabase.instance
                    .reference()
                    .child("room_medz")
                    .child(getKey());
                gMessagesDbRef2.set({
                  "token": widget.user_me.token,
                  "name": widget.user_me.firstname +
                      " " +
                      widget.user_me.fullname.toString().toUpperCase(),
                  widget.user_me.auth_id: true,
                  "lastmessage": _subject,
                  "key": getKey(),
                  "me": false,
                  "timestamp":
                      ServerValue.timestamp /*new DateTime.now().toString()*/,
                });

                FirebaseDatabase.instance
                    .reference()
                    .child("room_medz")
                    .child(getKey1())
                    .set({
                  "token": widget.user.token,
                  widget.user.auth_id: true,
                  "lastmessage": _subject,
                  "key": getKey1(),
                  "me": false,
                  "timestamp":
                      ServerValue.timestamp /*new DateTime.now().toString()*/,
                });

                var gMessagesDbRef = FirebaseDatabase.instance
                    .reference()
                    .child("message_medz")
                    .child(getKey());
                var gMessagesDbRef_inv = FirebaseDatabase.instance
                    .reference()
                    .child("message_medz")
                    .child(getKey1());
                if (_titrecontroller.text != "") {
                  gMessagesDbRef.push().set({
                    'timestamp': ServerValue.timestamp,
                    'messageText': _titrecontroller.text,
                    'idUser': widget.user_me.auth_id,
                  });

                  gMessagesDbRef_inv.push().set({
                    'timestamp': ServerValue.timestamp,
                    'messageText': _titrecontroller.text,
                    'idUser': widget.user_me.auth_id,
                  });
                }
                widget.connect_action();
              }

              _scaffoldKey.currentState.showSnackBar(new SnackBar(
                  backgroundColor: Fonts.col_gr,
                  content: new Text(
                    "Demande envoyée",
                    style: TextStyle(color: Colors.white),
                  )));

              new Timer(new Duration(seconds: 2), () {
                Navigator.of(context).pop();
              });
            },
            icon: Image.asset(
              'images/send.png',
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
    );
  }

  List<String> list = [
    "Offres d'affaires",
    "Opportunités de carrière",
    "Offres de conseil",
    "Demande d'expertise",
    "Autre"
  ];

  Widget get _senderAddressRow {
    return PopupMenuButton<String>(
      padding: EdgeInsets.zero,
      offset: Offset(0, 100),
      onSelected: (String obj) {
        setState(() {
          _subject = obj;
        });
      },
      itemBuilder: (BuildContext context) => list
          .map((String a) => PopupMenuItem<String>(
                value: a,
                child: Text(a, style: Theme.of(context).textTheme.subtitle),
              ))
          .toList(),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 12, top: 16, right: 10, bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: Text(_subject,
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 14))),
            const Icon(
              Icons.arrow_drop_down,
              color: lightText,
              size: 28,
            )
          ],
        ),
      ),
    );
  }

  Widget get _recipientRow {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Wrap(
              children: <Widget>[
                Chip(
                    backgroundColor: chipBackground,
                    padding: EdgeInsets.zero,
                    avatar: CircleAvatar(
                      backgroundImage: NetworkImage(widget.user.image),
                    ),
                    label: Text(
                        AppServices.capitalizeFirstofEach(
                                widget.user.firstname?.toLowerCase()) +
                            " " +
                            widget.user.fullname.toString().toUpperCase(),
                        style: Theme.of(context).textTheme.subtitle)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
