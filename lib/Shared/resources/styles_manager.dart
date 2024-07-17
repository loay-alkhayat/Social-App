import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(double fontsize, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontsize,
      fontFamily: FontConstants.fontFamily,
      color: color,
      fontWeight: fontWeight);
}

//regular style
TextStyle getRegularStyle({
  double fontsize = FontSize.s12,
  required Color color,
  fontWeight = FontWeightManager.regular,
}) {
  return _getTextStyle(fontsize, fontWeight, color);
}

//medium style
TextStyle getMediumStyle({
  double fontsize = FontSize.s12,
  required Color color,
  fontWeight = FontWeightManager.medium,
}) {
  return _getTextStyle(fontsize, fontWeight, color);
}
//semiBold style

TextStyle getSemiBoldStyle({
  double fontsize = FontSize.s12,
  required Color color,
  fontWeight = FontWeightManager.semibold,
}) {
  return _getTextStyle(fontsize, fontWeight, color);
}
//Light style

TextStyle getLightStyle({
  double fontsize = FontSize.s12,
  required Color color,
  fontWeight = FontWeightManager.light,
}) {
  return _getTextStyle(fontsize, fontWeight, color);
}
//Bold style

TextStyle getBoldStyle({
  double fontsize = FontSize.s12,
  required Color color,
  fontWeight = FontWeightManager.bold,
}) {
  return _getTextStyle(fontsize, fontWeight, color);
}
