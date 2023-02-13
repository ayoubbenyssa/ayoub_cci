import 'package:flutter/material.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/validators.dart';
import 'package:mycgem/user/myprofile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycgem/widgets/widgets.dart';

class AddVote extends StatefulWidget {
  AddVote(this.user, this.list,{this.type});

  User user;
  List list;
  var type;


  @override
  _AddVoteState createState() => _AddVoteState();
}

class _AddVoteState extends State<AddVote> {
  // String selectedValue = "";
  ScrollController scrollController = new ScrollController();

  ParseServer parse_s = new ParseServer();
  final _descctrl = new TextEditingController();
  FocusNode _descfocus = new FocusNode();
  bool _autovalidate = false;
  bool uploading = false;
  var im = "";
  var lo = false;
  var error = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List<TextEditingController> txted = new List<TextEditingController>();
  List<String> ids = new List<String>();

  List<bool> show = new List<bool>();
  Validators val = new Validators();

  bool sho = false;
  bool load = false;

  //FocusNode _focus = new FocusNode();

  int count = 1;
  List lst = [];

  Widget desc() => Widgets.textfield_des(
      "Votre question", _descfocus, "", _descctrl, TextInputType.text, val.validatedesc);

  Widget answers_field(controller, focus, i) => new Padding(
      padding: new EdgeInsets.only(bottom: 16.0),
      child: new Container(
        width: ScreenUtil().setWidth(620.0),
        //name, focus, value, myController, type, validator,
        child: Widgets.textfield("Option  " + i.toString(), focus, "",
            controller, TextInputType.text, val.validatedesc),
      ));

  List<Widget> children() => new List.generate(count, (int i) {
        print(sho);

        txted.add(new TextEditingController());
        show.add(false);
        return show[i] == true
            ? Container()
            : sho == true && i < count - 1
                ? Card(
                    elevation: 2.0,
                    borderOnForeground: true,
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.78,
                        child: Row(children: <Widget>[
                          Container(
                              width: MediaQuery.of(context).size.width * 0.65,
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                txted[i].text,
                                style: TextStyle(
                                    color: load == true
                                        ? Colors.grey[400]
                                        : Colors.black),
                              )),
                          IconButton(
                              icon: Icon(
                                Icons.close,
                                color:
                                    load == true ? Colors.red[100] : Colors.red,
                              ),
                              onPressed: () async {
                                setState(() {
                                  load = true;
                                });

                                await parse_s.deleteparse("options/" + ids[i]);
                                setState(() {
                                  load = true;
                                  show[i] = true;
                                  ids.removeAt(i);
                                  print(i);
                                  //count= count-1;
                                });
                              })
                        ])))
                : answers_field(txted[i], new FocusNode(), i + 1);
      });

  @override
  Widget build(BuildContext context) {
  //  ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    var ht = ScreenUtil().setHeight(24.0);

    return Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          title: new Text(
            "Publier un sondage",
            style: TextStyle(fontSize: ScreenUtil().setSp(16.0)),
          ),
          elevation: 0.0,
          actions: <Widget>[
            new InkWell(
              onTap: () async {
                Widgets.onLoading(context);

                for (var i in ids) {
                  lst.add({
                    "__type": "Pointer",
                    "className": "options",
                    "objectId": i
                  });
                }

                var js = {
                  "title": _descctrl.text,
                  "type": "sondage",
                  "active": 1,
                  "author": {
                    "__type": "Pointer",
                    "className": "users",
                    "objectId": widget.user.id
                  },
                  "options": {"__op": "AddUnique", "objects": lst}
                };

                await parse_s.postparse('offers', js);
                Navigator.of(context, rootNavigator: true).pop('dialog');
                Navigator.pop(context);
              },
              child: new Container(
                padding: EdgeInsets.all(4.0),
                margin: EdgeInsets.all(4.0),
                //width: 100.0,
                height: 20.0,
                decoration: new BoxDecoration(
                  border: new Border.all(color: Colors.white, width: 2.0),
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                child: new Center(
                  child: new Text(
                    LinkomTexts.of(context).sve(),
                    style: new TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: new Form(
            key: _formKey,
            autovalidate: _autovalidate,
            //onWillPop: _warnUserAboutInvalidData,

            child: new ListView(
                controller: scrollController,
                padding: new EdgeInsets.all(ht),
                children: <Widget>[
                  new Container(height: ht),
                  desc(),
                  new Container(height: ht),
                  new Text(
                    "Options: ",
                    style: TextStyle(
                        color: Fonts.col_app,
                        fontSize: ScreenUtil().setSp(15.0)),
                  ),
                  new Container(height: ht * 2),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      new Column(children: children()),
                      new Expanded(child: new Container()),
                      new Padding(
                          padding: new EdgeInsets.only(top: 18.0),
                          child: new GestureDetector(
                              child: new Container(
                                  padding: const EdgeInsets.all(0.5),
                                  // borde width
                                  decoration: new BoxDecoration(
                                    color: Colors.black, // border color
                                    shape: BoxShape.circle,
                                  ),
                                  child: new CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 18.0,
                                    child: new Icon(
                                      Icons.add,
                                      color: Fonts.col_app,
                                      size: 28.0,
                                    ),
                                  )),
                              onTap: () async {
                                final FormState form = _formKey.currentState;
                                if (!form.validate()) {
                                  _autovalidate = true;
                                } else {
                                  setState(() {
                                    load = true;
                                    sho = true;
                                  });

                                  var js = {
                                    "title": txted[count - 1].text,
                                    "users": [],
                                  };
                                  await parse_s
                                      .postparse('options', js)
                                      .then((val) {
                                    print(val);
                                    ids.add(val["objectId"]);
                                  });

                                  setState(() {
                                    load = false;
                                  });
                                  setState(() {
                                    count = count + 1;
                                  });
                                  scrollController.animateTo(9000.0,
                                      curve: Curves.easeOut,
                                      duration: const Duration(seconds: 1));
                                }
                                /*setState(() {
                                  count = count + 1;
                                });*/
                              })),
                    ],
                  ),
                ])));
  }
}
