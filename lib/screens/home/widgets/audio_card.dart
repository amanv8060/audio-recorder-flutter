import 'dart:io';
import 'package:audiorecorder/providers/player_provider.dart';
import 'package:audiorecorder/providers/previous_recording_providers.dart';
import 'package:audiorecorder/utils/functions/datetime_from_fillename.dart';
import 'package:audiorecorder/utils/theme/app_theme.dart';
import 'package:audiorecorder/utils/ui/size_config.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
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
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppTheme.lightBlueColor,
          ),
          width: SizeConfig.screenWidth * 0.95,
          child: Column(
            children: [
              ListTile(
                onTap: () async {
                  //play
                  HapticFeedback.vibrate();
                  Provider.of<PlayerProvider>(context, listen: false).play();
                },
                onLongPress: () async {
                  //show Dialog for delete
                },
                title: Text(DateFormat("MMMM d , y   HH:m").format(time)),
                subtitle:
                    Text(context.select((PlayerProvider r) => r.duration)),
                trailing: Container(
                    decoration: const BoxDecoration(
                      color: AppTheme.lightBlueColor,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.lock)),
              ),
              Stack(
                children: [
                  Container(
                    height: heightPlayer,
                    color: Colors.red,
                    width: SizeConfig.screenWidth * 0.95,
                  ),
                  context.select(
                          (PlayerProvider r) => r.playerSubscription != null)
                      ? StreamBuilder(
                          stream: context.select(
                              (PlayerProvider r) => r.playerSubscription),
                          builder: (BuildContext context,
                              AsyncSnapshot<PlaybackDisposition> snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              return Container(
                                height: heightPlayer,
                                width: (snapshot.data!.position.inMilliseconds /
                                        snapshot
                                            .data!.duration.inMilliseconds) *
                                    SizeConfig.screenWidth *
                                    0.95,
                                color: Colors.black,
                              );
                            }
                            return const SizedBox();
                          })
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}