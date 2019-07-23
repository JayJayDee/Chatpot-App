import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

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
    logoImageWithTypo: const AssetImage('assets/chatpot-logo-with-typo-medium.png'),

    appBackground: const Color(0xffd0d0d0),
    mainBackground: const Color(0xffefe7e3),
    splashBackground: const Color(0xfff4f4f4),
    link: const Color(0xff007aff),
    cardActionTextStyle: const TextStyle(fontSize: 15.0),
    primaryFontColor: const Color(0xFF505050),
    secondaryFontColor: const Color(0xFF929292),
    thirdFontColor: const Color(0xFFCCCCCC),
    inputFieldDevidier: const Color(0xFFCCCCCC),
    listViewRowBackground: const Color(0xffffffff),
    listViewRowBackgroundMoreDark: Color(0xffffffff),
    listRowHeaderBackground: const Color(0xfff4f4f4),
    listRowDivider: const Color(0xffa4a4a4),

    tabBarBackground: const Color(0xfff6f6f6),
    tabBarActive: const Color(0xff007aff),
    tabBarInactive: const Color(0xff8e8e93),
    
    navigationBarBackground: const Color(0xfff6f6f6),
    
    sheetBackground: const Color(0xffd5d9dc),
    messageBackgroundMine: const Color(0xff007aff),
    messageBackgroundOther: const Color(0xffcbc1bd),
    messageBackgroundNotification: const Color(0xffcbc1bd),
    
    profileCardBackground: const Color(0xffffffff),
    editTextFont: const Color(0xFF505050),
    editTextHint: const Color(0xFF929292),
    
    popupPrimaryFontColor: const Color(0xFF505050),
    popupSecondaryFontColor: const Color(0xFF929292),

    innerDrawerBackground: const Color(0xfff4f4f4));
  return style;
}

AppStyle _darkTheme() {
  AppStyle style = AppStyle(
    logoImageWithTypo: const AssetImage('assets/chatpot-logo-with-typo-medium-white.png'),

    appBackground: const Color(0xff000000),
    mainBackground: const Color(0xff283b42),
    splashBackground: const Color(0xff283b42),
    link: const Color(0xff6cb1ff),
    cardActionTextStyle: const TextStyle(fontSize: 15.0),
    primaryFontColor: const Color(0xffd1dddb),
    secondaryFontColor: const Color(0xff85b8cb),
    thirdFontColor: const Color(0xFFCCCCCC),
    inputFieldDevidier: const Color(0xFFCCCCCC),
    listViewRowBackground: const Color(0xff1d6a96),
    listViewRowBackgroundMoreDark: Color(0xff113d56),
    listRowHeaderBackground: const Color(0xff473b42),
    listRowDivider: const Color(0xff473b42),
    
    tabBarBackground: const Color(0xff1d6a96),
    tabBarActive: const Color(0xffd1dddb),
    tabBarInactive: const Color(0xff85b8cb),
    
    navigationBarBackground: const Color(0xff1d6a96),
    
    sheetBackground: const Color(0xffd5d9dc),

    messageBackgroundMine: const Color(0xff222222),
    messageBackgroundOther: const Color(0xff473b42),
    messageBackgroundNotification: const Color(0xff473b42),
    
    profileCardBackground: const Color(0xff1d6a96),

    editTextFont: const Color(0xffd1dddb),
    editTextHint: const Color(0xff85b8cb),
    
    popupPrimaryFontColor: const Color(0xFF505050),
    popupSecondaryFontColor: const Color(0xFF929292),
    innerDrawerBackground: const Color(0xff473b42));
  return style;
}

class AppStyle {
  AppStyle({
    @required this.logoImageWithTypo,
    @required this.appBackground,
    @required this.mainBackground,
    @required this.splashBackground,
    @required this.link,
    @required this.cardActionTextStyle,
    @required this.primaryFontColor,
    @required this.secondaryFontColor,
    @required this.thirdFontColor,
    @required this.inputFieldDevidier,
    @required this.listViewRowBackground,
    @required this.listViewRowBackgroundMoreDark,
    @required this.listRowHeaderBackground,
    @required this.listRowDivider,
    @required this.tabBarBackground,
    @required this.tabBarActive,
    @required this.tabBarInactive,
    @required this.navigationBarBackground,
    @required this.profileCardBackground,
    @required this.sheetBackground,
    @required this.messageBackgroundMine,
    @required this.messageBackgroundOther,
    @required this.messageBackgroundNotification,
    @required this.editTextHint,
    @required this.editTextFont,
    @required this.popupPrimaryFontColor,
    @required this.popupSecondaryFontColor,
    @required this.innerDrawerBackground});

  final AssetImage logoImageWithTypo;
  final Color appBackground;
  final Color mainBackground;
  final Color splashBackground;
  final Color link;

  final TextStyle cardActionTextStyle;

  final Color primaryFontColor;
  final Color secondaryFontColor;
  final Color thirdFontColor;
  final Color inputFieldDevidier;

  final Color listViewRowBackground;
  final Color listViewRowBackgroundMoreDark;
  final Color listRowHeaderBackground;
  final Color listRowDivider;

  final Color tabBarBackground;
  final Color tabBarActive;
  final Color tabBarInactive;

  final Color navigationBarBackground;

  final Color profileCardBackground;
  final Color sheetBackground;

  final Color messageBackgroundMine;
  final Color messageBackgroundOther;
  final Color messageBackgroundNotification;

  final Color editTextHint;
  final Color editTextFont;

  final Color popupPrimaryFontColor;
  final Color popupSecondaryFontColor;

  final Color innerDrawerBackground;
}