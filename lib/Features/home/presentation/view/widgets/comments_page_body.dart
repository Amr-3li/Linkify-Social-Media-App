import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/home/presentation/cubit/cubit/add_comment_cubit.dart';
import 'package:linkify/Features/home/presentation/cubit/get_post_comments/get_post_comments_cubit.dart';
import 'package:linkify/Features/home/presentation/view/widgets/comment_container.dart';
import 'package:linkify/core/constants/animation.dart';
import 'package:linkify/core/constants/colors.dart';
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
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: MyColors.iconNavColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
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
              BlocBuilder<AddCommentCubit, AddCommentState>(
                builder: (context, state) {
                  if (state is AddCommentSuccess) {
                    WidgetsBinding.instance.addPostFrameCallback((_) async {
                      _commentController.clear();
                      setState(() {
                        comment = "";
                      });
                      await BlocProvider.of<GetPostCommentsCubit>(context)
                          .getComments(widget.postTime);
                    });
                  }

                  if (state is AddCommentFailure) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errMessage)),
                      );
                    });
                  }

                  return comment.isNotEmpty
                      ? IconButton(
                          onPressed: state is AddCommentLoading
                              ? null
                              : () async {
                                  await BlocProvider.of<AddCommentCubit>(
                                          context)
                                      .addComment(widget.postTime, comment);
                                },
                          icon: state is AddCommentLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Icon(Icons.send,
                                  color: MyColors.iconActiveColor),
                        )
                      : const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
