import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:mycgem/communities/ville_list.dart';
import 'package:mycgem/login/pays_list.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as clientHttp;

class Add_formation extends StatefulWidget {

  @override
  _Add_formationState createState() => _Add_formationState();
}

class _Add_formationState extends State<Add_formation> {
  final _intitulecontroller = new TextEditingController();
  FocusNode _focusintitule = new FocusNode();

  FocusNode _focusedesc = new FocusNode();
  final _desccontroller = new TextEditingController();

  FocusNode _focuspa = new FocusNode();
  final _pacontroller = new TextEditingController();

  final _vicontroller = new TextEditingController();

  String _authHint = '';

  String ss_region_id = "";
  String ville_id = "";
  List<String> type = [];

  DateTime date = DateTime.now();

  FocusNode _focusville = new FocusNode();

  FocusNode _focusetell = new FocusNode();
  final _tellcontroller = new TextEditingController();

  FocusNode _focuseemal = new FocusNode();
  final _emailcontroller = new TextEditingController();

  paramsparsejson() {
    return {
      "X-Parse-Application-Id": "C9EcHeKgPkRnUrWtYw3y5A8DaFcJfMhQmSp",
      "Content-Type": 'applicaton/json',
      'X-Parse-Master-Key': 'nTrWtYw3y5A8DaFcJfMhPmSpUsXuZw4z6B8'
    };
  }

  Map<String, Object> add_formation = {
    'date_formation': '',
    'telephone': '',
    'payante': '',
    'lieu': '',
    'titre': '',
    'email': '',
    'description': '',
  };

  bool payant = true ;

  open_bottomsheet() {
    showModalBottomSheet<bool>(
        context: context,
        builder: (BuildContext context) {
          return new Container(
              height: 112.0,
              child: new Container(
                // padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                  child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new ListTile(
                            onTap: () {
                              // _handleCameraButtonPressed();
                            },
                            title: new Text("Prendre une photo")),
                        new ListTile(
                            onTap: () {
                              // _handleGalleryButtonPressed();
                            },
                            title: new Text("Photo depuis la galerie")),
                      ])));
        });
  }

  // Map<String, bool> values = {
  //   'foo': true,
  //   'bar': false,
  // };

  Widget btn_log = Center(child: Container(
    padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(25)),
      border: Border.all(color : Color(0xffF8F8F8) ,width: 0.5),
      color :Color(0xff218BB1),
    ),
    // height: 48,
    width: 100,
    child: Center(child: Text("Enregistrer",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w500,fontFamily: "louis george cafe"),)),
  ),
  );
  choose_date_start() async {
    DateTime newDateTime = await showRoundedDatePicker(
      context: context,
      locale: Locale("fr"),
      initialDate: date,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      borderRadius: 16,
      theme: ThemeData(primaryColor: Color.fromRGBO(247, 247, 247, 100)),
    );

    if (!this.mounted) return;

    setState(() {
      date = newDateTime;
    });
    print(newDateTime.toString());
  }


  @override
  Widget build(BuildContext context) {
    Widget intitule = Widgets.textfield_des(
        "Intitulé  ",
        _focusintitule,
        "",
        _intitulecontroller,
        TextInputType.text,
        null
    );

    Widget debut = InkWell(
        onTap: () {
          choose_date_start();
        },
        child: Container(
            decoration: BoxDecoration(
                color: Color(0xffF8F8F8),
                borderRadius: BorderRadius.all(Radius.circular(25))
            ),
            padding: EdgeInsets.only(left: 12,right: 12,top: 10,bottom: 10),
            child: Row(children: [
              Container(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 4.h,
                  ),
                  Text("Date Formation",
                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
                  ),
                  Container(height: 4.h)
                ],
              ),
              Expanded(child: Container()),
              Text(new DateFormat('dd/MM/yyyy').format(date),
                  style:
                  TextStyle(fontSize: 14.0, color: Colors.grey)
              ),
              SizedBox(width: 15,),
              Container(child: Image.asset("images/date.png",height: 25,width: 25,fit: BoxFit.cover,),),
              SizedBox(width: 10,),
              Container(
                // width: 8.w,
              )
            ])));

    Widget description = Expanded(
        child: Container(
            margin: EdgeInsets.only(left: 12.0),
            decoration: new BoxDecoration(
              // border: new Border.all(color: Colors.grey[400], width: 1.0),
                borderRadius: new BorderRadius.circular(25.0)),
            child: Widgets.textfield0(
              "Description",
              _focusedesc,
              "",
              _desccontroller,
              TextInputType.text,
            )));

    Widget pays =   Expanded(
        child:GestureDetector(
            onTap: () async {
              setState(() {
                _authHint = "";
                _vicontroller.text = "";
              });

              List vi = await Navigator.push(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
                    return new PaysLIst();
                  }));

              setState(() {
                _pacontroller.text = vi[1];
              });

            },
            child: AbsorbPointer(
                child: new Container(
                    margin: EdgeInsets.only(left: 12.0),
                    decoration: new BoxDecoration(
                      // border: new Border.all(color: Colors.grey[400], width: 1.0),
                        borderRadius: new BorderRadius.circular(25.0)),
                    child: Widgets.textfield0(
                      "Pays",
                      _focuspa,
                      "",
                      _pacontroller,
                      TextInputType.text,
                    )
                )
            )
        )
    );

    Widget ville = Expanded(child: _pacontroller.text != "Maroc"
        ? new Container(
        margin: EdgeInsets.only(left: 12.0,right: 12),
        decoration: new BoxDecoration(
          // border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(25.0)),
        child: Widgets.textfield0(
          "Ville",
          _focusville,
          "",
          _vicontroller,
          TextInputType.text,
        ))
        : GestureDetector(
        onTap: () async {
          setState(() {
            _authHint = "";
          });
          /*if (tt.length == 0)
                setState(() {
                  _authHint = "Choisir la région !";
                });
              else {*/
          print("dyeyye");
          // Navigator.pop(widget.context);
          List vi = await Navigator.push(context,
              new MaterialPageRoute(builder: (BuildContext context) {
                return new VilleLIst(ss_region_id, null, null);
              }));

          print(type);
          setState(() {
            _vicontroller.text = vi[1];
            ville_id = vi[0];
          });

          // nb_cap= await Navigator.push(context, route)
        },
        child: new Container(
            margin: EdgeInsets.only(left: 12.0),
            decoration: new BoxDecoration(
              // border: new Border.all(color: Colors.grey[400], width: 1.0),
                borderRadius: new BorderRadius.circular(25.0)),
            child: AbsorbPointer(
                child: Widgets.textfield0(
                  "Ville",
                  _focusville,
                  "",
                  _vicontroller,
                  TextInputType.text,
                )))));

    Widget tell = Expanded(
        child: Container(
            margin: EdgeInsets.only(left: 12.0),
            decoration: new BoxDecoration(
              // border: new Border.all(color: Colors.grey[400], width: 1.0),
                borderRadius: new BorderRadius.circular(25.0)),
            child: Widgets.textfield0(
              "Ajouter un numéro de téléphone",
              _focusetell,
              "",
              _tellcontroller,
              TextInputType.number,
            )));

    Widget email = Expanded(
        child: Container(
            margin: EdgeInsets.only(left: 12.0),
            decoration: new BoxDecoration(
              // border: new Border.all(color: Colors.grey[400], width: 1.0),
                borderRadius: new BorderRadius.circular(25.0)),
            child: Widgets.textfield0(
              "Email",
              _focuseemal,
              "",
              _emailcontroller,
              TextInputType.emailAddress,
            )));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(247, 247, 247, 100),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Color(0xff272C6E)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Ajouter une formation", style: TextStyle(color: Color(0xff272C6E),fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "louis george cafe"),),
            Container(
              margin: EdgeInsets.only(right: 10,),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(9)),

              ),
              child: Center(
                child: Image.asset("images/logo.png"),
              ),
            ),
          ],
        ),
      ),
      body: Container(
          color: Color.fromRGBO(247, 247, 247, 100),
          child: Container(
            height: double.infinity,
            width: MediaQuery.of(context).size.width *1 ,
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            margin: EdgeInsets.only(left: 27, right: 27,top: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.5),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25),
              ),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Color(0xffF8F8F8),
                          borderRadius: BorderRadius.all(Radius.circular(25))
                      ),
                      padding: EdgeInsets.only(top: 10,left: 12,right: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Container(

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                Container(child: Text("Intitulé",style: TextStyle(fontSize: 13,fontFamily: "louis george cafe" ,color: Color(0xffA6A6A6)),),),
                                Expanded(child: Container()),
                                Container(child: Image.asset("images/edittt.png",height: 15,width: 15,fit: BoxFit.cover,),),
                                SizedBox(width: 10,),
                              ],),),
                          intitule,
                        ],
                      )),


                  new Container(
                    height: 12.0,
                  ),

                  Container(
                      decoration: BoxDecoration(
                          color: Color(0xffF8F8F8),
                          borderRadius: BorderRadius.all(Radius.circular(25))
                      ),
                      padding: EdgeInsets.only(left: 12,right: 12),
                      child: Row(
                        children: [
                          description,
                          Container(child: Image.asset("images/edittt.png",height: 15,width: 15,fit: BoxFit.cover,),),
                          SizedBox(width: 10,),
                        ],
                      )
                  ),


                  new Container(
                    height: 12.0,
                  ),

                  debut,



                  new Container(
                    height: 12.0,
                  ),



                  Container(
                      decoration: BoxDecoration(
                          color: Color(0xffF8F8F8),
                          borderRadius: BorderRadius.all(Radius.circular(25))
                      ),
                      padding: EdgeInsets.only(left: 12,right: 12),
                      child: Row(
                        children: [
                          pays,
                          Container(child: Image.asset("images/localisation.png",height: 25,width: 25,fit: BoxFit.cover,),),
                          SizedBox(width: 10,),

                        ],
                      )),

                  new Container(
                    height: 12.0,
                  ),

                  Container(
                      decoration: BoxDecoration(
                          color: Color(0xffF8F8F8),
                          borderRadius: BorderRadius.all(Radius.circular(25))
                      ),
                      padding: EdgeInsets.only(left: 12,right: 12),
                      child: Row(
                        children: [
                          ville,
                          Container(child: Image.asset("images/localisation.png",height: 25,width: 25,fit: BoxFit.cover,),),
                          SizedBox(width: 10,),

                        ],
                      )),

                  new Container(
                    height: 12.0,
                  ),

                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(child: Text("payent "),),
                            SizedBox(width: 10,),
                            Container(child:
                            Checkbox(
                              checkColor: Colors.white,
                              value: payant,
                                onChanged : (value){
                                setState(() {
                                  payant = true ;
                                });
                                }
                            )
                            ),
                          ],
                        ),
                        SizedBox(width: 15,),

                        Row(
                          children: [
                            Container(child: Text("gratuite "),),
                            SizedBox(width: 10,),
                            Container(child:
                            Checkbox(
                                checkColor: Colors.white,
                                value: !payant,
                                onChanged : (value){
                                  setState(() {
                                    payant = false ;
                                  });
                                }
                            )
                            ),
                          ],
                        ),
                      ],
                    ),


                  ),



                  // new Container(
                  //   height: 12.0,
                  // ),
                  //
                  // Container(
                  //     decoration: BoxDecoration(
                  //         color: Color(0xffF8F8F8),
                  //         borderRadius: BorderRadius.all(Radius.circular(25))
                  //     ),
                  //     padding: EdgeInsets.only(left: 12,right: 12),
                  //     child: Row(
                  //       children: [
                  //         r_s,
                  //         Container(child: Image.asset("images/edittt.png",height: 15,width: 15,fit: BoxFit.cover,),),
                  //         SizedBox(width: 10,),
                  //       ],
                  //     )
                  // ),

                  new Container(
                    height: 12.0,
                  ),



                  Container(
                      decoration: BoxDecoration(
                          color: Color(0xffF8F8F8),
                          borderRadius: BorderRadius.all(Radius.circular(25))
                      ),
                      padding: EdgeInsets.only(left: 12,right: 12),
                      child: Row(
                        children: [
                          tell,
                          Container(child: Image.asset("images/phonex.png",height: 25,width: 25,fit: BoxFit.cover,),),
                          SizedBox(width: 10,),
                        ],
                      )
                  ),



                  // new Container(
                  //   height: 12.0,
                  // ),
                  //
                  // Container(
                  //     decoration: BoxDecoration(
                  //         color: Color(0xffF8F8F8),
                  //         borderRadius: BorderRadius.all(Radius.circular(25))
                  //     ),
                  //     padding: EdgeInsets.only(left: 12,right: 12),
                  //     child: Row(
                  //       children: [
                  //         adresse,
                  //         Container(child: Image.asset("images/edittt.png",height: 15,width: 15,fit: BoxFit.cover,),),
                  //         SizedBox(width: 10,),
                  //       ],
                  //     )
                  // ),




                  new Container(
                    height: 12.0,
                  ),

                  Container(
                      decoration: BoxDecoration(
                          color: Color(0xffF8F8F8),
                          borderRadius: BorderRadius.all(Radius.circular(25))
                      ),
                      padding: EdgeInsets.only(left: 12,right: 12),
                      child: Row(
                        children: [
                          email,
                          Container(child: Image.asset("images/mailx.png",height: 25,width: 25,fit: BoxFit.cover,),),
                          SizedBox(width: 10,),
                        ],
                      )
                  ),



                  // new Container(
                  //   height: 12.0,
                  // ),
                  //
                  // Container(
                  //     decoration: BoxDecoration(
                  //         color: Color(0xffF8F8F8),
                  //         borderRadius: BorderRadius.all(Radius.circular(25))
                  //     ),
                  //     padding: EdgeInsets.only(left: 12,right: 12),
                  //     child: Row(
                  //       children: [
                  //         web_site,
                  //         Container(child: Image.asset("images/edittt.png",height: 15,width: 15,fit: BoxFit.cover,),),
                  //         SizedBox(width: 10,),
                  //       ],
                  //     )
                  // ),

                  new Container(
                    height: 12.0,
                  ),

                  SizedBox(height: 30,),

                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xffF8F8F8),
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        border: Border.all(color: Fonts.col_app,width: 0.5)
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.start,
                      children: [
                        new FlatButton(
                          onPressed: () {
                            open_bottomsheet();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,

                            children: [
                              Container(
                                child: new Text(
                                  "Ajouter le logo de votre organisme",
                                  style: new TextStyle(
                                      color: Color(0xff005C9F),
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 13,
                                      fontFamily: "louis george cafe"
                                  ),
                                ),
                              ),
                              Container(
                                width: 60,
                              ),
                              Image.asset("images/attchaa.png",fit: BoxFit.cover,height: 12,width: 12,)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  new Container(
                    height: 12.0,
                  ),

                  InkWell(
                      onTap: () async {
                        var url = Uri.parse('http://217.182.139.190:1383/parse/classes/formation');

                        print("@@@@@@@@@@");
                        print(_intitulecontroller.text);
                        print(_desccontroller.text);
                        print(date);
                        print("pays " +_pacontroller.text);
                        print("ville " +_vicontroller.text);
                        print("payent " +payant.toString());
                        print("tee " +_tellcontroller.text);
                        print("email " +_emailcontroller.text);
                        // _handleSubmitted();
                        var body =  jsonEncode(<String, Object>{
                          "date_formation": DateFormat('dd/MM/yyyy').format(date) ,
                          "titre": _intitulecontroller.text,
                          "email": _emailcontroller.text,
                          "telephone": _tellcontroller.text,
                          "payent": payant,
                          "adresse": "${_pacontroller.text} ${_vicontroller.text}",
                          "description": _desccontroller.text,
                        });
                        var response = await clientHttp.post(url ,headers: paramsparsejson() , body: body);
                        var responsebody = jsonEncode(response.body);
                        print("######## ${responsebody} ######");
                      },
                      child: btn_log),
                  new Container(
                    height: 8.0,
                  ),




                ],
              ),
            ),
          )
      ),


    );
  }
}
