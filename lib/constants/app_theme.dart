import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/font_family.dart';
import '../constants/text_styles.dart';

final ThemeData themeData = ThemeData(
  fontFamily: FontFamily.quickSand,
  brightness: Brightness.light,
  primaryColor: AppColors.primaryColor,
  primaryColorBrightness: Brightness.light,
  accentColor: AppColors.accentColor,
  backgroundColor: AppColors.whiteColor,
  accentColorBrightness: Brightness.light,
  textTheme: const TextTheme(
    headline1: TextStyles.titleTextStyle,
  ),
);
