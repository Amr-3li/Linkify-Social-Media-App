import 'package:flutter/material.dart';
import 'package:true_gym/Features/posts/presentation/view/widgets/add_post_body.dart';
import 'package:true_gym/Features/posts/presentation/view/widgets/post_appbar.dart';

class AddPostPage extends StatelessWidget {
  const AddPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PostAppBar(),
      body: AddPostBody(),
    );
  }
}
