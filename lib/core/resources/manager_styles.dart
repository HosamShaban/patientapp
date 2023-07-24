import 'package:flutter/material.dart';
import 'package:patientapp/core/resources/manager_fonts.dart';

TextStyle _textStyle({
  required double fontSize,
  required String fontFamily,
  required FontWeight fontWeight,
  required Color color,
  required TextDecoration decoration,
}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    fontWeight: fontWeight,
    color: color,
    decoration: decoration,
  );
}

TextStyle getRegularTextStyle({
  required double fontSize,
  required Color color,
  TextDecoration decoration = TextDecoration.none,
}) {
  return _textStyle(
    fontSize: fontSize,
    fontFamily: ManagerFontFamily.fontFamily,
    fontWeight: ManagerFontWight.regular,
    color: color,
    decoration: decoration,
  );
}

TextStyle getBoldTextStyle({
  required double fontSize,
  required Color color,
  TextDecoration decoration = TextDecoration.none,
}) {
  return _textStyle(
    fontSize: fontSize,
    fontFamily: ManagerFontFamily.fontFamily,
    fontWeight: ManagerFontWight.bold,
    color: color,
    decoration: decoration,
  );
}

TextStyle getMediumTextStyle({
  required double fontSize,
  required Color color,
  TextDecoration decoration = TextDecoration.none,
}) {
  return _textStyle(
    fontSize: fontSize,
    fontFamily: ManagerFontFamily.fontFamily,
    fontWeight: ManagerFontWight.medium,
    color: color,
    decoration: decoration,
  );
}

TextStyle getTextStyle({
  required double fontSize,
  required Color color,
  TextDecoration decoration = TextDecoration.none,
  FontWeight? weight,
}) {
  return _textStyle(
    fontSize: fontSize,
    fontFamily: ManagerFontFamily.fontFamily,
    fontWeight: weight ?? ManagerFontWight.medium,
    color: color,
    decoration: decoration,
  );
}
