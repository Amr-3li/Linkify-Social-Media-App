class ExersieseModel {
  final String ?name;
  final int ?time;
  final int ?calories;

  ExersieseModel({required this.name,required this.time,required this.calories});

  factory ExersieseModel.fromJson(Map<String, dynamic> json) {
    return ExersieseModel(
      name: json['name'],
      time: json['duration_minutes'],
      calories: json['total_calories'],
    );
  }
}
