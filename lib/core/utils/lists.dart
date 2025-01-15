import 'package:flutter/material.dart';
import 'package:true_gym/Features/home/presentation/view/widgets/home_page_body.dart';
import 'package:true_gym/Features/posts/presentation/view/add_post_page.dart';
import 'package:true_gym/Features/settings/presentation/view/settings.dart';

List navigationItems = [
  Icons.home,
  Icons.add_box,
  Icons.settings,
];
List pages = const [HomePageBody(), AddPostPage(), SettingsPage()];
