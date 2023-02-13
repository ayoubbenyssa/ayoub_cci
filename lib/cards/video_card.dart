import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:mycgem/fils_actualit/card_footer.dart';
import 'package:mycgem/models/user.dart' as prefix0;
import 'package:mycgem/models/video.dart';
import 'package:mycgem/widgets/common.dart';

class VideoCard extends StatefulWidget {
  VideoCard(this.user, this.video, this.chng);

  Video video;
  prefix0.User user;
  var chng;

  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  String videoId;

  //https://www.youtube.com/embed/fq4N0hgOWzU

  //
  final regex =
      RegExp(r'.*\?v=(.+?)($|[\&])', caseSensitive: false, multiLine: false);

  to_id() {
    final url = widget.video.link;
    if (regex.hasMatch(url)) {
      videoId = regex.firstMatch(url).group(1);
      print(videoId);
    } else {
      print("Cannot parse $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    var textcat = new TextStyle(
        color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w600);


    print(widget.video.type);

    void playYoutubeVideo(text) {
      /*  FlutterYoutube.playYoutubeVideoByUrl(
        apiKey: "AIzaSyCfqw9PpyFDSQnX0AS2uEXHtUg1pnMoDEg",
        videoUrl: text,
      );*/

      Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
        return new WebviewScaffold(
          url: text,
          appBar: new AppBar(
            title: new Text(widget.video.title),
            backgroundColor: Colors.black,
          ),
        );
      }));
    }

    return Card(
        margin: EdgeInsets.all(8),
        elevation: 0,

        child: new GestureDetector(
            onTap: () {
              print(widget.video.link);

              playYoutubeVideo(widget.video.link);
              //  _launched = _launch(items[0]);
            },
            child: new Container(
                padding: EdgeInsets.only(top: 4),
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                          width: MediaQuery.of(context).size.width,
                          padding: new EdgeInsets.only(
                              left: 16.0, bottom: 0.0, top: 8.0, right: 16),
                          child: new Text(widget.video.title, style: textcat)),
                      Container(
                        height: 8,
                      ),

                      /*  new Container(
                      width: MediaQuery.of(context).size.width,


                      padding: new EdgeInsets.only(
                          left: 16.0, bottom: 8.0, top: 0.0,right: 16),
                      child: new Text(widget.video.release_date,
                          style: TextStyle(color: Colors.grey[600]))),*/
                      new SizedBox(
                          height: 200.0,
                          child: new Stack(
                            children: <Widget>[
                              new Positioned.fill(
                                child: new FadingImage.network(
                                  widget.video.img,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              /*new Positioned(
                                  left: 2,
                                  right: 2,
                                  top: 2,
                                  bottom: 2,
                                  child: Image.asset("images/youtube.png"))*/
                            ],
                          )),
                      Container(
                        height: 8,
                      ),
                      new Container(
                          color: Colors.grey[100],
                          width: MediaQuery.of(context).size.width,
                          padding: new EdgeInsets.only(
                              left: 16.0, bottom: 4.0, top: 8.0, right: 16),
                          child: new Text(widget.video.link,
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue[600]))),
                      Container(
                        height: 12,
                      ),
                      CardFooter(widget.video, widget.user, null, [], null,
                          null, null, null, widget.chng)
                    ]))));
  }
}
