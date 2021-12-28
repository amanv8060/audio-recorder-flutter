import 'dart:io';
import 'package:audiorecorder/services/previous_recording_service.dart';
import 'package:audiorecorder/utils/get_it/locator.dart';
import 'package:flutter/widgets.dart';

/// Provides the previously recorded values
class PreviousRecordingProvider extends ChangeNotifier {
  late final PreviousRecordingService _service;
  List<FileSystemEntity> files = [];

  PreviousRecordingProvider() {
    _service = locator<PreviousRecordingService>();
    refreshList();
  }

  void refreshList() async {
    files = await _service.getRecordings();
    notifyListeners();
  }
}
