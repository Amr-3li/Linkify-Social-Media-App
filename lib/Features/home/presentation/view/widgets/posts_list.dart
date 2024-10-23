import 'package:flutter/material.dart';
import 'package:true_gym/Features/home/presentation/view/widgets/post_container.dart';

class PostsList extends StatelessWidget {
  const PostsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return const Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                child: PostContainer(),
              ),
              Divider(height: 10, thickness: 1, color: Colors.black),
            ],
          );
        });
  }
}
