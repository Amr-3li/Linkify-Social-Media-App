import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/chat/data/repository/chat_repo.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.chatRepo) : super(ChatInitial());
  final ChatRepo chatRepo;
  void getAllMessages(String toId) async {
    emit(GetAllMessageLoading());
    final result = chatRepo.getAllMessage(toId);
    result.fold(
      (l) {
        emit(GetAllMessageFaild(l.errMessage));
      },
      (r) {
        emit(GetAllMessageSuccess(r));
      },
    );
  }
}
