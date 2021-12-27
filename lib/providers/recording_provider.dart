import 'dart:async';
import 'dart:io';
import 'package:audiorecorder/services/recording_service.dart';
import 'package:logger/logger.dart';
import 'package:audiorecorder/utils/get_it/locator.dart';
import 'package:audiorecorder/utils/logging/custom_logger.dart';
import 'package:audiorecorder/utils/logging/info_toast.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class RecordingProvider extends ChangeNotifier {
  /// Permission for recording
  bool microphonePermission = false;
  bool locked = false;
  bool initDone = false;
  FlutterSoundRecorder? recorder = FlutterSoundRecorder(logLevel: Level.info);
  final Codec _codec = Codec.aacADTS;
  String path = "";
  String currentFileName = "";

  RecordingProvider() {
    init();
  }

  /// Notify listeners explicitly after calling this function
  reset() {
    locked = false;
  }

  Future<void> init() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      microphonePermission = false;
    } else {
      microphonePermission = true;
      recorder = await recorder?.openAudioSession();
      recorder?.setSubscriptionDuration(const Duration(milliseconds: 100));
    }
    initDone = true;
    notifyListeners();
  }

  void record() async {
    if (recorder == null) {
      InfoToast("Some Error while Initializing , reinitializing");
      reset();
      await init();
    }
    currentFileName = await locator<RecordingService>().getFilePath();
    await recorder!.startRecorder(codec: _codec, toFile: currentFileName);
    notifyListeners();
  }

  void resume() async {
    if (recorder!.isPaused) {
      await recorder!.resumeRecorder();
      notifyListeners();
    }
  }

  void pause() async {
    //sanity check to only pause if not paused
    if (recorder!.isStopped || recorder!.isPaused) {
      notifyListeners();
      return;
    }
    await recorder!.pauseRecorder();
    notifyListeners();
  }

  void lockRecorder() {
    locked = true;
    notifyListeners();
  }

  deleteRecording() async {
    String? mUrl = await recorder!.stopRecorder();
    CustomLogger.instance.singleLine(mUrl);
    File file = File(currentFileName);
    file.deleteSync();
    reset();
    notifyListeners();
  }

  Future<void> stopRecorder() async {
    String? mUrl = await recorder?.stopRecorder();
    CustomLogger.instance.singleLine(mUrl);
    reset();
    notifyListeners();
  }
}
