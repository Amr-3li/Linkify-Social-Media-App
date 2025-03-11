import 'package:bloc/bloc.dart';
import 'package:linkify/Features/chat/data/repository/chat_repo.dart';
import 'package:meta/meta.dart';

part 'message_count_state.dart';

class MessageCountCubit extends Cubit<MessageCountState> {
  MessageCountCubit(this.chatRepo) : super(MessageCountInitial());
  final ChatRepo chatRepo;
  Future<int> countUnreadMessage(String toId) async {
    final result = await chatRepo.countUnreadMessage(toId);
    result.fold((l) {
      emit(MessageCountError(message: l.errMessage));
    }, (r) {
      emit(MessageCountLoaded());
      return r;
    });
    return 0;
  }
}
