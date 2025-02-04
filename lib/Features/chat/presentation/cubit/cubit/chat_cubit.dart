import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:true_gym/Features/chat/data/repository/chat_repo.dart';
import 'package:true_gym/Features/register/data/model/user.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.chatRepo) : super(ChatInitial());
  final ChatRepo chatRepo;
  void getAllMessages(UserModel toUser) {
    emit(GetAllMessageLoading());
    final result = chatRepo.getAllMessage(toUser);
    result.fold(
      (l) {
        emit(GetAllMessageFaild(l.errMessage));
      },
      (r) {
        emit(GetAllMessageSuccess(r));
      },
    );
  }

  Future<void> sendMessage(UserModel toUser, String msg) async {
    emit(SendMessageLoading());
    final result = await chatRepo.sendMessage(toUser, msg);
    result.fold(
      (l) {
        emit(SendMessageFaild(l.errMessage));
      },
      (r) {
        emit(SendMessageSuccess());
      },
    );
  }
}
