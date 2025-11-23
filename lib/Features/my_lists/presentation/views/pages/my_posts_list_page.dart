import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:linkify/Features/my_lists/presentation/views/widgets/loved_list_interface_widget.dart';
import 'package:linkify/Features/my_lists/presentation/views/widgets/saved_list_interface_widget.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            LovedListInterfaceWidget(),

            SavedListInterfaceWidget(),
            //  PostContainer(post: null),
          ],
        ),
      ),
    );
  }
}
