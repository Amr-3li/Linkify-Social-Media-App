import 'package:flutter/material.dart';
import 'package:true_gym/Features/calculators/presentation/view/widgets/calculator_component.dart';
import 'package:true_gym/lists.dart';

class CalculatorsPageBody extends StatelessWidget {
  const CalculatorsPageBody({super.key});

  @override
  Widget build(BuildContext context) {
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
