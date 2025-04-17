import 'package:flutter/material.dart';
import 'package:linkify/core/constants/colors.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: SearchAppbar(), body: Center(child: Text("Search")));
  }
}

class SearchAppbar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: MyColors.appBarColor,
        leading: const SizedBox(),
        leadingWidth: 50,
        title: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: TextFormField(
                  style:
                      const TextStyle(color: MyColors.fontColor, fontSize: 20),
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: MyColors.light, width: 3)),
                      hintText: "Search",
                      hintStyle:
                          TextStyle(color: MyColors.light, fontSize: 20)),
                ),
              ),
            ),
            const SizedBox(width: 5),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.person_search_outlined,
                    size: 32, color: MyColors.iconNavColor))
          ],
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
