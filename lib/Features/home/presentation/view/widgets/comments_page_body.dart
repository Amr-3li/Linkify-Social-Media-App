import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/home/presentation/cubit/cubit/add_comment_cubit.dart';
import 'package:linkify/Features/home/presentation/cubit/get_post_comments/get_post_comments_cubit.dart';
import 'package:linkify/Features/home/presentation/view/widgets/comment_container.dart';
import 'package:linkify/Features/posts/data/repository/add_post_repo.dart';
import 'package:linkify/core/constants/animation.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/dependicy_injection/get_it.dart';
import 'package:lottie/lottie.dart';

class CommentsPageBody extends StatefulWidget {
  const CommentsPageBody({
    super.key,
    required this.postTime,
  });
  final String postTime;

  @override
  State<CommentsPageBody> createState() => _CommentsPageBodyState();
}

class _CommentsPageBodyState extends State<CommentsPageBody> {
  String comment = "";
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<GetPostCommentsCubit, GetPostCommentsState>(
          builder: (context, state) {
            if (state is GetPostCommentsloading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetPostCommentsSuccess) {
              return Expanded(
                child: ListView.builder(
                  itemCount: state.comments.length,
                  itemBuilder: (context, index) {
                    return CommentContainer(
                      commentModel: state.comments[index],
                    );
                  },
                ),
              );
            } else {
              return Expanded(
                child: Lottie.asset(MyAnimation.animationsNotExist),
              );
            }
          },
        ),
        BlocListener<AddCommentCubit, AddCommentState>(
          listener: (context, state) {
            if (state is AddCommentSuccess) {
              _commentController.clear();
              setState(() {
                comment = "";
              });
              // Refresh the comments
              context.read<GetPostCommentsCubit>().getComments(widget.postTime);
            } else if (state is AddCommentFailure) {
              throw Exception(state.errMessage);
            }
          },
          child: Container(
            margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: MyColors.iconNavColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: BlocBuilder<AddCommentCubit, AddCommentState>(
              builder: (context, state) {
                return Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Write a comment",
                        ),
                        maxLines: 3,
                        minLines: 1,
                        onChanged: (value) {
                          setState(() {
                            comment = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    comment.isNotEmpty
                        ? IconButton(
                            onPressed: state is AddCommentLoading
                                ? null
                                : () async {
                                    await context
                                        .read<AddCommentCubit>()
                                        .addComment(comment, widget.postTime);
                                  },
                            icon: state is AddCommentLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2),
                                  )
                                : const Icon(Icons.send,
                                    color: MyColors.iconActiveColor),
                          )
                        : const SizedBox.shrink(),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
