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
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                child: PostContainer(post: posts[index]),
              ),
              const Divider(height: 10, thickness: 1, color: Colors.black),
            ],
          );
        });
  }
}
