import 'package:flutter/material.dart';
import 'package:linkify/Features/search/presentation/views/widgets/search_appbar.dart';
import 'package:linkify/core/constants/colors.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SearchAppbar(),
      body: Center(child: Text("Search")),
    );
  }
}
