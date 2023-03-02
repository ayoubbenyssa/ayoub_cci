import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PdfViewerPage extends StatefulWidget {
  String title ;
  String url ;
  PdfViewerPage(this.title,this.url);
  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  String localPath;
  // bool loading ;

  static Future<String> loadPDF(url) async {

    print("url === ${url}");

    var response = await http.get(url);

    var dir = await getApplicationDocumentsDirectory();
    File file = new File("${dir.path}/data.pdf");
    file.writeAsBytesSync(response.bodyBytes, flush: true);

    return file.path;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loadPDF(widget.url);
    print("url === ${widget.url}");
    print("title === ${widget.title}");


    loadPDF(widget.title).then((value) {

      setState(() {
          localPath = value;
        });
      });

    // ApiServiceProvider.loadPDF().then((value) {
    //   setState(() {
    //     localPath = value;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(247, 247, 247, 100),
    elevation: 0.0,
    iconTheme: IconThemeData(color: Color(0xff272C6E)),
    title: Wrap(
    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(widget.url, maxLines: 2,style: TextStyle(color: Color(0xff272C6E),fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "louis george cafe"),),
    // Container(
    // margin: EdgeInsets.only(right: 10,),
    // height: 40,
    // width: 40,
    // decoration: BoxDecoration(
    // color: Colors.white,
    // borderRadius: BorderRadius.all(Radius.circular(9)),
    //
    // ),
    // child: Center(
    // child: Image.asset("images/logo.png"),
    // ),
    // ),
    ],
    ),

    ),
      body: localPath != null
          ? PDFView(
        filePath: localPath,
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
