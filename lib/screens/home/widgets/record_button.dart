import 'package:audiorecorder/providers/previous_recording_providers.dart';
import 'package:audiorecorder/providers/recording_provider.dart';
import 'package:audiorecorder/utils/constants.dart';
import 'package:audiorecorder/utils/logging/custom_logger.dart';
import 'package:audiorecorder/utils/ui/size_config.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class RecordButton extends StatelessWidget {
  const RecordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RecordingProvider>(builder: (context, value, child) {
      return LongPressDraggable(
        feedback: SizedBox(
          width: SizeConfig.fitToWidth(150),
          height: SizeConfig.fitToHeight(150),
          child: Lottie.asset("assets/anim/waves.json", fit: BoxFit.fill),
        ),
        onDragStarted: () {
          if (!value.locked) {
            value.record();
          }
        },
        childWhenDragging: SizedBox(
          width: SizeConfig.fitToWidth(100),
          height: SizeConfig.fitToHeight(100),
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
        child: GestureDetector(
          onTap: () {
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
          child: SizedBox(
            width: SizeConfig.fitToWidth(150),
            height: SizeConfig.fitToHeight(150),
            child: Container(
              child: (value.recorderState == RecorderState.RECORDING ||
                      value.recorderState == RecorderState.PAUSED)
                  ? Lottie.asset("assets/anim/waves.json",
                      width: SizeConfig.fitToWidth(48),
                      height: SizeConfig.fitToHeight(48),
                      fit: BoxFit.fill)
                  : Icon(
                      Icons.keyboard_voice_outlined,
                      color: Colors.white,
                      size: SizeConfig.fitToWidth(48),
                    ),
            ),
          ),
        ),
      );
    });
  }
}
