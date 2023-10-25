import 'package:flutter/material.dart';

List<Locale> localesSupported = const [
  Locale('cn', 'CN'),
  Locale('fr', 'FR'),
  Locale('en', 'US'),
  Locale('es', 'ES'),
  Locale('sw', 'KE'),
];

String getLanguageName(Locale l) {
  switch (l.languageCode) {
    case 'cn':
      return '中文';
    case 'fr':
      return 'Français';
    case 'en':
      return 'English(US)';
    case 'es':
      return 'Español';
    case 'sw':
      return 'Swahili';
    default:
      return 'Not supported';
  }
}
