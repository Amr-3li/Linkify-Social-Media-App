import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:true_gym/Features/chat/data/repository/chat_repo.dart';
import 'package:true_gym/Features/register/data/model/user.dart';

part 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  SendMessageCubit(this.chatRepo) : super(SendMessageInitial());
  final ChatRepo chatRepo;
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
