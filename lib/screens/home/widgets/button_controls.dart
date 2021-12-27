import 'package:audiorecorder/providers/recording_provider.dart';
import 'package:audiorecorder/screens/home/widgets/delete_button.dart';
import 'package:audiorecorder/screens/home/widgets/lock_button.dart';
import 'package:audiorecorder/screens/home/widgets/pause_button.dart';
import 'package:audiorecorder/screens/home/widgets/record_button.dart';
import 'package:audiorecorder/utils/constants.dart';
import 'package:audiorecorder/utils/ui/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:provider/provider.dart';

class ButtonControls extends StatelessWidget {
  const ButtonControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: context.select<RecordingProvider, FlutterSoundRecorder?>(
                  (value) => value.recorder) ==
              null
          ? const Center(
              child: Text(Constants.unknownError),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const LockButton(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const DeleteButton(),
                    SizedBox(width: SizeConfig.fitToWidth(20)),
                    const RecordButton(),
                    SizedBox(width: SizeConfig.fitToWidth(20)),
                    const PauseButton()
                  ],
                ),
              ],
            ),
    );
  }
}
