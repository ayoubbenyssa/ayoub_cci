
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mycgem/communities/ville_list.dart';
import 'package:mycgem/login/pays_list.dart';
import 'package:mycgem/login/ss_region/ss_region.dart';
import 'package:mycgem/models/membre.dart';
import 'package:mycgem/models/sector.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/validators.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:flutter/services.dart';


class EditMyOrganisme extends StatefulWidget {
  EditMyOrganisme(this.membre);
  Membre membre;


  @override
  _EditOrganismeState createState() => _EditOrganismeState();
}

class _EditOrganismeState extends State<EditMyOrganisme>
    with SingleTickerProviderStateMixin {


  final _adrcontroller = new TextEditingController();
  final _vicontroller = new TextEditingController();
  final _pacontroller = new TextEditingController();

  FocusNode _focusville = new FocusNode();
  FocusNode _focusact = new FocusNode();

  FocusNode _focuspa = new FocusNode();

  FocusNode _focusadr = new FocusNode();
  String ss_region = "";
  String ss_region_id = "";
  final _nomcontroller = new TextEditingController();

  String type_organisme = "";

  final _activcontroller = new TextEditingController();
  bool uploading = false;
  List<Sector> _list = [];
  final _precontroller = new TextEditingController();
  FocusNode _focuspre = new FocusNode();
  FocusNode _focusnom = new FocusNode();
  String type_e = "";



  var im = "";
  var lo = false;
  var error = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool _autovalidate = false;
  List<String> items = new List<String>();
  List<String> type_profile = [];
  List<String> type = [];
  FocusNode _focuscontact = new FocusNode();

  String _authHint = '';
  ParseServer parse_s = new ParseServer();
  String id_organisme;
  String _platformVersion;
  var my_id = "";
  List tt = [];
  String ville_id = "";





  create_entreprise() async {
    var res = await parse_s.putparse('membres/' + widget.membre.objectId, {

      "ville_id": "$ville_id",
      "address": "${_adrcontroller.text}",
      "imageUrl": im.toString(),
      "tel":MyFormState.list_tel,
      "ville": {
        "__type": "Pointer",
        "className": "ville",
        "objectId": ville_id
      },
      "activities":_activcontroller.text,
      "ville_externe": _vicontroller.text,
      "pays": _pacontroller.text,

    });
  }

  bool yes_or = false;


  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {

    setState(() {
      im = widget.membre.logo;
      _vicontroller.text = "";
      _pacontroller.text  = widget.membre.pays;
      _adrcontroller.text  = widget.membre.address;
      _activcontroller.text = widget.membre.activities;

    });



  }



  sub() {
    setState(() {
      yes_or = true;
    });
  }

  String id_code;
/*
  update_user_entreprise(id, entreprise) async {
    String ra = _raisonc.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("ent", "true");

    String reg = _capontroller.text;
    var js_org = {
      "membre_user": {
        "__type": "Pointer",
        "className": "membres",
        "objectId": '$id'
      },
      "verify_code": verify_code,
      "civilite": type_civil,
      "confirm": false,
      "ent": false,
      "id_code": id_code,
      "organisme": "$entreprise",

    };

    var a =  await parse_s.putparse('users/' + my_id, js_org);

    print("noooooooo");
    print(a);
  }*/


  Widget hintText() {
    return _authHint == ""
        ? new Container()
        : new Container(
      //height: 80.0,
        padding: const EdgeInsets.all(32.0),
        child: new Text(_authHint,
            key: new Key('hint'),
            style: new TextStyle(fontSize: 14.0, color: Colors.red[700]),
            textAlign: TextAlign.center));
  }


  save_image(image) async {
    setState(() {
      uploading = true;
    });

    int timestamp = new DateTime.now().millisecondsSinceEpoch;
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child("profile/img_" + timestamp.toString() + ".jpg");
    StorageUploadTask uploadTask = storageReference.put(image);
    await storageReference.put(image).onComplete.then((val) {
      val.ref.getDownloadURL().then((val) {
        //if (!mounted) return;

        setState(() {
          im = val.toString();
          error = "";
          uploading = false;
        });
      });
    });
  }

  gallery() async {
    Navigator.pop(context);
    var platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      var fi = await ImagePicker.pickImage(source: ImageSource.gallery);
      if (!this.mounted) return;

      File fil;

      setState(() {
        fil = fi;
      });

      _cropImage(fil);
    } on PlatformException {
    }
    if (!mounted) return;
  }

  Future _cropImage(image) async {
    File compressedFile =
    await FlutterNativeImage.compressImage(image.path, quality: 60);
    save_image(compressedFile);
  }

  ///image
  _handleCameraButtonPressed() async {
    Navigator.of(context).pop(true);
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    _cropImage(image);
  }


  /*create_entreprise(name, contact, entreprise) async {
    var js_membre = {
      "ice": _organismecontroller.text,
      "username": "$name",
      "address": _adrcontroller.text,
      "active": 0,
      "type_e": type_e,
      "doc": "$document",
      "confirm": false,
      "imageUrl": im == ""
          ? "https://res.cloudinary.com/dgxctjlpx/image/upload/v1565012657/placeholder_2_seeta8.png"
          : im.toString(),
      "password": "123456",
      "month": new DateTime.now().month.toString(),
      "year": new DateTime.now().year.toString(),
      "emails": [_contactcontroller.text],

      // "email": "$contact",
      "type": "$type_organisme",

      "ville_id": "$ville_id",
      "author_id": widget.id,
      "description": _desccontroller.text,

      "ville": {
        "__type": "Pointer",
        "className": "ville",
        "objectId": '$ville_id'
      },
      "pays": _pacontroller.text,
      "nb_emp": _nbcontroller.text,

      /// "chiffre": _chcontroller.text,
    };

    var res = await parse_s.postparse('membres/', js_membre);
    id_organisme = res["objectId"];
    await update_user_entreprise(id_organisme, entreprise);
    User ctc = new User(
      //id: "",
        new_membre: true,
        id: "",
        firstname: _precontroller.text,
        email: _contactcontroller.text,
        fullname: _nomcontroller.text,

        /// new_membre: true,
        prenom: _precontroller.text,
        titre: _titrecontroller.text,
        entreprise: Membre.fromMap(js_membre),
        organisme: _namecontroller.text);

    Navigator.pop(context);
    Routes.goto(context, "register", null, null, [], null, widget.chng,
        id_ent: id_organisme, contact: ctc);

    ///
    //
  }

*/

  void _handleSubmitted() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidate = true;

// Start validating on every change.
      //showInSnackBar("Veuillez corriger les erreurs en rouge");
    }  else {
      print("jihad");
      setState(() {
        _authHint = "";
      });
      //form.save();
      Widgets.onLoading(context);

         await create_entreprise();
         Navigator.pop(context);



    }
  }


  String ss_id = "";

  Widget ssregion() => new InkWell(
      child: new Container(
          margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
          padding: EdgeInsets.only(left: 8, right: 4, top: 12, bottom: 12),
          decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0),
          ),
          child: new Row(children: <Widget>[
            new Container(width: 8.0),
            new Container(
                child: new Text(
                    ss_region.toString() == "null" || ss_region.toString() == ""
                        ? "Sous région"
                        : ss_region.toUpperCase(),
                    style: new TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[500]))),
            new Container(
              width: 4.0,
            ),
            new Container(
              width: 8.0,
            ),
            new Expanded(child: new Container()),
            new Image.asset(
              "images/arr.png",
              width: 20,
              height: 20,
            ),
            new Container(
              width: 8.0,
            ),
          ])),
      onTap: () async {
        tt = await Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext context) {
              return new SSRegionsList();
            }));

        setState(() {
          ss_region = tt[1];
          ss_id = tt[0];
        });
      });


  bool verify = false;
  String id_entreprise = "";

  bool uploading1 = false;
  ParseServer ps = new ParseServer();
  String progress = "";
  String progress_res = "";
  String document = "";

  setProgress(progress) {
    setState(() {
      progress_res = progress;
    });

    print(4444);
    print(progress_res);
  }

  bool verify_code = false;


  @override
  Widget build(BuildContext context) {
    Validators val = new Validators(context: context);


    Widget activities = Widgets.textfield_des(
      "Activités  ",
      _focusact,
      "",
      _activcontroller,
      TextInputType.text,
      null


    );


    Widget Nom = new Container(
        margin: EdgeInsets.only(left: 12.0, right: 12.0),
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0)),
        child: Widgets.textfield("Nom", _focusnom, "", _nomcontroller,
            TextInputType.text, val.validatename));

    Widget prenom = new Container(
        margin: EdgeInsets.only(left: 12.0, right: 12.0),
        decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(4.0)),
        child: Widgets.textfield("Prénom", _focuspre, "", _precontroller,
            TextInputType.text, val.validatename));

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


    Widget address = new Container (
    decoration: BoxDecoration(
        color: Color(0xffF8F8F8),
        borderRadius: BorderRadius.all(Radius.circular(25)))
    , child : Container(
        margin: EdgeInsets.only(left: 12.0, right: 12.0),
        decoration: new BoxDecoration(
            // border: new Border.all(color: Colors.grey[400], width: 1.0),
            borderRadius: new BorderRadius.circular(25.0)),
        child: Widgets.textfield(" Addresse", _focusadr, "", _adrcontroller,
            TextInputType.text, val.validateAddress)
    ));

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
                              onTap: _handleCameraButtonPressed,
                              title: new Text("Prendre le logo")),
                          new ListTile(
                              onTap: gallery,
                              title: new Text("Photo depuis la galerie")),
                        ])));
          });
    }

    Widget pht = new InkWell(
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Container(
                width: 12.0,
              ),
              new Text(
                "Ajouter le logo de votre organisme :",
                style: new TextStyle(color: Colors.grey[600], fontSize: 15.6),
              ),
              new Container(
                width: 12.0,
              ),
              uploading ? new RefreshProgressIndicator() : new Container(),
            ],
          ),
        ],
      ),
      onTap: () {},
    );


    var style = new TextStyle(
        color: const Color(0xffeff2f7),
        fontSize: 20.0,
        fontWeight: FontWeight.w500);
    var clr = Fonts.col_app_fon;

    Widget btn_log = new InkWell(
      // color:  const Color(0xffa3bbf1),
        onTap: () {
          _handleSubmitted();
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

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(247, 247, 247, 100),
          elevation: 0.0,
          iconTheme: IconThemeData(color: Color(0xff272C6E)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Mon organisme", style: TextStyle(color: Color(0xff272C6E),fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "louis george cafe"),),
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
            padding: EdgeInsets.symmetric(horizontal: 20),
            margin: EdgeInsets.only(left: 27, right: 27,top: 60),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.5),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25),
              ),
              color: Colors.white,
            ),
            child: new Container(

                child:

                ListView(children: <Widget>[
                  Column(children: <Widget>[
                    new Form(
                        key: _formKey,
                        autovalidate: _autovalidate,
                        //onWillPop: _warnUserAboutInvalidData,
                        child: new Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: <Widget>[
                              new Container(height: 12.0),
                              /*new Center(
                                                child: Widgets.subtitle5(
                                                    Fonts.col_app_fonn,
                                                    widget.type.toString())),*/


                              ///   Nom,

                              ///  prenom,
                              // new Container(height: 12.0),
                              //
                              //
                              //
                              // Container(
                              //   height: 12.0,
                              // ),
                              // pht,

                              Container(
                                height: 12.0,
                              ),

                              im == ""
                                  ? Container(
                                  padding:
                                  new EdgeInsets.all(4.0),
                                  width: 100.0,
                                  height: 100.0,
                                  child: new Material(
                                      borderRadius:
                                      new BorderRadius
                                          .circular(12.0),
                                      shadowColor:
                                      Colors.white,
                                      elevation: 3.0,
                                      child:
                                      new Image.asset("images/imagee.png",fit: BoxFit.cover,)))
                                  : new Stack(children: <Widget>[
                                new Container(
                                    padding:
                                    new EdgeInsets.all(4.0),
                                    width: 100.0,
                                    height: 100.0,
                                    child: new Material(
                                        borderRadius:
                                        new BorderRadius
                                            .circular(12.0),
                                        shadowColor:
                                        Colors.white,
                                        elevation: 3.0,
                                        child:
                                        new Image.network(
                                          im,
                                          fit: BoxFit.cover,
                                        ))),
                                new Positioned(
                                    top: 0.0,
                                    right: 2.0,
                                    child: new InkWell(
                                      child: new CircleAvatar(
                                          radius: 10.0,
                                          backgroundColor:
                                          const Color(
                                              0xffff374e),
                                          child: new Center(
                                              child: new Icon(
                                                Icons.close,
                                                size: 18.0,
                                                color: Colors.white,
                                              ))),
                                      onTap: () {
                                        setState(() {
                                          im = "";
                                        });
                                      },
                                    ))
                              ]),

                              SizedBox(height: 30,),

                              Container(
                                decoration: BoxDecoration(
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
                                                color: Fonts.col_app,
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
                                          Image.asset("images/attchaa.png",fit: BoxFit.cover,color: Fonts.col_app,height: 12,width: 12,)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 28,),

                              Container(width: MediaQuery.of(context).size.width * 0.75,height: 1,color: Color(0xffF8F8F8),),


                              SizedBox(height: 12,),

                              // new Container(
                              //   height: 12.0,
                              // ),
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

                                        Container(child: Text("Activités",style: TextStyle(fontSize: 13,fontFamily: "louis george cafe" ,color: Color(0xffA6A6A6)),),),
                                        Expanded(child: Container()),
                                        Container(child: Image.asset("images/edittt.png",height: 15,width: 15,fit: BoxFit.cover,),),
                                         SizedBox(width: 10,),
                                      ],),),
                                      activities,
                                    ],
                                  )),



                              ///  coomissions_widget(),
                              /// coomissions_feds(),

                              ///   region(),



                              new Container(
                                height: 12.0,
                              ),

                              Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xffF8F8F8),
                                      borderRadius: BorderRadius.all(Radius.circular(25))
                                  ),
                                  padding: EdgeInsets.only(left: 12,right: 12),child: Row(
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

                              // Row(
                              //   children: <Widget>[
                              //
                              //     Container(
                              //       width: 2,
                              //     ),
                              //   ],
                              // ),
                              new Container(
                                height: 12.0,
                              ),
                              // Container(
                              //     decoration: BoxDecoration(
                              //         color: Color(0xffF8F8F8),
                              //         borderRadius: BorderRadius.all(Radius.circular(25))
                              //     ),
                              //     padding: EdgeInsets.only(left: 12,right: 12),
                              //     child: Row(
                              //       children: [
                              //         address,
                              //         // Container(child: Image.asset("assets/images/edittt.png",height: 30,width: 30,fit: BoxFit.cover,color: Colors.red,),)
                              //
                              //       ],
                              //     )),

                              address,


                              MyForm(widget.membre.tels),

                              hintText(),
                              new Container(
                                height: 12.0,
                              ),
                              btn_log,
                              new Container(
                                height: 8.0,
                              ),
                            ]))
                  ])
                ])
            ),
          ),
        ));
  }
}






class MyForm extends StatefulWidget {
  MyForm(this.list_tel);
  List<String> list_tel =[];

  @override
  MyFormState createState() => MyFormState();
}
class MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  static List<String> list_tel =[];


  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    list_tel = widget.list_tel.length== 0?[null]: widget.list_tel;

  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {




    /// add / remove button
    Widget _addRemoveButton(bool add, int index){
      return InkWell(
        onTap: (){
          if(add){
            // add new text-fields at the top of all friends textfields
            list_tel.insert(0, null);
          }
          else list_tel.removeAt(index);
          setState((){});
        },
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: (add) ? Fonts.col_ap : Colors.red,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon((add) ? Icons.add : Icons.remove, color: Colors.white,),
        ),
      );
    }



    /// get firends text-fields
    List<Widget> _getFriends() {
      List<Widget> friendsTextFields = [];
      for (int i = 0; i < list_tel.length; i++) {
        friendsTextFields.add(
            Container(
              decoration: BoxDecoration(
                  color: Color(0xffF8F8F8),
                  borderRadius: BorderRadius.all(Radius.circular(25))
              ),
              padding: EdgeInsets.only(left: 12,right: 12),
              child: Row(
                children: [
                  Expanded(child: FriendTextFields(i)),
                  SizedBox(width: 16,),
                  // we need add button at last friends row
                  _addRemoveButton(i == list_tel.length - 1, i),
                ],
              ),
            )
        );
      }
      return friendsTextFields;
    }

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // SizedBox(height: 20,),
            // Text('Ajouter un numéro de téléphone',
            //   style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),),
            ..._getFriends(),
            SizedBox(height: 40,),


          ],
        ),
      ),
    );
  }

}




class FriendTextFields extends StatefulWidget {
  final int index;
  FriendTextFields(this.index);
  @override
  _FriendTextFieldsState createState() => _FriendTextFieldsState();
}

class _FriendTextFieldsState extends State<FriendTextFields> {
  TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Validators val = new Validators(context: context);


    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nameController.text = MyFormState.list_tel[widget.index] ?? '';
    });

    return TextFormField(
      controller: _nameController,
      onChanged: (v) => MyFormState.list_tel[widget.index] = v,
      decoration: InputDecoration(
        border: InputBorder.none,
          hintText: 'Numéro de téléphone'
      ),
      validator: val.validatephonenumber
    );
  }
}