import 'package:flutter/material.dart';
import 'package:linkify/Features/add_post/presentation/view/widgets/add_post_body.dart';
import 'package:linkify/Features/add_post/presentation/view/widgets/post_appbar.dart';

class AddPostPage extends StatelessWidget {
  const AddPostPage({super.key});
  static const String routeName = '/addPost';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PostAppBar(),
      body: AddPostBody(),
    );
  }
}
