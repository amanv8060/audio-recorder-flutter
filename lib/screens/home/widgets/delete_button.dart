import 'package:audiorecorder/providers/recording_provider.dart';
import 'package:audiorecorder/utils/ui/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RecordingProvider>(builder: (context, value, child) {
      return (value.recorder!.isPaused || value.recorder!.isRecording)
          ? SizedBox(
              width: SizeConfig.fitToWidth(100),
              height: SizeConfig.fitToHeight(100),
              child: DragTarget<bool>(
                builder: (context, List accepted, List rejected) {
                  return IconButton(
                      onPressed: () {
                        value.stopRecorder();
                      },
                      icon: const Icon(Icons.delete_forever));
                },
                onAccept: (data) {
                  value.stopRecorder();
                },
                onLeave: (data) {},
                onWillAccept: (data) {
                  return true;
                },
              ))
          : SizedBox(
              width: SizeConfig.fitToWidth(100),
              height: SizeConfig.fitToHeight(100),
            );
    });
  }
}
