import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/add_post/presentation/cubit/add_post/add_post_cubit.dart';
import 'package:linkify/Features/add_post/presentation/view/widgets/add_post_image.dart';
import 'package:linkify/Features/add_post/presentation/view/widgets/post_text_field.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/constants/constants.dart';
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
          SnackBarWidget.showSnack(context, Constants.postsAddedSuccess.tr());
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
                  imageFile = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BlocBuilder<AddPostCubit, AddPostState>(
                builder: (context, state) {
                  return CustomButton(
                    title: state is AddPostLoading
                        ? Constants.postLoading.tr()
                        : Constants.postNow.tr(),
                    color: MyColors.toMessageBorder,
                    onTap: state is AddPostLoading
                        ? () {}
                        : () {
                            if (postController.text.isEmpty) {
                              SnackBarWidget.showSnack(
                                  context, Constants.postEmpty.tr());
                              return;
                            }

                            BlocProvider.of<AddPostCubit>(context).addPosts(
                              postController.text,
                              imageFile,
                            );
                            imageFile = null;
                            setState(() {});
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
