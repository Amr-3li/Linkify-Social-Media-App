import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:true_gym/Features/calculators/data/model/calculator_model.dart';
import 'package:true_gym/Features/calculators/presentation/view/widgets/calculator_component.dart';

class CalculatorsPageBody extends StatelessWidget {
  const CalculatorsPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    List<CalculatorModel> calculatorList = [
      CalculatorModel(
          title: "Calories Calculator",
          image: "assets/images/calculator.png",
          onTap: () {
            GoRouter.of(context).push('/caloriesCalculatorPage');
          }),
      CalculatorModel(
          title: "Water Calculator",
          image: "assets/images/water.png",
          onTap: () {
            GoRouter.of(context).push('/waterCalculatorPage');
          }),
    ];

    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children:
              calculatorList.map((e) => CalculatorComponent(model: e)).toList(),
        ),
      ),
    );
  }
}
