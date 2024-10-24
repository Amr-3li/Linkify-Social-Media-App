import 'package:flutter/material.dart';
import 'package:true_gym/Features/home/presentation/view/widgets/posts_list.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                floating: true,
                snap: true,
                leading: IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(Icons.menu)),
                actions: const [
                  IconButton(
                    onPressed: null,
                    icon: Icon(Icons.search),
                  )
                ],
                title: const Text(
                  "Home",
                  style:  TextStyle(color: Colors.black),
                ),
              ),
            ],
        body: const PostsList());
  }
}
