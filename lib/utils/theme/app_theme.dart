import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static const Color lightGreyColor = Color(0xffa19fa5);
  static const Color toastColor = Color(0xff303030);
  static const Color lightBlueColor = Color(0xff179cde);
  static const Color greyColor = Color(0xff424242);
  static const Color primaryColor = Color(0xff242424);
  static const Color redColor = Color(0xffC73526);
  static const Color white = Color(0xfffafafa);
  static const Color lightPeach = Color(0xffC8ACBF);
  static const Color greyDark = Color(0xff1c1c1c);

  static final ThemeData globalTheme = ThemeData(
    androidOverscrollIndicator: null,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: primaryColor,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: greyDark,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: greyDark, statusBarIconBrightness: Brightness.light),
      iconTheme: IconThemeData(color: primaryColor),
    ),
    backgroundColor: primaryColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: primaryColor,
    ),
  );
}
