import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class Audio {
  final record = AudioRecorder();
  Future<void> requestPermissions() async {
    await Permission.microphone.request();
    await Permission.storage.request();
  }

  Future<void> startRecording() async {
    if (await record.hasPermission()) {
      await record.start(const RecordConfig(), path: "");
      await record
          .startStream(const RecordConfig(encoder: AudioEncoder.pcm16bits));
    }
  }

  Future<void> stopRecording() async {
    await record.stop();
  }

  Future<void> cancelRecording() async {
    await record.cancel();
  }

  void dispose() => record.dispose();
}
