import 'package:true_gym/data/models/exersiese_model.dart';
import 'package:true_gym/data/web_ser/exersieses_calories.dart';

class ExersieseRepository {
  ExersiesesWebService? exersiesesWebService;

  ExersieseRepository(this.exersiesesWebService);

  Future<List<ExersieseModel>> getExersieses(
      double weight, String activity, int time) async {
    List<ExersieseModel> exersieses = await exersiesesWebService!
        .getExersieses(weight, activity, time)
        .then((value) => value.map((e) => ExersieseModel.fromJson(e)).toList());
    return exersieses;
  }
}
