import 'package:flutter/material.dart';
import 'package:true_gym/views/widgets/calculator/calculator_list.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      primary: true,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Calculators',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            Divider(
              color: Colors.black,
              thickness: 1,
            ),
            CalculatorsList(),
          ],
        ),
      ),
    );
  }
}
