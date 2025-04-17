import 'package:flutter/material.dart';
import 'package:linkify/Features/profile/presentation/view/widgets/posts_user_list.dart';

import 'package:linkify/core/shared_logic/data/models/user.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return const PostsUserList();
  }
}
