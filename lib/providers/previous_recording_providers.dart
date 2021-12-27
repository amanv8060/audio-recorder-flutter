import 'package:flutter/widgets.dart';
import 'package:flutter_sound/flutter_sound.dart';

class PreviousRecordingProvider extends ChangeNotifier {
  FlutterSoundPlayer myPlayer = FlutterSoundPlayer();

  @override
  void dispose() {
    myPlayer.closeAudioSession();
    super.dispose();
  }
}
