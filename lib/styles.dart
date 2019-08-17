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
    logoImageOnly: const AssetImage('assets/chatpot-logo-only-800.png'),

    appBackground: const Color(0xffd0d0d0),
    mainBackground: const Color(0xffffffff),
    splashBackground: const Color(0xfff4f4f4),
    link: const Color(0xff007aff),
    cardActionTextStyle: const TextStyle(fontSize: 15.0),
    primaryFontColor: const Color(0xFF505050),
    secondaryFontColor: const Color(0xFF929292),
    thirdFontColor: const Color(0xFFCCCCCC),
    inputFieldDevidier: const Color(0xFFCCCCCC),
    listViewRowBackground: const Color(0xfff9f9f9),
    listViewRowBackgroundMoreDark: Color(0xfff9f9f9),
    listRowHeaderBackground: const Color(0xffffffff),
    listRowDivider: const Color(0xffa4a4a4),

    tabBarBackground: const Color(0xfff9f9f9),
    tabBarActive: const Color(0xff007aff),
    tabBarInactive: const Color(0xff8e8e93),
    
    navigationBarBackground: const Color(0xfff9f9f9),
    
    sheetBackground: const Color(0xffd5d9dc),
    messageBackgroundMine: const Color(0xff007aff),
    messageBackgroundOther: const Color(0xffdddddd),
    messageBackgroundNotification: const Color(0xffdddddd),
    
    profileCardBackground: const Color(0xffefefef),
    editTextFont: const Color(0xFF505050),
    editTextHint: const Color(0xFF929292),
    
    popupPrimaryFontColor: const Color(0xFF505050),
    popupSecondaryFontColor: const Color(0xFF929292),

    innerDrawerBackground: const Color(0xffdddddd),
    editTextBackground: const Color(0xfff2f9f8));
  return style;
}

AppStyle _darkTheme() {
  AppStyle style = AppStyle(
    logoImageWithTypo: const AssetImage('assets/chatpot-logo-with-typo-medium-white.png'),
    logoImageOnly: const AssetImage('assets/chatpot-logo-only-800.png'),

    appBackground: const Color(0xff000000),
    mainBackground: const Color(0xff111d2d),
    splashBackground: const Color(0xff111d2d),
    link: const Color(0xff6cb1ff),
    cardActionTextStyle: const TextStyle(fontSize: 15.0),
    primaryFontColor: const Color(0xffd1dddb),
    secondaryFontColor: const Color(0xff85b8cb),
    thirdFontColor: const Color(0xff547d8c),
    inputFieldDevidier: const Color(0xFFCCCCCC),
    listViewRowBackground: const Color(0xff1d6a96),
    listViewRowBackgroundMoreDark: Color(0xff17335e),
    //listRowHeaderBackground: const Color(0xff473b42),
    listRowHeaderBackground: const Color(0xff0c3461),
    listRowDivider: const Color(0xff473b42),
    
    tabBarBackground: const Color(0xff094aa1),
    tabBarActive: const Color(0xffd1dddb),
    tabBarInactive: const Color(0xff85b8cb),
    
    navigationBarBackground: const Color(0xff094aa1),
    
    sheetBackground: const Color(0xffd5d9dc),

    messageBackgroundMine: const Color(0xff507cc5),
    messageBackgroundOther: const Color(0xff0c3461),
    messageBackgroundNotification: const Color(0xff24324a),
    
    profileCardBackground: const Color(0xff273249),

    editTextFont: const Color(0xffd1dddb),
    editTextHint: const Color(0xff85b8cb),
    
    popupPrimaryFontColor: const Color(0xFF505050),
    popupSecondaryFontColor: const Color(0xFF929292),
    innerDrawerBackground: const Color(0xff273249),
    editTextBackground: const Color(0xff111d2d));
  return style;
}

class AppStyle {
  AppStyle({
    @required this.logoImageWithTypo,
    @required this.logoImageOnly,
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
    @required this.innerDrawerBackground, 
    @required this.editTextBackground });

  final AssetImage logoImageWithTypo;
  final AssetImage logoImageOnly;
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
  final Color editTextBackground;
}