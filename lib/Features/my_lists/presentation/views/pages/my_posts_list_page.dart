import 'package:flutter/material.dart';
import 'package:linkify/core/widgets/custom_appbar.dart';

class MyPostsListPage extends StatelessWidget {
  const MyPostsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'My Posts'),
    );
  }
}
