class ExersieseModelCalculator {
  final String ?name;
  final int ?time;
  final int ?calories;

  ExersieseModelCalculator({required this.name,required this.time,required this.calories});

  factory ExersieseModelCalculator.fromJson(Map<String, dynamic> json) {
    return ExersieseModelCalculator(
      name: json['name'],
      time: json['duration_minutes'],
      calories: json['total_calories'],
    );
  }
}
