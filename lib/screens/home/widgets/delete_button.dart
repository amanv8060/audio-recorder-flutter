import 'package:audiorecorder/providers/recording_provider.dart';
import 'package:audiorecorder/utils/ui/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RecordingProvider>(builder: (context, value, child) {
      return (value.recorderState == RecorderState.PAUSED ||
              value.recorderState == RecorderState.RECORDING)
          ? SizedBox(
              width: SizeConfig.fitToWidth(100),
              height: SizeConfig.fitToHeight(100),
              child: DragTarget<bool>(
                builder: (context, List accepted, List rejected) {
                  return IconButton(
                      padding: const EdgeInsets.all(0),
                      iconSize: SizeConfig.fitToWidth(48),
                      onPressed: () {
                        value.deleteRecording();
                      },
                      icon: Icon(
                        Icons.delete_forever,
                        color: Colors.red.shade300,
                      ));
                },
                onAccept: (data) {
                  value.deleteRecording();
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
