import 'package:audiorecorder/providers/recording_provider.dart';
import 'package:audiorecorder/utils/functions/format_number.dart';
import 'package:audiorecorder/utils/ui/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RecordingProvider>(
      builder: (context, value, _) {
        if (value.recorderState == RecorderState.RECORDING ||
            value.recorderState == RecorderState.PAUSED) {
          return SizedBox(
              height: SizeConfig.fitToHeight(20),
              child: _buildTimer(value.durationRecorded));
        }
        return SizedBox(
          height: SizeConfig.fitToHeight(20),
        );
      },
    );
  }

  Widget _buildTimer(int val) {
    final String minutes = formatNumber(val ~/ 60);
    final String seconds = formatNumber(val % 60);

    return FittedBox(
      child: Text(
        '$minutes : $seconds',
        style:
            TextStyle(color: Colors.red.shade400, fontWeight: FontWeight.bold),
      ),
    );
  }
}
