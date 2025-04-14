import 'package:bloc/bloc.dart';
import 'package:linkify/Features/home/data/Models/comment_model.dart';
import 'package:linkify/core/shared_logic/data/repositories/post_control_repo.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'add_comment_state.dart';

class AddCommentCubit extends Cubit<AddCommentState> {
  AddCommentCubit(this.postControlRepo) : super(AddCommentInitial());
  final PostControlRepo postControlRepo;
  SharedPreferences? prefs;
  Future<void> addComment(String postTime, String comment) async {
    emit(AddCommentLoading());
    prefs = await SharedPreferences.getInstance();
    final commentModel = CommentModel(
        comment: comment,
        userId: prefs!.getString("uid")!,
        time: DateTime.now().millisecondsSinceEpoch.toString(),
        userImage: prefs!.getString("userImage")!,
        userName: prefs!.getString("userName")!);
    final response = await postControlRepo.addComment(postTime, commentModel);
    response.fold((l) {
      emit(AddCommentFailure(l.errMessage));
    }, (r) {
      emit(AddCommentSuccess());
    });
  }
}
