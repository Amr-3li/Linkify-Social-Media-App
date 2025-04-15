import 'package:flutter/material.dart';
import 'package:linkify/Features/add_friend/presentation/view/add_friend_page.dart';
import 'package:linkify/Features/home/presentation/view/pages/home_page.dart';
import 'package:linkify/Features/posts/presentation/view/add_post_page.dart';
import 'package:linkify/Features/profile/presentation/view/profile.dart';
import 'package:linkify/Features/search/presentation/views/search_page.dart';
import 'package:linkify/Features/settings/presentation/view/settings.dart';

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
  AddFriendPage(),
  SettingsPage(),
];
