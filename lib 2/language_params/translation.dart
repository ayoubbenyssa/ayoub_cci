import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mycgem/language_params/linkom_texts.dart';


class TranslationsDelegate extends LocalizationsDelegate<LinkomTexts> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<LinkomTexts> load(Locale locale) => LinkomTexts.load(locale);

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}

class SpecifiedLocalizationDelegate
    extends LocalizationsDelegate<LinkomTexts> {
  final Locale overriddenLocale;

  const SpecifiedLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<LinkomTexts> load(Locale locale) =>
      LinkomTexts.load(overriddenLocale);

  @override
  bool shouldReload(SpecifiedLocalizationDelegate old) => true;
}
