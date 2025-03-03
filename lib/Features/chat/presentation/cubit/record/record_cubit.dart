// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:meta/meta.dart';
import 'package:true_gym/core/helper/audio.dart';

part 'record_state.dart';

class RecordCubit extends Cubit<RecordState> {
  RecordCubit() : super(RecordInitial());

  Future<void> startRecord(FlutterSoundRecorder audioRecorder) async {
    emit(RecordStart());
    Audio().requestPermissions();
    try {
      await audioRecorder.openRecorder();
      await audioRecorder.startRecorder(toFile: 'audio_record.aac');
    } catch (e) {
      emit(RecordFaild());
    }
  }

  Future<String> stopRecord(FlutterSoundRecorder audioRecorder) async {
    try {
      String? recordedFilePath = await audioRecorder.stopRecorder();

      await audioRecorder.closeRecorder();
      emit(RecordSuccess(audioPath: recordedFilePath!));
      return recordedFilePath;
    } catch (e) {
      emit(RecordFaild());
      return "";
    }
  }

  Future<void> cancelRecord(FlutterSoundRecorder audioRecorder) async {
    emit(RecordCancel());
    try {
      await audioRecorder.closeRecorder();
      await audioRecorder.deleteRecord(fileName: 'audio_record.aac');
      emit(RecordCancel());
    } catch (e) {
      emit(RecordFaild());
    }
  }

  Future<void> playRecord(FlutterSoundPlayer audioPlayer) async {
    try {
      await audioPlayer.openPlayer();
            await audioPlayer.startPlayer(fromURI: 'audio_record.aac');
    } catch (e) {
      emit(RecordFaild());
    }
  }
}
