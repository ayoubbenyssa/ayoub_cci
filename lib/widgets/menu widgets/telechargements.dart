import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:mycgem/pages/conditions.dart';
import 'package:mycgem/widgets/menu%20widgets/view_pdf.dart';
class Telechargements extends StatefulWidget {


  @override
  _TelechargementsState createState() => _TelechargementsState();
}

class _TelechargementsState extends State<Telechargements> {
  String localPath;


  Widget cart_dowloand(){
    return  InkWell(
      onTap: (){
        {
          Navigator.push(context, new MaterialPageRoute<String>(
              builder: (BuildContext context) {
                return new WebviewScaffold(
                  url: "https://www.ibm.com/downloads/cas/GJ5QVQ7X",
                  withJavascript: true,
                  withZoom: true,
                  // zoom
                  hidden: true,
                  appBar: new AppBar(
                    title: new Text(""),
                  ),
                );
              }));

          Navigator.push(context, new MaterialPageRoute<String>(
              builder: (BuildContext context) {
                return new PdfViewerPage(
                  "https://www.ibm.com/downloads/cas/GJ5QVQ7X", "Evolution des indices des prix des materiaux de construction du grand Agadir"
                );
              }));

          // Navigator.push(context, new MaterialPageRoute<String>(
          // builder: (BuildContext context) {
          //   return new PdfViewerPage() }));
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 9,vertical: 8),
        height: 193,width: 138,
        decoration: BoxDecoration(
          color: Color(0xffFDFCFC),
          borderRadius: BorderRadius.all(Radius.circular(18)),
          border: Border.all(color: Color(0xffC9C9CE),width: 1),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),

              ),
              height: 122,width: 122,
              padding: EdgeInsets.symmetric(horizontal: 9,vertical: 8),
              child: Image.asset("assets/images/logo.png",fit: BoxFit.cover,),
            ),
            SizedBox(height: 2,),
            Container(
              child: Text("Evolution des indices des prix des materiaux de construction du grand Agadir",
                maxLines: 3,
                style: TextStyle(color: Color(0xffA9A9A9),fontFamily: "louis george cafe" ,fontSize:12 ,fontWeight: FontWeight.bold),),
            )
          ],
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(247, 247, 247, 100),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Color(0xff272C6E)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Téléchargements", style: TextStyle(color: Color(0xff272C6E),fontSize: 20, fontWeight: FontWeight.bold, fontFamily: "louis george cafe"),),
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
      body: Container(
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
          
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 28,
              runSpacing: 12,
              children: [
                cart_dowloand(),
                cart_dowloand(),
                cart_dowloand(),
                cart_dowloand(),
                cart_dowloand(),
                cart_dowloand(),
              ],
            ),
          )
        ),
      ),
    );
  }
}
