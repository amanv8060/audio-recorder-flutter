import 'dart:async';
import 'package:audiorecorder/services/path_service.dart';
import 'package:audiorecorder/utils/constants.dart';
import 'package:audiorecorder/utils/get_it/locator.dart';
import 'package:audiorecorder/utils/logging/info_toast.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class RecordingProvider extends ChangeNotifier {
  /// Permission for recording
  bool microphonePermission = false;
  bool locked = false;
  bool initDone = false;
  FlutterSoundRecorder? recorder = FlutterSoundRecorder();
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
    }
    recorder = await recorder?.openAudioSession();
    recorder?.setSubscriptionDuration(const Duration(milliseconds: 100));
    path = locator<PathService>().directory.path;
    initDone = true;
    notifyListeners();
  }

  void record() async {
    if (recorder == null) {
      InfoToast("Some Error while Initializing , reinitializing");
      reset();
      await init();
    }
    currentFileName = Constants.filePrefix +
        DateTime.now().millisecondsSinceEpoch.toString() +
        ".aac";
    await recorder!.startRecorder(codec: _codec, toFile: currentFileName);
    notifyListeners();
  }

  void resume() async {
    if (recorder!.isPaused) {
      await recorder!.pauseRecorder();
      notifyListeners();
    }
  }

  void pause() async {
    //sanity check to only pause if not paused
    if (recorder!.isStopped || recorder!.isPaused) {
      return;
    }
    recorder!.pauseRecorder();
    notifyListeners();
  }

  void lockRecorder() {
    locked = true;
    notifyListeners();
  }

  deleteRecording() async {
    String? mUrl = await recorder!.stopRecorder();
    if (mUrl != null) {
      recorder!.deleteRecord(fileName: currentFileName);
    }
  }

  Future<void> stopRecorder() async {
    String? mUrl = await recorder?.stopRecorder();
    reset();
    notifyListeners();
  }
}
