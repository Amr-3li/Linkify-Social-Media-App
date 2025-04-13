import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/home/presentation/cubit/add_remove_love/add_remove_love_cubit.dart';
import 'package:linkify/Features/home/presentation/view/widgets/comments_widget.dart';
import 'package:linkify/Features/home/presentation/view/widgets/post_reaction_bar_item.dart';

class ReactionContainerBar extends StatefulWidget {
  const ReactionContainerBar({
    super.key,
    required this.postTime,
    required this.userId,
  });
  final String userId, postTime;
  @override
  State<ReactionContainerBar> createState() => _ReactionContainerStateBar();
}

class _ReactionContainerStateBar extends State<ReactionContainerBar> {
  bool isLove = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkIfUserLoved();
  }

  Future<void> _checkIfUserLoved() async {
    // جِب الدوكومنت من Firestore وتأكد إذا كان الـ userId موجود في قائمة اللايكات
    final doc = await FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.postTime)
        .get();

    if (doc.exists) {
      final data = doc.data();
      final likes = data?['likes'] as List<dynamic>?;

      if (likes != null) {
        final loved = likes.any((like) => like['id'] == widget.userId);
        setState(() {
          isLove = loved;
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          isLoading
              ? const CircularProgressIndicator()
              : PostReactionBarItem(
                  onTap: () async {
                    await BlocProvider.of<AddRemoveLoveCubit>(context)
                        .addRemoveLike(widget.postTime, widget.userId);

                    await _checkIfUserLoved();
                    // نرجع نحدث الحالة بعد اللايك
                  },
                  icon: Icons.favorite,
                  text: "Like",
                  isLove: isLove,
                ),
          CommenstWidget(postTime: widget.postTime),
          PostReactionBarItem(onTap: () {}, icon: Icons.share, text: "Share"),
        ],
      ),
    );
  }
}
