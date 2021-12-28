import 'package:audiorecorder/providers/previous_recording_providers.dart';
import 'package:audiorecorder/providers/recording_provider.dart';
import 'package:audiorecorder/utils/constants.dart';
import 'package:audiorecorder/utils/logging/custom_logger.dart';
import 'package:audiorecorder/utils/logging/info_toast.dart';
import 'package:audiorecorder/utils/theme/app_theme.dart';
import 'package:audiorecorder/utils/ui/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecordButton extends StatelessWidget {
  const RecordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RecordingProvider>(builder: (context, value, child) {
      return LongPressDraggable(
        feedback: CircleAvatar(
          child: Icon(
            Icons.keyboard_voice_outlined,
            color: Colors.white,
            size: SizeConfig.fitToWidth(24),
          ),
          backgroundColor: AppTheme.primaryColor,
        ),
        onDragStarted: () {
          if (!value.locked) {
            value.record();
          }
        },
        childWhenDragging: SizedBox(
          width: SizeConfig.fitToWidth(24),
        ),
        onDragEnd: (data) {
          CustomLogger.instance.singleLine("called");
          // handle logic for short upload
          if (!value.locked) {
            if (value.durationRecorded < Constants.minRecordDuration) {
              value.deleteRecording();
            } else {
              value.stopRecording();
              Provider.of<PreviousRecordingProvider>(context, listen: false)
                  .refreshList();
            }
          }
        },
        data: true,
        child: IconButton(
          onPressed: () {
            if (value.recorderState == RecorderState.RECORDING ||
                value.recorderState == RecorderState.PAUSED) {
              value.stopRecording();
              Provider.of<PreviousRecordingProvider>(context, listen: false)
                  .refreshList();
            } else {
              value.lockRecorder();
              value.record();
            }
          },
          icon: Icon(
              (value.recorderState == RecorderState.RECORDING ||
                      value.recorderState == RecorderState.PAUSED)
                  ? Icons.stop
                  : Icons.keyboard_voice_outlined,
              color: Colors.green),
        ),
      );
    });
  }
}
