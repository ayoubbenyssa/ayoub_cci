import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:mycgem/login/login_w.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:share/share.dart';
import 'package:mycgem/widgets/widgets.dart';

class Invitrefriends extends StatefulWidget {
  @override
  _InvitrefriendsState createState() => _InvitrefriendsState();
}

class _InvitrefriendsState extends State<Invitrefriends> {
  @override
  Widget build(BuildContext context) {
    var style = new TextStyle(
        color: const Color(0xffeff2f7),
        fontSize: 20.0,
        fontWeight: FontWeight.w500);

    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Fonts.col_app_fon,
          title: new Text(""),
          elevation: 0.0,
        ),
        body: new Container(
          decoration: new BoxDecoration(
            color: Colors.grey[300],
            /* image: new DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Colors.white.withOpacity(0.1), BlendMode.dstATop),
                  image: new AssetImage("images/back.jpg"))*/
          ),
          child: new Stack(fit: StackFit.expand, children: <Widget>[
            ListView(children: <Widget>[
              new Container(
                  height: 700.0,
                  child: new LoginBackground(
                    Widgets.kitGradients1,
                    showIcon: false,
                  ))
            ]),
            new Container(
                padding: new EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.08,
                    top: 120.0,
                    left: 24.0,
                    right: 24.0),
                child: new Card(
                    child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(height: 48.0),

                    new Image.asset(
                      "assets/images/logo.png",
                      width: 150.0,
                      height: 150.0,
                    ),
                    Container(height: 18.0),

                    Container(
                        padding: EdgeInsets.all(8),
                        child: new Text(
                          "Invitez vos contacts ?? rejoindre CCIS ",
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                              color: Colors.grey[800],
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        )),

                    Container(height: 12.0),
                    //new Text(,textAlign:TextAlign.center,style: new TextStyle(color: Fonts.col_app,fontWeight: FontWeight.w600,fontSize: 14.0,),),
                    new Container(
                      height: 0.0,
                    ),

                    new Padding(
                        padding: new EdgeInsets.only(
                            left: 36.0, right: 36.0, top: 12),
                        child: new Material(
                            elevation: 12.0,
                            shadowColor: Fonts.col_app_fon,
                            borderRadius: new BorderRadius.circular(12.0),
                            color: Fonts.col_app_fon,

                            /*decoration: new BoxDecoration(
            border: new Border.all(color: const Color(0xffeff2f7), width: 1.5),
            borderRadius: new BorderRadius.circular(6.0)),*/
                            child: new MaterialButton(
                                // color:  const Color(0xffa3bbf1),
                                onPressed: () {
                                  Share.share(
                                      """Je t'invite ?? rejoindre CCIS, l'application 100% d??di??e ?? la communaut?? des affaires.

Cette application te permettra de :

???	suivre l???actualit?? de la Conf??d??ration, des Commissions permanentes, des f??d??rations statutaires et des CGEM-R??gions et recevoir des alertes ;
???	suivre les ??v??nements organis??s par la CCIS et vous y inscrire ;
???	publier votre actualit?? et vos ??v??nements sur votre profil ;
???	publier et saisir des opportunit??s d???affaires ; 
???	vous connecter aux autres membres selon plusieurs crit??res (r??gion, f??d??ration, commission, centre d???int??r??t) et leur envoyer des messages ;
???	profiter de l???offre de services de la Conf??d??ration en quelques clics.

Lien Appstore :  ; Lien Google store :
                                  """);
                                },
                                child: new Text("PARTAGER", style: style))))
                  ],
                )))
          ]),
        ) /**/);
  }
}
