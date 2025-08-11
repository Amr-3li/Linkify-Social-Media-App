import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/home/presentation/cubit/add_comment/add_comment_cubit.dart';
import 'package:linkify/Features/home/presentation/cubit/get_post_comments/get_post_comments_cubit.dart';
import 'package:linkify/Features/home/presentation/view/widgets/comment_container.dart';
import 'package:linkify/core/constants/animation.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/constants/constants.dart';
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
              return const Expanded(
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (state is GetPostCommentsSuccess) {
              return Expanded(
                child: state.comments.isEmpty
                    ? Center(
                        child: Lottie.asset(MyAnimation.animationsNotExist),
                      )
                    : ListView.separated(
                        itemCount: state.comments.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
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
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: Constants.writeComment,
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                  ),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
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
              BlocListener<AddCommentCubit, AddCommentState>(
                listener: (context, state) {
                  if (state is AddCommentSuccess) {
                    _commentController.clear();
                    setState(() {
                      comment = "";
                    });
                    BlocProvider.of<GetPostCommentsCubit>(context)
                        .getComments(widget.postTime);
                  } else if (state is AddCommentFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errMessage)),
                    );
                  }
                },
                child: BlocBuilder<AddCommentCubit, AddCommentState>(
                  builder: (context, state) {
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
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(Icons.send,
                                    color: MyColors.iconActiveColor),
                          )
                        : const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
