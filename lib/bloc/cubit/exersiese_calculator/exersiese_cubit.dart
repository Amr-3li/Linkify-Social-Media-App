// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:true_gym/data/models/exersiese_model.dart';
import 'package:true_gym/data/repository/exersiese_repo.dart';

part 'exersiese_state.dart';

class ExersieseCalculatorCubit extends Cubit<ExersieseCalculatorState> {
  ExersieseRepository exersieseRepository;
  ExersieseCalculatorCubit(this.exersieseRepository) : super(ExersieseCalculatorInitial());

  Future<void> getExersiesesCalculator(double weight, String activity, int time) async {
    emit(ExersieseCalculatorLoading());
    try {
      List<ExersieseModelCalculator> exersieses =
          await exersieseRepository.getExersieses(weight, activity, time);
      if (exersieses.isNotEmpty) {
        emit(ExersieseCalculatorLoaded(exersieses[0]));
      } else {
        emit(ExersieseCalculatorError("Check the name of the exercise"));
      }
    } on Exception catch (e) {
      emit(ExersieseCalculatorError(e.toString()));
    }
  }
}
