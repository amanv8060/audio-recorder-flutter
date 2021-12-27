import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static const Color greyColor = Color(0xffd3d3d3);
  static const Color toastColor = Color(0xff303030);
  static const Color lightBlueColor = Color(0xff179cde);
  static const Color greyColor1 = Color(0xffcccccc);
  static const Color primaryColor = Color(0xff0088cc);

  static final ThemeData globalTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: primaryColor,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      iconTheme: IconThemeData(color: primaryColor),
    ),
    backgroundColor: const Color(0xffFFFFFF),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: const Color(0xfffdf2e9),
    ),
  );
}
