// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:true_gym/data/models/exersiese_model.dart';
import 'package:true_gym/data/repository/exersiese_repo.dart';

part 'exersiese_state.dart';

class ExersieseCubit extends Cubit<ExersieseState> {
  ExersieseRepository exersieseRepository;
  ExersieseCubit(this.exersieseRepository) : super(ExersieseInitial());

  Future<void> getExersieses(double weight, String activity, int time) async {
    emit(ExersieseLoading());
    try {
      List<ExersieseModel> exersieses =
          await exersieseRepository.getExersieses(weight, activity, time);
      if (exersieses.isNotEmpty) {
        emit(ExersieseLoaded(exersieses[0]));
      } else {
        emit(ExersieseError("Check the name of the exercise"));
      }
    } on Exception catch (e) {
      emit(ExersieseError(e.toString()));
    }
  }
}
