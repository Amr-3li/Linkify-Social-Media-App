import 'package:flutter/material.dart';
import 'package:linkify/Features/posts/presentation/view/widgets/add_post_image.dart';
import 'package:linkify/Features/posts/presentation/view/widgets/post_text_field.dart';
import 'package:linkify/core/widgets/custom_button.dart';

class AddPostBody extends StatelessWidget {
  const AddPostBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const PostTextField(),
          const AddPostImage(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomButton(
                title: "Post",
                color: const Color.fromARGB(139, 0, 67, 35),
                onTap: () {}),
          )
        ],
      ),
    );
  }
}
