import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:true_gym/Features/chat/data/repository/chat_repo.dart';

part 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  SendMessageCubit(this.chatRepo) : super(SendMessageInitial());
  final ChatRepo chatRepo;
  Future<void> sendMessage(
      {required String toId,
      required bool isImage,
      required String msg}) async {
    emit(SendMessageLoading());
    final result = await chatRepo.sendMessage(toId, isImage, msg);
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
