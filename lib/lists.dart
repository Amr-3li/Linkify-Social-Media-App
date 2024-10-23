import 'package:flutter/material.dart';
import 'package:true_gym/Features/profile/presentation/view/profile.dart';
import 'package:true_gym/views/pages/app_pages/settings.dart';
import 'package:true_gym/views/widgets/home_page_body.dart';

List navigationItems = [
  Icons.home,
  Icons.calculate,
  Icons.person,
];
List pages = const [HomePageBody(), SettingsPage(), ProfilePage()];
