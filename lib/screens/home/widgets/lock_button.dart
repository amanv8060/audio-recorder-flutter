import 'package:audiorecorder/providers/recording_provider.dart';
import 'package:audiorecorder/utils/ui/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LockButton extends StatelessWidget {
  const LockButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RecordingProvider>(builder: (context, value, child) {
      return !value.locked && value.recorder!.isRecording
          ? SizedBox(
              width: SizeConfig.fitToWidth(100),
              height: SizeConfig.fitToHeight(120),
              child: DragTarget<bool>(
                builder: (context, List accepted, List rejected) {
                  return const Icon(Icons.lock);
                },
                onAccept: (data) {
                  value.lockRecorder();
                },
                onWillAccept: (data) {
                  return true;
                },
              ))
          : const SizedBox();
    });
  }
}
