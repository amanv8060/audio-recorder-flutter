import 'package:audiorecorder/providers/recording_provider.dart';
import 'package:audiorecorder/utils/ui/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PauseButton extends StatelessWidget {
  const PauseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RecordingProvider>(builder: (context, value, child) {
      return value.locked
          ? SizedBox(
              width: SizeConfig.fitToWidth(100),
              height: SizeConfig.fitToHeight(100),
              child: DragTarget<bool>(
                builder: (context, List accepted, List rejected) {
                  return IconButton(
                      color: Colors.white,
                      iconSize: SizeConfig.fitToWidth(48),
                      onPressed: () {
                        value.recorderState == RecorderState.PAUSED
                            ? value.resume()
                            : value.pause();
                      },
                      icon: value.recorderState == RecorderState.PAUSED
                          ? const Icon(Icons.play_arrow)
                          : const Icon(Icons.pause));
                },
                onAccept: (data) {
                  value.recorderState == RecorderState.PAUSED
                      ? value.resume()
                      : value.pause();
                },
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
