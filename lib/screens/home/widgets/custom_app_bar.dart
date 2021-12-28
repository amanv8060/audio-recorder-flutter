import 'package:audiorecorder/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar(BuildContext context, {Key? key})
      : super(
            key: key,
            backgroundColor: AppTheme.greyDark,
            title: const Text(
              "Audio Recorder",
              style: TextStyle(color: Colors.white),
            ));
}
