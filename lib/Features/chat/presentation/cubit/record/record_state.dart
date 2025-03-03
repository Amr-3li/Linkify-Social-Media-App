part of 'record_cubit.dart';

@immutable
sealed class RecordState {}

final class RecordInitial extends RecordState {}

final class RecordStart extends RecordState {}

final class RecordSuccess extends RecordState {
  final String audioPath;

  RecordSuccess({required this.audioPath});
}

final class RecordFaild extends RecordState {}

final class RecordCancel extends RecordState {}
