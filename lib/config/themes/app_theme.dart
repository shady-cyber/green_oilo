import 'package:flutter/material.dart';
import '../../business/shared/textstyle/customTextFormStyle.dart';
import '../styles/colors/app_colors.dart';
import '../styles/strings/app/app_strings.dart';

ThemeData appTheme() {
  return ThemeData(
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: AppColors.primaryColor,
      ),
      primaryColor: AppColors.primaryColor,
      hintColor: AppColors.grayColor,
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
      fontFamily: AppStrings.fontFamily,
      textTheme: TextTheme(
        bodyMedium: subHeadingTextStyle,
      ));
}
