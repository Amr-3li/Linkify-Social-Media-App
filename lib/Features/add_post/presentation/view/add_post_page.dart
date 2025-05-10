import 'package:flutter/material.dart';
import 'package:linkify/Features/add_post/presentation/view/widgets/add_post_body.dart';
import 'package:linkify/Features/add_post/presentation/view/widgets/post_appbar.dart';
import 'package:linkify/core/constants/colors.dart';

class AddPostPage extends StatelessWidget {
  const AddPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: PostAppBar(),
      body: AddPostBody(),
    );
  }
}
