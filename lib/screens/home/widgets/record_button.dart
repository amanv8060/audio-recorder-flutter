import 'package:audiorecorder/providers/recording_provider.dart';
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
          value.record();
        },
        childWhenDragging: SizedBox(
          width: SizeConfig.fitToWidth(24),
        ),
        onDragEnd: (data) {
          //handle logic for short upload
          // if (!locked)
          //   setState(() {
          //     recording = false;
          //   });
        },
        data: true,
        child: IconButton(
          onPressed: () {
            if (value.recorder!.isRecording) {
              value.stopRecorder();
            } else {
              value.lockRecorder();
              value.record();
            }
          },
          icon: Icon(
              value.recorder!.isRecording
                  ? Icons.stop
                  : Icons.keyboard_voice_outlined,
              color: Colors.green),
        ),
      );
    });
  }
}
