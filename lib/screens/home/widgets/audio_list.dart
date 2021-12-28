import 'package:audiorecorder/providers/previous_recording_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'audio_card.dart';

class AudioList extends StatelessWidget {
  const AudioList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PreviousRecordingProvider>(builder: (context, value, _) {
      return value.files.isEmpty
          ? const Center(
              //add animation
              child: Text("No recordings Availble"),
            )
          : Column(
              children: [
                const Text("Recorded Previously"),
                Expanded(
                  child: ListView.builder(
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
