import 'package:flutter/material.dart';
import 'package:true_gym/views/pages/app_pages/calculator_pages/calories_calculator_page.dart';
import 'package:true_gym/views/pages/app_pages/calculator_pages/water_calculator.dart';
import 'package:true_gym/views/widgets/calculator/calculator_item.dart';

class CalculatorsList extends StatelessWidget {
  const CalculatorsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> items = [
      {
        'icon': Icons.calculate,
        'title': 'Calories \nin day',
        'onTap': () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const CaloriesCalculatorPage();
          }));
        },
      },
      {
        'icon': Icons.water_drop_outlined,
        'title': 'Water \nin day',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const WaterCalculator();
              },
            ),
          );
        },
      },
      {
        'icon': Icons.coffee_outlined,
        'title': 'Calories \nof food',
        'onTap': () {},
      },
      {
        'icon': Icons.directions_bike,
        'title': 'calories \nof exercise',
        'onTap': () {},
      },
    ];
    return Container(
      height: 400,
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: GridView.builder(
          itemCount: 4,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            return CalculatorItem(
              item: items[index],
            );
          }),
    );
  }
}
