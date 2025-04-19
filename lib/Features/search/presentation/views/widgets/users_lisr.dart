import 'package:flutter/material.dart';
import 'package:linkify/Features/search/presentation/views/widgets/user_item.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';

class UsersList extends StatelessWidget {
  const UsersList({super.key, required this.users});
  final List<UserModel> users;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) => UserItem(user: users[index]),
    );
  }
}
