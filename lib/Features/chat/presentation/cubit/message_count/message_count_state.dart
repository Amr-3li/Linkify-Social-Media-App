part of 'message_count_cubit.dart';

@immutable
sealed class MessageCountState {}

final class MessageCountInitial extends MessageCountState {}

final class MessageCountLoaded extends MessageCountState {}

final class MessageCountLoading extends MessageCountState {}

final class MessageCountError extends MessageCountState {
  final String message;

  MessageCountError({required this.message});
}
