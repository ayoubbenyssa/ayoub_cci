import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/services/routes.dart';
import 'package:mycgem/slides2/pages.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PagerIndicator extends StatelessWidget {
  final PagerIndicatorViewModel viewModel;

  var onLocaleChange;

  var func;

  PagerIndicator(
    this.func,
    this.onLocaleChange, {
    this.viewModel,
  });

  @override
  Widget build(BuildContext context) {

    List<PageBubble> bubbles = [];
    for (var i = 0; i < viewModel.pages.length; ++i) {
      final page = viewModel.pages[i];

      var percentActive;
      if (i == viewModel.activeIndex) {
        percentActive = 1.0 - viewModel.slidePercent;
      } else if (i == viewModel.activeIndex - 1 &&
          viewModel.slideDirection == SlideDirection.leftToRight) {
        percentActive = viewModel.slidePercent;
      } else if (i == viewModel.activeIndex + 1 &&
          viewModel.slideDirection == SlideDirection.rightToLeft) {
        percentActive = viewModel.slidePercent;
      } else {
        percentActive = 0.0;
      }

      bool isHollow = i > viewModel.activeIndex ||
          (i == viewModel.activeIndex &&
              viewModel.slideDirection == SlideDirection.leftToRight);

      bubbles.add(
        new PageBubble(
          viewModel: new PageBubbleViewModel(
            page.iconAssetPath,
            page.color,
            isHollow,
            percentActive,
          ),
        ),
      );
    }

    final BUBBLE_WIDTH = 55.0;
    final baseTranslation =
        ((viewModel.pages.length * BUBBLE_WIDTH) / 2) - (BUBBLE_WIDTH / 2);
    var translation = baseTranslation - (viewModel.activeIndex * BUBBLE_WIDTH);
    if (viewModel.slideDirection == SlideDirection.leftToRight) {
      translation += BUBBLE_WIDTH * viewModel.slidePercent;
    } else if (viewModel.slideDirection == SlideDirection.rightToLeft) {
      translation -= BUBBLE_WIDTH * viewModel.slidePercent;
    }

    gohome() {
      //routesFunctions.gomenubottom(context);
    }

    return new Column(
      children: [
        new Expanded(child: new Container()),
        new Transform(
          transform: new Matrix4.translationValues(translation, 0.0, 0.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: bubbles,
          ),
        ),
        new Container(
          padding: new EdgeInsets.only(
              left: 12.0, right: 12.0, top: 0.0, bottom: 16.0),
          width: MediaQuery.of(context).size.width,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             /*
                ,*/
              new Container(
                width: MediaQuery.of(context).size.width * 0.05,
              ),

            ],
          ),
        ),
        /**/
        new Container(
          height: 8.0,
        ),
      ],
    );
  }
}

enum SlideDirection {
  leftToRight,
  rightToLeft,
  none,
}

class PagerIndicatorViewModel {
  final List<PageViewModel> pages;
  final int activeIndex;
  final SlideDirection slideDirection;
  final double slidePercent;

  PagerIndicatorViewModel(
    this.pages,
    this.activeIndex,
    this.slideDirection,
    this.slidePercent,
  );
}

class PageBubble extends StatelessWidget {
  final PageBubbleViewModel viewModel;

  PageBubble({
    this.viewModel,
  });

  /*

    Widget clr(image) => new Container(
        width: 90.0,
        height: 90.0,
        padding: new EdgeInsets.all(4.0),
      child: new Material(
      color: Colors.grey[200],
      type: MaterialType.circle,
      shadowColor: Colors.blue[300],
      elevation: 8.0,child:
      new Padding(padding: new EdgeInsets.all(16.0),

        child: new Image.network(image,fit: BoxFit.cover,),
    )));
   */
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 55.0,
      height: 65.0,
      child: new Center(
        child: new Container(
          padding: EdgeInsets.all(8),
          width: lerpDouble(20.0, 45.0, viewModel.activePercent),
          height: lerpDouble(20.0, 45.0, viewModel.activePercent),
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            color: viewModel.isHollow
                ? Fonts.col_cl
                    .withAlpha((0x88 * viewModel.activePercent).round())
                : Fonts.col_cl,
            border: new Border.all(
              color: viewModel.isHollow
                  ? Fonts.col_grey.withAlpha(
                      (0x88 * (1.0 - viewModel.activePercent)).round())
                  : Colors.transparent,
              width: 3.0,
            ),
          ),
          child: new Opacity(
            opacity: viewModel.activePercent,
            child: new Image.asset(
              viewModel.iconAssetPath,
            ),
          ),
        ),
      ),
    );
  }
}

class PageBubbleViewModel {
  final String iconAssetPath;
  final Color color;
  final bool isHollow;
  final double activePercent;

  PageBubbleViewModel(
    this.iconAssetPath,
    this.color,
    this.isHollow,
    this.activePercent,
  );
}
