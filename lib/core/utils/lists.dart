import 'package:flutter/material.dart';
import 'package:linkify/Features/friends/presentation/view/friends_page.dart';
import 'package:linkify/Features/home/presentation/view/pages/home_page.dart';
import 'package:linkify/Features/add_post/presentation/view/add_post_page.dart';
import 'package:linkify/Features/search/presentation/views/search_page.dart';
import 'package:linkify/Features/settings/presentation/view/pages/settings.dart';

List navigationItems = [
  Icons.home,
  Icons.search,
  Icons.add_box_outlined,
  Icons.group_add_outlined,
  Icons.settings
];
List pages = const [
  HomePage(),
  SearchPage(),
  AddPostPage(),
  FriendPage(),
  SettingsPage(),
];
