import 'dart:async';
import 'dart:io';
import 'package:audiorecorder/services/player_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';

class PlayerProvider extends ChangeNotifier {
  final PlayerService _playerService = PlayerService();
  FileSystemEntity file;

  AudioPlayer get audioPlayer => _playerService.audioPlayer;

  Duration? get fileLength => _playerService.duration;

  Stream<Duration> get positionStream => _playerService.playerPositionStream;

  Stream<Duration?> get durationStream => _playerService.playerDurationStream;

  PlayerProvider(this.file) {
    _playerService.setSource(file.path);
    durationStream.listen((event) {
      notifyListeners();
    });
  }

  void play() async {
    HapticFeedback.vibrate();
    await _playerService.play();
    notifyListeners();
  }

  void stop() async {
    await _playerService.stop();
    notifyListeners();
  }

  void pause() async {
    await _playerService.pause();
    notifyListeners();
  }

  @override
  void dispose() {
    _playerService.dispose();
    super.dispose();
  }
}
