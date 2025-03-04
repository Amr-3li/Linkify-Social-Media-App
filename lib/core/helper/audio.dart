import 'package:audioplayers/audioplayers.dart';
import 'package:permission_handler/permission_handler.dart';

class Audio {
  static final Audio _instance = Audio._internal();

  factory Audio() => _instance;

  Audio._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  Future<void> requestPermissions() async {
    await Permission.microphone.request();
  }

  Future<void> playRecording(String audioUrl) async {
    try {
      if (_isPlaying) {
        await stopPlayback(); // Stop any currently playing audio
      }

      await _audioPlayer.play(UrlSource(audioUrl));
      _isPlaying = true;

      _audioPlayer.onPlayerComplete.listen((_) {
        _isPlaying = false;
      });
    } catch (e) {
      print('Error playing recording: $e');
    }
  }

  Future<void> stopPlayback() async {
    try {
      await _audioPlayer.stop();
      _isPlaying = false;
    } catch (e) {
      print('Error stopping playback: $e');
    }
  }
}
