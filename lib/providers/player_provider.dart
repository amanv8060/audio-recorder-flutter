import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';

class PlayerProvider extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  FileSystemEntity file;

  AudioPlayer get audioPlayer => _player;

  Duration? get fileLength => _player.duration;

  Stream<Duration> get positionStream => _player.positionStream;

  Stream<Duration?> get durationStream => _player.durationStream;

  PlayerProvider(this.file) {
    _player.setFilePath(file.path);
    durationStream.listen((event) {
      notifyListeners();
    });
    positionStream.listen((duration) {
      if (_player.duration != null && _player.position >= _player.duration!) {
        stop();
        seek(Duration.zero);
      }
      notifyListeners();
    });
  }

  void play() async {
    var temp = file.statSync();
    HapticFeedback.vibrate();
    if (_player.duration != null && _player.position >= _player.duration!) {
      _player.seek(Duration.zero);
    }
    _player.play();
    notifyListeners();
  }

  void stop() async {
    await _player.stop();
    notifyListeners();
  }

  void pause() async {
    await _player.pause();
    notifyListeners();
  }

  Future<void> seek(Duration d) async {
    await _player.seek(d);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
