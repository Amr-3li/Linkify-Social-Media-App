import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/posts/presentation/cubit/post_control/post_control_cubit.dart';
import 'package:linkify/Features/posts/presentation/view/widgets/add_post_image.dart';
import 'package:linkify/Features/posts/presentation/view/widgets/post_text_field.dart';
import 'package:linkify/core/widgets/custom_button.dart';
import 'package:linkify/core/widgets/snack_bar_widget.dart';

class AddPostBody extends StatelessWidget {
  const AddPostBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostControlCubit, PostControlState>(
      builder: (context, state) {
        if (state is PostControlLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PostControlFailure) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            SnackBarWidget.showSnack(context, state.error);
          });
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
                    onTap: () {},
                  ),
                ),
              ],
            ),
          );
        } else {
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
                    onTap: () {},
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
