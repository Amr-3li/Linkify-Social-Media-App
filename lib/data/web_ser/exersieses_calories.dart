import 'dart:ffi';

import 'package:dio/dio.dart';

class ExersiesesWebService {
  Dio? dio;
  ExersiesesWebService() {
    dio = Dio();
  }
  Future<List<dynamic>> getExersieses(weight, String activity, int time) async {
    int bounds = (weight * 2.2).toInt();
    try {
      Response response = await dio!.get(
          "https://api.api-ninjas.com/v1/caloriesburned?activity=$activity&X-Api-Key=NjiWr0TPUdsOZRNQ6iAzPw==oypLENzVqVZH0yPV&weight=$bounds&duration=$time");
      return response.data;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
