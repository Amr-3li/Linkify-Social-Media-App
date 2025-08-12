import 'package:bloc/bloc.dart';
import 'package:linkify/Features/chat/data/repository/chat_users_repo.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:meta/meta.dart';

part 'chat_users_state.dart';

class ChatUsersCubit extends Cubit<ChatUsersState> {
  ChatUsersCubit(this.chatUsersRepo) : super(ChatUsersInitial());
  final ChatUsersRepo chatUsersRepo;

  Future<void> getChatUsers() async {
    emit(ChatUsersLoading());
    final result = await chatUsersRepo.getChatUsers();
    result.fold((failure) => emit(ChatUsersError(failure.errMessage)),
        (users) => emit(ChatUsersLoaded(users)));
  }
}
