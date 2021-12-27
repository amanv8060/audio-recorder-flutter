import 'package:audiorecorder/providers/recording_provider.dart';
import 'package:audiorecorder/screens/home/widgets/audio_list.dart';
import 'package:audiorecorder/screens/home/widgets/button_controls.dart';
import 'package:audiorecorder/screens/home/widgets/custom_app_bar.dart';
import 'package:audiorecorder/screens/home/widgets/no_permssion.dart';
import 'package:audiorecorder/utils/ui/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: CustomAppBar(context),
      body: Column(
        children: [
          const Expanded(flex: 5, child: AudioList()),
          Expanded(
              flex: 3,
              child: context.select((RecordingProvider val) => val.initDone)
                  ? context.select((RecordingProvider value) =>
                          value.microphonePermission)
                      ? const ButtonControls()
                      : const NoPermission()
                  : Center(child: Text("Initializing")))
        ],
      ),
    );
  }
}
