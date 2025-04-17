import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/Features/search/presentation/cubit/get_search_user/get_search_user_cubit.dart';
import 'package:linkify/core/constants/colors.dart';

class SearchAppbar extends StatefulWidget implements PreferredSizeWidget {
  const SearchAppbar({
    super.key,
  });

  @override
  State<SearchAppbar> createState() => _SearchAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchAppbarState extends State<SearchAppbar> {
  Timer? _debounce;
  String search = '';

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

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
                  onChanged: (value) async {
                    _debounce = Timer(const Duration(milliseconds: 500), () {
                      setState(() {
                        search = value;
                      });
                      BlocProvider.of<GetSearchUserCubit>(context)
                          .getUsersBySearch(value);
                    });
                  },
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
                onPressed: () async {
                  await BlocProvider.of<GetSearchUserCubit>(context)
                      .getUsersBySearch(search);
                },
                icon: const Icon(Icons.person_search_outlined,
                    size: 32, color: MyColors.iconNavColor))
          ],
        ));
  }
}
