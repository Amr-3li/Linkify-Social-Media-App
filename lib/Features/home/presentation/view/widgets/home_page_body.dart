import 'package:flutter/material.dart';
import 'package:true_gym/Features/home/presentation/view/widgets/posts_list.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          actions: [
            IconButton(
              onPressed: null,
              icon: Icon(Icons.search),
            )
          ],
          title: Text(
            "Home",
            style: TextStyle(color: Colors.black),
          ),
        ),
        SliverToBoxAdapter(child: PostsList()),
      ],
    );
  }
}
