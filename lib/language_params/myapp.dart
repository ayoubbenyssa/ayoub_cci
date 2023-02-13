import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycgem/language_params/scope_model_wrapper.dart';
import 'package:mycgem/language_params/translation.dart';
import 'package:mycgem/login/rout_page.dart';
import 'package:mycgem/services/Fonts.dart';

import 'package:scoped_model/scoped_model.dart';

//callback interface
typedef LocaleChangeCallback = void Function(
    Locale locale, TextDirection textDirection);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SpecifiedLocalizationDelegate _localeOverrideDelegate;

  @override
  void initState() {
    super.initState();
    _localeOverrideDelegate =
    new SpecifiedLocalizationDelegate(const Locale("en", ""));
  }

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  onLocaleChange(Locale l,
      TextDirection textDirection,) {
    setState(() {
      _localeOverrideDelegate = new SpecifiedLocalizationDelegate(l);
    });
  }

  AppModel1 appModel = AppModel1();

  @override
  Widget build(BuildContext context) {
    //    ScreenUtil.instance = ScreenUtil(width: 375, height: 812)..init(context);
    return ScopedModelDescendant<AppModel1>(
        builder: (context, child, model) =>
            ScopedModel<AppModel1>(
                model: appModel,
                child: ScreenUtilInit(
                    designSize: Size(414, 896),
                    allowFontScaling: false,
                    builder: () =>
                        MaterialApp(
                          localizationsDelegates: [
                            _localeOverrideDelegate,
                            const TranslationsDelegate(),
                            GlobalMaterialLocalizations.delegate,
                            GlobalWidgetsLocalizations.delegate,
                          ],
                          supportedLocales: [
                            const Locale('en', ''), // English
                            const Locale('ar', ''), // Arabic
                          ],
                          builder: (BuildContext context, Widget child) {
                            return Directionality(
                                textDirection: TextDirection.ltr,
                                child: child);

                          },
                          debugShowCheckedModeBanner: false,
                          title: "CCIS Connect",
                          theme: new ThemeData(
                              primaryColor: Fonts.col_app_fon,
                              fontFamily: "coffee"),
                          home: new RootPage(onLocaleChange,
                              analytics: analytics, observer: observer),
                        ))));
  }
}
