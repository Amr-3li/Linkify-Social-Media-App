import 'package:record/record.dart';

class Audio {
  final record = AudioRecorder();
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
