import 'dart:async';

import 'package:flutter/cupertino.dart';

class TimerService {
  Timer? _timer;

  /// Length of audio recorded , stores value in secs
  int _recordDuration = 0;

  int get recordDuration => _recordDuration;

  /// Use when you save/delete a recording
  void reset() {
    _timer?.cancel();
    _recordDuration = 0;
  }

  void dispose() {
    _timer?.cancel();
  }

  /// increments the currently recorded audio length
  Future<void> start(VoidCallback callback) async {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _recordDuration++;
      callback();
    });
  }

  ///Cancels the timer but maintains value of currently recorded length
  void stop() {
    _timer?.cancel();
  }
}
