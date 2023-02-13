import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

class Tpes_c extends StatefulWidget {
  @override
  _ChooseCategoryState createState() => new _ChooseCategoryState();
}

class _ChooseCategoryState extends State<Tpes_c> {
  // Zone zone;
  List<String> cities = [
    "Comité du club",
    "Le personnel (qui travaillent pour le club",
    "La direction technique",
    "Joueur",
    "Entraîneur",
    "Stuff technique et médicale",
    "Mentors",
    "Adhérents"
  ];
  bool load = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text("Type de profil")),
        body: load
            ? new Center(child: new RefreshProgressIndicator())
            : new ListView(
                children: cities.map((String city) {
                return new ListTile(
                    onTap: () {
                      Navigator.pop(context, city);
                    },
                    title: new Text(city,
                        style: new TextStyle(
                            fontSize: 14.0, color: Colors.grey[700])));
              }).toList()));
  }
}
