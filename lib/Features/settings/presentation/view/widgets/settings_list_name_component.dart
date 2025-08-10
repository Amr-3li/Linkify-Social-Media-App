import 'package:flutter/material.dart';

class ListNameComponent extends StatelessWidget {
  const ListNameComponent({
    super.key,
    required this.name,
  });
  final String name;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 30,
      titleAlignment: ListTileTitleAlignment.center,
      title: Text(name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          )),
      tileColor: Theme.of(context).colorScheme.tertiary,
    );
  }
}
