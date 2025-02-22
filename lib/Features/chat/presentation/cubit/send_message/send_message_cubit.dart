import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:true_gym/Features/chat/data/repository/chat_repo.dart';
import 'package:true_gym/Features/register/data/repository/image_repo.dart';

part 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  SendMessageCubit(this.chatRepo, this.imageRepo) : super(SendMessageInitial());
  final ChatRepo chatRepo;
  final ImageRepo imageRepo;
  Future<void> sendMessage(
      {required String toId, File? imageURL, required String msg}) async {
    emit(SendMessageLoading());
    if (imageURL == null) {
      final result = await chatRepo.sendMessage(toId, "", msg);
      result.fold(
        (l) {
          emit(SendMessageFaild(l.errMessage));
        },
        (r) {
          emit(SendMessageSuccess());
        },
      );
    } else {
      var result = await imageRepo.uploadImageToFirebase(imageURL);
      result.fold(
        (l) {
          emit(SendMessageFaild(l.errMessage));
        },
        (r) async {
          final result = await chatRepo.sendMessage(toId, r, msg);
          result.fold(
            (l) {
              emit(SendMessageFaild(l.errMessage));
            },
            (r) {
              emit(SendMessageSuccess());
            },
          );
        },
      );
    }
  }
}
