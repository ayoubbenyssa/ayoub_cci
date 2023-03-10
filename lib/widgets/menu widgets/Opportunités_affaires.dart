
import 'package:flutter/material.dart';
import 'package:mycgem/communities/ville_list.dart';
import 'package:mycgem/login/pays_list.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/validators.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import '../widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';


class Opportunites_affaires extends StatefulWidget {

  @override
  _Opportunites_affairesState createState() => _Opportunites_affairesState();
}

class _Opportunites_affairesState extends State<Opportunites_affaires> {
  final _activitecontroller = new TextEditingController();
  FocusNode _focusactvt = new FocusNode();
  final _pacontroller = new TextEditingController();
  final _vicontroller = new TextEditingController();
  final _secturescontroller = new TextEditingController();
  final _RCcontroller = new TextEditingController();
  final _adressecontroller = new TextEditingController();
  final _tellcontroller = new TextEditingController();
  final _emailcontroller = new TextEditingController();
  final _site_webcontroller = new TextEditingController();

  String _authHint = '';
  FocusNode _focuspa = new FocusNode();
  FocusNode _focusecteur = new FocusNode();
  FocusNode _focuseRC = new FocusNode();
  FocusNode _focusetell = new FocusNode();
  FocusNode _focuseadresse = new FocusNode();
  FocusNode _focuseemal = new FocusNode();
  FocusNode _focuseweb = new FocusNode();

  FocusNode _focusville = new FocusNode();
  String ss_region_id = "";
  String ville_id = "";
  List<String> type = [];
  DateTime date = DateTime.now();

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

  Widget btn_log = new InkWell(
    // color:  const Color(0xffa3bbf1),
    onTap: () {
      // _handleSubmitted();
    },
    child: Center(child: Container(
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
    Validators val = new Validators(context: context);

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
                  Text("Date d'absence",
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
              Container(child: Image.asset("images/edittt.png",height: 15,width: 15,fit: BoxFit.cover,),),
              SizedBox(width: 10,),
              Container(
                width: 8.w,
              )
            ])));

    Widget activities = Widgets.textfield_des(
        "Intitul??  ",
        _focusactvt,
        "",
        _activitecontroller,
        TextInputType.text,
        null
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
                  _authHint = "Choisir la r??gion !";
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

    Widget secteur_dacturte = Expanded(
          child: Container(
              margin: EdgeInsets.only(left: 12.0),
              decoration: new BoxDecoration(
                // border: new Border.all(color: Colors.grey[400], width: 1.0),
                  borderRadius: new BorderRadius.circular(25.0)),
              child: Widgets.textfield0(
                "Secteur d'acturt??s",
                _focusecteur,
                "",
                _secturescontroller,
                TextInputType.text,
              )));

    Widget r_s = Expanded(
        child: Container(
            margin: EdgeInsets.only(left: 12.0),
            decoration: new BoxDecoration(
              // border: new Border.all(color: Colors.grey[400], width: 1.0),
                borderRadius: new BorderRadius.circular(25.0)),
            child: Widgets.textfield0(
              "R.S",
              _focuseRC,
              "",
              _RCcontroller,
              TextInputType.text,
            )));

    Widget tell = Expanded(
        child: Container(
            margin: EdgeInsets.only(left: 12.0),
            decoration: new BoxDecoration(
              // border: new Border.all(color: Colors.grey[400], width: 1.0),
                borderRadius: new BorderRadius.circular(25.0)),
            child: Widgets.textfield0(
              "Ajouter un num??ro de t??l??phone",
              _focusetell,
              "",
              _tellcontroller,
              TextInputType.number,
            )));

    Widget adresse = Expanded(
        child: Container(
            margin: EdgeInsets.only(left: 12.0),
            decoration: new BoxDecoration(
              // border: new Border.all(color: Colors.grey[400], width: 1.0),
                borderRadius: new BorderRadius.circular(25.0)),
            child: Widgets.textfield0(
              "Addresse",
              _focuseadresse,
              "",
              _adressecontroller,
              TextInputType.text,
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

    Widget web_site = Expanded(
        child: Container(
            margin: EdgeInsets.only(left: 12.0),
            decoration: new BoxDecoration(
              // border: new Border.all(color: Colors.grey[400], width: 1.0),
                borderRadius: new BorderRadius.circular(25.0)),
            child: Widgets.textfield0(
              "Site web",
              _focuseweb,
              "",
              _site_webcontroller,
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
                    )))));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(247, 247, 247, 100),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Color(0xff272C6E)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Opportunit??s d'Affaires", style: TextStyle(color: Color(0xff272C6E),fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "louis george cafe"),),
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

                                Container(child: Text("Intitul??",style: TextStyle(fontSize: 13,fontFamily: "louis george cafe" ,color: Color(0xffA6A6A6)),),),
                                Expanded(child: Container()),
                                Container(child: Image.asset("images/edittt.png",height: 15,width: 15,fit: BoxFit.cover,),),
                                SizedBox(width: 10,),
                              ],),),
                          activities,
                        ],
                      )),

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
                          secteur_dacturte,
                          Container(child: Image.asset("images/edittt.png",height: 15,width: 15,fit: BoxFit.cover,),),
                          SizedBox(width: 10,),
                        ],
                      )
                  ),

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
                          r_s,
                          Container(child: Image.asset("images/edittt.png",height: 15,width: 15,fit: BoxFit.cover,),),
                          SizedBox(width: 10,),
                        ],
                      )
                  ),


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
                      Container(child: Image.asset("images/edittt.png",height: 15,width: 15,fit: BoxFit.cover,),),
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
                          Container(child: Image.asset("images/edittt.png",height: 15,width: 15,fit: BoxFit.cover,),),
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
                          tell,
                          Container(child: Image.asset("images/phonex.png",height: 25,width: 25,fit: BoxFit.cover,),),
                          SizedBox(width: 10,),
                        ],
                      )
                  ),



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
                          adresse,
                          Container(child: Image.asset("images/edittt.png",height: 15,width: 15,fit: BoxFit.cover,),),
                          SizedBox(width: 10,),
                        ],
                      )
                  ),




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
                          web_site,
                          Container(child: Image.asset("images/edittt.png",height: 15,width: 15,fit: BoxFit.cover,),),
                          SizedBox(width: 10,),
                        ],
                      )
                  ),

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

                  btn_log,
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
