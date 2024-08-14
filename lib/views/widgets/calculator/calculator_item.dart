import 'package:flutter/material.dart';

class CalculatorItem extends StatelessWidget {
  const CalculatorItem({
    super.key,
    required this.item,
  });
  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: item['onTap'],
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black, width: 2),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const Spacer(
              flex: 1,
            ),
            Icon(
              item['icon'],
              color: Color.fromARGB(255, 86, 0, 120),
              size: 40,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              item['title'],
              style: const TextStyle(
                  color: Color.fromARGB(255, 83, 0, 0),
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            ),
            const Spacer(
              flex: 1,
            )
          ]),
        ));
  }
}
