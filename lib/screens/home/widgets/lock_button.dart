import 'package:audiorecorder/providers/recording_provider.dart';
import 'package:audiorecorder/utils/ui/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LockButton extends StatelessWidget {
  const LockButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RecordingProvider>(builder: (context, value, child) {
      return (!value.locked && (value.recorderState == RecorderState.RECORDING))
          ? SizedBox(
              width: SizeConfig.fitToWidth(100),
              height: SizeConfig.fitToHeight(100),
              child: DragTarget<bool>(
                builder: (context, List accepted, List rejected) {
                  return Icon(
                    Icons.lock,
                    color: Colors.white,
                    size: SizeConfig.fitToWidth(48),
                  );
                },
                onAccept: (data) {
                  value.lockRecorder();
                },
                onWillAccept: (data) {
                  return true;
                },
              ))
          : SizedBox(
              height: SizeConfig.fitToHeight(100),
            );
    });
  }
}
