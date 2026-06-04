import 'dart:ui';

class AppLocales {
  AppLocales._();

  static const Locale english = Locale('en', 'US');
  static const Locale hindi = Locale('hi', 'IN');

  static const List<Locale> supportedLocales = [english, hindi];
}
