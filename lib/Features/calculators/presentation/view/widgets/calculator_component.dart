import 'package:flutter/material.dart';
import 'package:true_gym/Features/calculators/data/model/calculator_model.dart';
import 'package:true_gym/consts.dart';

class CalculatorComponent extends StatelessWidget {
  const CalculatorComponent({super.key, required this.model});
  final CalculatorModel model;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: model.onTap,
        child: Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              color: MyColors.calculatorContainerColor,
              image: DecorationImage(
                image: AssetImage(model.image),
                fit: BoxFit.contain,
                opacity: 0.7,
              )),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(model.title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
