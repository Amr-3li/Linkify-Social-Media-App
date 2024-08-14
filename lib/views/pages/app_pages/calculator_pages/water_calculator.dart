// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:true_gym/views/widgets/basic_bages_Color.dart';

class WaterCalculator extends StatefulWidget {
  const WaterCalculator({super.key});

  @override
  State<WaterCalculator> createState() => _WaterCalculatorState();
}

class _WaterCalculatorState extends State<WaterCalculator> {
  double _currentValue =
      20; // Moved outside the build method and removed the nullable type
  double ammountWater = 0;
  setAmountWater() {
    ammountWater = _currentValue * 0.033;
  }

  @override
  Widget build(BuildContext context) {
    return BasicBagesColor(
      body: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            'Water Calculator',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 75, 75, 75),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Weight in kg',
              style: TextStyle(
                  fontSize: 35,
                  color: Color.fromARGB(255, 15, 0, 98),
                  fontWeight: FontWeight.bold),
            ),
            Text(
              _currentValue.toStringAsFixed(2),
              style: const TextStyle(
                  fontSize: 50,
                  color: Color.fromARGB(255, 0, 98, 73),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Slider(
              value: _currentValue,
              onChanged: (value) {
                setState(() {
                  _currentValue = value;
                  setAmountWater();
                });
              },
              min: 0, // Optional: Add a minimum value to define the range.
              max: 200,
              divisions: 200,
              activeColor: const Color.fromARGB(255, 15, 0, 98),
              inactiveColor: const Color.fromARGB(255, 59, 56, 79),
              label: _currentValue.round().toString(),
            ),
            const SizedBox(
              height: 20,
            ),
            ammountWater == 0
                ? const Text('')
                : const Text(
                    'You need water per day : ',
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 15, 0, 98),
                        fontWeight: FontWeight.bold),
                  ),
            Text(
              '${ammountWater.toStringAsFixed(2)} Liters',
              style: const TextStyle(
                  fontSize: 50,
                  color: Color.fromARGB(255, 1, 172, 129),
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
