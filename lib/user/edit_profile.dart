import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/validators.dart';
import 'package:mycgem/user/competences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:mycgem/widgets/widgets.dart';

import '';
import 'name_info_user.dart';
import 'objectifs.dart';
class Edit_profile extends StatefulWidget {
  User user;




  Edit_profile(this.user);
  @override
  _Edit_profileState createState() => _Edit_profileState();
}

class _Edit_profileState extends State<Edit_profile> {

  ParseServer parse_s = new ParseServer();
  bool uploading = false;



  final _namecontroller = new TextEditingController();
  final _firstctrl = new TextEditingController();
  final _agectrl = new TextEditingController();
  FocusNode _focusfullname = new FocusNode();
  FocusNode _firstfouc = new FocusNode();
  FocusNode _agefocus = new FocusNode();
  final _bioctrl = new TextEditingController();
  FocusNode _biofocus = new FocusNode();

  final _nmrtelephonctrl = new TextEditingController();
  FocusNode _nmrtelephonfocus = new FocusNode();


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
                            title: new Text("Prendre une photo")),
                        new ListTile(
                            onTap: _handleGalleryButtonPressed,
                            title: new Text("Photo depuis la galerie")),
                      ])));
        });
  }

  _handleCameraButtonPressed() async {
    Navigator.of(context).pop(true);
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    _cropImage(image);
  }

  _handleGalleryButtonPressed() async {
    Navigator.of(context).pop(true);
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _cropImage(image);
  }



  Future _cropImage(image) async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
    );
    if (croppedFile != null) {
      image = croppedFile;
      //ImageProperties properties = await FlutterNativeImage.getImageProperties(image.path);
      File compressedFile =
      await FlutterNativeImage.compressImage(image.path, quality: 70);
      save_image(compressedFile);
    }
  }
  save_image(image) async {
    setState(() {
      uploading = true;
    });

    int timestamp = new DateTime.now().millisecondsSinceEpoch;
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child("profile/img_" + timestamp.toString() + ".jpg");
    await storageReference.put(image).onComplete.then((val) {
      val.ref.getDownloadURL().then((val) {
        var js = {
          "photoUrl": val.toString(),
        };

        parse_s.putparse("users/" + widget.user.id, js);

        if (!mounted) return;

        setState(() {
          widget.user.image = val.toString();
          update();
          uploading = false;
        });
      });
    });
  }
  update() async {
    Map<String, dynamic> mapp = User.toMap(widget.user);
    print(mapp);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", mapp.toString());
  }
  edit_name() async {
    User us = await Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
          return new InfoUser1(widget.user);
        }));

    setState(() {
      widget.user = us;
    });
  }

  Widgets edit_chompe( name, focus, value, myController, type, validator,{submit}){
     TextFormField(
          enabled: true,
          style: new TextStyle(fontSize: 15.0, color: Colors.black),
          obscureText: false,
          controller: myController,
          focusNode: focus,
          decoration: InputDecoration(
            //helperText: name,
            labelText: name,
            contentPadding: new EdgeInsets.all(8.0),
            hintText: name,
            hintStyle: new TextStyle(fontSize: 15.0, color: Colors.grey),
          ),
          keyboardType: type,
          validator: validator,
          onSaved: (val) {
            myController.text = val;
            submit();
          },
          onFieldSubmitted: (val) {
            myController.text = val;
            submit();
          },
        );
  }
  editwidget(colors, tap) {
    return new InkWell(
        child: new Container(
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: new Container(child: Image.asset("images/edittt.png",height: 22,width: 13,
            ),
            ),

        ),
        onTap: () {
          tap();
        });
  }

  edit_comp() async {
    User us = await Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
          return new Cmpetences(widget.user);
        }));

    setState(() {
      widget.user.cmpetences = us.cmpetences;
    });
  }

  edit_objectifs() async {
    User us = await Navigator.push(
      context,
      new PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> _,
            Animation<double> __) {
          return new Objectifs_widget(widget.user);
        },
      ),
    );

    setState(() {
      widget.user = us;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _namecontroller.text = widget.user.fullname;
    _firstctrl.text = widget.user.firstname;
    _agectrl.text = widget.user.age;
    _nmrtelephonctrl.text = widget.user.phone;
    _bioctrl.text = widget.user.bio;

  }

  @override
  Widget build(BuildContext context) {

    Validators val = new Validators(context: context);

    Widget npm = Widgets.textfield_dec(
        "Nom",
        _focusfullname,
        widget.user.fullname,
        _namecontroller,
        TextInputType.text,
        val.validatename);

    Widget first = Widgets.textfield_dec(
        "Prénom",
        _firstfouc,
        widget.user.firstname,
        _firstctrl,
        TextInputType.text,
        val.validatename);

    Widget age = Widgets.textfield0(
        "L'age", _agefocus, widget.user.age, _agectrl, TextInputType.number);

    Widget nmrtelephone = Widgets.textfield(
        "Entrez votre numéro de téléphone",
        _nmrtelephonfocus,
        widget.user.bio,
        _nmrtelephonctrl,
        TextInputType.phone,
        val.validatephonenumber);

    Widget bio = Widgets.textfield0_dec_bio(
      "Présentez vous en quelques mots",
      _biofocus,
      widget.user.bio,
      _bioctrl,
      TextInputType.text,

    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(247, 247, 247, 100),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Color(0xff272C6E)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Edit mon Profile", style: TextStyle(color: Color(0xff272C6E),fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "louis george cafe"),),
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
      body:     Container(
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
    child: ListView(
    children: [
    SizedBox(height: 20,),
      Stack(
        children: [
          new Center(
              child: new Container(
                child: new CircleAvatar(
                  backgroundImage:
                  NetworkImage(widget.user.image),
                  radius: 45.0,
                ),
              )),
          new Positioned(
              bottom: 0.0,
              //bottom: 8.0,
              left: 46.0,
              right: -8.0,
              child: new CircleAvatar(
                  radius: 15.0,
                  backgroundColor: Colors.blue[300],
                  child: new IconButton(
                    iconSize: 1,
                      color: Colors.grey[100],
                      icon: new Image.asset("images/edittt.png" ,height: 25 , width: 15, ),
                      onPressed: () {
                        open_bottomsheet();
                      }))),
        ],
      ),

      new Container(
        height: 10.0,
      ),
      Container(
        // margin: EdgeInsets.only(bottom: 11),
        // height: 40,
        width: 300,
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25)),
          border: Border.all(color: Colors.grey.withOpacity(0.5),width: 1),
        ),
        child: npm,
      ),
      new Container(
        height: 10.0,
      ),
          Container(
            // margin: EdgeInsets.only(bottom: 11),
            // height: 40,
            width: 300,
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(25)),
              border: Border.all(color: Colors.grey.withOpacity(0.5),width: 1),
            ),
            child: first,
          ),
      new Container(
        height: 10.0,
      ),
      Container(
        // margin: EdgeInsets.only(bottom: 11),
        // height: 40,
        width: 300,
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25)),
          border: Border.all(color: Colors.grey.withOpacity(0.5),width: 1),
        ),
        child: age,
      ),

      new Container(
        height: 10.0,
      ),
      Container(
        margin: EdgeInsets.only(bottom: 11),
        // height: 40,
        width: 300,
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25)),
          border: Border.all(color: Colors.grey.withOpacity(0.5),width: 1),
        ),
        child: nmrtelephone,
      ),
      new Container(
        height: 10.0,
      ),

      new Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Container(child: Image.asset("images/customer-review.png",height: 22,width: 13,),),
        Container(width: 12.0),
        new Container(
            child: new Text(LinkomTexts.of(context).compe(),
                style: new TextStyle(color: Color(0xffa5a5a5),fontSize: 13,fontWeight: FontWeight.w300,fontFamily: "louis george cafe"))),
        new Container(width: 12.0),
        editwidget(Fonts.col_app, edit_comp)
      ]),

      new Container(
        height: 10.0,
      ),

      new Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Container(child: Image.asset("images/heart .png",height: 18,width: 11,),),
        Container(width: 12.0),

        new Container(
            child: new Text(
              LinkomTexts.of(context).objs(),
              style: new TextStyle(color: Color(0xffa5a5a5),fontSize: 13,fontWeight: FontWeight.w300,fontFamily: "louis george cafe"),
            )),
        Container(width: 12.0),
        editwidget(Fonts.col_app, edit_objectifs)
      ]),

      new Container(
        height: 10.0,
      ),
      Container(
        margin: EdgeInsets.only(bottom: 11),
        // height: 40,
        width: 300,
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25)),
          border: Border.all(color: Colors.grey.withOpacity(0.5),width: 1),
        ),
        child: bio,
      ),

      SizedBox(height: 15,),

      InkWell(
        onTap: ()async {
          widget.user.fullname = _namecontroller.text;
          widget.user.firstname = _firstctrl.text;
          widget.user.age = _agectrl.text;
          widget.user.phone = _nmrtelephonctrl.text;
          widget.user.bio = _bioctrl.text;

          var js = {
            "firstname": _firstctrl.text,
            "familyname": _namecontroller.text,
            "age": _agectrl.text,
            "phone": widget.user.phone,
            "bio":widget.user.bio
          };

          await parse_s.putparse("users/" + widget.user.id, js);

          Navigator.pop(context, widget.user);
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
      ),

      SizedBox(height: 15,),

    ]
    ),
    ),
      )
    );
  }
}
