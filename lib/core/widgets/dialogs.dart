// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/home/presentation/cubit/post_control/post_control_cubit.dart';
import 'package:linkify/core/dependicy_injection/get_it.dart';
import 'package:linkify/core/shared_logic/data/repositories/post_control_repo.dart';
import 'package:linkify/core/widgets/snack_bar_widget.dart';

class Dialogs {
  static Future<dynamic> deletePostDialog(
      BuildContext context, String userId, String time) {
    return showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => PostControlCubit(gitItInstanse<PostControlRepo>()),
        child: BlocBuilder<PostControlCubit, PostControlState>(
          builder: (context, state) {
            if (state is PostControlFailure) {
              SnackBarWidget.showSnack(context, state.error);
              Navigator.pop(context);
            }
            return AlertDialog(
              title: const Text("Delete Post"),
              content: const Text("Are you sure you want to delete this post?"),
              actions: state is PostControlLoading
                  ? const [CircularProgressIndicator()]
                  : [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel")),
                      TextButton(
                          onPressed: () async {
                            await BlocProvider.of<PostControlCubit>(context)
                                .deletePosts(userId, time);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ))
                    ],
            );
          },
        ),
      ),
    );
  }

  static Future<dynamic> editPostDialog(
      BuildContext context, String description) {
    return showDialog(
        context: context,
        builder: (context) => BlocBuilder<PostControlCubit, PostControlState>(
              builder: (context, state) {
                return AlertDialog(
                  content: TextFormField(
                      style: const TextStyle(fontSize: 12),
                      maxLines: 5,
                      minLines: 1,
                      controller: TextEditingController(text: description),
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                      )),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel")),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Edit",
                          style: TextStyle(color: Colors.red),
                        ))
                  ],
                );
              },
            ));
  }
}
