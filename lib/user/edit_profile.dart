import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import '';
class Edit_profile extends StatefulWidget {
  User user;
Edit_profile(this.user);
  @override
  _Edit_profileState createState() => _Edit_profileState();
}

class _Edit_profileState extends State<Edit_profile> {

  ParseServer parse_s = new ParseServer();

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
  bool uploading = false;

  @override
  Widget build(BuildContext context) {
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
                      icon: new Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        open_bottomsheet();
                      }))),
        ],
      ),

    ]
    ),
    ),
      )
    );
  }
}
