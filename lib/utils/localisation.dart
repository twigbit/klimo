// extension ContextTranslatable<T> on BuiltMap<String, T> {
//   T translate(BuildContext context) {
//     return this[context.locale.languageCode] ??
//         this[context.fallbackLocale?.languageCode] ??
//         values.safeFirst ??
//         '';
//   }
// }

import 'package:flutter/material.dart';
import 'package:klimo/utils/iterable.dart';
import 'package:klimo_datamodels/util.dart';

import '../l10n/app_localizations.dart';
import '../l10n/string_translations.dart';

extension WithTranslations on BuildContext {
  AppLocalizations localisation() => AppLocalizations.of(this)!;
  Locale locale() => Localizations.localeOf(this);
}

extension TranslationExtension<T> on Translation<T> {
  T tr(BuildContext context) {
    return this[context.locale().toString()] ?? values.safeFirst;
  }
}

extension WithStringTranslations on String {
  tr(BuildContext context) {
    if (stringTranslations[this] != null) {
      return stringTranslations[this]!(context);
    } else {
      debugPrint("Missing translation for string $this");
      return "MISSING_TRANSLATION: $this";
    }
  }
}

extension WithCalculatorTranslations on String? {
  nullIfEmpty() {
    if (this == null || this != null && this!.isEmpty) {
      return null;
    } else {
      return this;
    }
  }
}
