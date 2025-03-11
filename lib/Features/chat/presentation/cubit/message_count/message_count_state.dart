part of 'message_count_cubit.dart';

@immutable
sealed class MessageCountState {}

final class MessageCountInitial extends MessageCountState {}

final class MessageCountLoaded extends MessageCountState {
  final Stream<QuerySnapshot<Map<String, dynamic>>> count;

  MessageCountLoaded({required this.count});
}

final class MessageCountLoading extends MessageCountState {}

final class MessageCountError extends MessageCountState {
  final String message;

  MessageCountError({required this.message});
}
