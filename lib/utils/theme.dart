import 'package:flutter/material.dart';
import 'package:hola/common/colors.dart';
import 'package:hola/utils/widgetThemes/text_fieldThemes.dart';
import 'package:hola/utils/widgetThemes/text_themes.dart';

class Mytheme {
  Mytheme._();

  static ThemeData lightTheme = ThemeData(
      bottomSheetTheme: const BottomSheetThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)))),
      dialogTheme: DialogTheme(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: ColorsApp.backgroundLight,
      backgroundColor: ColorsApp.backgroundLight,
      accentColor: Colors.blue[100],
      brightness: Brightness.light,
      textTheme: MyTextTheme.lightTextTheme,
      inputDecorationTheme: TextFieldformTheme.lightInputDecorationTheme);
  static ThemeData darkTheme = ThemeData(
      bottomSheetTheme: const BottomSheetThemeData(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)))),
      dialogTheme: DialogTheme(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      accentColor: Colors.grey.shade600,
      brightness: Brightness.dark,
      backgroundColor: ColorsApp.backgroundDark,
      scaffoldBackgroundColor: ColorsApp.backgroundDark,
      textTheme: MyTextTheme.darkTextTheme,
      inputDecorationTheme: TextFieldformTheme.darkInputDecorationTheme);
}
