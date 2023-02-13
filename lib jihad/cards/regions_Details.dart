import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart' as ht;
import 'package:mycgem/models/commission.dart';
import 'package:mycgem/models/region.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/widgets/app_appbar.dart';
import 'package:mycgem/widgets/common.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RegionDetails extends StatefulWidget {
  RegionDetails(this.region);

  Region region;

  @override
  _RegionDetailsState createState() => _RegionDetailsState();
}

class _RegionDetailsState extends State<RegionDetails> {
  var controller;

  String hight;
  double webHight = 400; //default some value
  Future funcThatMakesAsyncCall() async {
    var result =
    await controller.evaluateJavascript('document.body.scrollHeight');
    //here we call javascript for get browser data
    setState(
          () {
        hight = result;
      },
    );
  }

 /* PDFDocument doc;

  getpdf() async {
    print(widget.region.docUrl);
    var docc = await PDFDocument.fromURL(widget.region.docUrl);
    setState(() {
      doc = docc;
    });
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

   // getpdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: MyCgemBarApp(
          widget.region.name,
          actionswidget: Container(),
        ),
        body: ListView(
          children: <Widget>[
            widget.region.img.toString() == "null"
                ? Container()
                : Column(children: [
              /* new Padding(
                        padding: EdgeInsets.all(8),
                        child: InkWell(
                            onTap: () {},
                            child: Material(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(22)),
                                elevation: 1,
                                child: ClipRRect(
                                    //<--clipping image
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(22)),
                                    child: Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.36,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.86,
                                        child: Hero(
                                            tag: widget.region.id,
                                            child: widget.region.img
                                                        .toString() ==
                                                    "null"
                                                ? Container()
                                                : FadingImage.network(
                                                    widget.region.img,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.36,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.86,
                                                    fit: BoxFit.cover,
                                                  )))))))*/
            ]),
            Container(
                padding: EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width * 0.65,
                child: Text(
                  widget.region.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Fonts.col_app_fon,
                      height: 1.2),
                )),
            Container(
              color: Fonts.col_grey.withOpacity(0.3),
              padding: widget.region.chef_name == ""
                  ? EdgeInsets.all(0)
                  : EdgeInsets.all(16),
              child: Column(
                children: [
                  widget.region.chef_civilite == ""
                      ? Container()
                      : Text(
                    widget.region.name.contains("MeM")
                        ? "Président MeM by CGEM"
                        : widget.region.name.contains("Casablanca")
                        ? "Président"
                        : widget.region.chef_civilite == "M"
                        ? "Président Régional"
                        : widget.region.chef_civilite == "Mme"
                        ? "Présidente Régionale"
                        : "",
                    style: TextStyle(
                        color: Fonts.col_app,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  widget.region.chef_name == ""
                      ? Container()
                      : Container(
                    height: 16,
                  ),
                  widget.region.chef_name == ""
                      ? Container()
                      : Text(
                    widget.region.chef_name.toString(),
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  widget.region.chef_name == ""
                      ? Container()
                      : Container(
                    height: 16,
                  ),
                  widget.region.chef_image == ""
                      ? Container()
                      : Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: ClipRRect(
                          borderRadius:
                          BorderRadius.all(Radius.circular(8)),
                          child: widget.region.chef_image == null
                              ? Container()
                              : Image.network(
                            widget.region.chef_image,
                            fit: BoxFit.cover,
                          ))),
                  widget.region.chef_image == ""
                      ? Container()
                      : Container(
                    height: 16,
                  ),
                  widget.region.chef_image == ""
                      ? Container()
                      : Container(
                    height: 28,
                  ),
                  widget.region.vice_chef == ""
                      ? Container()
                      : Text(
                    widget.region.name.contains("MeM")
                        ? "Vice-Président MeM by CGEM"
                        : widget.region.name.contains("Casablanca")
                        ? "Vice-Président Général"
                        : widget.region.vice_civilite == "M"
                        ? "Vice-Président Général Régional"
                        : widget.region.vice_civilite == "Mme"
                        ? "Vice-présidente Générale Régionale"
                        : "",
                    style: TextStyle(
                        color: Fonts.col_app,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  widget.region.vice_chef == ""
                      ? Container()
                      : Container(
                    height: 16,
                  ),
                  widget.region.vice_chef == ""
                      ? Container()
                      : Text(
                    widget.region.vice_chef.toString(),
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  widget.region.vice_image == ""
                      ? Container()
                      : Container(
                    height: 16,
                  ),
                  widget.region.vice_image == ""
                      ? Container()
                      : Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: ClipRRect(
                          borderRadius:
                          BorderRadius.all(Radius.circular(8)),
                          child: widget.region.vice_image == ""
                              ? Container()
                              : Image.network(
                            widget.region.vice_image,
                            fit: BoxFit.cover,
                          ))),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.all(16),
                child: ht.HtmlWidget(
                  widget.region.description
                      .toString()
                      .replaceAll(RegExp(r'(\\n)+'), ''),
                )),
           /* widget.region.docUrl != null
                ? doc == null
                ? Container(
              child: Center(
                child: Widgets.load(),
              ),
            )
                : Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5,
                child: PDFViewer(
                  document: doc,
                  //indicatorText: Fonts.col_app,
                  tooltip: PDFViewerTooltip(pick: "Choisir une page"),
                ))
                : Container()*/
          ],
        ));
  }
}
