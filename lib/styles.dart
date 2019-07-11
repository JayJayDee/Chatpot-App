import 'package:flutter/cupertino.dart';

enum StyleType {
  LIGHT, DARK
}

StyleType _type = StyleType.LIGHT;

AppStyle styles() {
  if (_type == StyleType.LIGHT) return _lightTheme();
  else if (_type == StyleType.DARK) return _darkTheme();
  return null;
}

StyleType getStyleType() => _type;

void setStyleType(StyleType type) {
  _type = type;
}

AppStyle _lightTheme() {
  AppStyle style = AppStyle(
    appBackground: const Color(0xffd0d0d0),
    mainBackground: const Color(0xffefefef),
    splashBackground: const Color(0xfff4f4f4),
    cardActionTextStyle: const TextStyle(fontSize: 15.0),
    primaryFontColor: const Color(0xFF505050),
    secondaryFontColor: const Color(0xFF929292),
    thirdFontColor: const Color(0xFFCCCCCC),
    inputFieldDevidier: const Color(0xFFCCCCCC),
    listViewRowBackground: const Color(0xffefefef),
    listRowHeaderBackground: const Color(0xffefefef),
    listRowDivider: const Color(0xffa4a4a4),

    tabBarBackground: const Color(0xfff6f6f6),
    tabBarActive: const Color(0xff007aff),
    tabBarInactive: const Color(0xff8e8e93));
  return style;
}

AppStyle _darkTheme() {
  AppStyle style = AppStyle(
    appBackground: const Color(0xff000000),
    mainBackground: const Color(0xffefefef),
    splashBackground: const Color(0xff0376ff),
    cardActionTextStyle: const TextStyle(fontSize: 15.0),
    primaryFontColor: const Color(0xFF505050),
    secondaryFontColor: const Color(0xFF929292),
    thirdFontColor: const Color(0xFFCCCCCC),
    inputFieldDevidier: const Color(0xFFCCCCCC),
    listViewRowBackground: const Color(0xffefefef),
    listRowHeaderBackground: const Color(0xffefefef),
    listRowDivider: const Color(0xffa4a4a4),
    
    tabBarBackground: const Color(0xff000000),
    tabBarActive: const Color(0xff007aff),
    tabBarInactive: const Color(0xff8e8e93));
  return style;
}

class AppStyle {
  AppStyle({
    this.appBackground,
    this.mainBackground,
    this.splashBackground,
    this.cardActionTextStyle,
    this.primaryFontColor,
    this.secondaryFontColor,
    this.thirdFontColor,
    this.inputFieldDevidier,
    this.listViewRowBackground,
    this.listRowHeaderBackground,
    this.listRowDivider,
    this.tabBarBackground,
    this.tabBarActive,
    this.tabBarInactive});

  final Color appBackground;
  final Color mainBackground;
  final Color splashBackground;

  final TextStyle cardActionTextStyle;

  final Color primaryFontColor;
  final Color secondaryFontColor;
  final Color thirdFontColor;
  final Color inputFieldDevidier;

  final Color listViewRowBackground;
  final Color listRowHeaderBackground;
  final Color listRowDivider;

  final Color tabBarBackground;
  final Color tabBarActive;
  final Color tabBarInactive;
}