import 'package:college_match/core/themes/text_theme.dart';
import 'package:college_match/core/values/colors.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: AppColor.kPrimaryPurple[50],
    scaffoldBackgroundColor: Colors.white,
    textTheme: textTheme,
  );
}
