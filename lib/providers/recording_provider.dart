import 'dart:async';
import 'dart:io';
import 'package:audiorecorder/services/recording_service.dart';
import 'package:audiorecorder/services/timer_service.dart';
import 'package:audiorecorder/utils/get_it/locator.dart';
import 'package:audiorecorder/utils/logging/info_toast.dart';
import 'package:flutter/widgets.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

/// Maintains the current state of the recorder
//ignore: constant_identifier_names
enum RecorderState { RECORDING, PAUSED, IDLE }

class RecordingProvider extends ChangeNotifier {
  /// Permission for recording
  bool microphonePermission = false;

  ///holds
  bool locked = false;
  bool initDone = false;

  Record recorder = Record();

  ///stores the current state of recorder
  RecorderState recorderState = RecorderState.IDLE;
  String currentFileName = "";
  final TimerService _timerService = locator<TimerService>();

  int get durationRecorded => _timerService.recordDuration;

  RecordingProvider() {
    init();
  }

  /// Notify listeners explicitly after calling this function
  reset() {
    locked = false;
    recorderState = RecorderState.IDLE;
    currentFileName = "";
    _timerService.reset();
  }

  Future<void> init() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      microphonePermission = false;
    } else {
      microphonePermission = true;
    }
    _timerService.reset();
    initDone = true;
    notifyListeners();
  }

  void record() async {
    currentFileName = await locator<RecordingService>().getFilePath();
    await recorder.start(path: currentFileName);
    recorderState = RecorderState.RECORDING;
    _timerService.start(() {
      notifyListeners();
    });
    notifyListeners();
  }

  void resume() async {
    await recorder.resume();
    _timerService.start(() {
      notifyListeners();
    });
    recorderState = RecorderState.RECORDING;
    notifyListeners();
  }

  void pause() async {
    await recorder.pause();
    recorderState = RecorderState.PAUSED;
    _timerService.stop();
    notifyListeners();
  }

  void lockRecorder() {
    locked = true;
    notifyListeners();
  }

  void deleteRecording() async {
    await recorder.stop();
    File file = File(currentFileName);
    file.deleteSync();
    reset();
    InfoToast("Discarded");
    notifyListeners();
  }

  Future<void> stopRecording() async {
    await recorder.stop();
    reset();
    InfoToast("Saved");
    notifyListeners();
  }

  @override
  void dispose() {
    _timerService.dispose();
    super.dispose();
  }
}
