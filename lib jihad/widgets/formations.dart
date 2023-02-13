import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:mycgem/func/parsefunc.dart';
import 'package:mycgem/language_params/linkom_texts.dart';
import 'package:mycgem/language_params/scope_model_wrapper.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/widgets/app_appbar.dart';
import 'package:mycgem/widgets/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

class Formations extends StatefulWidget {
  @override
  _PresentationState createState() => _PresentationState();
}

class _PresentationState extends State<Formations> {
  var summary = null;
  ParseServer parse_server = new ParseServer();

  /* PDFDocument doc;

  getpdf(dc) async {
    var docc = await PDFDocument.fromURL(dc);
    setState(() {
      doc = docc;
    });
  }*/ //

  getpr() async {
    var a = await parse_server.getparse("formation");
    if (!this.mounted) return;

    print(a["results"]);

    setState(() {
      summary = a["results"][0];
      // doc = a["results"][0]["doc"];
      //  getpdf(a["results"][0]["doc"]);
    });
  }

  @override
  void initState() {
    super.initState();
    getpr();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyCgemBarApp(
          "Formation",
          actionswidget: Container(),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [

            Padding(
                padding: EdgeInsets.only(left: 12, right: 12, bottom: 12),
                child: HtmlWidget(
                  summary == null
                      ? ""
                      : summary["formation_continue"]
                          .toString()
                          .replaceAll(RegExp(r'(\\n)+'), ''),
                )),

            Padding(
                padding: EdgeInsets.only(left: 12, right: 12, bottom: 12),
                child: HtmlWidget(
                  summary == null
                      ? ""
                      : summary["finance_text"]
                          .toString()
                          .replaceAll(RegExp(r'(\\n)+'), ''),
                )),

            Padding(
                padding: EdgeInsets.only(left: 12, right: 12, bottom: 12),
                child: HtmlWidget(
                  summary == null
                      ? ""
                      : summary["etablissement_text"]
                          .toString()
                          .replaceAll(RegExp(r'(\\n)+'), ''),
                )),
            /*  doc == null
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
                    ))*/
          ],
        ) /*ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          ScopedModelDescendant<AppModel1>(
              builder: (context, child, model) => HtmlWidget(
                    summary == null
                        ? ""
                        : model.locale == "ar"
                            ? summary["text_ar"]
                                .toString()
                                .replaceAll(RegExp(r'(\\n)+'), '')
                            : summary["text"]
                                .toString()
                                .replaceAll(RegExp(r'(\\n)+'), ''),
                  )),
        ],
      ),*/
        );
  }
}
