import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:mycgem/widgets/app_appbar.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:timeago/timeago.dart' as ta;
import 'package:youtube_plyr_iframe/youtube_plyr_iframe.dart';
//import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YtbeVideo extends StatefulWidget {
  YtbeVideo(this.id_video,this.urlVideo);

  String id_video;
  String urlVideo;

  @override
  _RTMPState createState() => _RTMPState();
}

class _RTMPState extends State<YtbeVideo> {
  /// IjkMediaController controller = IjkMediaController();

  // int playerWidth =
  int playerHeight = 360;

  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    ///https://www.youtube.com/watch?v=y46NcP-VMs4&ab_channel=ArryadiaTV
    ///here youtube configuration
    /*_controller = YoutubePlayerController(
        initialVideoId: widget.id_video, ///https://youtu.be/
        flags: YoutubePlayerFlags(isLive: false,autoPlay: false,
        )
    );*/

    print("heloooooooooooooooooooo");
    _controller = YoutubePlayerController(
      initialVideoId: widget.id_video,
      params: YoutubePlayerParams(

        // playlist: ['nPt8bK2gbaU', 'gQDByCdjUXw'], // Defining custom playlist
          showControls: true,
          color: "00994b",
          showFullscreenButton: true,
          desktopMode: false,
          autoPlay: false,
          enableCaption: true,
          showVideoAnnotations: false,
          enableJavaScript: true,
          privacyEnhanced: true,
          loop: false,
          playsInline: true,
          strictRelatedVideos: false
        //useHybridComposition: true,

      ),
    )..listen((value) {
      if (value.isReady && !value.hasPlayed) {
        _controller
        // ..hidePauseOverlay()
        //..play()
          ..hideTopMenu();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    // _controller.stop();
  }

  @override
  Widget build(BuildContext context) {
    void _showDialog(context, videoID) {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return YoutubeViewer(
            videoID,
          );
        },
      );
    }

    Widget ytPlayer(videoID) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(context,
                new MaterialPageRoute<String>(builder: (BuildContext context) {
                  return new WebviewScaffold(
                    url: widget.urlVideo,
                    withZoom: true, // zoom
                    hidden: true,
                    appBar: MyCgemBarApp(
                      "",
                      actionswidget: Container(),
                    ),
                  );
                }));
          /*  _showDialog(
              context,
              videoID,
            );*/
          },
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (kIsWeb && constraints.maxWidth > 800) {
                        return Column(children: [
                          Container(height: 12),
                          Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.all(5),
                            width: MediaQuery.of(context).size.width / 2,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: new Image.network(
                                YoutubePlayerController.getThumbnail(
                                    videoId: videoID,
                                    // todo: get thumbnail quality from list
                                    quality: ThumbnailQuality.max,
                                    webp: false),
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                        ]);
                      } else {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: new Image.network(
                            YoutubePlayerController.getThumbnail(
                                videoId: videoID,
                                // todo: get thumbnail quality from list
                                quality: ThumbnailQuality.max,
                                webp: false),
                            fit: BoxFit.cover,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              Icon(
                Icons.play_circle_filled,
                color: Colors.white,
                size: 55.0,
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      // height: MediaQuery.of(context).size.height * 0.34,
        width: MediaQuery.of(context).size.width,
        // padding:  EdgeInsets.all(20),
        child: ytPlayer(widget
            .id_video) /*YoutubePlayerControllerProvider(
            child: YoutubePlayerIFrame(
                gestureRecognizers: null,
                aspectRatio: MediaQuery.of(context).size.width /
                    MediaQuery.of(context).size.height *
                    0.32),

            controller: _controller,

            //liveUIColor: Co,
          )*/
    );
    /*IjkPlayer(
          mediaController: controller,
        )*/ /*AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(_controller),
                  ClosedCaption(text: _controller.value.caption.text),
                  _PlayPauseOverlay(controller: _controller),
                  VideoProgressIndicator(_controller, allowScrubbing: true),
                ],
              ),
            )*/
  }
}

class YoutubePlayer extends StatefulWidget {
  final String videoID;

  YoutubePlayer(this.videoID);

  @override
  _YoutubePlayerState createState() => _YoutubePlayerState();
}

class _YoutubePlayerState extends State<YoutubePlayer> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          _showDialog(
            context,
            widget.videoID,
          );
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (kIsWeb && constraints.maxWidth > 800) {
                      return Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width / 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: new Image.network(
                            YoutubePlayerController.getThumbnail(
                                videoId: widget.videoID,
                                // todo: get thumbnail quality from list
                                quality: ThumbnailQuality.max),
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width * 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: new Image.network(
                            YoutubePlayerController.getThumbnail(
                                videoId: widget.videoID,
                                // todo: get thumbnail quality from list
                                quality: ThumbnailQuality.max,
                                webp: false),
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            Icon(
              Icons.play_circle_filled,
              color: Colors.white,
              size: 55.0,
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(context, videoID) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return YoutubeViewer(
          videoID,
        );
      },
    );
  }
}

class YoutubeViewer extends StatefulWidget {
  final String videoID;

  YoutubeViewer(this.videoID);

  @override
  _YoutubeViewerState createState() => _YoutubeViewerState();
}

class _YoutubeViewerState extends State<YoutubeViewer> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoID, // livestream example
      params: YoutubePlayerParams(
        //startAt: Duration(minutes: 1, seconds: 5),
        showControls: true,
        showFullscreenButton: true,
        desktopMode: false,
        autoPlay: false,
        enableCaption: true,
        showVideoAnnotations: false,
        enableJavaScript: true,
        privacyEnhanced: true,
        //  useHybridComposition: true,
        playsInline: false,
      ),
    )..listen((value) {
      if (value.isReady && !value.hasPlayed) {
        _controller
        // ..hidePauseOverlay()
        //..play()
          ..hideTopMenu();
      }
      if (value.hasPlayed) {
        //  _controller..hideEndScreen();
      }
    });
    _controller.onExitFullscreen = () {
      Navigator.of(context).pop();
    };
  }

  @override
  Widget build(BuildContext context) {
    final player = YoutubePlayerIFrame();
    return YoutubePlayerControllerProvider(
      key: UniqueKey(),
      controller: _controller,
      child: AlertDialog(
        insetPadding: EdgeInsets.all(10),
        backgroundColor: Colors.black,
        content: player,
        contentPadding: EdgeInsets.all(0),
        actions: <Widget>[
          new Center(
            child: TextButton(
              child: new Text("Fermer"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
