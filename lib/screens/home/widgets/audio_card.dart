import 'dart:io';

import 'package:audiorecorder/providers/player_provider.dart';
import 'package:audiorecorder/providers/previous_recording_providers.dart';
import 'package:audiorecorder/utils/functions/datetime_from_filename.dart';

import 'package:audiorecorder/utils/theme/app_theme.dart';
import 'package:audiorecorder/utils/ui/size_config.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//ignore immutable
class AudioCard extends StatelessWidget {
  AudioCard({Key? key, required this.file}) : super(key: key) {
    time = getDateTimefromFilename(file);
    _playerProvider = PlayerProvider(file);
  }

  late final DateTime time;
  final FileSystemEntity file;
  late final PlayerProvider _playerProvider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _playerProvider,
      builder: (context, _) => Align(
        alignment: Alignment.centerRight,
        child: Consumer<PlayerProvider>(builder: (context, provider, _) {
          return FocusedMenuHolder(
            onPressed: () {},
            menuItems: [
              FocusedMenuItem(
                title: const Text("Delete"),
                onPressed: () async {
                  File temp = File(file.path);
                  temp.deleteSync();
                  Provider.of<PreviousRecordingProvider>(context, listen: false)
                      .refreshList();
                },
              )
            ],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: SizeConfig.screenWidth * 0.75,
                  margin: EdgeInsets.only(top: SizeConfig.fitToHeight(12)),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppTheme.greyColor),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          provider.audioPlayer.playing
                              ? provider.pause()
                              : provider.play();
                        },
                        icon: Icon(
                          provider.audioPlayer.playing
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                          size: SizeConfig.fitToWidth(40),
                        ),
                        splashRadius: 2,
                        padding: const EdgeInsets.all(0),
                      ),
                      Expanded(
                        child: Slider(
                            activeColor: Colors.blue,
                            inactiveColor: AppTheme.white,
                            max: provider.audioPlayer.duration?.inMilliseconds
                                    .toDouble() ??
                                1,
                            value: provider.audioPlayer.position.inMilliseconds
                                .toDouble(),
                            onChanged: (d) {
                              provider.seek(Duration(milliseconds: d.toInt()));
                            }),
                      ),
                      Text(
                        _printDuration(provider.audioPlayer.position),
                        style:
                            const TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.fitToHeight(3),
                ),
                Padding(
                  padding: EdgeInsets.only(right: SizeConfig.fitToWidth(5)),
                  child: Text(
                    DateFormat("MMM d , HH:mm").format(time),
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    String hoursString =
        duration.inHours == 0 ? '' : "${twoDigits(duration.inHours)}:";
    return "$hoursString$twoDigitMinutes:$twoDigitSeconds";
  }
}
