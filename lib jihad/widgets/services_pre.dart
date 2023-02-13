import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/home/conventions.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/language_params/scope_model_wrapper.dart';
import 'package:mycgem/models/serv.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/widgets/app_appbar.dart';
import 'package:mycgem/widgets/common.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServicesPre extends StatefulWidget {
  ServicesPre(this.lat, this.lng, this.user, this.chng);

  var lat, lng;
  User user;
  var chng;

  @override
  _ServicesPreState createState() => _ServicesPreState();
}

class _ServicesPreState extends State<ServicesPre> {
  ParseServer services = new ParseServer();
  List<Serv> serv = new List<Serv>();
  bool load = true;

  getservices() async {
    var a = await services.getparse("services?order=order");
    if (!this.mounted) return;
    List res = a["results"];
    print("<3");
    print(res);
    List<dynamic> list =
    res.map((var contactRaw) => new Serv.fromMap(contactRaw)).toList();
    setState(() {
      serv = list;
      load = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getservices();
  }

  texts(String id) {
    String text;
    switch (id) {
      case 'kJvbP2p48V':
        text = LinkomTexts.of(context).details();
        break;

      case 'rRWuwJAXga':
      //https://coronavirus.cgem.ma/corridors-by-cgem/
        text = "Je bénéficie des Corridors";
        break;

      case 'siAOwGGsXX':
        text = LinkomTexts.of(context).details();
        break;

      default:
        text = "";
        break;

    //
    }

    return text.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: load
            ? Center(
          child: Widgets.load(),
        )
            : ListView(
            padding: EdgeInsets.only(top: 6),
            children: serv
                .map((Serv a) => Padding(
                padding: EdgeInsets.all(2),
                child: ScopedModelDescendant<AppModel1>(
                    builder: (context, child, model) => Card(
                        elevation: 0,
                        color: Colors.white,
                        child: Theme(
                            data: Theme.of(context).copyWith(
                                accentColor: Fonts.col_app_fon),
                            child: new ExpansionTile(
                              title: Row(
                                children: [
                                  a.img == ""
                                      ? Container()
                                      : Image.network(
                                    a.img,
                                    width: 50,
                                  ),
                                  Container(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.67,
                                      padding: EdgeInsets.all(8),
                                      child: Text(
                                        model.locale == "ar"
                                            ? a.name_ar
                                            : a.name,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: Fonts.col_ap_fonn,
                                            fontSize: 16.5.sp,
                                            fontWeight:
                                            FontWeight.w700),
                                      ))
                                ],
                              ),
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(12),
                                  color: Colors.white,
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        model.locale == "ar"
                                            ? a.desc_ar
                                            : a.desc,
                                        style: TextStyle(
                                            height: 1.4,
                                            color: Colors.grey[600]),
                                      ),
                                      Row(
                                        mainAxisAlignment: a.id ==
                                            "siAOwGGsXX"
                                            ? MainAxisAlignment.center
                                            : MainAxisAlignment.end,
                                        children: <Widget>[
                                          a.id == "siAOwGGsXX"
                                              ? Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              children: [
                                                Column(
                                                  children: [
                                                    Material(
                                                        borderRadius:
                                                        BorderRadius.all(Radius.circular(
                                                            22)),
                                                        elevation:
                                                        2,
                                                        child: ClipRRect(
                                                          //<--clipping image
                                                            borderRadius: BorderRadius.all(Radius.circular(22)),
                                                            child: Container(
                                                                height: MediaQuery.of(context).size.width * 0.26,
                                                                width: MediaQuery.of(context).size.width * 0.26,
                                                                child: FadingImage.network(
                                                                  "https://firebasestorage.googleapis.com/v0/b/cgembusiness-5e7e3.appspot.com/o/logo%20rse%20200x300-01.jpg?alt=media&token=632783f7-a00b-466e-a17f-d04115512360",
                                                                  height: MediaQuery.of(context).size.width * 0.28,
                                                                  width: MediaQuery.of(context).size.width * 0.26,
                                                                  fit: BoxFit.cover,
                                                                )))),
                                                    Container(
                                                      height: 8.h,
                                                    ),
                                                    RaisedButton(
                                                        color: Fonts
                                                            .col_app_fon,
                                                        child:
                                                        Text(
                                                          "Label RSE",
                                                          style: TextStyle(
                                                              color:
                                                              Colors.white),
                                                        ),
                                                        shape: new RoundedRectangleBorder(
                                                            borderRadius: new BorderRadius.all(Radius.circular(
                                                                8.0))),
                                                        onPressed:
                                                            () {
                                                          Navigator.push(
                                                              context,
                                                              new MaterialPageRoute<String>(builder:
                                                                  (BuildContext context) {
                                                                return new WebviewScaffold(
                                                                  url:
                                                                  a.lien,
                                                                  appBar:
                                                                  new MyCgemBarApp(
                                                                    "Label RSE",
                                                                    actionswidget: Container(),
                                                                  ),
                                                                );
                                                              }));
                                                        }),
                                                  ],
                                                ),
                                                Container(
                                                  width: 10.w,
                                                ),
                                                Column(
                                                  children: [
                                                    Material(
                                                        borderRadius:
                                                        BorderRadius.all(Radius.circular(
                                                            22)),
                                                        elevation:
                                                        2,
                                                        child: ClipRRect(
                                                          //<--clipping image
                                                            borderRadius: BorderRadius.all(Radius.circular(22)),
                                                            child: Container(
                                                                height: MediaQuery.of(context).size.width * 0.26,
                                                                width: MediaQuery.of(context).size.width * 0.26,
                                                                child: FadingImage.network(
                                                                  "https://firebasestorage.googleapis.com/v0/b/cgembusiness-5e7e3.appspot.com/o/tahceine-1-611a437a5f2e2.png?alt=media&token=5ec197db-0876-4b10-a48b-75e55b293849",
                                                                  height: MediaQuery.of(context).size.width * 0.28,
                                                                  width: MediaQuery.of(context).size.width * 0.26,
                                                                  fit: BoxFit.contain,
                                                                )))),
                                                    Container(
                                                      height: 8.h,
                                                    ),
                                                    RaisedButton(
                                                        color: Fonts
                                                            .col_app_fon,
                                                        child:
                                                        Text(
                                                          "Label Imanor",
                                                          style: TextStyle(
                                                              color:
                                                              Colors.white),
                                                        ),
                                                        shape: new RoundedRectangleBorder(
                                                            borderRadius: new BorderRadius.all(Radius.circular(
                                                                8.0))),
                                                        onPressed:
                                                            () {
                                                          //

                                                          Navigator.push(
                                                              context,
                                                              new MaterialPageRoute<String>(builder:
                                                                  (BuildContext context) {
                                                                return new WebviewScaffold(
                                                                  url:
                                                                  "https://www.imanor.gov.ma/label-tahceine/",
                                                                  appBar:
                                                                  new MyCgemBarApp(
                                                                    "Label Imanor",
                                                                    actionswidget: Container(),
                                                                  ),
                                                                );
                                                              }));
                                                        }),
                                                  ],
                                                ),
                                                Container(
                                                  width: 10.w,
                                                ),
                                                Column(
                                                  children: [
                                                    Material(
                                                        borderRadius:
                                                        BorderRadius.all(Radius.circular(
                                                            22)),
                                                        elevation:
                                                        2,
                                                        child: ClipRRect(
                                                          //<--clipping image
                                                            borderRadius: BorderRadius.all(Radius.circular(22)),
                                                            child: Container(
                                                                height: MediaQuery.of(context).size.width * 0.26,
                                                                width: MediaQuery.of(context).size.width * 0.26,
                                                                child: FadingImage.network(
                                                                  "https://firebasestorage.googleapis.com/v0/b/cgembusiness-5e7e3.appspot.com/o/220217%20LABEL%20TAMYIZ%20I%20PANTONE%20(1).png?alt=media&token=3467054b-f8a4-4ee2-9fed-6d052ff8a633",
                                                                  height: MediaQuery.of(context).size.width * 0.28,
                                                                  width: MediaQuery.of(context).size.width * 0.26,
                                                                  fit: BoxFit.contain,
                                                                )))),
                                                    Container(
                                                      height: 8.h,
                                                    ),
                                                    RaisedButton(
                                                        color: Fonts
                                                            .col_app_fon,
                                                        child:
                                                        Text(
                                                          "Label Tamyiz",
                                                          style: TextStyle(
                                                              color:
                                                              Colors.white),
                                                        ),
                                                        shape: new RoundedRectangleBorder(
                                                            borderRadius: new BorderRadius.all(Radius.circular(
                                                                8.0))),
                                                        onPressed:
                                                            () {
                                                          //

                                                          Navigator.push(
                                                              context,
                                                              new MaterialPageRoute<String>(builder:
                                                                  (BuildContext context) {
                                                                return new WebviewScaffold(
                                                                  url:
                                                                  "https://www.fcs.ma/labellisation",
                                                                  appBar:
                                                                  new MyCgemBarApp(
                                                                    "Label Tamyiz",
                                                                    actionswidget: Container(),
                                                                  ),
                                                                );
                                                              }));
                                                        }),
                                                  ],
                                                )
                                              ])
                                              : texts(a.id) == ""
                                              ? Container(
                                            child: Container(
                                                width: MediaQuery.of(
                                                    context)
                                                    .size
                                                    .width *
                                                    0.9,
                                                child: RichText(
                                                    textAlign: TextAlign.left,
                                                    text: new TextSpan(
                                                      text:
                                                      "",
                                                      children: <
                                                          TextSpan>[
                                                        new TextSpan(
                                                          text:
                                                          "Pour plus d'informations, contactez-nous à : ",
                                                          style:
                                                          TextStyle(color: Colors.grey[600], fontSize: 15),
                                                        ),
                                                        new TextSpan(
                                                            text: //(dans une entreprise déjà inscrite au niveau de la plateforme)
                                                            "adherents@cgem.ma",
                                                            recognizer: new TapGestureRecognizer()
                                                              ..onTap = () {
                                                                final Uri _emailLaunchUri = Uri(
                                                                  scheme: 'mailto',
                                                                  path: 'adherents@cgem.ma',
                                                                );

// ...

                                                                launch(_emailLaunchUri.toString());
                                                              },
                                                            style: new TextStyle(decoration: TextDecoration.underline, color: Colors.blue, fontSize: 16.0, fontWeight: FontWeight.w500))
                                                      ],
                                                    ))),
                                          )
                                              : RaisedButton(
                                            color: Fonts
                                                .col_app_fon,
                                            shape: new RoundedRectangleBorder(
                                                borderRadius: new BorderRadius
                                                    .all(
                                                    Radius.circular(
                                                        8.0))),
                                            onPressed: () {
                                              if (a.name.contains(
                                                  "Avantages+")) {
                                                Navigator.push(
                                                    context,
                                                    new MaterialPageRoute(builder:
                                                        (BuildContext
                                                    context) {
                                                      return Scaffold(
                                                          appBar:
                                                          MyCgemBarApp(
                                                            "Avantages+ by CGEM",
                                                            actionswidget:
                                                            Container(),
                                                          ),
                                                          body:
                                                          new Conventions(
                                                            widget
                                                                .lat,
                                                            widget
                                                                .lng,
                                                            widget
                                                                .user,
                                                            null,
                                                            null,
                                                            "cgem",
                                                            widget
                                                                .chng,
                                                          ));
                                                    }));
                                              } else
                                                Navigator.push(
                                                    context,
                                                    new MaterialPageRoute<
                                                        String>(
                                                        builder:
                                                            (BuildContext context) {
                                                          return new WebviewScaffold(
                                                            url: a
                                                                .lien,
                                                            appBar:
                                                            new AppBar(
                                                              iconTheme:
                                                              IconThemeData(color: Fonts.col_app_fonn),
                                                              backgroundColor:
                                                              Fonts.col_app_shadow,
                                                              title:
                                                              new Text(
                                                                model.locale == "ar"
                                                                    ? a.name_ar
                                                                    : a.name,
                                                                style: TextStyle(
                                                                    color: Fonts.col_app_fonn,
                                                                    fontWeight: FontWeight.w500),
                                                              ),
                                                            ),
                                                          );
                                                        }));
                                            },
                                            child: Text(
                                              texts(a.id),
                                              style: TextStyle(
                                                  color: Colors
                                                      .white,
                                                  fontWeight:
                                                  FontWeight
                                                      .w600),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ))))))
                .toList()));
  }
}
