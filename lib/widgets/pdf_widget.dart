import 'package:flutter/material.dart';
import 'package:mycgem/widgets/app_appbar.dart';
import 'package:mycgem/widgets/widgets.dart';

class PdfWiget extends StatefulWidget {
  PdfWiget(this.pdfile, this.page,{this.title});

  String pdfile;
  var page;
  String title;

  @override
  _PdfWigetState createState() => _PdfWigetState();
}

class _PdfWigetState extends State<PdfWiget> {
  PageController _pageController;
  bool load = true;

  /*getpdf() async {
    var docc = await PDFDocument.fromURL(widget.pdfile);
    if (!this.mounted) return;

    setState(() {
      doc = docc;
    });
    Future.delayed(Duration(milliseconds: 400)).then((value) async {
      _pageController.jumpToPage(widget.page - 1);
      load = false;
    });
  }*/

  @override
  void initState() {
    _pageController = new PageController();
    // TODO: implement initState
    super.initState();
    //getpdf();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      /*body: doc == null && load == true
          ? Center(
              child: Widgets.load(),
            )
          : PDFViewer(
              document: doc,
              showPicker: false,
              controller: _pageController,

              //indicatorText: Fonts.col_app,
              // tooltip: PDFViewerTooltip(pick: "Choisir une page"),
            ),*/
      appBar: new MyCgemBarApp(
       widget.title.toString()=="null"?"": widget.title,
        actionswidget: Container(),
      ),
    );
  }
}
