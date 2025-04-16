import 'package:bloc/bloc.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:linkify/core/shared_logic/data/repositories/user_data_repo.dart';
import 'package:meta/meta.dart';

part 'get_user_data_state.dart';

class GetUserDataCubit extends Cubit<GetUserDataState> {
  GetUserDataCubit(this.userDataRepo) : super(GetUserDataInitial());
  final UserDataRepo userDataRepo;
  Future<void> getUserData(String userId) async {
    emit(GetUserDataLoading());
    final result = await userDataRepo.getUserById(userId);
    result.fold(
      (l) {
        emit(GetUserDataError(l.errMessage));
      },
      (r) {
        emit(GetUserDataLoaded(r));
      },
    );
  }
}
