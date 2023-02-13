import 'dart:async';
import 'dart:io';
import 'dart:async';
import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart' as ht;
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/models/commission.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/widgets/common.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ComDetails extends StatefulWidget {
  ComDetails(this.com, this.bl);

  Commission com;
  bool bl = false;

  @override
  _ComDetailsState createState() => _ComDetailsState();
}

class _ComDetailsState extends State<ComDetails> {
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

  PDFDocument doc;

  getpdf() async {
    print(widget.com.docUrl);
    var docc = await PDFDocument.fromURL(widget.com.docUrl);
    setState(() {
      doc = docc;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getpdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Fonts.col_app_shadow,
          iconTheme: IconThemeData(color: Fonts.col_app_fonn),
          title: Text(
            "",
            style: TextStyle(color: Fonts.col_app_fonn),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            widget.com.img.toString() == "null"
                ? Container()
                : Column(children: [
                    new Padding(
                        padding: EdgeInsets.all(8),
                        child: InkWell(
                            onTap: () {},
                            child: Material(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(22)),
                                elevation: 2,
                                child: ClipRRect(
                                    //<--clipping image
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(22)),
                                    child: Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.56,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.56,
                                        child: Hero(
                                            tag: widget.com.objectId,
                                            child: widget.com.img.toString() ==
                                                    "null"
                                                ? Container()
                                                : FadingImage.network(
                                                    widget.com.img,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.56,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.56,
                                                    fit: BoxFit.fitWidth,
                                                  )))))))
                  ]),
            Container(
                padding: EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  widget.com.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Fonts.col_app_fon,
                      height: 1.2),
                )),
            Container(
              color: Fonts.col_grey.withOpacity(0.3),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    widget.com.chef_civilite == "M"
                        ? "Président"
                        : widget.com.chef_civilite == "Mme"
                            ? "Présidente"
                            : "",
                    style: TextStyle(
                        color: Fonts.col_app,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  Container(
                    height: 16,
                  ),
                  Text(
                    widget.com.chef.toString(),
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  Container(
                    height: 16,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: widget.com.chef_image == null
                              ? Container()
                              : Image.network(
                                  widget.com.chef_image,
                                  fit: BoxFit.cover,
                                ))),
                  Container(
                    height: 16,
                  ),
                  widget.bl == true
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Expanded(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Container(
                                      height: 8,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Adresse : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.72,
                                            child: Text(
                                              widget.com.address,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ))
                                      ],
                                    ),
                                    Container(
                                      height: 8,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Tél : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.72,
                                            child: Text(
                                              widget.com.tel,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ))
                                      ],
                                    ),
                                    Container(
                                      height: 8,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Fax : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.72,
                                            child: Text(
                                              widget.com.fax,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ))
                                      ],
                                    ),
                                    Container(
                                      height: 8,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "E-mail : ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.72,
                                            child: Text(
                                              widget.com.email,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                            ))
                                      ],
                                    ),
                                  ])),
                            ])
                      : Container(),
                  Container(
                    height: 16,
                  ),
                  widget.bl == true
                      ? Container()
                      : Text(
                          widget.com.vice_civilite == "M"
                              ? "Vice-Président"
                              : widget.com.vice_civilite == "Mme"
                                  ? "Vice-Présidente"
                                  : "",
                          style: TextStyle(
                              color: Fonts.col_app,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                  Container(
                    height: 16,
                  ),
                  widget.bl == true
                      ? Container()
                      : Text(
                          widget.com.vice_chef.toString(),
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                  Container(
                    height: 16,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: widget.com.vice_image == null
                              ? Container()
                              : Image.network(
                                  widget.com.vice_image,
                                  fit: BoxFit.cover,
                                ))),
                ],
              ),
            ),
            widget.bl
                ? widget.com.description == null
                    ? Container()
                    : Container(
                        padding: EdgeInsets.all(16),
                        child: ht.HtmlWidget(
                          widget.com.description
                              .toString()
                              .replaceAll(RegExp(r'(\\n)+'), ''),
                        ))
                : Container(
                    /*padding: EdgeInsets.only(left: 16,right: 16),
                    width: MediaQuery.of(context).size.width * 0.68,
                    child: Text(
                      widget.com.description.toString() == 'null'
                          ? ""
                          : widget.com.description.toString(),
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                    )*/
                    ),
            widget.bl
                ? Container()
                : widget.com.docUrl != null
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
                              tooltip:
                                  PDFViewerTooltip(pick: "Choisir une page"),
                            ))
                    /*ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 5000),
                        child: WebView(
                          initialUrl: widget.com.docUrl,

                          gestureRecognizers: Set()
                            ..add(
                              Factory<VerticalDragGestureRecognizer>(
                                () => VerticalDragGestureRecognizer(),
                              ), // or null
                            ),
                          key: Key("webview1"),
                          debuggingEnabled: true,
                          javascriptMode: JavascriptMode.unrestricted,
                          //    gestureRecognizers: Set()..add(Factory<VerticalDragGestureRecognizer>(()=>VerticalDragGestureRecognizer())),
                        ))*/
                    : Container()
          ],
        )));
  }
}
