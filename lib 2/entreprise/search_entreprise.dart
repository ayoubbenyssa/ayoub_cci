import 'package:flutter/material.dart';
import 'package:mycgem/home/search_entreprise.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/search/list_users_results.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SearchWidgetEntreprise extends StatefulWidget {
  SearchWidgetEntreprise(this.user, this.list, this.lat, this.lng, this.analytics,
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

class _StateSearchWidget extends State<SearchWidgetEntreprise> {
  var text = new TextEditingController();
  FocusNode focus = new FocusNode();



  @override
  Widget build(BuildContext context) {
    return Container(

        height: MediaQuery.of(context).size.height * 0.06,
        padding: EdgeInsets.only(right: 0),
        //height: ,

        child: Center(
            child: Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              child: InkWell(
                  onTap: () {
                    Alert(
                        context: context,
                        title: "Rechercher un organisme ",
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

