import 'package:flutter/material.dart';
import 'package:mycgem/home/search_entreprise.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/search/list_users_results.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SearchWidget extends StatefulWidget {
  SearchWidget(this.user, this.list, this.lat, this.lng, this.analytics,
      this.bl, this.chng,
      {Key key})
      : super(key: key);
  var user;
  var list;
  var lat;
  var lng;
  var analytics;
  var bl;
  var chng;

  @override
  _StateSearchWidget createState() => _StateSearchWidget();
}

class _StateSearchWidget extends State<SearchWidget> {
  var text = new TextEditingController();
  FocusNode focus = new FocusNode();

  bool val1 = true;
  bool val2 = false;
  bool val = true;
  String type = "Utilisateur";

  func(a) {
    setState(() {
      type = a;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(

        height: MediaQuery.of(context).size.height * 0.06,
        padding: EdgeInsets.only(right: 16),
        //height: ,

        child: Center(
            child: Card(
          color: Fonts.col_grey.withOpacity(0.18),
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
          ),
          child: InkWell(
              onTap: () {
                Alert(
                    context: context,
                    title: "RECHERCHE",
                    content: Column(
                      children: <Widget>[
                        Container(height: 12),
                        TextFormField(
                          style: new TextStyle(
                            color: Fonts.col_app_fon,
                          ),

                          controller: text,
                          //focusNode: focus,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: Fonts.col_app_fon,
                            ),

                            //  contentPadding: EdgeInsets.all(8),
                            //   border: InputBorder.none, hintText: "Chercher .."),
                            counterStyle:
                                TextStyle(color: const Color(0xffeff6fb)),
                            contentPadding: EdgeInsets.all(6.0),
                            hintText: LinkomTexts.of(context).search() + '  ..',
                            /* enabledBorder: OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderSide:
                          BorderSide(color: Colors.grey[50], width: 0.0),
                      borderRadius: BorderRadius.circular(60.0),
                    ),*/
                            hintStyle: TextStyle(
                              color: Fonts.col_app_fon,
                            ),
                          ),
                          onFieldSubmitted: (String text) {
                            if (text.length > 0) {
                              Navigator.push(context, new MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return new UserListsResults(
                                  text,
                                  widget.user,
                                  widget.list,
                                  widget.analytics,
                                  widget.lat,
                                  widget.lng,
                                  widget.bl,
                                  null,
                                  widget.chng,
                                );
                              }));
                            }
                          },
                        ),
                        Container(
                          height: 16,
                        ),
                        Choices(val1, val2, func),
                        Container(
                          height: 16,
                        ),
                      ],
                    ),
                    buttons: [
                      DialogButton(
                        onPressed: () {
                          print("jdjdjjdjdjjdjdjdj");
                          Navigator.pop(context);
                          var tex = text.text;
                          setState(() {
                            text.text = "";
                          });

                          print(type);
                          if (type == "Utilisateur") {
                            Navigator.push(context, new MaterialPageRoute(
                                builder: (BuildContext context) {
                              return new UserListsResults(
                                tex,
                                widget.user,
                                widget.list,
                                widget.analytics,
                                widget.lat,
                                widget.lng,
                                widget.bl,
                                null,
                                widget.chng,
                              );
                            }));
                          } else {
//

                            Navigator.push(context, new MaterialPageRoute(
                                builder: (BuildContext context) {
                              return new ListsResultsEntreprises(
                                tex,
                                widget.user,
                                widget.list,
                                widget.analytics,
                                widget.lat,
                                widget.lng,
                                widget.bl,
                                null,
                                widget.chng,
                              );
                            }));
                          }

                          /* setState(() {
                      text.text = "";
                    });*/
                        },
                        child: Text(
                          LinkomTexts.of(context).search(),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )
                    ]).show();
              },
              // padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 12,
                      ),
                      GestureDetector(
                        child: Icon(
                          Icons.search,
                          color: Fonts.col_app_fon,
                        ),
                        onTap: () {},
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Container(
                            padding: EdgeInsets.all(4),
                            //   margin: EdgeInsets.only(bottom: 8),
                            child: Text(
                              LinkomTexts.of(context).search() + " ..",
                              style: TextStyle(color: Fonts.col_app_fonn),
                            )),
                      ),
                      /*InkWell(
              onTap: () {
                //Navigator.of(context).push(
                  //  MaterialPageRoute(builder: (context) => SettingsScreen()));
              },
              child: Icon(
                Icons.search,
                color: Colors.black54,
              ),
            ),*/
                    ],
                  ),

                  //  Container(height: 0.8,width: 50,color: Colors.white,)
                ],
              )),
        )));
  }
}

class Choices extends StatefulWidget {
  Choices(this.val1, this.val2, this.func);

  bool val1 = true;
  bool val2 = false;
  var func;

  @override
  _ChoicesState createState() => _ChoicesState();
}

class _ChoicesState extends State<Choices> {
  @override
  Widget build(BuildContext context) {
    return new Container(
        child: Column(
            //backgroundColor: Colors.grey[100],
            children: [
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                "Utilisateur",
                style: TextStyle(fontSize: 14),
              ),
              new Checkbox(
                value: widget.val1,
                onChanged: (bool value) {
                  setState(() {
                    widget.val1 = value;
                    widget.val2 = !value;
                    widget.func("Utilisateur");
                  });
                },
              ),
              new Container(width: 16.0),
              new Text(
                "Entreprise",
                style: TextStyle(fontSize: 14),
              ),
              new Checkbox(
                value: widget.val2,
                onChanged: (bool value) {
                  setState(() {
                    widget.val2 = value;
                    widget.val1 = !value;
                    widget.func("Entreprise");
                  });
                },
              )
            ],
          ),
        ]));
    ;
  }
}
