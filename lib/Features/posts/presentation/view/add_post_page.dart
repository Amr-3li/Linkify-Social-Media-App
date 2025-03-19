import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/home/data/Models/post.dart';
import 'package:linkify/Features/posts/presentation/cubit/add_post/add_post_cubit.dart';
import 'package:linkify/Features/posts/presentation/cubit/post_control/post_control_cubit.dart';
import 'package:linkify/Features/posts/presentation/view/widgets/add_post_body.dart';
import 'package:linkify/Features/posts/presentation/view/widgets/post_appbar.dart';
import 'package:linkify/core/constants/colors.dart';
import 'package:linkify/core/dependicy_injection/get_it.dart';

class AddPostPage extends StatelessWidget {
  const AddPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: const PostAppBar(),
      body: BlocProvider(
        create: (context) => gitItInstanse<AddPostCubit>(),
        child: const AddPostBody(),
      ),
    );
  }
}
