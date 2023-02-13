import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'myapp.dart';
import 'package:timeago/timeago.dart' as timeago;


class ScopeModelWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel1>(model: AppModel1(), child: MyApp());
  }
}

class AppModel1 extends Model {
  TextDirection _textDirection = TextDirection.ltr;
  TextDirection get textDirection => _textDirection ?? TextDirection.ltr;

  String _locale = "en";
  String get locale => _locale ?? "ar";

  void changeDirection() {
    if (_textDirection == TextDirection.ltr) {
      _textDirection = TextDirection.ltr;
      _locale = "en";
      timeago.setLocaleMessages('fr', timeago.FrMessages());

    } else {
      _textDirection = TextDirection.ltr;
      _locale = "ar";
      timeago.setLocaleMessages('ar', timeago.ArMessages());

    }
    notifyListeners();
  }
}
