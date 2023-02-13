import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/widgets/ensuevisiblewhenfocus.dart';
import 'package:mycgem/widgets/idget_loading_foot.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Widgets {
  static exitapp(context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => new AlertDialog(
          titlePadding: new EdgeInsets.all(0.0),
          contentPadding: new EdgeInsets.all(0.0),
          title: new Container(
              padding: new EdgeInsets.all(2.0),
              color: Colors.grey[300],
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    new GestureDetector(
                      child: new Icon(Icons.close, color: Colors.grey[800]),
                      onTap: () {
                        Navigator.of(context, rootNavigator: true)
                            .pop('dialog');
                      },
                    )
                    // new Text('Login'),
                  ])),
          content: new Container(
              color: Colors.grey[300],
              padding: new EdgeInsets.only(left: 8.0, right: 8.0),
              height: 230.0,
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //new Container(height: 8.0,),
                    Center(
                        child: new Text(
                      "Voulez vous quitter l'application?",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[800],
                      ),
                    )),
                    new Container(
                      height: 18.0,
                    ),
                    GestureDetector(
                        onTap: () {
                          exit(1);
                        },
                        child: new Image.asset(
                          "images/lo.png",
                          width: 50.0,
                          height: 50.0,
                          color: Colors.blue,
                        )),
                    new Container(
                      height: 12.0,
                    ),

                    new Container(
                      height: 16.0,
                    ),
                    new Divider(
                      color: Colors.grey,
                    ),
                    new FlatButton(
                        padding: EdgeInsets.all(8.0),
                        child: new Text(
                          "Quitter",
                          style: new TextStyle(
                              color: Colors.grey[800],
                              fontSize: 20.0,

                              /// fontFamily: "Rest",
                              fontWeight: FontWeight.w600),
                        ),
                        onPressed: () {
                          exit(1);
                        }),
                  ]))),
    );
  }

  static Widget avatar = new Container(
      child: new GestureDetector(
          onTap: () {},
          child: new Image.asset(
            "images/c.png",
            width: 120,
          )));

  static Widget avatar1 = new Container(
      child: new GestureDetector(
          onTap: () {},
          child: new Image.asset(
            "images/logo.png",
            width: 80.0,
            height: 80.0,
          )));

  static List<Color> kitGradients = [
    // new Color.fromRGBO(103, 218, 255, 1.0),
    // new Color.fromRGBO(3, 169, 244, 1.0),
    // new Color.fromRGBO(0, 122, 193, 1.0),
    Fonts.col_app_fonn,
    const Color(0xffc4effe),
  ];

  static List<Color> kitGradients1 = [
    // new Color.fromRGBO(103, 218, 255, 1.0),
    // new Color.fromRGBO(3, 169, 244, 1.0),
    // new Color.fromRGBO(0, 122, 193, 1.0),
    Fonts.col_app,
    const Color(0xffc4effe),
  ];

  static List<Color> kitGradients10 = [
    // new Color.fromRGBO(103, 218, 255, 1.0),
    // new Color.fromRGBO(3, 169, 244, 1.0),
    // new Color.fromRGBO(0, 122, 193, 1.0),
    Fonts.col_app,
    const Color(0xffeff6fb),
  ];

  static load() => SpinKitFadingCircle(
        itemBuilder: (_, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: index.isEven ? Fonts.col_app_shadow : Fonts.col_app,
            ),
          );
        },
      );

  static List<Color> kitGradients11 = [
    // new Color.fromRGBO(103, 218, 255, 1.0),
    // new Color.fromRGBO(3, 169, 244, 1.0),
    // new Color.fromRGBO(0, 122, 193, 1.0),
    const Color(0xffc4effe),
    Fonts.col_app,
  ];

  static void onLoading(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => new Dialog(
              child: new Container(
                padding: new EdgeInsets.all(16.0),
                width: 40.0,
                color: Colors.transparent,
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    new RefreshProgressIndicator(),
                    new Container(height: 8.0),
                    new Text(
                      "En cours ..",
                      style: new TextStyle(
                        color: Fonts.col_app_fonn,
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  static BoxDecoration boxdecoration_background() => new BoxDecoration(
      image: new DecorationImage(
          fit: BoxFit.cover, image: new AssetImage("images/background.png")));

  static Widget subtitle3(color) => new Text("Réinitialiser le mot de passe",
      style: new TextStyle(
          fontSize: 22.0, fontWeight: FontWeight.w800, color: color));

  static Widget subtitle5(color, type) => Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: new Text(type,
          style: new TextStyle(
              fontSize: 19.0, fontWeight: FontWeight.w800, color: color)));

  static Widget subtitle(color, size) => new Text("Login",
      style: new TextStyle(
          fontSize: size, fontWeight: FontWeight.w800, color: color));

  static Widget subtitle1(color) => new Text("Vérification de compte",
      style: new TextStyle(
          fontSize: 22.0, fontWeight: FontWeight.w800, color: color));

  static Widget subtitle2(color) => new Text("Créer un compte",
      style: new TextStyle(
          fontSize: 22.0, fontWeight: FontWeight.w800, color: color));

  static Widget subtitle33(color, text) =>
      new Text("Rejoindre la commission: " + text,
          style: new TextStyle(
              fontSize: 17.0, fontWeight: FontWeight.w800, color: color));

  static Widget textfield1(
    name,
    focus,
    value,
    myController,
    type,
    validator, {
    obscure = false,
  }) {
    return new EnsureVisibleWhenFocused(
        focusNode: focus,
        child: TextFormField(
          obscureText: obscure,
          controller: myController,
          focusNode: focus,
          decoration: InputDecoration(
            // border: InputBorder.none,
            contentPadding: new EdgeInsets.all(8.0),
            labelText: name,
            hintText: name,
            hintStyle: new TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.grey),
          ),
          keyboardType: type,
          validator: validator,
          onFieldSubmitted: (val) => value = val,
        ));
  }

  static Widget textfield0(
    name,
    focus,
    value,
    myController,
    type, {
    obscure = false,
  }) {
    return new EnsureVisibleWhenFocused(
        focusNode: focus,
        child: TextFormField(
          style: new TextStyle(fontSize: 15.0, color: Colors.black),
          obscureText: obscure,
          controller: myController,
          focusNode: focus,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: new EdgeInsets.all(8.0),
            hintText: name,
            hintStyle: new TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
          keyboardType: type,
          onFieldSubmitted: (val) => value = val,
        ));
  }

  static Widget textfield0_dec_bio(
    name,
    focus,
    value,
    myController,
    type, {
    obscure = false,
  }) {
    return TextFormField(
      style: new TextStyle(fontSize: 15.0, color: Colors.black),
      obscureText: obscure,
      maxLines: 12,
      controller: myController,
      focusNode: focus,
      decoration: InputDecoration(
        labelText: name,
        contentPadding: new EdgeInsets.all(8.0),
        hintText: name,
        hintStyle: new TextStyle(fontSize: 14.0, color: Colors.grey),
      ),
      keyboardType: type,
      onFieldSubmitted: (val) => value = val,
    );
  }

  static Widget textfield0_dec(
    name,
    focus,
    value,
    myController,
    type, {
    obscure = false,
  }) {
    return new EnsureVisibleWhenFocused(
        focusNode: focus,
        child: TextFormField(
          style: new TextStyle(fontSize: 15.0, color: Colors.black),
          obscureText: obscure,
          controller: myController,
          focusNode: focus,
          decoration: InputDecoration(
            contentPadding: new EdgeInsets.all(8.0),
            hintText: name,
            hintStyle: new TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
          keyboardType: type,
          onFieldSubmitted: (val) => value = val,
        ));
  }

  static Widget textfield(name, focus, value, myController, type, validator,
      {obscure = false, submit, size}) {
    return TextFormField(
      style: new TextStyle(
          fontSize: /*size != null ? size :*/ 15.0,
          color: Fonts.col_app_fon,
          fontWeight: FontWeight.w800),
      obscureText: obscure,
      controller: myController,
      focusNode: focus,
      decoration: InputDecoration(
        errorMaxLines: 3,
      //  border: InputBorder.none,
        contentPadding: new EdgeInsets.all(0.0),
        hintText: name,
        hintStyle: new TextStyle(
            fontSize: size != null ? size : 15.0, color: Fonts.col_grey2),
      ),
      keyboardType: type,
      validator: validator,
      onSaved: (val) {
        myController.text = val;
        submit();
      },
      onFieldSubmitted: (val) {
        myController.text = val;
        if(submit != null)
        submit();
      },
    );
  }

  static Widget textfield_dec(name, focus, value, myController, type, validator,
      {obscure = false, submit, en = true}) {
    return new EnsureVisibleWhenFocused(
        focusNode: focus,
        child: TextFormField(
          enabled: en,
          style: new TextStyle(fontSize: 15.0, color: Colors.black),
          obscureText: obscure,
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
        ));
  }

  static Widget textfield_des1(
      name, focus, value, myController, type, validator,
      {obscure = false, submit}) {
    return TextFormField(
      style: new TextStyle(fontSize: 15.0, color: Colors.black),
      obscureText: obscure,
      controller: myController,
      maxLines: 2,
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

  static Widget textfield_des(name, focus, value, myController, type, validator,
      {obscure = false, submit}) {
    return new EnsureVisibleWhenFocused(
        focusNode: focus,
        child: TextFormField(
          style: new TextStyle(fontSize: 15.0, color: Colors.black),
          obscureText: obscure,
          controller: myController,
          maxLines: 3,
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
        ));
  }
}
