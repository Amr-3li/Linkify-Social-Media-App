import 'package:flutter/material.dart';
import 'package:linkify/Features/home/presentation/view/widgets/home_page_body.dart';
import 'package:linkify/Features/posts/presentation/view/add_post_page.dart';
import 'package:linkify/Features/settings/presentation/view/settings.dart';

List navigationItems = [
  Icons.post_add,
  Icons.home,
  Icons.settings,
];
List pages = const [AddPostPage(), HomePageBody(), SettingsPage()];
