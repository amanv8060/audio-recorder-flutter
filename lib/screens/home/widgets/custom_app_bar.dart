import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar(BuildContext context, {Key? key})
      : super(
            key: key,
            backgroundColor: Colors.white,
            title: const Text(
              "Audio Recorder",
              style: TextStyle(color: Colors.black),
            ));
}
