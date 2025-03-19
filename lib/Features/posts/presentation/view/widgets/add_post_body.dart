import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/posts/presentation/cubit/add_post/add_post_cubit.dart';
import 'package:linkify/Features/posts/presentation/view/widgets/add_post_image.dart';
import 'package:linkify/Features/posts/presentation/view/widgets/post_text_field.dart';
import 'package:linkify/core/widgets/custom_button.dart';
import 'package:linkify/core/widgets/snack_bar_widget.dart';

class AddPostBody extends StatefulWidget {
  const AddPostBody({
    super.key,
  });

  @override
  State<AddPostBody> createState() => _AddPostBodyState();
}

class _AddPostBodyState extends State<AddPostBody> {
  File? imageFile;
  TextEditingController postController = TextEditingController();

  @override
  void dispose() {
    postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddPostCubit, AddPostState>(
      listener: (context, state) {
        if (state is AddPostFailure) {
          SnackBarWidget.showSnack(context, state.errMessage);
        } else if (state is AddPostSuccess) {
          SnackBarWidget.showSnack(context, "Post added successfully");
          postController.clear();
          setState(() {
            imageFile = null;
          });
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            PostTextField(controller: postController),
            AddPostImage(
              onImagePicked: (value) {
                setState(() {
                  imageFile = value; // تحديث imageFile هنا
                });
              },
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BlocBuilder<AddPostCubit, AddPostState>(
                builder: (context, state) {
                  return CustomButton(
                    title: state is AddPostLoading ? "Posting..." : "Post",
                    color: const Color.fromARGB(139, 0, 67, 35),
                    onTap: state is AddPostLoading
                        ? () => null
                        : () {
                            if (postController.text.isEmpty) {
                              SnackBarWidget.showSnack(
                                  context, "Post can't be empty");
                              return;
                            }
                            print(
                                "Image Path: ${imageFile?.path ?? 'No image'}");
                            BlocProvider.of<AddPostCubit>(context).addPosts(
                              postController.text,
                              imageFile,
                            );
                            imageFile = null;
                          },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
