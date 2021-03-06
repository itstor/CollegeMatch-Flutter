import 'package:flutter/material.dart';

class AppColor {
  static const Map<int, Color> kPrimaryPurple = {
    100: Color(0xFFC4B1F8),
    80: Color(0xFFD2C4F6),
    50: Color(0xFFDED6F4),
    20: Color(0xFFF2EEFC)
  };

  static const Map<int, Color> kPrimaryPink = {
    100: Color(0xFFFDB1D5),
    80: Color(0xFFFFD4E9),
    50: Color(0xFFFFEAF4),
    20: Color(0xFFFFF5FA)
  };

  static const Map<int, Color> kTyphographyColor = {
    100: Color(0xFF1A1D26),
    80: Color(0xFF2A2F3D),
    50: Color(0xFF4D5364),
    20: Color(0xFF6E7489)
  };

  static const Map<int, Color> kGrayColor = {
    100: Color(0xFF9A9FAE),
    80: Color(0xFFA8ACB9),
    50: Color(0xFFC4C7D0),
    20: Color(0xFFEBEBEB),
    10: Color(0xFFF4F4F4)
  };

  static const Map<String, Color> kAccentColor = {
    "red": Color(0xFFFF3666),
  };

  static const MaterialColor purplePallete =
      MaterialColor(_purplePalletePrimaryValue, <int, Color>{
    50: Color(0xFFF5F1FF),
    100: Color(0xFFE5DCFF),
    200: Color(0xFFD4C4FF),
    300: Color(0xFFC3ACFF),
    400: Color(0xFFB69BFF),
    500: Color(_purplePalletePrimaryValue),
    600: Color(0xFFA281FF),
    700: Color(0xFF9876FF),
    800: Color(0xFF8F6CFF),
    900: Color(0xFF7E59FF),
  });
  static const int _purplePalletePrimaryValue = 0xFFA989FF;

  static const MaterialColor purplePalleteAccent =
      MaterialColor(_purplePalleteAccentValue, <int, Color>{
    100: Color(0xFFFFFFFF),
    200: Color(_purplePalleteAccentValue),
    400: Color(0xFFFEFDFF),
    700: Color(0xFFEAE4FF),
  });
  static const int _purplePalleteAccentValue = 0xFFFFFFFF;
}
