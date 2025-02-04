part of 'chat_cubit.dart';

sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class GetAllMessageLoading extends ChatState {}

final class GetAllMessageSuccess extends ChatState {
  final Stream<QuerySnapshot<Map<String, dynamic>>> messages;

  GetAllMessageSuccess(this.messages);
}

final class GetAllMessageFaild extends ChatState {
  final String message;

  GetAllMessageFaild(this.message);
}

//=========== send message ===========================
final class SendMessageLoading extends ChatState {}

final class SendMessageSuccess extends ChatState {}

final class SendMessageFaild extends ChatState {
  final String message;

  SendMessageFaild(this.message);
}
