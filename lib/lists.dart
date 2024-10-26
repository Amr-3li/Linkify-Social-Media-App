import 'package:flutter/material.dart';
import 'package:true_gym/Features/calculators/data/model/calculator_model.dart';
import 'package:true_gym/Features/calculators/presentation/view/calculators_page.dart';
import 'package:true_gym/Features/profile/presentation/view/profile.dart';
import 'package:true_gym/Features/home/presentation/view/widgets/home_page_body.dart';

List navigationItems = [
  Icons.home,
  Icons.calculate,
  Icons.person,
];
List pages = const [HomePageBody(), CalculatorsPage(), ProfilePage()];

List<CalculatorModel> calculatorList = [
  CalculatorModel(
      title: "Calories Calculator",
      image: "assets/images/calculator.png",
      onTap: () {}),
  CalculatorModel(
      title: "Water Calculator",
      image: "assets/images/water.png",
      onTap: () {}),
];
