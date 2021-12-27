import 'package:audiorecorder/providers/recording_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PauseButton extends StatelessWidget {
  const PauseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RecordingProvider>(builder: (context, value, child) {
      return value.locked
          ? SizedBox(
              width: 100,
              height: 100,
              child: DragTarget<bool>(
                builder: (context, List accepted, List rejected) {
                  return IconButton(
                      onPressed: () {
                        value.pause();
                      },
                      icon: const Icon(Icons.pause));
                },
                onAccept: (data) {
                  value.pause();
                },
                onWillAccept: (data) {
                  return true;
                },
              ))
          : const SizedBox(
              width: 100,
              height: 100,
            );
    });
  }
}
