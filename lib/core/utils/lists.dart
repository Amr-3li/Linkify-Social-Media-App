import 'package:flutter/material.dart';
import 'package:true_gym/Features/calculators/presentation/view/pages/calculators_page.dart';
import 'package:true_gym/Features/home/presentation/view/widgets/home_page_body.dart';
import 'package:true_gym/Features/settings/presentation/view/settings.dart';

List navigationItems = [
  Icons.home,
  Icons.calculate,
  Icons.settings,
];
List pages = const [HomePageBody(), CalculatorsPage(), SettingsPage()];
