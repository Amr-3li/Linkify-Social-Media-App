import 'package:true_gym/data/models/exersiese_model.dart';
import 'package:true_gym/data/web_ser/exersieses_calories.dart';

class ExersieseRepository {
  ExersiesesWebService? exersiesesWebService;

  ExersieseRepository(this.exersiesesWebService);

  Future<List<ExersieseModelCalculator>> getExersieses(
      double weight, String activity, int time) async {
    List<ExersieseModelCalculator> exersieses = await exersiesesWebService!
        .getExersieses(weight, activity, time)
        .then((value) => value.map((e) => ExersieseModelCalculator.fromJson(e)).toList());
    return exersieses;
  }
}
