import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/language_params/scope_model_wrapper.dart';
import 'package:mycgem/models/model_formation.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/widgets/app_appbar.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'add_formations.dart';

class Formations extends StatefulWidget {
  @override
  _PresentationState createState() => _PresentationState();
}

class _PresentationState extends State<Formations> {
  List<Formation_model> formation = [];

  static ParseServer parse_s = new ParseServer();


  bool load = true ;

  /* PDFDocument doc;

  getpdf(dc) async {
    var docc = await PDFDocument.fromURL(dc);
    setState(() {
      doc = docc;
    });
  }*/ //

  Widget items_cart(image,title,text,iconH,iconW){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 5),

        margin: EdgeInsets.only(bottom: 5),
        child :
        Wrap(
          children: [
            Row(
              children: [
                Container(
                  child: Image.asset(image,height: iconH,width: iconW,fit: BoxFit.cover,),
                ),
                SizedBox(width: 6,),
                Container(
                  child: Text(title, maxLines: 3,style: TextStyle(
                      color: Color(0xff262B6D),fontFamily: "Louis George Cafe",fontSize: 13,fontWeight: FontWeight.bold
                  ),),
                ),

              ],
            ),
            SizedBox(height: 10,),

            Wrap(children: [
              Container(
                padding: EdgeInsets.only(left: 19,top: 2),
                child: Text(text, maxLines: 3,style: TextStyle(
                    color: Color(0xffBCBCBC),fontFamily: "Louis George Cafe",fontSize: 13,fontWeight: FontWeight.bold
                ),),
              ),
            ],),
            SizedBox(height: 5,),

          ],
        )
    );
  }

  Widget cart_item(date  , CONVENTION ,PAYS){
    return  Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
      // height: 165,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18)),
        border: Border.all(color: Color(0xffC9C9CE),width: 0.5),

      ),
      child: Column(
        children: [
          items_cart("images/date.png","DATE :" , date,20.00,17.00)   ,
          items_cart("images/handshake.png","CONVENTION :" ,CONVENTION,15.00,14.00)   ,
          items_cart("images/localisation.png","PAYS : " , PAYS,20.00,17.00)   ,
        ],
      ),
    );
  }

  static get_list_partners_all() async {
    //,"sponsored":1
    String url = 'formation';
    var getc = await parse_s.getparse(url);
    if (getc == "No") return "No";
    if (getc == "error") return "error";
    List res = getc["results"];

    print("res !@@@@@@@@@@@@@@@@@@");
    print(res);
    print("res !@@@@@@@@@@@@@@@@@@");


    return res
        .map((var contactRaw) => new Formation_model.fromMap(contactRaw))
        .toList();
  }

  getAll() async {
    var a = await get_list_partners_all();
    if (!this.mounted) return;
    setState(() {
      formation = a;
      // gal.insert(0, Partnr(date: "Date", name: "Convention", country: "Pays"));

      load = false;
    });
  }

  // getpr() async {
  //   var a = await parse_server.getparse("formation");
  //   if (!this.mounted) return;
  //
  //   print(a["results"]);
  //
  //   setState(() {
  //     formation = a["results"][0];
  //     load = false ;
  //     // doc = a["results"][0]["doc"];
  //     //  getpdf(a["results"][0]["doc"]);
  //   });
  // }

  @override
  void initState() {
    super.initState();
    get_list_partners_all();
    getAll();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        floatingActionButton: FloatingActionButton(
          heroTag: null,
          highlightElevation: 7.0,
          backgroundColor: Colors.transparent,

          elevation: 0.0,
          //iconSize: 62,

          child: Container(
            decoration: BoxDecoration(
                color: Fonts.col_app,
                borderRadius: BorderRadius.all(Radius.circular(14.r))
            ),
            width: 60.w,
            height: 60.h,
            child: Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.add, color: Colors.white, size: 40.r)),
          ),
          onPressed: () {
            Navigator.push(context,
                new MaterialPageRoute(builder: (BuildContext context) {
                  return new Add_formation();
                }));
          },
        ),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(247, 247, 247, 100),
          elevation: 0.0,
          iconTheme: IconThemeData(color: Color(0xff272C6E)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Formation", style: TextStyle(color: Color(0xff272C6E),fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "louis george cafe"),),
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
        body:  Container(
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

              child: load ? Center(child: Widgets.load()) : SingleChildScrollView(
                child: Column(

                    children: formation
                        .map(
                            (e) =>
                            cart_item(e.date_formation.split("T")[0],e.title,e.lieu)
                    )
                        .toList()),

              ),
            ))
    );


    // return Scaffold(
    //     appBar: MyCgemBarApp(
    //       "Formation",
    //       actionswidget: Container(),
    //     ),
    //     body: ListView(
    //       padding: EdgeInsets.all(16),
    //       children: [
    //
    //         Padding(
    //             padding: EdgeInsets.only(left: 12, right: 12, bottom: 12),
    //             child: HtmlWidget(
    //               summary == null
    //                   ? ""
    //                   : summary["titre"]
    //                       .toString()
    //                       .replaceAll(RegExp(r'(\\n)+'), ''),
    //             )),
    //
    //         Padding(
    //             padding: EdgeInsets.only(left: 12, right: 12, bottom: 12),
    //             child: HtmlWidget(
    //               summary == null
    //                   ? ""
    //                   : summary["description"]
    //                       .toString()
    //                       .replaceAll(RegExp(r'(\\n)+'), ''),
    //             )),
    //
    //         Padding(
    //             padding: EdgeInsets.only(left: 12, right: 12, bottom: 12),
    //             child: HtmlWidget(
    //               summary == null
    //                   ? ""
    //                   : summary["lieu"]
    //                       .toString()
    //                       .replaceAll(RegExp(r'(\\n)+'), ''),
    //             )),
    //         /*  doc == null
    //             ? Container(
    //                 child: Center(
    //                   child: Widgets.load(),
    //                 ),
    //               )
    //             : Container(
    //                 width: MediaQuery.of(context).size.width,
    //                 height: MediaQuery.of(context).size.height * 0.5,
    //                 child: PDFViewer(
    //                   document: doc,
    //
    //                   //indicatorText: Fonts.col_app,
    //                   tooltip: PDFViewerTooltip(pick: "Choisir une page"),
    //                 ))*/
    //       ],
    //     ) /*ListView(
    //     padding: EdgeInsets.all(16.0),
    //     children: <Widget>[
    //       ScopedModelDescendant<AppModel1>(
    //           builder: (context, child, model) => HtmlWidget(
    //                 summary == null
    //                     ? ""
    //                     : model.locale == "ar"
    //                         ? summary["text_ar"]
    //                             .toString()
    //                             .replaceAll(RegExp(r'(\\n)+'), '')
    //                         : summary["text"]
    //                             .toString()
    //                             .replaceAll(RegExp(r'(\\n)+'), ''),
    //               )),
    //     ],
    //   ),*/
    //     );
  }
}
