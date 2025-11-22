import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:linkify/Features/home/presentation/view/widgets/post_container.dart';
import 'package:linkify/core/constants/constants.dart';
import 'package:linkify/core/widgets/custom_appbar.dart';

class MyPostsListPage extends StatelessWidget {
  const MyPostsListPage({super.key});
  static const String routeName = '/MyPostsListPage';
  @override
  Widget build(BuildContext context) {
    Theme.of(context).colorScheme;
    return Scaffold(
      appBar: CustomAppbar(title: Constants.myLists.tr()),
      body: Column(
        children: [
          ListTitle(
            icon: Icons.favorite,
            title: Constants.lovedList.tr(),
          ),
          PostContainer(post: null),
          ListTitle(
            icon: Icons.bookmark,
            title: Constants.savedList.tr(),
          ),
          PostContainer(post: null),
        ],
      ),
    );
  }
}

class ListTitle extends StatelessWidget {
  const ListTitle({
    super.key,
    required this.title,
    required this.icon,
  });
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,
          style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface, fontSize: 20)),
      leading: Icon(icon, color: Colors.grey),
      trailing: Text(Constants.seeAll.tr(),
          style: TextStyle(color: Colors.grey, fontSize: 16)),
      tileColor: Theme.of(context).colorScheme.surfaceVariant,
    );
  }
}
