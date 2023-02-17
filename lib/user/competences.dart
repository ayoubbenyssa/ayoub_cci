import 'package:flutter/material.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/models/domaine.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/partners_list.dart';
import 'package:mycgem/widgets/ensuevisiblewhenfocus.dart';

class Cmpetences extends StatefulWidget {
  Cmpetences(this.user);

  User user;

  @override
  _CmpetencesState createState() => _CmpetencesState();
}

class _CmpetencesState extends State<Cmpetences> {


  // List<String> cmptes = [];
  ParseServer parse_s = new ParseServer();
  List<Domaine> domaines = [];
  bool loading = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  deleted(item) {
    setState(() {
      widget.user.cmpetences.remove(item);
    });
  }

  Future<List<Domaine>> getdomains() async {
    var res = await PartnersList.get_domains();

    setState(() {
      domaines = res;

      for (String elem in widget.user.cmpetences) {
        domaines.removeWhere((a) => a.name == elem);
      }
      loading = false;
    });
  }

  void initState() {
    super.initState();

    getdomains();
  }

  add_skill_selected(name) {
    if (widget.user.cmpetences.length <= 9) {
      setState(() {
        widget.user.cmpetences.add(name);
        domaines.removeWhere((a) => a.name == name);
      });
    } else {
      print("éloadingyeetetetetetetet");
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: new Text("Vous pouvez choisir au maximum 10 domaines d'expertise !"),
      ));
    }
  }

  /* add_skill(){
    if (_cctrl.text != "") {
      setState(() {
        widget.user.cmpetences.add(_cctrl.text);
        _cctrl.text = "";
      });
      domaines.removeWhere((a)=>
      a.name == _cctrl.text);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    /*Widget cmp = new EnsureVisibleWhenFocused(
        focusNode: _cfoucs,
        child: TextFormField(
          style: new TextStyle(fontSize: 15.0, color: Colors.black),
          controller: _cctrl,
          focusNode: _cfoucs,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: new EdgeInsets.all(8.0),
            hintText: "Entrez votre domaine d’expertise ",
            hintStyle: new TextStyle(fontSize: 13.0, color: Colors.grey),
          ),
          keyboardType: TextInputType.text,
          onFieldSubmitted: (val) {
            if (_cctrl.text != "") {
              setState(() {
                cmptes.add(_cctrl.text);
                _cctrl.text = "";
              });
            }
          },
        ));*/

    return new WillPopScope(
        onWillPop: () {
          Navigator.pop(context, widget.user);
        },
        child: Scaffold(
          key: _scaffoldKey,

          appBar: AppBar(
            backgroundColor: Color.fromRGBO(247, 247, 247, 100),
            elevation: 0.0,
            iconTheme: IconThemeData(color: Color(0xff272C6E)),
            actions: <Widget>[
              new IconButton(
                  icon: new Icon(Icons.check),
                  onPressed: () async {

                    /*if (widget.user.cmpetences.isNotEmpty) {
                      for (var i in widget.user.cmpetences) {
                        widget.user.cmpetences.add(i);
                        widget.user.list.add(i);
                      }
                    }*/

                    var js = {
                      "competences": widget.user.cmpetences,
                    };
                    await parse_s.putparse("users/" + widget.user.id, js);

                    Navigator.pop(context, widget.user);
                  })
            ],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Profil", style: TextStyle(color: Color(0xff272C6E),fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "louis george cafe"),),
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

          body: new ListView(
            padding: new EdgeInsets.all(16.0),
            children: <Widget>[
              /* new Row(mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Container(padding: new EdgeInsets.only(left: 8.0,right: 8.0),width: 240.0,child:  cmp),
              new Expanded(child: new Container()),
              new Container(child:  new InkWell(onTap: (){
                add_skill();
              },child:  new Container(
                padding: new EdgeInsets.only(top: 4.0, bottom: 4.0),
                width: 70.0,
                alignment: Alignment.center,
                decoration: new BoxDecoration(
                  border: new Border.all(color: Fonts.col_app, width: 1.0),
                  color: Fonts.col_app_shadow,
                  borderRadius: new BorderRadius.circular(8.0),
                ),
                child: new Text(
                  "Ajouter",
                  style: new TextStyle(color:Fonts.col_app),
                ),
              ),))
            ],),*/

              new Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  spacing: 2.0,
                  children: widget.user.cmpetences.map((String item) {
                    return new Container(
                        child: new Chip(
                      backgroundColor: Colors.grey[300],
                      //padding: new EdgeInsets.only(left: 4.0,right: 4.0),
                      deleteIconColor: Fonts.col_app,
                      label: new Text(item),
                      onDeleted: () {
                        deleted(item);
                      },
                    ));
                  }).toList()),
              Divider(),
              loading
                  ? new Center(
                      child: new RefreshProgressIndicator(),
                    )
                  : new Wrap(
                      crossAxisAlignment: WrapCrossAlignment.start,
                      spacing: 2.0,
                      children: domaines.map((Domaine item) {
                        return new Container(
                            child: InkWell(
                                onTap: () {
                                  add_skill_selected(item.name);
                                  setState(() {
                                    domaines.remove(domaines.where((element) =>
                                        element.name == item.name));
                                  });
                                },
                                child: new Chip(
                                  backgroundColor: Colors.grey[300],
                                  //padding: new EdgeInsets.only(left: 4.0,right: 4.0),
                                  deleteIconColor: Fonts.col_app,
                                  label: new Text(item.name),
                                )));
                      }).toList()),
            ],
          ),
        ));
  }
}

/*

   new Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                           new Container(padding: new EdgeInsets.only(left: 8.0,right: 8.0),width: 240.0,child:  cmp),
                            new Expanded(child: new Container()),
                           new Container(child:  new RaisedButton(onPressed: (){
                              add_skill();
                            },child: new Text("Ajouter"),))
                          ],)  ,
                            new Wrap(
                                crossAxisAlignment: WrapCrossAlignment.start,
                                spacing: 2.0,
                                children: cmptes.map((String item) {
                                  return new Chip(
                                    backgroundColor: Colors.grey[300],
                                    //padding: new EdgeInsets.only(left: 4.0,right: 4.0),
                                    deleteIconColor: Colors.purpleAccent,
                                    label: new Text(item),
                                    onDeleted: () {
                                      deleted(item);
                                    },
                                  );
                                }).toList())
                          ],

 */
