
import 'dart:ui' as prefix0;

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mycgem/home/search_event_pub.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/sector.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/products/fabfill.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/sector_services.dart';
import 'package:mycgem/widgets/fixdropdown.dart';
import 'package:mycgem/widgets/widgets.dart';


class FilterProdServ extends StatefulWidget {

  /*this.doc*/
   FilterProdServ({Key key, @required this.sourceRect,this.user,this.chng})
      : assert(sourceRect != null),
        super(key: key);

    static Route<dynamic> route(BuildContext context, GlobalKey key, use,chnga) {
     RenderBox box = key.currentContext.findRenderObject();
     Rect sourceRect = box.localToGlobal(Offset.zero) & box.size;
     User user = use;
    var chng = chnga;

    return PageRouteBuilder<void>(
      pageBuilder: (BuildContext context, _, __) =>
          FilterProdServ(chng:chng, sourceRect: sourceRect , user: use),
      transitionDuration: const Duration(milliseconds: 350),
    );
  }

  final Rect sourceRect;
   var chng ;

   final User user;

  @override
  _EditorPageState createState() => _EditorPageState();
}

class _EditorPageState extends State<FilterProdServ>
    with TickerProviderStateMixin {
  TabController _tabController;
  final _titrecontroller = new TextEditingController();
  FocusNode _focustitre = new FocusNode();
  List<Sector> _list = [];
  int type_prod = 0;

  String selectedValue1 = "";


  getSectors() async {
    List<Sector> sect = await SectorsServices.get_list_sectors();
    setState(() {
      _list = sect;
    });
  }


  List<Tab> tabs() =>
      <Tab>[
        new Tab(
            text: "TOUS",
            icon: SvgPicture.asset("images/icons/all.svg",
                height: 20.0, color: Fonts.col_app)),
        new Tab(
            text: "PRODUITS",
            icon: SvgPicture.asset("images/icons/product.svg",
                height: 30.0, color: Fonts.col_app)),
        new Tab(
            text: "SERVICES",
            icon: SvgPicture.asset("images/icons/cust.svg",
                height: 20.0, color: Fonts.col_app))
      ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(vsync: this, length: tabs().length);
    getSectors();
  }

  @override
  Widget build(BuildContext context) {
    String fabIcon = 'images/icons/filter.png';

    Widget titre =  Widgets.textfield_des1(
            "Chercher un produit ou un service", _focustitre, "",
            _titrecontroller, TextInputType.text, null);

    Widget drop_down() =>
        _list.isEmpty
            ? Container()
            : new Container(
            color: Colors.white,
            width: 700.0,
            height: 60.0,
            child: Container(
                margin: const EdgeInsets.all(8.0),
                // padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                decoration: new BoxDecoration(
                  // color: Fonts.col_app,
                  border: new Border.all(color: Colors.grey[100], width: 1.0),
                  borderRadius: new BorderRadius.circular(2.0),
                ),
                child: new FixDropDown(
                  style: TextStyle(color: Colors.black),
                    iconSize: 32.0,
                    isDense: false,
                    items: _list.map((Sector value) {
                      return new FixDropdownMenuItem(
                        value: value,
                        child: new Text(
                          value.name.toString(),
                          maxLines: 2,
                          textAlign: TextAlign.justify,
                          softWrap: true,
                          style: new TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    hint: new Text(
                      selectedValue1 != ""
                          ? selectedValue1
                          : "Choisir un secteur",
                      maxLines: 1,
                      softWrap: true,
                      style: new TextStyle(color: Colors.black),
                    ),
                    onChanged: (Sector value) {
                      setState(() {
                        selectedValue1 = value.name;
                        //depctrl.text = value.name;
                        //Reload();
                      });
                    })));

    return FabFillTransition(
      source: widget.sourceRect,
      icon: fabIcon,
      child: Scaffold(
        bottomNavigationBar: Container(width:
        MediaQuery
            .of(context)
            .size
            .width,
          height: MediaQuery.of(context).size.height*0.08,
          child: RaisedButton(
          padding: EdgeInsets.all(0),
           color: const Color(0xffff374e),
          onPressed: () {
            print(_titrecontroller.text);
            print(type_prod);
            print(selectedValue1);

            Navigator.push(context, new MaterialPageRoute(
                builder: (BuildContext context) {
                  return new SearchNewEvent(
                      _titrecontroller.text,
                      widget.user,
                      null,
                      null,
                      null,
                      "prod_service",                    widget.chng,
                  );
                }));

          },
          child: const Text(
            "FILTRER",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ), ),
        appBar: AppBar(
          elevation: 1.0,
          titleSpacing: 0,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.close,
              color: Fonts.col_app_fonn,
            ),
          ),
          backgroundColor: Fonts.col_app_shadow,
          centerTitle: true,
          title: Text(
            "Filtre des produits et des services",
            style: TextStyle(color: Fonts.col_app_fonn, fontSize: 13.5),
          ),
          actions: <Widget>[
          ],
        ),
        backgroundColor: Colors.grey[100],
        body: SafeArea(
            child: ListView(
              children: <Widget>[

                Container(
                  color: Colors.grey[300], padding: EdgeInsets.all(16),
                  child: Text(
                    "Mots clés:", style: TextStyle(color: Fonts.col_app_fonn,
                      fontWeight: FontWeight.w700),),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,),

                Container(height: 8,),
                Padding(padding: EdgeInsets.only(left: 16, right: 16),
                    child: titre),
                Container(height: 8,),

                Container(
                  color: Colors.grey[300], padding: EdgeInsets.all(16),
                  child: Text(
                    "Type:", style: TextStyle(color: Fonts.col_app_fonn,
                      fontWeight: FontWeight.w700),),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,),
                Center(child: Container(
                  //width: MediaQuery.of(context).size.width,
                    child: new TabBar(
                      isScrollable: true,
                      indicatorColor: Fonts.col_app,
                      unselectedLabelColor: Colors.blueGrey[300],
                      labelColor: Fonts.col_app,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: new BubbleTabIndicator(
                        indicatorHeight: 60.0,
                        indicatorRadius: 4.0,
                        indicatorColor: Colors.white,
                        tabBarIndicatorSize: TabBarIndicatorSize.tab,
                      ),
                      tabs: tabs(),
                      onTap: (val) {
                        print(val);
                        type_prod = val;
                        //setv(val);
                      },
                      controller: _tabController,
                    ))),
                Container(
                  color: Colors.grey[300], padding: EdgeInsets.all(16),
                  child: Text(
                    LinkomTexts.of(context).sector()+ ":", style: TextStyle(color: Fonts.col_app_fonn,
                      fontWeight: FontWeight.w700),),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,),
                drop_down()
              ],
            )),
      ),
    );
  }

  Widget get _spacer {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(width: double.infinity, height: 1, color: Colors.grey),
    );
  }
}
