import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:true_gym/core/helper/audio.dart';

class AudioRecorder extends StatefulWidget {
  @override
  _AudioRecorderState createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {
  FlutterSoundRecorder? _audioRecorder;
  FlutterSoundPlayer? _audioPlayer;
  bool _isRecording = false;
  String? _recordedFilePath;

  @override
  void initState() {
    super.initState();
    _audioRecorder = FlutterSoundRecorder();
    _audioPlayer = FlutterSoundPlayer();
  }

  @override
  void dispose() {
    _audioRecorder?.closeRecorder();
    _audioPlayer?.closePlayer();
    super.dispose();
  }

  Future<void> _startRecording() async {
    Audio().requestPermissions();
    try {
      await _audioRecorder!.openRecorder();
      await _audioRecorder!.startRecorder(toFile: 'audio_record.aac');
      setState(() {
        _isRecording = true;
      });
    } catch (e) {
      print('Error starting recording: $e');
    }
  }

  Future<void> _stopRecording() async {
    try {
      _recordedFilePath = await _audioRecorder!.stopRecorder();
      await _audioRecorder!.closeRecorder();
      setState(() {
        _isRecording = false;
      });
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }

  Future<void> _playRecording() async {
    try {
      await _audioPlayer!.openPlayer();
      await _audioPlayer!.startPlayer(fromURI: _recordedFilePath);
    } catch (e) {
      print('Error playing recording: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Recorder'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _isRecording
                ? const Text('Recording...')
                : const Text('Press the button to start recording'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              child: Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
            ),
            const SizedBox(height: 20),
            if (_recordedFilePath != null)
              ElevatedButton(
                onPressed: _playRecording,
                child: const Text('Play Recording'),
              ),
          ],
        ),
      ),
    );
  }
}
