import 'package:flutter/material.dart';
import 'package:mycgem/models/revue.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/widgets/common.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class RevueCard extends StatefulWidget {
  RevueCard(this.user, this.revue);

  User user;
  Revue revue;

  @override
  _RevueCardState createState() => _RevueCardState();
}

class _RevueCardState extends State<RevueCard> {
  Future<File> createFileOfPdfUrl() async {
    // final url =
    // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
    final url = widget.revue.url;
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.revue.img.toString());
  }

  @override
  Widget build(BuildContext context) {
    final imageOverlayGradient = new DecoratedBox(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          colors: [
            const Color(0xFF000000),
            // Colors.black87,
            const Color(0x00000000),
            const Color(0x00000000),
          ],
        ),
      ),
    );

    return Stack(children: <Widget>[
      Container(
          padding: EdgeInsets.all(2),
          child: Material(
            elevation: 15.0,
            shadowColor: Colors.yellow.shade900,
            child: InkWell(
                onTap: () {
                  // Navigator.pushNamed(context, 'detail/${book.title}');
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.52,
                  color: Colors.grey[400],
                  child: FadingImage.network(
                    widget.revue.img,
                    height: MediaQuery.of(context).size.height * 0.52,
                    fit: BoxFit.cover,
                  ),
                )),
          )),
      new Positioned(
          top: 4,
          right: 4,
          child: RaisedButton(
            onPressed: () {






              /* File file = await createFileOfPdfUrl();
      if (file != null) {
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) => PDFScreen(path: file.path)),
    );
    }*/
            },
            color: Fonts.col_app_fonn.withOpacity(0.92),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(4.0)),
            child: Text(
              widget.revue.img.toString(),
              style: TextStyle(color: Colors.white),
            ),
          )),
      new Positioned(
          bottom: 0,
          left: 4,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.48,
            padding: EdgeInsets.all(8.0),
            decoration: new BoxDecoration(
              color: Colors.black38,
              borderRadius: const BorderRadius.all(const Radius.circular(4.0)),
            ),
            child: Text(
              widget.revue.date,
              style: TextStyle(color: Colors.white, fontSize: 12.5),
            ),
          )),
    ]);
  }
}
