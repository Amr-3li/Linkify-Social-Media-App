part of 'send_message_cubit.dart';

sealed class SendMessageState {}

final class SendMessageInitial extends SendMessageState {}

final class SendMessageLoading extends SendMessageState {}

final class SendMessageSuccess extends SendMessageState {}

final class SendMessageFaild extends SendMessageState {
  final String message;

  SendMessageFaild(this.message);
}
