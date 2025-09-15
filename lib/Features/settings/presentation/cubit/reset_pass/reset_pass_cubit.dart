import 'package:bloc/bloc.dart';
import 'package:linkify/Features/settings/data/repo/reset_pass_repo.dart';
import 'package:meta/meta.dart';

part 'reset_pass_state.dart';

class ResetPassCubit extends Cubit<ResetPassState> {
  ResetPassCubit(this.resetPassRepo) : super(ResetPassInitial());
  final ResetPassRepo resetPassRepo;
  Future<void> resetPass() async {
    emit(ResetPassLoading());
    final result = await resetPassRepo.resetPass();
    result.fold(
      (failure) => emit(ResetPassFailure(failure.errMessage)),
      (_) => emit(ResetPassSuccess()),
    );
  }
}
