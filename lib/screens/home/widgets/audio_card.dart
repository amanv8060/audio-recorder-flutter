import 'dart:io';

import 'package:audiorecorder/providers/player_provider.dart';
import 'package:audiorecorder/providers/previous_recording_providers.dart';
import 'package:audiorecorder/utils/functions/datetime_from_fillename.dart';
import 'package:audiorecorder/utils/functions/format_number.dart';
import 'package:audiorecorder/utils/theme/app_theme.dart';
import 'package:audiorecorder/utils/ui/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class AudioCard extends StatelessWidget {
  AudioCard({Key? key, required this.file}) : super(key: key) {
    time = getDateTimefromFilename(file);
    _playerProvider = PlayerProvider(file);
  }

  late DateTime time;
  final FileSystemEntity file;
  late final PlayerProvider _playerProvider;

  //minor optimization to avoid calling calculation everytime
  double heightPlayer = SizeConfig.fitToHeight(2);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _playerProvider,
      builder: (context, _) => Align(
        alignment: Alignment.centerRight,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppTheme.lightBlueColor,
          ),
          margin: EdgeInsets.fromLTRB(0, 5, 5, 5),
          width: SizeConfig.screenWidth * 0.80,
          child: Consumer<PlayerProvider>(builder: (context, provider, _) {
            return Column(
              children: [
                ListTile(
                  onTap: () async {
                    provider.audioPlayer.playing &&
                            provider.audioPlayer.processingState !=
                                ProcessingState.completed
                        ? provider.stop()
                        : provider.play();
                  },
                  onLongPress: () async {
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title: const Text("Delete this recording"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: const Text("No")),
                              TextButton(
                                  onPressed: () async {
                                    File temp = File(file.path);
                                    temp.deleteSync();
                                    Provider.of<PreviousRecordingProvider>(
                                            context,
                                            listen: false)
                                        .refreshList();
                                    Navigator.of(ctx).pop();
                                  },
                                  child: const Text("Yes"))
                            ],
                          );
                        });
                  },
                  title: Text(DateFormat("MMMM d , y   HH:mm").format(time)),
                  subtitle: Text(
                      "${formatNumber((provider.fileLength?.inSeconds ?? 0) ~/ 60)}:${formatNumber((provider.fileLength?.inSeconds ?? 0) % 60)} "),
                  trailing: Container(
                      decoration: const BoxDecoration(
                        color: AppTheme.lightBlueColor,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: provider.audioPlayer.playing &&
                              provider.audioPlayer.processingState !=
                                  ProcessingState.completed
                          ? const Icon(Icons.stop, color: Colors.red)
                          : const Icon(
                              Icons.play_arrow,
                              color: Colors.green,
                            )),
                ),
                Stack(
                  children: [
                    Container(
                      height: heightPlayer,
                      color: Colors.red,
                      width: SizeConfig.screenWidth * 0.79,
                    ),
                    (provider.fileLength == null)
                        ? const SizedBox()
                        : StreamBuilder(
                            stream: context
                                .select((PlayerProvider r) => r.positionStream),
                            builder: (BuildContext context,
                                AsyncSnapshot<Duration> snapshot) {
                              if (snapshot.hasData && snapshot.data != null) {
                                return Container(
                                  height: heightPlayer,
                                  width: (snapshot.data!.inMilliseconds /
                                          provider.fileLength!.inMilliseconds) *
                                      SizeConfig.screenWidth *
                                      0.95,
                                  color: Colors.black,
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
