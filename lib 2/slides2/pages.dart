import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mycgem/services/Fonts.dart';
import 'package:mycgem/slides2/pager_indicator.dart';

/**
 * xImage.asset("images/logo.png",width: MediaQuery.of(context).size.width*0.15,)
 */
final pages = [
  new PageViewModel(
      Fonts.col_app,
      "assets/images/logo.png",
      /* 100% dédiée à aux membres*/
      'Bienvenue sur CCIS Connect !',
      "L'application de la communauté CCIS qui vous permet de vous connecter et de contacter d'autres membres par message, de partager votre actualité, de saisir de nouvelles opportunités d'affaires et de promouvoir vos produits et services !",
      "assets/images/logo.png",
      'assets/images/logo.png'),
  new PageViewModel(
      Colors.blueGrey[900],
      'assets/images/1.png',
      'Opportunités d’affaires ',
      'Nous facilitons l’interaction et les échanges au sein de la communauté CCSI. Dans l’objectif de multiplier vos opportunités d’affairés ',
      'assets/images/1.png',
      'assets/images/1.png'),
  new PageViewModel(
      // const Color(0xffd6a943),//0xFFd89d9d),
      Colors.teal[900],
      'assets/images/2.png',
      'Événements',
      "La CCSI organisé régulièrement des conférences, Rencontres et forums que vous retrouvez dans l’agenda et auxquels vous pourrez participer en complétant le formulaire d’inscription ",
      'assets/images/2.png',
      'assets/images/2.png'),
  new PageViewModel(
      // const Color(0xffd6a943),//0xFFd89d9d),
      Colors.indigo[800],
      'assets/images/3.png',
      "Networking",
      "Nus facilitons les interactions et les échanges Entre opérateurs économiques dans l’objectif d’élargir votre réseau ",
      'assets/images/3.png',
      'assets/images/3.png'),
];

class Page extends StatelessWidget {
  //final PageViewModel viewModel;
  //final double percentVisible;
  Widget item;
  var func;
  var onLocaleChange;
  var slideDirection, slidePercent;

  var e;

  Page(this.e,
      {this.item,
      this.func,
      this.onLocaleChange,
      this.slideDirection,
      this.slidePercent});

  @override
  Widget build(BuildContext context) {
    //  ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);

    /**
        itemBuilder: (BuildContext context, int index) {
        return new Container(
        color: Colors.grey[200],
        child: new FadingImage.network(
        widget.ads.pic[index].toString()
        /*"http://via.placeholder.com/350x150"*/,
        fit: BoxFit.cover,
        ));
        },
        itemCount: widget.ads.pic.length,
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
     */
    return new Container(
        color: Colors.white,
        child: new Container(
            width: double.infinity,
            //color: viewModel.color,
            child: new Container(
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    // logo,

                    /*   new Center(
                    child:   new Text("....................................",
                            style: new  TextStyle(
                              color: Colors.blue[50],
                              fontSize: 22.0,
                              fontWeight: FontWeight.w800,
                              fontFamily: "RapidinhoFontFamily",
                            ))),*/
                    //new Container(height: 8.0,),
                    new Container(
                      height: 150.h,
                      width: ScreenUtil().setWidth(200),
                      child: new Image.asset(
                        e.heroAssetPath,
                        fit: BoxFit.contain,
                      ),
                    ),

                    new Container(height: 12.0),

                    new Padding(
                      padding: new EdgeInsets.only(
                          top: 12.0, bottom: 4.0, left: 8.0, right: 8.0),
                      child: new Text(
                        e.title,
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                          //color: Colors.white,
                          color: Fonts.col_app,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(17),
                        ),
                      ),
                    ),

                    Container(
                      height: 12.0,
                    ),

                    new Padding(
                        padding: new EdgeInsets.only(
                            bottom: 24.0, left: 24.0, right: 24.0, top: 12),
                        child: new Text(
                          e.body,
                          textAlign: TextAlign.justify,
                          style: new TextStyle(
                              color: Fonts.col_app_fonn,
                              fontWeight: FontWeight.w500,
                              height: 1.1,
                              //  color: Colors.white,
                              fontSize: ScreenUtil().setSp(14)),
                        )),

                    new Container(height: 20.0),

                    Container(
                        height: 120,
                        child: new PagerIndicator(
                          func,
                          onLocaleChange,
                          viewModel: new PagerIndicatorViewModel(
                            pages,
                            pages.indexOf(e),
                            slideDirection,
                            slidePercent,
                          ),
                        )),
                  ]),
            )));
  }
}

class PageViewModel {
  final Color color;
  final String heroAssetPath;
  final String title;
  final String body;
  final String iconAssetPath;
  final String background;

  PageViewModel(this.color, this.heroAssetPath, this.title, this.body,
      this.iconAssetPath, this.background);
}
