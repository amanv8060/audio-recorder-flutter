import 'package:just_audio/just_audio.dart';

class PlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  //Streams to show the play progress
  Stream<Duration> get playerPositionStream => _audioPlayer.positionStream;

  Stream<Duration?> get playerDurationStream => _audioPlayer.durationStream;

  // Set audio source
  Future<void> setSource(String path) async {
    final source = AudioSource.uri(Uri.parse(path));
    await _audioPlayer.setAudioSource(source);
  }

  // Play audio
  Future<void> play() async {

    await _audioPlayer.play();
  }

  // Pause audio
  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  // Stop audio
  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  // Get duration
  Duration? get duration {
    return _audioPlayer.duration;
  }

  // get audio player
  AudioPlayer get audioPlayer {
    return _audioPlayer;
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
