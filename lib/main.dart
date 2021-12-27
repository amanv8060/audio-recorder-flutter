import 'package:audiorecorder/providers/recording_provider.dart';
import 'package:audiorecorder/screens/home/home_screen.dart';
import 'package:audiorecorder/utils/get_it/locator.dart';
import 'package:audiorecorder/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  setuplocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audio Recorder',
      theme: AppTheme.globalTheme,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => RecordingProvider())
        ],
        child: const HomeView(),
      ),
    );
  }
}
