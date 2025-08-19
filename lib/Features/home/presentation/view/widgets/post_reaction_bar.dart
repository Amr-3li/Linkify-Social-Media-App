import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/home/presentation/cubit/add_remove_love/add_remove_love_cubit.dart';
import 'package:linkify/Features/home/presentation/view/pages/loves_page.dart';
import 'package:linkify/Features/home/presentation/view/widgets/comments_widget.dart';
import 'package:linkify/Features/home/presentation/view/widgets/post_reaction_bar_item.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostReactionBar extends StatefulWidget {
  const PostReactionBar({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  State<PostReactionBar> createState() => _ReactionContainerStateBar();
}

class _ReactionContainerStateBar extends State<PostReactionBar> {
  bool isLove = false;
  bool isLoading = true;
  String userId = '';
  String userName = '';

  @override
  void initState() {
    super.initState();
    _initUser();
  }

  Future<void> _initUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('uid') ?? '';

    await _checkIfUserLoved();
  }

  Future<void> _checkIfUserLoved() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.post.time)
          .get();

      if (doc.exists) {
        final data = doc.data();
        final likes = data?['likes'] as List<dynamic>?;

        if (likes != null) {
          final loved = likes.any(
              (like) => like is Map<String, dynamic> && like['id'] == userId);

          if (!mounted) return;
          setState(() {
            isLove = loved;
          });
        }
      }
    } catch (e) {
      debugPrint("Error checking love status: $e");
    } finally {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
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
              ? PostReactionBarItem(
                  onTap: () => null,
                  icon: Icons.favorite,
                  text: Constants.like,
                  isLove: isLove,
                )
              : PostReactionBarItem(
                  onTap: () async {
                    setState(() => isLove = !isLove); // تغيير محلي سريع
                    await BlocProvider.of<AddRemoveLoveCubit>(context)
                        .addRemoveLike(widget.post.time, userId);
                  },
                  icon: Icons.favorite,
                  text: Constants.like,
                  isLove: isLove,
                  openList: () {
                    GoRouter.of(context)
                        .push('${LovesPage.routeName}/${widget.post.time}');
                  },
                ),
          CommenstWidget(postTime: widget.post.time),
        ],
      ),
    );
  }
}
