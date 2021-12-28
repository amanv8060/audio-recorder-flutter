import 'package:audiorecorder/screens/home/widgets/delete_button.dart';
import 'package:audiorecorder/screens/home/widgets/lock_button.dart';
import 'package:audiorecorder/screens/home/widgets/pause_button.dart';
import 'package:audiorecorder/screens/home/widgets/record_button.dart';
import 'package:audiorecorder/screens/home/widgets/timer_widget.dart';
import 'package:audiorecorder/utils/ui/size_config.dart';
import 'package:flutter/material.dart';

class ButtonControls extends StatelessWidget {
  const ButtonControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const TimerWidget(),
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
    );
  }
}
