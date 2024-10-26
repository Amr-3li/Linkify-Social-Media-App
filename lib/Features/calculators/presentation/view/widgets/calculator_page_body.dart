import 'package:flutter/material.dart';
import 'package:true_gym/consts.dart';

class CalculatorsPageBody extends StatelessWidget {
  const CalculatorsPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 250,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: MyColors.calculatorContainerColor,
                image: DecorationImage(
                  image: AssetImage("assets/images/calculator.png"),
                  fit: BoxFit.contain,
                  opacity: 0.7,
                )),
            child: const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 12.0),
                child: Text("calories in day",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
