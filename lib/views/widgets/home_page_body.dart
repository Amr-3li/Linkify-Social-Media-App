import 'package:flutter/material.dart';
import 'package:true_gym/Features/home/presentation/view/widgets/post_header.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          PostContainer(),
        ],
      ),
    );
  }
}

class PostContainer extends StatelessWidget {
  const PostContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        PostHeader(name: "amr"),
      ],
    );
  }
}
