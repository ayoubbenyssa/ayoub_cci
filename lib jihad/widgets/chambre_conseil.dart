import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/conseiler.dart';
import 'package:mycgem/models/resp.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/sector_services.dart';
import 'package:mycgem/widgets/app_appbar.dart';
import 'package:mycgem/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycgem/widgets/pdf_widget.dart';
import 'package:mycgem/widgets/widgets.dart';

class ChambreConseil extends StatefulWidget {
  ChambreConseil(this.scaff_exist);

  bool scaff_exist;

  @override
  _ChambreConseilState createState() => _ChambreConseilState();
}

class _ChambreConseilState extends State<ChambreConseil> {
  List<Conseiller> cons = new List<Conseiller>();

  bool loading = true;

  getlist() async {
    List<Conseiller> conss = await SectorsServices.get_list_conseillers();
    setState(() {
      cons = conss;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getlist();
  }

  @override
  Widget build(BuildContext context) {
    Widget refreshprogress = new Center(
        child: new Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: new RefreshProgressIndicator()));

    Widget page = loading
        ? Center(
            child: Widgets.load(),
          )
        : Column(children: [
            Center(
              child: FlatButton(
                onPressed: () {
                  Navigator.push(context, new MaterialPageRoute<String>(
                      builder: (BuildContext context) {
                    return new WebviewScaffold(
                      url: "http://cgem-parlement.ma/",
                      withJavascript: true,
                      withZoom: true,
                      // zoom
                      hidden: true,
                      appBar: new AppBar(
                        title: new Text(""),
                      ),
                    );
                  }));
                },
                child: Text(
                  "http://cgem-parlement.ma/",
                  style: TextStyle(
                      color: Fonts.col_app,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp),
                ),
              ),
            ),
            Expanded(
                child: ListView(
                    padding: EdgeInsets.only(top: 6),
                    children: cons
                        .map((Conseiller a) => Consseilerwidget(a))
                        .toList()))
          ]);

    return widget.scaff_exist == false
        ? page
        : new Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: MyCgemBarApp(
              "Groupe CGEM à la Chambre des Conseillers",
              actionswidget: Container(),
            ),
            body: new Padding(
              padding: new EdgeInsets.only(top: 0.0),
              child: page,
            ));
  }
}

class Consseilerwidget extends StatelessWidget {
  Consseilerwidget(this.conseiller);

  Conseiller conseiller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Card(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(8.0)),
          elevation: 0.0,
          child: Column(children: <Widget>[
            Container(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 8.w,
                ),
                GestureDetector(
                  child: Material(
                      borderRadius: BorderRadius.all(Radius.circular(22)),
                      elevation: 2,
                      child: ClipRRect(
                          //<--clipping image
                          borderRadius: BorderRadius.all(Radius.circular(22)),
                          child: Container(
                              height: MediaQuery.of(context).size.width * 0.26,
                              width: MediaQuery.of(context).size.width * 0.26,
                              child: Hero(
                                  tag: conseiller.id,
                                  child: conseiller.picture.toString() == "null"
                                      ? Container()
                                      : FadingImage.network(
                                          conseiller.picture,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.28,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.26,
                                          fit: BoxFit.cover,
                                        ))))),
                  onTap: () {
                    if (conseiller.document != "")
                      Navigator.push(context, new MaterialPageRoute<String>(
                          builder: (BuildContext context) {
                        return PdfWiget(
                          conseiller.document,
                          0,
                          title: conseiller.name,
                        );
                      }));
                  },
                ),
                Container(
                  width: 12.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 4,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          conseiller.name,
                          maxLines: 6,
                          style: TextStyle(
                              color: Fonts.col_ap_fonn,
                              fontSize: 15.5.sp,
                              fontWeight: FontWeight.w700),
                        )),
                    Container(
                      height: 8.sp,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          conseiller.title,
                          maxLines: 8,
                          style: TextStyle(
                              fontSize: 13.5.sp,
                              height: 1.4,
                              color: Colors.grey[600]),
                        )),
                    Container(
                      height: 4,
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: 10,
            )
          ])),
    );
  }
}
