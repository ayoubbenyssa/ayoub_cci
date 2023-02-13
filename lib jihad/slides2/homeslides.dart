import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/routes.dart';
import 'package:mycgem/slides2/page_dragger.dart';
import 'package:mycgem/slides2/page_reveal.dart';
import 'package:mycgem/slides2/pager_indicator.dart';
import 'package:mycgem/slides2/pages.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';

class Homeslides extends StatefulWidget {
  Homeslides(this.onLocaleChange);

  var onLocaleChange;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<Homeslides> with TickerProviderStateMixin {
  StreamController<SlideUpdate> slideUpdateStream;
  AnimatedPageDragger animatedPageDragger;
  PageController _pageController = new PageController();

  int activeIndex = 0;
  int nextPageIndex = 0;
  SlideDirection slideDirection = SlideDirection.none;
  double slidePercent = 0.0;

  @override
  void initState() {
    super.initState();
  }

  test() {
    print("hdhdh");
    setState(() {
      nextPageIndex = activeIndex + 1;
      activeIndex = nextPageIndex;
      _pageController.animateToPage(activeIndex,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    });
  }

  _onPageViewChange(int page) {
    setState(() {
      activeIndex = page;
    });
    print("Current Page: " + page.toString());
  }

  _MyHomePageState() {
    slideUpdateStream = new StreamController<SlideUpdate>();

    slideUpdateStream.stream.listen((SlideUpdate event) {
      setState(() {
        if (event.updateType == UpdateType.dragging) {
          print('Sliding ${event.direction} at ${event.slidePercent}');
          slideDirection = event.direction;
          slidePercent = event.slidePercent;

          if (slideDirection == SlideDirection.leftToRight) {
            nextPageIndex = activeIndex - 1;
          } else if (slideDirection == SlideDirection.rightToLeft) {
            nextPageIndex = activeIndex + 1;
          } else {
            nextPageIndex = activeIndex;
          }
        } else if (event.updateType == UpdateType.doneDragging) {
          print('Done dragging.');
          /* if (slidePercent > 0.5) {
            animatedPageDragger = new AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.open,
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );
          } else {*/
          animatedPageDragger = new AnimatedPageDragger(
            slideDirection: slideDirection,
            transitionGoal: TransitionGoal.close,
            slidePercent: 0.0,
            slideUpdateStream: slideUpdateStream,
            vsync: this,
          );

          nextPageIndex = activeIndex;
          // }

          animatedPageDragger.run();
        } else if (event.updateType == UpdateType.animating) {
          print('Sliding ${event.direction} at ${event.slidePercent}');
          slideDirection = event.direction;
          slidePercent = event.slidePercent;
        } else if (event.updateType == UpdateType.doneAnimating) {
          print('Done animating. Next page index: $nextPageIndex');
          activeIndex = nextPageIndex;

          slideDirection = SlideDirection.none;
          slidePercent = 0.0;

          animatedPageDragger.dispose();
        }
      });
    });
  }

//3c588e
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,

      ),
      body: new Stack(
        children: [
          PageView(
            allowImplicitScrolling: true,
              pageSnapping: true,

              onPageChanged: _onPageViewChange,
              controller: _pageController,
              children: p.pages
                  .map((e) => new p.Page(
                        e,
                        func: test,
                        onLocaleChange: widget.onLocaleChange,
                        slideDirection: slideDirection,
                        slidePercent: slidePercent,
                        //  viewModel: p.pages[activeIndex],
                        // percentVisible: 1.0,
                      ))
                  .toList()),
         Padding(padding: EdgeInsets.only(bottom: 12),
           child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                activeIndex == 3
                    ? new SizedBox(width: 0,height: 0,)
                    : new FlatButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.all(
                              Radius.circular(8.0),
                            )),
                        onPressed: () async {
                          SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                          prefs.setString("Slides", "yess");
                          Routes.go_login(
                              context, null, null, [], null, widget.onLocaleChange);
                        },
                        child: new Text("Passer",
                            style: TextStyle(
                                color: Fonts.col_grey,
                                fontSize:
                                ScreenUtil().setSp(16)))),

                new RaisedButton(
                    color: Fonts.col_app_fonn,
                    elevation: 0,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.all(
                          Radius.circular(24.0),
                        )),
                    onPressed: () async {
                      if (activeIndex == 3) {
                        SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                        prefs.setString("Slides", "yess");
                        Routes.go_login(
                            context, null, null, [], null, widget.onLocaleChange);
                      } else {
                        test();
                      }
                    },
                    child: new Text(
                        activeIndex == 3 ? "Entrer" : "Suivant",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(16)))),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
