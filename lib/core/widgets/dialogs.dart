// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/core/exports/app_router.dart';
import 'package:linkify/core/shared_logic/cubit/post_control/post_control_cubit.dart';
import 'package:linkify/core/dependicy_injection/get_it.dart';
import 'package:linkify/core/shared_logic/data/repositories/post_control_repo.dart';
import 'package:linkify/core/widgets/snack_bar_widget.dart';

class Dialogs {
  static Future<dynamic> deletePostDialog(
      BuildContext context, String userId, String time) {
    return showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => PostControlCubit(gitItInstanse<PostControlRepo>()),
        child: BlocListener<PostControlCubit, PostControlState>(
          listener: (context, state) {
            if (state is PostControlFailure) {
              SnackBarWidget.showSnack(context, state.error);
              GoRouter.of(context).pop();
            }
            if (state is PostControlSuccess) {
              GoRouter.of(context).pop();
            }
          },
          child: BlocBuilder<PostControlCubit, PostControlState>(
            builder: (context, state) {
              return AlertDialog(
                title: const Text("Delete Post"),
                content:
                    const Text("Are you sure you want to delete this post?"),
                actions: state is PostControlLoading
                    ? const [CircularProgressIndicator()]
                    : [
                        TextButton(
                          onPressed: () {
                            GoRouter.of(context).pop();
                          },
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () async {
                            await BlocProvider.of<PostControlCubit>(context)
                                .deletePosts(userId, time);
                          },
                          child: const Text("Delete",
                              style: TextStyle(color: Colors.red)),
                        ),
                      ],
              );
            },
          ),
        ),
      ),
    );
  }

  static Future<dynamic> editPostDialog(
      BuildContext context, String description, String userId, String time) {
    TextEditingController controller = TextEditingController(text: description);
    return showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => PostControlCubit(gitItInstanse<PostControlRepo>()),
        child: BlocListener<PostControlCubit, PostControlState>(
          listener: (context, state) {
            if (state is PostControlFailure) {
              SnackBarWidget.showSnack(context, state.error);
              GoRouter.of(context).pop();
            }
            if (state is PostControlSuccess) {
              GoRouter.of(context).pop(); // نقفل الـ dialog لما العملية تنجح
            }
          },
          child: BlocBuilder<PostControlCubit, PostControlState>(
            builder: (context, state) {
              return AlertDialog(
                content: TextFormField(
                  style: const TextStyle(fontSize: 12),
                  maxLines: 5,
                  minLines: 1,
                  controller: controller,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      BlocProvider.of<PostControlCubit>(context)
                          .updatePosts(controller.text, userId, time);
                    },
                    child: state is PostControlLoading
                        ? const CircularProgressIndicator()
                        : const Text(
                            "Edit",
                            style: TextStyle(color: Colors.red),
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
