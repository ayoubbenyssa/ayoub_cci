import 'package:flutter/material.dart';
import 'package:mycgem/models/user.dart';
import 'package:mycgem/parc_events_stream/parc_events_stream.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/widgets/app_appbar.dart';
import 'package:mycgem/youtube_videos/models/example_content.dart';
import 'package:mycgem/youtube_videos/views/youtube_card.dart';
import 'package:youtube_api/youtube_api.dart';

class YoutubeBody extends StatefulWidget {
  YoutubeBody  (this.user, this.lat, this.lng,
  this.list_partner, this.analytics, this.chng);
  User user;
  var lat,lng;
  List list_partner;
  var analytics;
  var chng;



  @override
  _YoutubeBodyState createState() => _YoutubeBodyState();
}

class _YoutubeBodyState extends State<YoutubeBody> {


  /*static String key = "AIzaSyCwNFdxa4g8PSXSuvf2o2MStnq9bfm6tNs";// ** ENTER YOUTUBE API KEY HERE **

  YoutubeAPI ytApi = new YoutubeAPI(key,maxResults: 50);
  List<YT_API> ytResult = [];

  callAPI() async {
    print('UI callled');
    String query = "FLUTTER";
    ytResult = await ytApi.channel("UCFfmKY2mqofI8d6XcxkFATA");
    setState(() {
      YT_API aa = ytResult[0];
      print(aa.thumbnail["high"]['url']);
    });
  }
  @override
  void initState() {
    super.initState();
    callAPI();
    print('hello');
  }
*/
  @override
  Widget build(BuildContext context) {


    int count1 = 0;

    setSount1(c) {
      setState(() {
        count1 = c;
      });
    }




    /*return Scaffold(
        appBar: AppBar(
          title: Text("Vidéothèque",style: TextStyle(color: Colors.black),),
          elevation: 1,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Fonts.col_app),
        ),
        body: Stack(
          children: <Widget>[

            ListView.builder(
              cacheExtent: MediaQuery.of(context).size.height,
              itemCount: ExampleContent.exampleVideos.length,
              itemBuilder: (BuildContext context, int index) {
                return InkResponse(
                  onTap: () => Scaffold.of(context).showSnackBar(SnackBar(
                        content:
                            Text(ExampleContent.exampleVideos[index].title),
                      )),
                  child:
                      YoutubeCard(content: ExampleContent.exampleVideos[index]),
                );
              },
            ),
          ],
        ));*/
    return Scaffold(
      backgroundColor: Colors.grey[50],

      appBar: MyCgemBarApp(

          "CGEM TV",
        actionswidget: Container(),

      ),
      body:    new StreamParcPub(
        new Container(),
        widget.lat,
        widget.lng,
        widget.user,
        "1",
        widget.list_partner,
        widget.analytics,
        setSount1,
        widget.chng,

        video:true,
        revue: false,
        favorite: false,
        boutique: false,
      ),
    );
  }
}
