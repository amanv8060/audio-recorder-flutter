import 'package:audiorecorder/providers/previous_recording_providers.dart';
import 'package:audiorecorder/utils/constants.dart';
import 'package:audiorecorder/utils/ui/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'audio_card.dart';

class AudioList extends StatelessWidget {
  const AudioList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PreviousRecordingProvider>(builder: (context, value, _) {
      return value.files.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: SizeConfig.screenWidth * .8,
                    child: AspectRatio(
                        aspectRatio: 2,
                        child: Image.asset(
                          "assets/images/404.png",
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
                const Center(
                  //add animation
                  child: Text(
                    Constants.noRecordings,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(right: SizeConfig.fitToWidth(10)),
                    itemBuilder: (context, index) {
                      return AudioCard(
                        file: value.files[index],
                      );
                    },
                    itemCount: value.files.length,
                    reverse: true,
                  ),
                ),
              ],
            );
    });
  }
}
