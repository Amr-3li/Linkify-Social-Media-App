import 'package:flutter/material.dart';
import 'package:true_gym/Features/home/data/Models/post.dart';
import 'package:true_gym/Features/home/data/repository/post_repository.dart';
import 'package:true_gym/Features/home/presentation/view/widgets/post_container.dart';

class PostsList extends StatefulWidget {
  const PostsList({super.key});

  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  List<Post> posts = PostRepository().getPosts();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
            child: PostContainer(post: posts[index]),
          );
        });
  }
}
