import 'dart:async';
import 'dart:io';
import 'package:audiorecorder/utils/logging/custom_logger.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sound/flutter_sound.dart';

import 'package:logger/logger.dart';

class PlayerProvider extends ChangeNotifier {
  FlutterSoundPlayer player = FlutterSoundPlayer(logLevel: Level.error);
  FileSystemEntity file;
  String duration = "Fetching duration";

  late Stream<PlaybackDisposition>? playerSubscription;

  PlayerProvider(this.file) {
    player.openAudioSession(focus: AudioFocus.requestFocusAndDuckOthers);
    player.setSubscriptionDuration(const Duration(milliseconds: 500));
    playerSubscription = player.onProgress;
    fetchDuration();
  }

  void fetchDuration() async {
    var data = (await FlutterSoundFFprobe().getMediaInformation(file.path))
        .getMediaProperties();
    if (data == null || data["duration"] == null) {
      duration = "Unable to fetch Length";
    } else {
      double val = double.parse(data["duration"]);
      duration = "${val ~/ 60}m:${(val % 60).toInt()}s";
    }
    notifyListeners();
  }

  void resume() async {
    await player.resumePlayer();
    notifyListeners();
  }

  void play() async {
    if (player.isPaused) {
      resume();
      return;
    }
    if (player.isPlaying) {
      pause();
      return;
    }
    await player.startPlayer(fromURI: file.path);
    notifyListeners();
  }

  void pause() async {
    if (player.isPlaying) {
      await player.pausePlayer();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    player.closeAudioSession();
    super.dispose();
  }
}
